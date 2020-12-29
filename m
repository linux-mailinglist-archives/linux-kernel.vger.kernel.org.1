Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241F32E6D58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 03:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgL2CiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 21:38:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10087 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgL2CiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 21:38:17 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D4dpT57xSzMBhl;
        Tue, 29 Dec 2020 10:36:33 +0800 (CST)
Received: from [10.174.177.185] (10.174.177.185) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 10:37:28 +0800
Subject: Re: [PATCH 1/3] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
References: <20201226102808.2534966-1-yukuai3@huawei.com>
 <20201226102808.2534966-2-yukuai3@huawei.com> <20201227115859.GA3282759@T590>
 <04c39621-0c4a-e593-5545-c4bd274c5fc2@huawei.com>
 <20201228082835.GB3304670@T590>
 <fce32e47-0e7d-39fa-611f-31ac0b422ba5@huawei.com>
 <20201229011517.GA3355551@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <5204c625-a8f0-56c6-d10e-f40638084b97@huawei.com>
Date:   Tue, 29 Dec 2020 10:37:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201229011517.GA3355551@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2020/12/29 9:15, Ming Lei wrote:
> Just wondering why you try to set 128 via sysfs for all disks? If you do that,
> you should know the potential result given the whole tags queue depth is just
> 128.

It's just a extreme example to show the unexpected result of "always
return true from hctx_may_queue()".

Thanks,
Yu Kuai
