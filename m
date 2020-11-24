Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866B72C3033
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404335AbgKXSvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:51:12 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:37489 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbgKXSvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:51:11 -0500
Received: by mail-ej1-f65.google.com with SMTP id z5so9915662ejp.4;
        Tue, 24 Nov 2020 10:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0R+EtKLcwBUIWNPi6ZHdj1eAgyrTOpvSjIN7TNW7t4=;
        b=J7e9W8FFOQD9AOYLW4eYtB+FWzu2WQLvTCpklH/x2EvnCxgBgW68znPsSlazeOdyMz
         fODgjjoyeef5ni5vXKdvaQdDBbNL6wuOa+iH5DkNUEaRMr319wGs9NmwhIrl3dKEo9xk
         aJDxx8sjTWq1B65dhA52rVdtLAJHukJDjQkw0YsqU6D+/m23zlk7InezzTELPAFxpNH9
         HySzPK9QI2FuOf3+SyOQghQH7Jde19hdsaIGnX/8247SWnjVBmOBXF7AiMfgXnfpDYGC
         jsePtY7ENuOw63phiPCDjI+Nf2kwbL9CWb5yxmbREUKLdeW/S8DHKkw+KXzRxHGX28H5
         /UXg==
X-Gm-Message-State: AOAM533EImo1fraDkJBJyATyoLvJ8XtQoRYcKD9c9DTIpGFZ+M7m2CBI
        WEAjHR9ef1RZVVRVtXtoRrB7QtGMEqLc5GxJULGBKt8tJMw=
X-Google-Smtp-Source: ABdhPJzQinRO0l6tnBe2mj7AAuZg0aZU9mTVb7m/VOeaa82ddlcWM2AAVL5a9KzUSHsMsTWMYXDVlRM0qa58a1rHLNQ=
X-Received: by 2002:a17:906:578b:: with SMTP id k11mr5521318ejq.330.1606243869540;
 Tue, 24 Nov 2020 10:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
 <20201119233257.2939-23-chang.seok.bae@intel.com> <CALCETrXBRATBVySDM9f0H-+gD37n7=CsNLWa446eLHi1mjokGw@mail.gmail.com>
In-Reply-To: <CALCETrXBRATBVySDM9f0H-+gD37n7=CsNLWa446eLHi1mjokGw@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 24 Nov 2020 13:50:58 -0500
Message-ID: <CAJvTdKng_WMrmO_KtkuCxvvzGZ_HLcd84u2SwJiD_UJivb4Yaw@mail.gmail.com>
Subject: Re: [PATCH v2 22/22] x86/fpu/xstate: Introduce boot-parameters for
 control some state component support
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:03 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Nov 19, 2020 at 3:37 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> > "xstate.enable=0x60000" will enable AMX on a system that does NOT have AMX
> > compiled into XFEATURE_MASK_USER_ENABLED (assuming the kernel is new enough
> > to support this feature).
> >
>
> What's the purpose of xstate.enable?  I can't really imagine it's
> useful for AMX.  I suppose it could be useful for hypothetical
> post-AMX features, but that sounds extremely dangerous.  Intel has
> changed its strategy so many times on XSTATE extensibility that I find
> it quite hard to believe that supporting unknown states is wise.

Not hypothetical -- there are subsequent hardware features coming that
will use the same
exact XSTATE support that this series puts in place for AMX.

We know that when those features ship in new hardware, there will be
a set of customers who want to exercise those features immediately,
but their kernel binary has not yet been re-compiled to see those
features by-default.

The purpose of "xstate.enable" is to empower those users to be able to
explicitly enable support using their existing binary.

You are right -- the feature isn't needed to enable AMX, unless somebody went to
the trouble of building a kernel with the AMX source update, but chose
to disable
AMX-specific recognition, by-default.

thanks,
Len Brown, Intel Open Source Technology Center
