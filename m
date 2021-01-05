Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79562EA814
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbhAEJ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbhAEJ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:57:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DCDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:56:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id g20so40504783ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5A1eUdVV8jBV9FEHfLRhVvTQqvHBMIsWDnMOxR+ewyE=;
        b=U61CdFz6T+oAkKvSQ9QI5MXmNVYjzQi0wTyqHIllBuU/CxsweaJWmgoPPRK+gaIN0d
         6/gEdEEze+t0/ZCSjn4OYQDJ0Yao759E+CrgTQkZoMD2MPwd1UDSp9D3yS5Sxd4BA6rh
         PW+nBYAR2EI0vq6q81zwDR1qHbsXNLAJ2XtUHXiqm6b+Iy14v0xK8RH53ksf8IC5jtk2
         ZQH2CN4tw1UshBS6Fj+LqOn3AeydMmjJk+IoyEVVRuxXEiebrBI3mMeFNWtt8A3eGKjX
         jm4v4qT+Bq1k6i7XOL1EVuExk5njF0b2DXNKikljHEcqr20oGrBaCDfjuxysaDb1Ju+G
         A2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5A1eUdVV8jBV9FEHfLRhVvTQqvHBMIsWDnMOxR+ewyE=;
        b=EPzxVT5LYxZ/qYo0tqRBUXb5m3+TsuAoSuJESP9cZLNcyanP0WeNlc9v6L3VH8o1sN
         bmtr6prCcBbVBW+hkV0FyjyA53Fe10C5cgtcRYswHhu9XFuNvJg7wTpbWuDsDdXjdATm
         FG3ZXTLsS1tXvYsSqluwSf5OIzvmXsvUGsTgEHwlamkjvGWR9DsvXJEG3/TMfTVLk2Sq
         INK2d5V8em1KoylDlBkBAKs8SGYooyDjhdT5D0y/IRvxlJKuKj/QLan27fDQ81mZrNB2
         GyI4+Ae+CCxRY2RQpnh76PR7Yd9JPAKGt1glsXCTTPZaRu8c0U1azCkROg5SHRj7eWJn
         V7KA==
X-Gm-Message-State: AOAM531D+1kIBruB0ezOU+bQEZvNE7C4B1X/HaDcf9J0V3A6XxGn3U2a
        T76D/tH864f3ja91A8knroJ2v4FTjlrmZXgj84BQrA==
X-Google-Smtp-Source: ABdhPJx3T7oCFvaCFTsIh3wLFkrXm4bB5+s0iVNYifNCqlR8z6OYgyLaQRObOPhEkkEw48QDxYukc0EeCozjt4evdg0=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr69092588ejz.45.1609840594391;
 Tue, 05 Jan 2021 01:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20210104100323.GC13207@dhcp22.suse.cz> <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <CAPcyv4h6mdKrwpqXfO0e_=sKjB-pY5KbP9ii+tQyFsK5bPkb=A@mail.gmail.com>
 <b5109800-a860-0f82-3e45-c0768cb1b038@redhat.com> <CAPcyv4jATooJTwXXGBvPrcCu57Ldt=6aBSEzaSqbwcHmczVaZg@mail.gmail.com>
 <dd49a67a-109e-b5c1-2010-572587fe4ed6@redhat.com>
In-Reply-To: <dd49a67a-109e-b5c1-2010-572587fe4ed6@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 5 Jan 2021 01:56:22 -0800
Message-ID: <CAPcyv4gMBvHwk6_QzpdKBwWZvRjaFYsN=0O8A9c39q2=CarqGA@mail.gmail.com>
Subject: Re: uninitialized pmem struct pages
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 1:37 AM David Hildenbrand <david@redhat.com> wrote:
>
> >> Yeah, obviously the first one. Being able to add+use PMEM is more
> >> important than using each and every last MB of main memory.
> >>
> >> I wonder if we can just stop adding any system RAM like
> >>
> >> [     Memory Section    ]
> >> [ RAM ] [      Hole     ]
> >>
> >> When there could be the possibility that the hole might actually be
> >> PMEM. (e.g., with CONFIG_ZONE_DEVICE and it being the last section in a
> >> sequence of sections, not just a tiny hole)
> >
> > I like the simplicity of it... I worry that the capacity loss
> > regression is easy to notice by looking at the output of free(1) from
> > one kernel to the next and someone screams.
>
> Well, you can always make it configurable and then simply fail to add
> PMEM later if impossible (trying to sub-section hot-add into early
> section). It's in the hands of the sysadmin then ("max out system ram"
> vs. "support any PMEM device that could eventually be there at
> runtime"). Distros would go for the second.
>
> I agree that it's not optimal, but sometimes simplicity has to win.

Here's where we left it last time, open to pfn_to_online_page hacks...

https://lore.kernel.org/linux-mm/CAPcyv4ivq=EPUePXiX2ErcVyF7+dV9Yv215Oue7X_Y2X_Jfw8Q@mail.gmail.com

I don't think a slow-path flag in the mem-section is too onerous, but
I'll withhold judgement until I have the patch I'm thinking of
in-hand. Let me give it a shot, you can always nack the final result.
