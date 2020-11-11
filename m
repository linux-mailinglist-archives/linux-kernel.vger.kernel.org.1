Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906F32AF72D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgKKRFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726915AbgKKRFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605114345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7BI6A34cDpZfmCEiKXdR3IWZbFMp1035i+ZLisC1Iv4=;
        b=jMCtQa7riit2u2W/sEA3AIBaB9SyApPEMiYBkXL77GGUz9CNQBQW0sdQwgoe1lqFiOX5pb
        ekC5uLUkZpvowg02imoquB333/dTYq/UCCkHKtUrAV0qP2i1LKBU5/7OuVjMZvzZ9wQC9C
        Z0RGX7KJUGekOjAGeKzu8u/eCppTQLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-JB56MwvqMbi2JTSrZkfi6w-1; Wed, 11 Nov 2020 12:05:43 -0500
X-MC-Unique: JB56MwvqMbi2JTSrZkfi6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C377F1087D67;
        Wed, 11 Nov 2020 17:05:41 +0000 (UTC)
Received: from treble (ovpn-120-65.rdu2.redhat.com [10.10.120.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 478FB27BB7;
        Wed, 11 Nov 2020 17:05:39 +0000 (UTC)
Date:   Wed, 11 Nov 2020 11:05:36 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201111170536.arx2zbn4ngvjoov7@treble>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 06:04:15AM +0000, Shinichiro Kawasaki wrote:
> Greetings,
> 
> I observe "WARNING: can't access registers at asm_common_interrupt+0x1e/0x40"
> in my kernel test system repeatedly, which is printed by unwind_next_frame() in
> "arch/x86/kernel/unwind_orc.c". Syzbot already reported that [1]. Similar
> warning was reported and discussed [2], but I suppose the cause is not yet
> clarified.
> 
> The warning was observed with v5.10-rc2 and older tags. I bisected and found
> that the commit 044d0d6de9f5 ("lockdep: Only trace IRQ edges") in v5.9-rc3
> triggered the warning. Reverting that from 5.10-rc2, the warning disappeared.
> May I ask comment by expertise on CC how this commit can relate to the warning?
> 
> The test condition to reproduce the warning is rather unique (blktests,
> dm-linear and ZNS device emulation by QEMU). If any action is suggested for
> further analysis, I'm willing to take it with my test system.
> 
> Wish this report helps.
> 
> [1] https://lkml.org/lkml/2020/9/6/231
> [2] https://lkml.org/lkml/2020/9/8/1538

Shin'ichiro,

Thanks for all the data.  It looks like the ORC unwinder is getting
confused by paravirt patching (with runtime-patched pushf/pop changing
the stack layout).

<user interrupt>
	exit_to_user_mode_prepare()
		exit_to_user_mode_loop()
			local_irq_disable_exit_to_user()
				local_irq_disable()
					raw_irqs_disabled()
						arch_irqs_disabled()
							arch_local_save_flags()
								pushfq
								<another interrupt>

Objtool doesn't know about the pushf/pop paravirt patch, so ORC gets
confused by the changed stack layout.

I'm thinking we either need to teach objtool how to deal with
save_fl/restore_fl patches, or we need to just get rid of those nasty
patches somehow.  Peter, any thoughts?

It looks like 044d0d6de9f5 ("lockdep: Only trace IRQ edges") is making
the problem more likely, by adding the irqs_disabled() check for every
local_irq_disable().

Also - Peter, Nicholas - is that irqs_disabled() check really necessary
in local_irq_disable()?  Presumably irqs would typically be be enabled
before calling it?

-- 
Josh

