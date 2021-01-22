Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F17300360
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbhAVMlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:41:22 -0500
Received: from foss.arm.com ([217.140.110.172]:45730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbhAVMlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:41:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B67011D4;
        Fri, 22 Jan 2021 04:40:22 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BD603F66E;
        Fri, 22 Jan 2021 04:40:21 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        mgorman@suse.de, song.bao.hua@hisilicon.com
Subject: [PATCH 0/1] sched/topology: NUMA distance deduplication 
Date:   Fri, 22 Jan 2021 12:39:42 +0000
Message-Id: <20210122123943.1217-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

As pointed out by Barry in [1], there are topologies out there that struggle to
go through the NUMA distance deduplicating sort. Included patch is something
I wrote back when I started untangling this distance > 2 mess.

It's only been lightly tested on some array of QEMU-powered topologies I keep
around for this sort of things. I *think* this works out fine with the NODE
topology level, but I wouldn't be surprised if I (re)introduced an off-by-one
error in there. 

@Barry feel free to test / edit this as you see fit.

[1]: http://lore.kernel.org/r/9d6c6d3ba6ac4272bf844034da4653fe@hisilicon.com

HTH.


Valentin Schneider (1):
  sched/topology: Make sched_init_numa() use a set for the deduplicating
    sort

 include/linux/topology.h |  1 +
 kernel/sched/topology.c  | 99 +++++++++++++++++++---------------------
 2 files changed, 49 insertions(+), 51 deletions(-)

--
2.27.0

