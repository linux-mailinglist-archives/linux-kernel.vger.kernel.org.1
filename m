Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9CE2D6445
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392437AbgLJR74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389278AbgLJR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:59:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3793CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:58:53 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d410017205789a0fcbfc3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4100:1720:5789:a0fc:bfc3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC6941EC0266;
        Thu, 10 Dec 2020 18:58:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607623131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwyvOQBqxuMUG7KzYXJrCDdCJAVHNYnOubZCd9QHgEo=;
        b=QAbiXUnnXNeeVEl8f1bWlVdTRkQaqyuO5GwcX57rzx5YgNGyAoPsKd8SiHoQhEKOL3cswb
        xJFTBEQqrivdDf2SutMFerrTsDT8f2MUOi3bt/x+qDD+kGByiHPn6aZFFd6jQgbpBKA5EE
        NQZ4t6DTvpVHfanMjclYCmWpEGp+G0c=
Date:   Thu, 10 Dec 2020 18:58:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 07/12] x86: add new features for paravirt patching
Message-ID: <20201210175846.GE26529@zn.tnic>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-8-jgross@suse.com>
 <20201208184315.GE27920@zn.tnic>
 <2510752e-5d3d-f71c-8a4c-a5d2aae0075e@suse.com>
 <20201209120307.GB18203@zn.tnic>
 <9e989b07-84e8-b07b-ba6e-c2a3ed19d7b1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e989b07-84e8-b07b-ba6e-c2a3ed19d7b1@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 01:22:24PM +0100, Jürgen Groß wrote:
> Lets take the spin_unlock() case. With patch 11 of the series this is
> 
> PVOP_ALT_VCALLEE1(lock.queued_spin_unlock, lock,
>                   "movb $0, (%%" _ASM_ARG1 ");",
>                   X86_FEATURE_NO_PVUNLOCK);
> 
> which boils down to ALTERNATIVE "call *lock.queued_spin_unlock"
>                                 "movb $0,(%rdi)" X86_FEATURE_NO_PVUNLOCK
> 
> The initial (paravirt) code is an indirect call in order to allow
> spin_unlock() before paravirt/alternative patching takes place.
> 
> Paravirt patching will then replace the indirect call with a direct call
> to the correct unlock function. Then alternative patching might replace
> the direct call to the bare metal unlock with a plain "movb $0,(%rdi)"
> in case pvlocks are not enabled.

Aha, that zeros the locking var on unlock, I see.

> In case alternative patching would occur first, the indirect call might
> be replaced with the "movb ...", and then paravirt patching would
> clobber that with the direct call, resulting in the bare metal
> optimization being removed again.

Yeah, that explains the whole situation much better - thanks - and
considering how complex the whole patching is, I wouldn't mind the gist
of it as text in alternative_instructions() or in a comment above it so
that we don't have to swap everything back in, months and years from
now, when we optimize it yet again. :-}

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
