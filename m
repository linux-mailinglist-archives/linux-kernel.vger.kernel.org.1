Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0672D41AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgLIMEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730910AbgLIMDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:03:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA68C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 04:03:13 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f480029f89b316a92fa4b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4800:29f8:9b31:6a92:fa4b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B28D1EC0118;
        Wed,  9 Dec 2020 13:03:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607515391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkDF2BGW53pllBVxbrp35zb7hHGQHDWR/sD7dvFz1IY=;
        b=HEfZeiKQCt2C7bZJNE6U0ObntUyi1mhN9sU2Pi4U4OH50xzO7goM8aBTpCO/vHZW/T20UL
        gCvwseWgnBUqsp6rixMDsQe46s2seaCU7GZWJG73Sb5KWEHRfSUOdQYEOF8C/pR3Li6VPM
        DksKCjaHWoiL91XA/+XuLCu+FKdjEN8=
Date:   Wed, 9 Dec 2020 13:03:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 07/12] x86: add new features for paravirt patching
Message-ID: <20201209120307.GB18203@zn.tnic>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-8-jgross@suse.com>
 <20201208184315.GE27920@zn.tnic>
 <2510752e-5d3d-f71c-8a4c-a5d2aae0075e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2510752e-5d3d-f71c-8a4c-a5d2aae0075e@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 08:30:53AM +0100, Jürgen Groß wrote:
> Hey, I already suggested to use ~FEATURE for that purpose (see
> https://lore.kernel.org/lkml/f105a63d-6b51-3afb-83e0-e899ea40813e@suse.com/

Great minds think alike!

:-P

> I'd rather make the syntax:
> 
> ALTERNATIVE_TERNARY <initial-code> <feature> <code-for-feature-set>
>                                              <code-for-feature-unset>
> 
> as this ...

Sure, that is ok too.

> ... would match perfectly to this interpretation.

Yap.

> Hmm, using flags is an alternative (pun intended :-) ).

LOL!

Btw, pls do check how much the vmlinux size of an allyesconfig grows
with this as we will be adding a byte per patch site. Not that it would
matter too much - the flags are a long way a comin'. :-)

> No, this is needed for non-Xen cases, too (especially pv spinlocks).

I see.

> > Can you give an example here pls why the paravirt patching needs to run
> > first?
> 
> Okay.

I meant an example for me to have a look at. :)

If possible pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
