Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9532A4393
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgKCK6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:58:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50384 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgKCK6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:58:10 -0500
Received: from zn.tnic (p200300ec2f10e0003c085ddaf11537c5.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:e000:3c08:5dda:f115:37c5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 24C661EC02E6;
        Tue,  3 Nov 2020 11:58:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604401089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0eBb3iz1k3ff6oq56+v0Kv7pCTv1NKfu1eGxm6iHIkw=;
        b=I7gx60bFgf5QXE+FwMSrWylpE6J7ELZCLfIhjJFDV2uLKE2NeTIDveyGroKNbygbJLKq/U
        TUYO2lPj1CbSqmSmbEG79dcSHXpAq0KrlKr879C5jsRbaMVCxKdjHlC2Odhlp2j7QZwXia
        OaKlCNjVV31ejUaWDS2ivLlU+GJgXZE=
Date:   Tue, 3 Nov 2020 11:57:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Anand K. Mistry" <amistry@google.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Joel Fernandes <joelaf@google.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        tglx@linutronix.de, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/speculation: Allow IBPB to be conditionally
 enabled on CPUs with always-on STIBP
Message-ID: <20201103105757.GC6310@zn.tnic>
References: <20201029065133.3027749-1-amistry@google.com>
 <20201029175120.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
 <839fad53-4377-592a-a0da-2cf18b5c6027@amd.com>
 <CAATStaOTMrdserLepxkSdFErrjhMKyvd_g_GNBqOo_4p932ikw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAATStaOTMrdserLepxkSdFErrjhMKyvd_g_GNBqOo_4p932ikw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 11:02:10AM +1100, Anand K. Mistry wrote:
> > I like the idea of passing in the mode you want to check, but it appears
> > they are never used independently. The ibpb and stibp modes are always
> > checked together in one of the if statements below, so you could make this
> > a function that checks both modes and just have a single call. I'll leave
> > that up to the maintainers to see what is preferred.
> 
> I can see both sides to this. Personally, I think I prefer it as-is
> since I think it improves readability a bit by making the conditions
> less complicated whilst not hiding too many details. I'll wait to see
> what others say before changing this one.

Yes, but if you make it a single function with a descriptive name, you'd
make the call sites even more readable:

	if (!is_spec_ib_conditional(..))
		bla;

or

	if (!is_spec_ib_user_controlled(..))
		blu;

and that function should simply check both spectre_v2_user_ibpb *and*
spectre_v2_user_stibp in one go.

Why should we do that?

Exactly because you both got your brains twisted just from looking at
this. Because this mitigation crap is such an ugly and complex maze that
we would take even the smallest simplification any day of the week!

Welcome to my life since meltdown. Brain twist feels good, doesn't it?

:-)))

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
