Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969F8250140
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgHXPgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 11:36:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54912 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgHXPgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:36:18 -0400
Received: from zn.tnic (p200300ec2f07f000112729bd4d59e57d.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:f000:1127:29bd:4d59:e57d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 539DD1EC0104;
        Mon, 24 Aug 2020 17:36:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598283376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LAKAxaYq4Tu211yNOD9ppBA3I/Gpf/vnCCr/iYWecHA=;
        b=ezN4asebCz4Gx0prWtC6o6ksyPfsud59bqN3+IEwXlNABS6vo9v2qq441MVQS79cIn95PV
        HL7Y2maibwfIdC6hJZaIPCEbdDNw7rpiafTlZiHTCeGbVehCrscXv7MrrcRa5wed/5JPPk
        UY8VOvTwNQ3CDtOmWC9FEHVGvZt2Zp8=
Date:   Mon, 24 Aug 2020 17:36:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for HPE Superdome Flex (UV)
 maintainers
Message-ID: <20200824153611.GD4732@zn.tnic>
References: <20200821154848.GI7871@localhost.localdomain>
 <20200824144523.GB60946@swahl-home.5wahls.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824144523.GB60946@swahl-home.5wahls.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:45:23AM -0500, Steve Wahl wrote:
> Added Darren Hart, Andy Shevchenko, Thomas Gleixner, Ingo Molnar,
> Borislav Petkov, and x86.kernel.org, after being told that
> get_maintainers.pl doesn't work on MAINTAINERS.
> 
> Thanks,
> 
> Steve Wahl, HPE
> 
> On Fri, Aug 21, 2020 at 10:48:49AM -0500, Steve Wahl wrote:

I could use a sentence here as a commit message, even if it repeats the
subject line.

> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index deaafb617361..4c2143d8ae45 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18874,6 +18874,15 @@ S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> >  F:	arch/x86/platform
> >  
> > +X86 PLATFORM UV HPE SUPERDOME FLEX
> > +M:	Steve Wahl <steve.wahl@hpe.com>
> > +R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
> > +R:	Russ Anderson <russ.anderson@hpe.com>
> > +S:	Supported
> > +F:	arch/x86/include/asm/uv/
> > +F:	arch/x86/kernel/apic/x2apic_uv_x.c
> > +F:	arch/x86/platform/uv/
> > +
> >  X86 VDSO
> >  M:	Andy Lutomirski <luto@kernel.org>
> >  L:	linux-kernel@vger.kernel.org
> > -- 

Looks ok to me, otherwise.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
