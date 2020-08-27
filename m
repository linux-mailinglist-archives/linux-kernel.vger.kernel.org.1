Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DC32541D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 11:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgH0JTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 05:19:15 -0400
Received: from mail.monom.org ([188.138.9.77]:49848 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgH0JTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:19:13 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 144C250035A;
        Thu, 27 Aug 2020 11:19:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id A7627500103;
        Thu, 27 Aug 2020 11:19:10 +0200 (CEST)
Date:   Thu, 27 Aug 2020 11:19:10 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200827091910.ibuyr53qprb7qmju@beryllium.lan>
References: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
 <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan>
 <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
 <20200826090518.m6vblobggnfdjau5@beryllium.lan>
 <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:43:26PM +0200, Daniel Wagner wrote:
> All looks good, no crash and all tests do pass on x86_64. Firing up the
> ARM boards now.

All test pass on the BeagleBone Black.

Something is a bit weird with my RPi3 in 64bit mode. uboot loads
the the dtb file via ftp and then does a booti. For all non PREEMPT_RT
kernels (PREEMPT, NONE, SMP=n, ...) everything works fine. For the
PREEMPT_RT kernel uboot complains with

  U-Boot> booti 0x00080000 - 0x02600000
  bootloader-commands: Wait for prompt Starting kernel (timeout 00:03:43)
  booti 0x00080000 - 0x02600000
  ERROR: Did not find a cmdline Flattened Device Tree
  Starting kernel ...

It's the same dtb in all cases. Not totally sure what is upsetting uboot
here, maybe the load addresses don't work anymore?

In short, I can't really say if v5.9-rt for ARMv8 works for me.
