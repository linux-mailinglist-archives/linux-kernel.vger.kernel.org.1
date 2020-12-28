Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243D32E3388
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 02:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgL1B5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 20:57:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9693 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgL1B5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 20:57:07 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D40xR5QjFzkx1T;
        Mon, 28 Dec 2020 09:55:23 +0800 (CST)
Received: from [10.174.177.185] (10.174.177.185) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 09:56:15 +0800
Subject: Re: [PATCH 1/3] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
References: <20201226102808.2534966-1-yukuai3@huawei.com>
 <20201226102808.2534966-2-yukuai3@huawei.com> <20201227115859.GA3282759@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <04c39621-0c4a-e593-5545-c4bd274c5fc2@huawei.com>
Date:   Mon, 28 Dec 2020 09:56:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201227115859.GA3282759@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/12/27 19:58, Ming Lei wrote:
> Hi Yu Kuai,
> 
> On Sat, Dec 26, 2020 at 06:28:06PM +0800, Yu Kuai wrote:
>> When sharing a tag set, if most disks are issuing small amount of IO, and
>> only a few is issuing a large amount of IO. Current approach is to limit
>> the max amount of tags a disk can get equally to the average of total
>> tags. Thus the few heavy load disk can't get enough tags while many tags
>> are still free in the tag set.
> 
> Yeah, current approach just allocates same share for each active queue
> which is evaluated in each timeout period.
> 
> That said you are trying to improve the following case:
> - heavy IO on one or several disks, and the average share for these
>    disks become bottleneck of IO performance
> - small amount IO on other disks attached to the same host, and all IOs are
> submitted to disk in <30 second period.
> 
> Just wondering if you may share the workload you are trying to optimize,
> or it is just one improvement in theory? And what is the disk(hdd, ssd
> or nvme) and host? And how many disks in your setting? And how deep the tagset
> depth is?

The details of the environment that we found the problem are as follows:

  total driver tags: 128
  number of disks: 13 (network drive, and they form a dm-multipath)
  default queue_depth: 32
  disk performance: when test with 4k randread and single thread, iops is
                    300. And can up to 4000 with 32 thread.
  test cmd: fio -ioengine=psync -numjobs=32 ...

We found that mpath will issue sg_io periodically(about 15s)��which lead
to active_queues setting to 13 for about 5s in every 15s.

By the way, I'm not sure this is a common scenario, however, sq don't
have such problem,

Thanks
Yu Kuai
