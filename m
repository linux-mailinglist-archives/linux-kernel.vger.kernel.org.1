Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591DF1EC9DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 08:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgFCG7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 02:59:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgFCG7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:59:33 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EF3F929B01C3B7124A8C;
        Wed,  3 Jun 2020 14:59:31 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 3 Jun 2020
 14:59:28 +0800
Subject: Re: [PATCH v2] f2fs: fix retry logic in f2fs_write_cache_pages()
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1591101707-18802-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d233cbc9-99e6-ea06-b138-8c8adcdc02b6@huawei.com>
Date:   Wed, 3 Jun 2020 14:59:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1591101707-18802-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/2 20:41, Sahitya Tummala wrote:
> In case a compressed file is getting overwritten, the current retry
> logic doesn't include the current page to be retried now as it sets
> the new start index as 0 and new end index as writeback_index - 1.
> This causes the corresponding cluster to be uncompressed and written
> as normal pages without compression. Fix this by allowing writeback to
> be retried for the current page as well (in case of compressed page
> getting retried due to index mismatch with cluster index). So that
> this cluster can be written compressed in case of overwrite.
> 
> Also, align f2fs_write_cache_pages() according to the change -
> <64081362e8ff>("mm/page-writeback.c: fix range_cyclic writeback vs
> writepages deadlock").
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
