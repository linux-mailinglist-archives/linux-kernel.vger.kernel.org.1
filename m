Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2429284F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgJFQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:13:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37478 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgJFQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:13:26 -0400
Date:   Tue, 6 Oct 2020 18:13:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602000805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZptl3j2TZnVgHibHySJvfx6RC/wAj9H8/wlATVQaqU=;
        b=BEWE2we4ShOb/+Trfuojq3AORHTvRfsXC7NrfkX+DCCLjKKK3QHzVfxK8AHSDtGDfcRCkL
        l2r+7Z4ZdrcNQQu95yqcIYaKoOIR2Vcg8BxKpfiG+sxyVjH39iWrZXgjluo1BfePXGyMXm
        +B4BrCmGVHdmdJlEiOD62ruvsWzJpbSFuwR9Re2OBXmvdqGzs8NWTYVci02N+vj6MYBCdZ
        1Rcc3N+Mx3P4I5W+EOCYh3DlG4y+qehLCNu1SJ2cui3w8TbYdE6eWoKy1LOPtJoXeFCJen
        AcniwxUhb5tWxMgLWYr/rqg4rYoai8GEplX7JgOn5YnW2DNnXG3D4+QdMEsyqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602000805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZptl3j2TZnVgHibHySJvfx6RC/wAj9H8/wlATVQaqU=;
        b=wicHBhjxbzbMXoqqnZYQ8/ltJ4Mq8q3kYLqe+/sDj7rqkuxzcv/FQ83JaTtrMuJ0FrHL4p
        yM9npEE7PLZNx2Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc8-rt12
Message-ID: <20201006161323.wsjkbnlj5smbffpz@linutronix.de>
References: <20201006085811.mtizrfff6k5r3me7@linutronix.de>
 <6c5bce4f-1c7f-a9e4-6707-2cda54141d8e@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c5bce4f-1c7f-a9e4-6707-2cda54141d8e@monom.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-06 16:37:21 [+0200], Daniel Wagner wrote:
> Hi Sebastian,
Hi Daniel,

> On 06.10.20 10:58, Sebastian Andrzej Siewior wrote:
> > Dear RT folks!
> > 
> > I'm pleased to announce the v5.9-rc8-rt12 patch set.
> 
> Just as heads up. I just tried to build for arm64 but PREEMPT_RT
> is not available anymore. Looks like ARCH_SUPPORTS_RT is only
> available for !KVM.

It has been announced in v5.9-rc2-rt1
   https://lore.kernel.org/linux-rt-users/20200824154605.v66t2rsxobt3r5jg@linutronix.de/

and you replied to that mail. That mail contains information why and
what needs to be done to remove that restriction.

> Thanks,
> Daniel

Sebastian
