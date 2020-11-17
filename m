Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248B92B5BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgKQJSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:18:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45382 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgKQJSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:18:45 -0500
Received: from zn.tnic (p200300ec2f1013008dee3addeed0ca22.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:1300:8dee:3add:eed0:ca22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D5C01EC03D5;
        Tue, 17 Nov 2020 10:18:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605604724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rbikV7BXkOw+k4+ExJQ238GNgrFHk9HjzHfX7ZZpv4U=;
        b=qkU3HYeNhT2a0N0WA4BP2rvjX8OoVJ9HcRc4S+/F4r9aF4g2AZUJvBxT+73uiaXlNHsz6B
        G8lg97nc847JuWrg6apInBM7UJjNRHI1lavgpU8HwYtgOK2aATntYlqAnBP4WOk/VEfsox
        WkrkWUOHYr/q1blerhad0xsNi9chnFc=
Date:   Tue, 17 Nov 2020 10:18:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ashok Raj <ashok.raj@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] x86/microcode/intel: check cpu stepping and
 processor flag before saving microcode
Message-ID: <20201117091837.GA5719@zn.tnic>
References: <20201113015923.13960-1-yu.c.chen@intel.com>
 <20201116122735.GA1131@zn.tnic>
 <20201117022518.GA17555@chenyu-office.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117022518.GA17555@chenyu-office.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:25:18AM +0800, Chen Yu wrote:
> If I understand correctly, the only place that invokes
> save_mc_for_early() is in generic_load_microcode(). While in
> generic_load_microcode() only microcode has a newer version will be
> saved by checking has_newer_microcode(), and this function leverages
> find_matching_signature() to check if the candidate is of the same
> signature. So when it comes to save_microcode_patch(), the signature
> already matches. In case save_mc_for_early() will be invoked by other
> function in the future, it is okay to add this check too.

The important aspect is that you need to save in intel_ucode_patch
the *exact* patch for the CPU you're running on. The code above that
in save_microcode_patch() adds patches of the same family/model but
*not* same stepping to the microcode cache in case we want to support
mixed-stepping revisions. And those you don't need to check for exact
match.

What I'd like, however, is to get rid of that mixed-stepping support -
which is total nonsense anyway, if you ask me - and that would simplify
the code a *lot* more.

Thx for testing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
