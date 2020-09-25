Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EA0278AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgIYORR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgIYORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:17:15 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F6DC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:17:15 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1kLoWv-00037A-Bg; Fri, 25 Sep 2020 16:16:57 +0200
Date:   Fri, 25 Sep 2020 16:16:57 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Prasad Sodagudi <psodagud@codeaurora.org>, rostedt@goodmis.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, tkjos@google.com,
        Mohammed Khajapasha <mkhaja@codeaurora.org>
Subject: Re: [PATCH 2/2] printk: Make the console flush configurable in
 hotplug path
Message-ID: <20200925141657.GA6325@angband.pl>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
 <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
 <20200924063352.GB592892@kroah.com>
 <87wo0j6nos.fsf@nanos.tec.linutronix.de>
 <20200925092754.GA2508526@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200925092754.GA2508526@kroah.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:27:54AM +0200, Greg KH wrote:
> On Thu, Sep 24, 2020 at 08:21:07PM +0200, Thomas Gleixner wrote:
> > On Thu, Sep 24 2020 at 08:33, Greg KH wrote:
> > > On Wed, Sep 23, 2020 at 05:08:32PM -0700, Prasad Sodagudi wrote:
> > >> +config CONSOLE_FLUSH_ON_HOTPLUG
> > >> +	bool "Enable console flush configurable in hot plug code path"

> > CPU hotplug is not meant to be a high speed operation and if people
> > think they need it to be fast then its pretty much guaranteed that they
> > want it for the completely wrong reasons.
> 
> Odds are, it's the big/little systems that are trying to use cpu hotplug
> for this type of thing :(

Just a bit of info:
My MT6797X (10 core: 4×A53 + 4×A53 + 2×A72), flickers its cores this way:
the right-hand piece is CPUs, one character per core: bars show utilization,
"o" stands for offline; every line is 0.1 second interval.

topline -i 0.1
mmcblk(⠀) (oooo▄▆oo▅o)
mmcblk(⠀) (oooo▅▄oooo)
mmcblk(⠀) (oooo▆▆oooo)
mmcblk(⠀) (oooo▅ooo▆o)
mmcblk(⠀) (oooo▆▆oo▄o)
mmcblk(⠀) (oooo▆▇oooo)
mmcblk(⠀) (oooo▇ooo▅o)
mmcblk(⠀) (oooo▆ooo█o)
mmcblk(⠀) (oooo▆ooo▄o)
mmcblk(⠀) (oooo▅ooo▆o)
mmcblk(⠀) (oooo▆ooo▅o)
mmcblk(⠀) (oooo▄ooo▇o)
mmcblk(⠀) (oooo▇▆oo▆o)
mmcblk(⠀) (oooo▆ooo▅o)
mmcblk(⠀) (oooo▅▆oooo)
mmcblk(⠀) (oooo▆█oooo)
mmcblk(⠀) (oooo▆▇oooo)
mmcblk(⠀) (oooo▆▆oooo)
mmcblk(⠀) (oooo▅▆oooo)
mmcblk(⠀) (oooo▆▅oooo)
mmcblk(⠀) (oooo▆ooo▆o)
mmcblk(⠀) (oooo▆ooo▇o)
mmcblk(⢀) (oooo▆▇oo▆o)
mmcblk(⠀) (oooo▄ooo▆o)
mmcblk(⠀) (oooo▆ooo█o)
mmcblk(⠀) (oooo▄ooo▇o)
mmcblk(⠀) (oooo▄▆oooo)
mmcblk(⠀) (oooo▆▆oooo)

So it's on the order of a few ons/offs per second.

The offline CPUs are "present" and "offline"; not sure if this means hotplug
or not (I'd expect dropping from "present" to "possible", but I don't know
these parts).


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ in the beginning was the boot and root floppies and they were good.
⢿⡄⠘⠷⠚⠋⠀                                       -- <willmore> on #linux-sunxi
⠈⠳⣄⠀⠀⠀⠀
