Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8542DFEED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 18:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgLURTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 12:19:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:38938 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgLURTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 12:19:54 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0BLHCTFq012889;
        Mon, 21 Dec 2020 11:12:30 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 0BLHCSI6012888;
        Mon, 21 Dec 2020 11:12:28 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 21 Dec 2020 11:12:28 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        "ravi.bangoria@linux.ibm.com" <ravi.bangoria@linux.ibm.com>,
        "mikey@neuling.org" <mikey@neuling.org>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>,
        "haren@linux.ibm.com" <haren@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "wangle6@huawei.com" <wangle6@huawei.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc:Don't print raw EIP/LR hex values in dump_stack() and show_regs()
Message-ID: <20201221171228.GA2672@gate.crashing.org>
References: <20201221032758.12143-1-nixiaoming@huawei.com> <2279fc96-1f10-0c3f-64d9-734f18758620@csgroup.eu> <20201221163130.GZ2672@gate.crashing.org> <ad814ccf34c14c76b45e50b6e7741c3a@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad814ccf34c14c76b45e50b6e7741c3a@AcuMS.aculab.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 04:42:23PM +0000, David Laight wrote:
> From: Segher Boessenkool
> > Sent: 21 December 2020 16:32
> > 
> > On Mon, Dec 21, 2020 at 04:17:21PM +0100, Christophe Leroy wrote:
> > > Le 21/12/2020 à 04:27, Xiaoming Ni a écrit :
> > > >Since the commit 2b0e86cc5de6 ("powerpc/fsl_booke/32: implement KASLR
> > > >infrastructure"), the powerpc system is ready to support KASLR.
> > > >To reduces the risk of invalidating address randomization, don't print the
> > > >EIP/LR hex values in dump_stack() and show_regs().
> > 
> > > I think your change is not enough to hide EIP address, see below a dump
> > > with you patch, you get "Faulting instruction address: 0xc03a0c14"
> > 
> > As far as I can see the patch does nothing to the GPR printout.  Often
> > GPRs contain code addresses.  As one example, the LR is moved via a GPR
> > (often GPR0, but not always) for storing on the stack.
> > 
> > So this needs more work.
> 
> If the dump_stack() is from an oops you need the real EIP value
> on order to stand any chance of making headway.

Or at least the function name + offset, yes.

> Otherwise you might just as well just print 'borked - tough luck'.

Yes.  ASLR is a house of cards.  But that isn't constructive wrt this
patch :-)


Segher
