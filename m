Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84945273D08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVINW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgIVINU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:13:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6BEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 01:13:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bfb00524dde00a85e5113.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:fb00:524d:de00:a85e:5113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF7931EC047E;
        Tue, 22 Sep 2020 10:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600762398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RO2mwEZQvbGv43zRsrwkkh5Y8NPYbXfILlq13bVVM58=;
        b=gZxU80DorfVEsOkK9g6HQnW2kx2knAGdhVgQlPkPicf4AUv6bkMi19vJY9tLqUYoiIw0mB
        g6nn02f4nb0CpTDrccAbHc0xZMSPv5fG5vdAyKjFMThnGmZu1L7PQ2zxNzHM44/TZXJQB5
        CVoDdHFlrP1PyElsxBadC9l1G5anqoM=
Date:   Tue, 22 Sep 2020 10:13:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Use feature bit names in clearcpuid=
Message-ID: <20200922081312.GA22660@zn.tnic>
References: <20200920154228.GB7473@zn.tnic>
 <87mu1ib5mw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mu1ib5mw.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:03:03AM +0200, Thomas Gleixner wrote:
> On Sun, Sep 20 2020 at 17:42, Borislav Petkov wrote:
> > Hi,
> >
> > so tglx hates this clearcpuid= interface where you have to give the
> > X86_FEATURE array indices in order to disable a feature bit for testing.
> > Below is a first attempt (lightly tested in a VM only) to accept the bit
> > names from /proc/cpuinfo too.
> >
> > I say "too" because not all feature bits have names and we would still
> > have to support the numbers. Yeah, yuck.
> >
> > An exemplary cmdline would then be something like:
> >
> > clearcpuid=de,440,smca,succory,bmi1,3dnow ("succory" is wrong on
> > purpose).
> >
> > and it says:
> >
> > [    0.000000] Clearing CPUID bits: de 13:24 smca bmi1 3dnow
> >
> > Also, I'm thinking we should taint the kernel when this option is used.
> >
> > Thoughts?
> 
> Yes, instead of making it differently horrible, can we finally remove that
> nonsense which should have never been there in the first place?

Fine with me - I don't need it.

I believe dhansen has a use-case or two, CCed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
