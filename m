Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CB52808C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgJAUtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:49:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:58748 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgJAUtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:49:51 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 091KiIqu017242;
        Thu, 1 Oct 2020 15:44:19 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 091KiHHX017241;
        Thu, 1 Oct 2020 15:44:17 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 1 Oct 2020 15:44:17 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] powerpc/time: Rename mftbl() to mftb()
Message-ID: <20201001204417.GP28786@gate.crashing.org>
References: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 12:42:39PM +0000, Christophe Leroy wrote:
> On PPC64, we have mftb().
> On PPC32, we have mftbl() and an #define mftb() mftbl().
> 
> mftb() and mftbl() are equivalent, their purpose is to read the
> content of SPRN_TRBL, as returned by 'mftb' simplified instruction.
> 
> binutils seems to define 'mftbl' instruction as an equivalent
> of 'mftb'.
> 
> However in both 32 bits and 64 bits documentation, only 'mftb' is
> defined, and when performing a disassembly with objdump, the displayed
> instruction is 'mftb'
> 
> No need to have two ways to do the same thing with different
> names, rename mftbl() to have only mftb().

There are mttbl and mttbu insns (and no mttb insn); they write a 32-bit
half for the time base.  There is an mftb, and an mftbu.  mftbu reads
the upper half, while mftb reads the *whole* register.  SPR 269 is the
TBU register, while SPR 268 is called both TB and TBL.  Yes, it is
confusing :-)

The "mftb" name is much clearer than "mftbl" (on 64-bit), because it
reads the whole 64-bit register.  On 32-bit mftbl is clearer (but not
defined in the architecture, not officially an insn or even an extended
mnemonic).


Segher
