Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE41F1490
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 10:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgFHIfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 04:35:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5867 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbgFHIfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:35:18 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DF832CAECECAF2C25341;
        Mon,  8 Jun 2020 16:35:15 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 8 Jun 2020
 16:35:12 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs: attach IO flags to the missing
 cases
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200604235023.1954-1-jaegeuk@kernel.org>
 <20200604235023.1954-2-jaegeuk@kernel.org>
 <20200608025125.GA127000@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <70f2b6f6-189f-bafe-6db8-7c16a4a7f6ac@huawei.com>
Date:   Mon, 8 Jun 2020 16:35:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200608025125.GA127000@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

This patch should be applied before "f2fs: attach IO flags to the missing cases",
otherwise, gcc may complain about implicit declaration of "__attach_io_flag".

On 2020/6/8 10:51, Jaegeuk Kim wrote:
> This patch adds another way to attach bio flags to node writes.
> 
> Description:   Give a way to attach REQ_META|FUA to node writes
>                given temperature-based bits. Now the bits indicate:
>                *      REQ_META     |      REQ_FUA      |
>                *    5 |    4 |   3 |    2 |    1 |   0 |
>                * Cold | Warm | Hot | Cold | Warm | Hot |
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
