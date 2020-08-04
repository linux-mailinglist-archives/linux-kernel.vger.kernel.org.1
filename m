Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2ED723B1F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 02:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgHDA5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 20:57:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbgHDA5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:57:36 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 82BDEFE8FF83CD2F15D5;
        Tue,  4 Aug 2020 08:57:34 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 4 Aug 2020
 08:57:27 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: update_sit_entry: Make the judgment
 condition of f2fs_bug_on more intuitive
To:     Zhihao Cheng <chengzhihao1@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yi.zhang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200801032450.3028986-1-chengzhihao1@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <213c79b1-39cc-1b22-f2d9-d6b5ee3dbdab@huawei.com>
Date:   Tue, 4 Aug 2020 08:57:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200801032450.3028986-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/1 11:24, Zhihao Cheng wrote:
> Current judgment condition of f2fs_bug_on in function update_sit_entry():
>    new_vblocks >> (sizeof(unsigned short) << 3) ||
> 	new_vblocks > sbi->blocks_per_seg
> 
> which equivalents to:
>    new_vblocks < 0 || new_vblocks > sbi->blocks_per_seg
> 
> The latter is more intuitive.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Reported-by: Jack Qiu <jack.qiu@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
