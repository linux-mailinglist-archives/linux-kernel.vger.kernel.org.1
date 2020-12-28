Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5779F2E3549
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 10:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgL1JDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 04:03:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9652 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgL1JDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 04:03:46 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D4BPx464xz15ksV;
        Mon, 28 Dec 2020 17:02:13 +0800 (CST)
Received: from [10.174.177.185] (10.174.177.185) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 17:02:51 +0800
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
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <fce32e47-0e7d-39fa-611f-31ac0b422ba5@huawei.com>
Date:   Mon, 28 Dec 2020 17:02:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201228082835.GB3304670@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2020/12/28 16:28, Ming Lei wrote:
> Another candidate solution may be to always return true from hctx_may_queue()
> for this kind of queue because queue_depth has provided fair allocation for
> each LUN, and looks not necessary to do that again.

If always return true from hctx_may_queue() in this case, for example,
we set queue_depth to 128(if can't, the biggger, the better) for all
disks, and test with numjobs=64. The result should be one disk with high
iops, and the rest very low. So I think it's better to ensure the max
tags a disk can get in this case.

Thanks!
Yu Kuai
