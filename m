Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015B02C9A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgLAI4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:56:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8541 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387670AbgLAI4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:56:19 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ClbXG4vwQzhlLr;
        Tue,  1 Dec 2020 16:55:10 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 1 Dec 2020
 16:55:31 +0800
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: rename logical_to_blk and
 blk_to_logical
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@android.com>
CC:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201126022416.3068426-1-jaegeuk@kernel.org>
 <20201201040904.GA3858797@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <107bda4f-4fd7-2d9d-313a-f1d4bcbe13bd@huawei.com>
Date:   Tue, 1 Dec 2020 16:55:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201201040904.GA3858797@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/1 12:09, Jaegeuk Kim wrote:
> Forgot to add f2fs mailing list.
> 
> On 11/25, Jaegeuk Kim wrote:
>> This patch renames two functions like below having u64.
>>   - logical_to_blk to bytes_to_blks
>>   - blk_to_logical to blks_to_bytes
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
