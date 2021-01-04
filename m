Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583E92E9730
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhADOZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:25:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49197 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbhADOZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:25:22 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kwQml-0008BG-Tt; Mon, 04 Jan 2021 14:24:40 +0000
To:     Daeho Jeong <daehojeong@google.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
Message-ID: <1acf4202-e5e6-f3fb-73c3-11bc965d3058@canonical.com>
Date:   Mon, 4 Jan 2021 14:24:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis using Coverity has detected a potential null pointer
dereference after a null check in the following commit:

commit 5fdb322ff2c2b4ad519f490dcb7ebb96c5439af7
Author: Daeho Jeong <daehojeong@google.com>
Date:   Thu Dec 3 15:56:15 2020 +0900

    f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE

The analysis is as follows:

4025 static int redirty_blocks(struct inode *inode, pgoff_t page_idx,
int len)
4026 {
4027        DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, page_idx);
4028        struct address_space *mapping = inode->i_mapping;
4029        struct page *page;
4030        pgoff_t redirty_idx = page_idx;
4031        int i, page_len = 0, ret = 0;
4032
4033        page_cache_ra_unbounded(&ractl, len, 0);
4034

    1. Condition i < len, taking true branch.
    4. Condition i < len, taking true branch.

4035        for (i = 0; i < len; i++, page_idx++) {
4036                page = read_cache_page(mapping, page_idx, NULL, NULL);

    2. Condition IS_ERR(page), taking false branch.
    5. Condition IS_ERR(page), taking true branch.

4037                if (IS_ERR(page)) {
4038                        ret = PTR_ERR(page);

    6. Breaking from loop.

4039                        break;
4040                }
4041                page_len++;

    3. Jumping back to the beginning of the loop.

4042        }
4043

    7. Condition i < page_len, taking true branch.

4044        for (i = 0; i < page_len; i++, redirty_idx++) {
4045                page = find_lock_page(mapping, redirty_idx);

    8. Condition !page, taking true branch.
    9. var_compare_op: Comparing page to null implies that page might be
null.

4046                if (!page)
4047                        ret = -ENOENT;

Dereference after null check (FORWARD_NULL)

   10. var_deref_model: Passing null pointer page to set_page_dirty,
which dereferences it.

4048                set_page_dirty(page);
4049                f2fs_put_page(page, 1);
4050                f2fs_put_page(page, 0);
4051        }
4052
4053        return ret;
4054 }

The !page check on line 4046 sets ret appropriately but we have a
following call to set_page_dirty on a null page that causes the error.
Not sure how this should be fixed, should the check bail out immediately
or just avoid the following set_page_dirty anf f2fs_put_page calls?

Colin

