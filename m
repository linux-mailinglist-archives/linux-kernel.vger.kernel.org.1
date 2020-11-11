Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0642AF78A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKKRrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKRrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:47:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85619C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vJivFssdXfp88XYtbpfiCyz81jkqRcBsCW2wX0rSaYQ=; b=XzBUp0rvhH54BrEz7/SkYqJNrb
        ZQ85h+TDFi1lbOxJ5+7e9IwzyxqAqjvGGPG9lCIg79uTdr0kY9fTzvzbQ8X9NlKKbZIbS2RKyT20F
        c+UTxO01G1J+ZTX1lmVWt/1XE2kPWT/o0fG97HZ37mIKKMiyK/i8j6fcRUxjERjuSt8RfYDBBibXW
        3K4YBo7Rdr1fB3AVb4ECd8HSIGWvtflCkLIh+UcyW2uWgch1O8MfRTnf3b9ozStvfI+fP3vVo2Rxz
        t2JpDHN16NBdfTHqGlTfmXBDytYDAScBdYw/bIlZseQ1asIhhsAl+DniwB2rqRSgcePU87wkkE/7f
        LE9gEwhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcuDZ-0006CW-6c; Wed, 11 Nov 2020 17:47:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82233301A42;
        Wed, 11 Nov 2020 18:47:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61BD0203E65A8; Wed, 11 Nov 2020 18:47:36 +0100 (CET)
Date:   Wed, 11 Nov 2020 18:47:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        andrew.cooper3@citrix.com, jgross@suse.com
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201111174736.GH2628@hirez.programming.kicks-ass.net>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111170536.arx2zbn4ngvjoov7@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:05:36AM -0600, Josh Poimboeuf wrote:
> On Fri, Nov 06, 2020 at 06:04:15AM +0000, Shinichiro Kawasaki wrote:
> > Greetings,
> > 
> > I observe "WARNING: can't access registers at asm_common_interrupt+0x1e/0x40"
> > in my kernel test system repeatedly, which is printed by unwind_next_frame() in
> > "arch/x86/kernel/unwind_orc.c". Syzbot already reported that [1]. Similar
> > warning was reported and discussed [2], but I suppose the cause is not yet
> > clarified.
> > 
> > The warning was observed with v5.10-rc2 and older tags. I bisected and found
> > that the commit 044d0d6de9f5 ("lockdep: Only trace IRQ edges") in v5.9-rc3
> > triggered the warning. Reverting that from 5.10-rc2, the warning disappeared.
> > May I ask comment by expertise on CC how this commit can relate to the warning?
> > 
> > The test condition to reproduce the warning is rather unique (blktests,
> > dm-linear and ZNS device emulation by QEMU). If any action is suggested for
> > further analysis, I'm willing to take it with my test system.
> > 
> > Wish this report helps.
> > 
> > [1] https://lkml.org/lkml/2020/9/6/231
> > [2] https://lkml.org/lkml/2020/9/8/1538
> 
> Shin'ichiro,
> 
> Thanks for all the data.  It looks like the ORC unwinder is getting
> confused by paravirt patching (with runtime-patched pushf/pop changing
> the stack layout).
> 
> <user interrupt>
> 	exit_to_user_mode_prepare()
> 		exit_to_user_mode_loop()
> 			local_irq_disable_exit_to_user()
> 				local_irq_disable()
> 					raw_irqs_disabled()
> 						arch_irqs_disabled()
> 							arch_local_save_flags()
> 								pushfq
> 								<another interrupt>

This is PARAVIRT_XXL only, which is a Xen special. My preference, as
always, is to kill it... Sadly the Xen people have a different opinion.

> Objtool doesn't know about the pushf/pop paravirt patch, so ORC gets
> confused by the changed stack layout.
> 
> I'm thinking we either need to teach objtool how to deal with
> save_fl/restore_fl patches, or we need to just get rid of those nasty
> patches somehow.  Peter, any thoughts?

Don't use Xen? ;-)

So with PARAVIRT_XXL the compiler will emit something like:

  "CALL *pvops.save_fl"

Which we then overwrite at runtime with "pushf; pop %[re]ax" and a few
NOPs.

Now, objtool understands alternatives, and ensures they have the same
stack layout, it has no chance in hell of understanding this, simply
because paravirt_patch.c is magic.

I don't have any immediate clever ideas, but let me ponder it a wee bit.

....

Something really disguisting we could do is recognise the indirect call
offset and emit an extra ORC entry for RIP+1. So the cases are:

	CALL *pv_ops.save_fl	-- 7 bytes IIRC
	CALL $imm;		-- 5 bytes
	PUSHF; POP %[RE]AX	-- 2 bytes

so the RIP+1 (the POP insn) will only ever exist in this case. The
indirect and direct call cases would never land on that IP.

....


> It looks like 044d0d6de9f5 ("lockdep: Only trace IRQ edges") is making
> the problem more likely, by adding the irqs_disabled() check for every
> local_irq_disable().
> 
> Also - Peter, Nicholas - is that irqs_disabled() check really necessary
> in local_irq_disable()?  Presumably irqs would typically be be enabled
> before calling it?

Yeah, so it's all a giant can of worms that; also see:

  https://lkml.kernel.org/r/20200821084738.508092956@infradead.org

The basic idea is to only trace edges, ie. when the hardware state
actually changes. Sadly this means doing a pushf/pop before the cli.
Ideally CLI would store the old IF in CF or something like that, but
alas.
