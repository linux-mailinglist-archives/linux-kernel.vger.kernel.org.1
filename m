Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C902DD6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 19:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgLQR7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:59:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B22C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:58:44 -0800 (PST)
Received: from zn.tnic (p200300ec2f10f600810bdc721ae5a957.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:f600:810b:dc72:1ae5:a957])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C9311EC059F;
        Thu, 17 Dec 2020 18:58:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608227921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lKW6EtXXc6FSMLz1VCn2XUrBr7oBxyq39Ngz4VM1cWk=;
        b=bBNVrca05lJxFhpxTxV+W4PTx0VRgtjrAjg6UPLFzrNAB9dpCk0p2Xh7zIJnStHEF/J3j/
        4wwbQDz4Yfa0Z37IgpwEc6UmaK8JUqBZ17/ecbK0jnsV4v7RwbeIJhAe8+9JTlJaWPrkD4
        GtOdmEP2R2qt2LieeDWhOUPj+Noe2/4=
Date:   Thu, 17 Dec 2020 18:58:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
Message-ID: <20201217175837.GD23634@zn.tnic>
References: <20181107171010.421878737@linutronix.de>
 <20181107124855.328133e7@lwn.net>
 <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
 <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
 <20181108074920.4c601ee3@lwn.net>
 <alpine.DEB.2.21.1811081637550.1549@nanos.tec.linutronix.de>
 <20201217150537.GC23634@zn.tnic>
 <20201217105323.4d882a7d@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201217105323.4d882a7d@lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 10:53:23AM -0700, Jonathan Corbet wrote:
> Gee...a response from a two-year-old thread...

You know how we love to document stuff, right? :-)

> it's taking me a while to page all of that back in :)

Here's the gist of your concern:

https://lkml.kernel.org/r/20181108074920.4c601ee3@lwn.net

> I'd love to see this work get in, I still feel bad about my part in
> stalling it before.

Why? It makes sense - you want the generic stuff which holds true for
the whole tree to be in generic docs. Read your example again and you'll
persuade yourself again. :-)

> Piecemeal could certainly work, or we could just try the whole thing and
> see what happens.  We got Thorsten's reporting-issues tome in without much
> trouble, after all, and that's bikeshed territory if anything is.  But
> whatever works is fine; send stuff and I'll gladly look at it.

Yeah, let's start slowly and small. We'll get there eventually... I
hope.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
