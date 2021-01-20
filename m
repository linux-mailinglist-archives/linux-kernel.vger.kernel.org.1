Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B302FD027
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbhATMRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 07:17:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46514 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730205AbhATLyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:54:12 -0500
Received: from zn.tnic (p200300ec2f0bb0007fac97ee58c503f0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b000:7fac:97ee:58c5:3f0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6ECA1EC0323;
        Wed, 20 Jan 2021 12:53:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611143605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qYTF8kHZLrkwLTvfnKGIX2MHz34xKdPwTmuPEsWL2GM=;
        b=OMMdTp3rxN5nUFcPP0IlZ7IGg8t2ERmkLyb01nliuhHScbt/rK9alGwwRIiU2maCgBjilB
        XJjvgd8qQSl+xSTf2fXW/8s2h4WBRXnSTn90dN1RZQBuJ7ZTJfv2j89qfzOCbT0Pwlhcp1
        /icDQjEnDTA6uIxnZmYAKMtKNVTjal8=
Date:   Wed, 20 Jan 2021 12:53:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/4] x86/fpu: Add kernel_fpu_begin_mask() to
 selectively initialize state
Message-ID: <20210120115324.GE825@zn.tnic>
References: <cover.1611077835.git.luto@kernel.org>
 <d3197b2d887dab3bf3d9984e2b74b0146d3568fb.1611077835.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3197b2d887dab3bf3d9984e2b74b0146d3568fb.1611077835.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 09:38:59AM -0800, Andy Lutomirski wrote:
> Currently, requesting kernel FPU access doesn't distinguish which parts of
> the extended ("FPU") state are needed.  This is nice for simplicity, but
> there are a few cases in which it's suboptimal:
> 
>  - The vast majority of in-kernel FPU users want XMM/YMM/ZMM state but do
>    not use legacy 387 state.  These users want MXCSR initialized but don't
>    care about the FPU control word.  Skipping FNINIT would save time.
>    (Empirically, FNINIT is several times slower than LDMXCSR.)
> 
>  - Code that wants MMX doesn't want or need MXCSR initialized.
>    _mmx_memcpy(), for example, can run before CR4.OSFXSR gets set, and
>    initializing MXCSR will fail.
> 
>  - Any future in-kernel users of XFD (eXtended Feature Disable)-capable
>    dynamic states will need special handling.
> 
> This patch adds a more specific API that allows callers specify exactly
> what they want.

Same nitpicks:

https://lkml.kernel.org/r/20210119110834.GH27433@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
