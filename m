Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441DB2C9B4B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbgLAJGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:06:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8543 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388884AbgLAJEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:04:38 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Clbjt0pWgzhlRL;
        Tue,  1 Dec 2020 17:03:30 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 1 Dec 2020
 17:03:23 +0800
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: fix wrong block count instead of
 bytes
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@android.com>
CC:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201126022416.3068426-1-jaegeuk@kernel.org>
 <20201126022416.3068426-3-jaegeuk@kernel.org>
 <20201201040935.GC3858797@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7f10f16c-b406-f21c-fd11-ea0fb7707ea0@huawei.com>
Date:   Tue, 1 Dec 2020 17:03:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201201040935.GC3858797@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/1 12:09, Jaegeuk Kim wrote:
> On 11/25, Jaegeuk Kim wrote:
>> We should convert cur_lblock, a block count, to bytes for len.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Fixes: af4b6b8edf6a ("f2fs: introduce check_swap_activate_fast()")

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
