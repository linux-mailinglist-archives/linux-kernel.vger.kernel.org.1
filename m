Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B1F29A9CA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898478AbgJ0KgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:36:05 -0400
Received: from mail.monom.org ([188.138.9.77]:54478 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898415AbgJ0KeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:34:14 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id C727C50046C;
        Tue, 27 Oct 2020 11:34:11 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 65E70500299;
        Tue, 27 Oct 2020 11:34:11 +0100 (CET)
Date:   Tue, 27 Oct 2020 11:34:11 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] v5.9.1-rt19
Message-ID: <20201027103411.h5ushvwsrovxls5u@beryllium.lan>
References: <20201024091838.gzhn2dlx2j7xnixg@linutronix.de>
 <20201027093616.5vn6xinmthxulhvx@beryllium.lan>
 <20201027100049.xtkmjqdwkn7zec2f@linutronix.de>
 <20201027102547.y6wop7j2ovzg2tyx@beryllium.lan>
 <20201027102851.gizepjlu4opensqb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027102851.gizepjlu4opensqb@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:28:51AM +0100, Sebastian Andrzej Siewior wrote:
> Is it running as a RT task?

root@c2d:~/rt-tests# ./pi_stress
Starting PI Stress Test
Number of thread groups: 1
Duration of test run: infinite
Number of inversions per group: unlimited
     Admin thread SCHED_FIFO priority 4
1 groups of 3 threads will be created
      High thread SCHED_FIFO priority 3
       Med thread SCHED_FIFO priority 2
       Low thread SCHED_FIFO priority 1

It says so, let me double check if those task really run with SCHED_FIFO.

> Do you have RCU-boosting enabled?

Yes

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
CONFIG_RCU_NOCB_CPU=y
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

> Otherwise it looks that if you throw enough non-RT load on the system,
> RCU can not catch up which does not sound good.

I think this is what Clark tried to tell me. If I understood him
correctly the test tool is not correct though.
