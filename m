Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38D2A74BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbgKEBNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbgKEBNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:13:33 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF3EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:13:33 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id n129so109054iod.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 17:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WyMUvbXsD6Cd+HVdB+2QZriRko6wOVZOY2U2kpsjkk=;
        b=bejopD0/53NQT2et/Tqaoe01gsRyjXFWDSyt5m9oR+m5MOiQmcSDOM6dIUzMijVryE
         UvNui8Sloeb7KP02V25AJpAh6hGcKPQ6BMrlRR9sSicZi04bBcnP95pyznQzC4BxzZ3Y
         pfHnmf5VgkclUnQ2DsYONEDl7Vi3R4KWlq4jdiEFn4umPmuEpUiS2GguTXV7YEJ2n1Ig
         7WzxnyRFFFS57KNwbKTwQVo5dO1Re71skgyTne7yCxOlnvB0VTsrNXo6mg70XCNrXvDO
         FxMqjuZNzP8fUGPK21zFfain+3IQBSNVFiHoEvIMDKqJGvsGoFkBrz3RxTMSI2AS0W5i
         WVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WyMUvbXsD6Cd+HVdB+2QZriRko6wOVZOY2U2kpsjkk=;
        b=rkUPN3/xmkLkE547zMK9H9UK2y1zUfXlJzK9I4cmM9eXfQXjto+sNadeqa9emZZFyO
         byxEJEr3pa79Foo7fGTE+Am2VlHCmRBEJ8HmD0DEnISGn4xB/gXlN3CO3yHIy7FIkxcd
         NmVrGIlutRh2DojR/Z1x0N7yVoFJgI+nxBDHIsXxbPz/2IzC6OAshPrsjMgCNZCZhMZv
         mECt7IuAXMpOEGC+Ka7RloC56MMM3ttAT4rO+rB6dEN+b5r6AyIS2V+Ff86RsmODgrWq
         4hFZBtxU3P/Go9hCKGney2w7+/MJ/PEQpX0LCju0OdW+7RI3bVFBucqzqfs0UhptmyP4
         pFVw==
X-Gm-Message-State: AOAM5327ahoKdQfSZnehv//rdA6ScrcKYo7uHkctG3JIPJZIvc3i6yEt
        JX/pnghBY/KWeGz23WDfx4Qd5Cz4G/JIkVPY8en4jg==
X-Google-Smtp-Source: ABdhPJxKzIMW+W4/Irmr0AYIO8+4LYffxxsv3cSZdbUN89MPQrjyhia7zxBC/v3iKVZoaoKOPfR2vRrY+G2Z5QlAD8c=
X-Received: by 2002:a02:c952:: with SMTP id u18mr174505jao.139.1604538811818;
 Wed, 04 Nov 2020 17:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20201029065133.3027749-1-amistry@google.com> <20201029175120.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
 <839fad53-4377-592a-a0da-2cf18b5c6027@amd.com> <CAATStaOTMrdserLepxkSdFErrjhMKyvd_g_GNBqOo_4p932ikw@mail.gmail.com>
 <20201103105757.GC6310@zn.tnic>
In-Reply-To: <20201103105757.GC6310@zn.tnic>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Thu, 5 Nov 2020 12:13:20 +1100
Message-ID: <CAATStaPkPUb-gSJTcYP0Xdnc+2i649iCquJE6Y4VpBcw7+L8Uw@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/speculation: Allow IBPB to be conditionally
 enabled on CPUs with always-on STIBP
To:     Borislav Petkov <bp@alien8.de>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020 at 21:58, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Nov 02, 2020 at 11:02:10AM +1100, Anand K. Mistry wrote:
> > > I like the idea of passing in the mode you want to check, but it appears
> > > they are never used independently. The ibpb and stibp modes are always
> > > checked together in one of the if statements below, so you could make this
> > > a function that checks both modes and just have a single call. I'll leave
> > > that up to the maintainers to see what is preferred.
> >
> > I can see both sides to this. Personally, I think I prefer it as-is
> > since I think it improves readability a bit by making the conditions
> > less complicated whilst not hiding too many details. I'll wait to see
> > what others say before changing this one.
>
> Yes, but if you make it a single function with a descriptive name, you'd
> make the call sites even more readable:
>
>         if (!is_spec_ib_conditional(..))
>                 bla;
>
> or
>
>         if (!is_spec_ib_user_controlled(..))
>                 blu;
>
> and that function should simply check both spectre_v2_user_ibpb *and*
> spectre_v2_user_stibp in one go.
>
> Why should we do that?
>
> Exactly because you both got your brains twisted just from looking at
> this. Because this mitigation crap is such an ugly and complex maze that
> we would take even the smallest simplification any day of the week!

Ok then, two votes for. I'll make the change in v2 and post that up today.

>
> Welcome to my life since meltdown. Brain twist feels good, doesn't it?

I don't think "feels good" are the words I'd use.

>
> :-)))
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Anand K. Mistry
Software Engineer
Google Australia
