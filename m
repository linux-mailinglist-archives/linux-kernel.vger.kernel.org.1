Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0FB25436E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgH0KQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 06:16:34 -0400
Received: from mail.monom.org ([188.138.9.77]:50060 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbgH0KQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:16:25 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id E73E150035A;
        Thu, 27 Aug 2020 12:16:22 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id A25AE500103;
        Thu, 27 Aug 2020 12:16:22 +0200 (CEST)
Date:   Thu, 27 Aug 2020 12:16:22 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200827101622.xx4jzecouxrlwbii@beryllium.lan>
References: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
 <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan>
 <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
 <20200826090518.m6vblobggnfdjau5@beryllium.lan>
 <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
 <20200827091910.ibuyr53qprb7qmju@beryllium.lan>
 <20200827092743.kjl6hkaephx3a64a@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827092743.kjl6hkaephx3a64a@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:27:43AM +0200, Sebastian Andrzej Siewior wrote:
> So v5.9-rc2-rt1 with PREEMPT_RT=y enabled leads to the problem and
> v5.9-rc2-rt1 with PREEMPT_PREEMPT=y boots fine?

Yes. But it must be something with uboot related since it's not the
kernel printing the error message. It's likely just an infrastructure
problem on my side. Properly related to the kernel size:

-rw-r--r-- 1 wagi users 31910400 Aug 26 12:54 rpi3-image-ll-v5.9-rc2-rt1-rebase-1-gdf6b97f22351
-rw-r--r-- 1 wagi users 31910400 Aug 26 12:49 rpi3-image-nohz-v5.9-rc2-rt1-rebase-1-gdf6b97f22351
-rw-r--r-- 1 wagi users 32891392 Aug 26 12:47 rpi3-image-none-v5.9-rc2-rt1-rebase-1-gdf6b97f22351
-rw-r--r-- 1 wagi users 38224384 Aug 26 12:45 rpi3-image-rt-v5.9-rc2-rt1-rebase-1-gdf6b97f22351
-rw-r--r-- 1 wagi users 31910400 Aug 26 12:54 rpi3-image-up-v5.9-rc2-rt1-rebase-1-gdf6b97f22351
-rw-r--r-- 1 wagi users 32891392 Aug 26 12:52 rpi3-image-vp-v5.9-rc2-rt1-rebase-1-gdf6b97f22351

The -rt kernel is roughly 6MB larger. Just need to check the memory
ranges u-boot is using.
