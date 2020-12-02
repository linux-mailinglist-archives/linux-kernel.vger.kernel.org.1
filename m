Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82A72CB276
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgLBBsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:48:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8550 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLBBsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:48:16 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cm1zq6NYNzhl3K;
        Wed,  2 Dec 2020 09:47:03 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 2 Dec 2020
 09:47:25 +0800
Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: remove buffer_head which has 32bits
 limit
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@android.com>
CC:     Light Hsieh <Light.Hsieh@mediatek.com>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201126022416.3068426-1-jaegeuk@kernel.org>
 <20201126022416.3068426-4-jaegeuk@kernel.org>
 <20201201040924.GB3858797@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7ce64222-cda4-6ad5-9246-c176998b79bb@huawei.com>
Date:   Wed, 2 Dec 2020 09:47:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201201040924.GB3858797@google.com>
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
>> This patch removes buffer_head dependency when getting block addresses.
>> Light reported there's a 32bit issue in f2fs_fiemap where map_bh.b_size is
>> 32bits while len is 64bits given by user. This will give wrong length to
>> f2fs_map_block.
>>
>> Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
