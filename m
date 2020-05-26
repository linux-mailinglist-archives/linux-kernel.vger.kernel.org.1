Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFC81B1BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 04:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDUCTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 22:19:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgDUCTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:19:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B16F7405F9438133B0B2;
        Tue, 21 Apr 2020 10:19:40 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 21 Apr
 2020 10:19:38 +0800
Subject: Re: [PATCH v2] f2fs: fix to avoid page count leak
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200415021313.95538-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <634e3958-ee48-90b1-f32f-60e2bc4ca88e@huawei.com>
Date:   Tue, 21 Apr 2020 10:19:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200415021313.95538-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

Let's drop this patch, I encounter bad page state (nonzero refcount) reported
by vm w/ this patch.

On 2020/4/15 10:13, Chao Yu wrote:
> In f2fs_read_data_pages(), once we add page into radix tree, we need to
> release reference count of that page, however when f2fs_read_multi_pages()
> fails, we didn't handle that case correctly, fix it.
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
