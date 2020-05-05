Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0CB1C5CC9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgEEQAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 12:00:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:53459 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbgEEQAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:00:19 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 045Fxiqh012171;
        Tue, 5 May 2020 10:59:45 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 045FxikO012170;
        Tue, 5 May 2020 10:59:44 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 5 May 2020 10:59:44 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
Message-ID: <20200505155944.GO31009@gate.crashing.org>
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr> <87sggecv81.fsf@mpe.ellerman.id.au> <1c6379b2-7e0a-91fe-34f0-51f5adca7929@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c6379b2-7e0a-91fe-34f0-51f5adca7929@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 05:40:21PM +0200, Christophe Leroy wrote:
> >>+#define __put_user_asm_goto(x, addr, label, op)			\
> >>+	asm volatile goto(					\
> >>+		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
> >>+		EX_TABLE(1b, %l2)				\
> >>+		:						\
> >>+		: "r" (x), "m<>" (*addr)				\
> >
> >The "m<>" here is breaking GCC 4.6.3, which we allegedly still support.
> >
> >Plain "m" works, how much does the "<>" affect code gen in practice?
> >
> >A quick diff here shows no difference from removing "<>".
> 
> It was recommended by Segher, there has been some discussion about it on 
> v1 of this patch, see 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/4fdc2aba6f5e51887d1cd0fee94be0989eada2cd.1586942312.git.christophe.leroy@c-s.fr/
> 
> As far as I understood that's mandatory on recent gcc to get the 
> pre-update form of the instruction. With older versions "m" was doing 
> the same, but not anymore.

Yes.  How much that matters depends on the asm.  On older CPUs (6xx/7xx,
say) the update form was just as fast as the non-update form.  On newer
or bigger CPUs it is usually executed just the same as an add followed
by the memory access, so it just saves a bit of code size.

> Should we ifdef the "m<>" or "m" based on GCC 
> version ?

That will be a lot of churn.  Just make 4.8 minimum?


Segher
