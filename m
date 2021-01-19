Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2EE2FB7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390958AbhASLXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391209AbhASLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:10:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86DEC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 03:08:35 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bca00c2aa0e949335efb7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:c2aa:e94:9335:efb7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 784801EC05DE;
        Tue, 19 Jan 2021 12:08:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611054514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Kdn7P9WzM0xVuzlmYLDRSLdnweoXLWKsFHtwTTxXd58=;
        b=Yyg/bTelymTJ0F9UpgftO+yPBlfEV8L22ww9skrs1MsNIWHTchstJ475l4N/bwhKNRDPM6
        Mr9YSQQwwscqCJ1G+UyZyWLcoWfmPt5fybGyVMa61P/Y/SKUDzDrQBEbNt33RIdk4t+JNg
        gEMmqq7jRx58floTsezJhbnPXeIXFFw=
Date:   Tue, 19 Jan 2021 12:08:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] x86/fpu: Add kernel_fpu_begin_mask() to selectively
 initialize state
Message-ID: <20210119110834.GH27433@zn.tnic>
References: <cover.1610950681.git.luto@kernel.org>
 <a9630f17c5bcafbfe297a0828c7b6c78b0f6dcbe.1610950681.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9630f17c5bcafbfe297a0828c7b6c78b0f6dcbe.1610950681.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just nitpicks:

On Sun, Jan 17, 2021 at 10:20:38PM -0800, Andy Lutomirski wrote:
> Currently, requesting kernel FPU access doesn't distinguish which parts of
> the extended ("FPU") state are needed.  This is nice for simplicity, but
> there are a few cases in which it's suboptimal:
> 
>  - The vast majority of in-kernel FPU users want XMM/YMM/ZMM state but do
>    not use legacy 387 state.  These users want MXCSR initialized but don't
>    care about the FPU control word.  Skipping FNINIT would save time.
>    (Empirically, FNINIT is several times slower than LDMXCSR.)
> 
>  - Code that wants MMX doesn't want need MXCSR or FCW initialized.

"want/need" ?

>    _mmx_memcpy(), for example, can run before CR4.OSFXSR gets set, and
>    initializing MXCSR will fail.

"... because LDMXCSR generates an #UD when the aforementioned CR4 bit is
not set."

>  - Any future in-kernel users of XFD (eXtended Feature Disable)-capable
>    dynamic states will need special handling.
> 
> This patch adds a more specific API that allows callers specify exactly

s/This patch adds/Add/

> what they want.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
