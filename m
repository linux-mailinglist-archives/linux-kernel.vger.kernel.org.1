Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5452293A58
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 13:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393907AbgJTL4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 07:56:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:35087 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393831AbgJTL4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:56:49 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 09KBpIuN022840;
        Tue, 20 Oct 2020 06:51:18 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 09KBpGRn022835;
        Tue, 20 Oct 2020 06:51:16 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 20 Oct 2020 06:51:16 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc: Fix pre-update addressing in inline assembly
Message-ID: <20201020115116.GY2672@gate.crashing.org>
References: <5ffcb064f695d5285bf1faab91bffa3f9245fc26.1603109522.git.christophe.leroy@csgroup.eu> <fbcdb173cc42da62f00285dfef8c2f7d4960b5c7.1603109522.git.christophe.leroy@csgroup.eu> <20201019202441.GU2672@gate.crashing.org> <ff158583-4e25-a5e6-5131-359423037e4f@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff158583-4e25-a5e6-5131-359423037e4f@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 09:44:33AM +0200, Christophe Leroy wrote:
> Le 19/10/2020 à 22:24, Segher Boessenkool a écrit :
> >>but the associated "<>" constraint is missing.
> >
> >But that is just fine.  Pointless, sure, but not a bug.
> 
> Most of those are from prehistoric code. So at some point in time it was 
> effective. Then one day GCC changed it's way and they became pointless. So, 
> not a software bug, but still a regression at some point.
> 
> >>Use UPD_CONSTR macro everywhere %Un modifier is used.
> >
> >Eww.  My poor stomach.
> 
> There are not that many :)

Heh, your pain threshold is much higher than mine I guess :-)

> >Have you verified that update form is *correct* in all these, and that
> >we even *want* this there?
> 
> I can't see anything that would militate against it, do you ?
> 
> I guess if the elders have put %Us there, it was wanted.

On old CPUs, update form load/stores actually executed faster than a
"normal" memory access and an addi (or plain add).  But on more recent
stuff it mostly saves code size.  Which is nice of course, and can speed
up your code a bit, in theory at least.

It is quite hard to trigger the compiler to generate update form insns
in asm, sigh.  So testing will probably not show anything either way.
Oh well :-)


Segher
