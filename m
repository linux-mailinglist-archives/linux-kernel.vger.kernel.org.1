Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409802C3645
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 02:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgKYBeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 20:34:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbgKYBeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 20:34:01 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CA72206D5;
        Wed, 25 Nov 2020 01:34:00 +0000 (UTC)
Date:   Tue, 24 Nov 2020 20:33:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, m.mizuma@jp.fujitsu.com
Subject: Re: [PATCH 1/1] ktest.pl: Fix incorrect reboot for grub2bls
Message-ID: <20201124203356.7ea7d86f@oasis.local.home>
In-Reply-To: <20201120231217.7fdc38d6@oasis.local.home>
References: <20201121021243.1532477-1-libo.chen@oracle.com>
        <20201120231217.7fdc38d6@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 23:12:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 20 Nov 2020 18:12:43 -0800
> Libo Chen <libo.chen@oracle.com> wrote:
> 
> > This issue was first noticed when I was testing different kernels on
> > Oracle Linux 8 which as Fedora 30+ adopts BLS as default. Even though a
> > kernel entry was added successfully and the index of that kernel entry was
> > retrieved correctly, ktest still wouldn't reboot the system into
> > user-specified kernel.
> > 
> > The bug was spotted in subroutine reboot_to where the if-statement never
> > checks for REBOOT_TYPE "grub2bls", therefore the desired entry will not be
> > set for the next boot.
> > 
> > Add a check for "grub2bls" so that $grub_reboot $grub_number can
> > be run before a reboot if REBOOT_TYPE is "grub2bls" then we can boot to
> > the correct kernel.
> > 
> > Fixes: ac2466456eaa ("ktest: introduce grub2bls REBOOT_TYPE option")  
> 
> I was just thinking a couple of hours ago if anyone uses ktest.pl, and
> if so, how come I haven't received any patches for it ;-)
> 
> Anyway, I'll take a look at this next week, and it may be a while
> before it gets into the kernel, as I like to run updates for a few
> weeks on my systems (as I use it to build all my kernels), before I
> push it upstream.
> 

Well, I didn't quite get to it this week, and I'm taking the rest of
the week off. Hopefully, I'll be able to look at it when I get back.

Thanks!

-- Steve
