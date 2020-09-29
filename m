Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441E327CEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgI2NXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgI2NXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:23:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179C1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:23:05 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ead002e8cabed22dc07c6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:ad00:2e8c:abed:22dc:7c6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 94AE31EC03CE;
        Tue, 29 Sep 2020 15:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601385783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qJWK6oVsor6MMB8V/whGU+FkMsOlIUQbLsxtldtAgmE=;
        b=ZZ0R3km1p3b50/n8sG68AMnJ0HuJ6kzG2/EQ+iMT469VS1CAz3JP7bTHT14KEqsnALGpR4
        zdFDeKzSWvWsLTi8dQSu/jVZlLE+psQGWHnQfw6jFvsi+kybvgnuvwyXrDDR2XoWWyf2lV
        ha5DA4nXoCRzr4yiHyPYwC3Nr+OE4uo=
Date:   Tue, 29 Sep 2020 15:22:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marc Zyngier <maz@misterjones.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Rabin Vincent <rabin@rab.in>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Add RIP to scripts/decodecode
Message-ID: <20200929132255.GE21110@zn.tnic>
References: <20200929113238.GC21110@zn.tnic>
 <b18c145f7b96cace7cd503de33c08311@misterjones.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b18c145f7b96cace7cd503de33c08311@misterjones.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 01:40:03PM +0100, Marc Zyngier wrote:
> Hi,
> 
> [dropping these ARM people I never heard of...]

Yeah, I completely forgot that those ARM folks are not there anymore,
thx! :-)

> Looks neat. Only objection is that RIP is pretty tainted from an
> architecture perspective. How about PC instead, which most people
> understand immediately?

Sure.

> Bonus points if you can convince decodecode to grok something such
> as "do_undefinstr+0x2e0/0x2f0" as the PC! ;-)

Well, I thought about it. And I don't know how the splats look on ARM
but on x86 we're not dumping the actual PC contents anymore:

[  477.366747][T23917] KASAN: null-ptr-deref in range [0x0000000000000100-0x0000000000000107]
[  477.374897][T23917] CPU: 1 PID: 23917 Comm: syz-executor.0 Not tainted 5.9.0-rc7+ #1
[  477.376375][T23917] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1 04/01/2014
[  477.378098][T23917] RIP: 0010:gfs2_rgrp_dump+0x37/0x660
			^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

so I could make the splat code dump PC again, but in brackets:

[  477.378098][T23917] RIP: 0010:gfs2_rgrp_dump+0x37/0x660 (0xffffffff8329a927)

or I would have to somehow have access to vmlinux or symbols which would
give me the function address. But that is not always the case - most of
the time you see a splat somewhere and that's all.

Unless you have a better idea...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
