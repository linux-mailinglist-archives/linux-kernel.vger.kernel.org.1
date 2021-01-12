Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA252F3DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbhALV4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbhALV4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:56:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB351C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:55:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o19so5684470lfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=391/aBiA2qochS6pTL8d1JkuyejrSRQMbWVrhMmzLt4=;
        b=ZeUW+1KZ7ytFAsajUvvMyuN2NCPY10FGts1P2BzghpaXEX3swAyDSiTYsoGa3AhWHI
         Q2Wxu7FmcMBQCZku/xesxcNmU3SNmg44700bqnq+/UIiLR618puVTmfY8J8gk8fDNPj3
         Nm434rNrraYgh8Dz+YMyTwPUCEpXjdSKZTtbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=391/aBiA2qochS6pTL8d1JkuyejrSRQMbWVrhMmzLt4=;
        b=W6VeO0E9lVs8vUeHWt5tIoZf6DDfNoSoJos5/MTestG9bg7ZgtTVbBntboSGO64aYu
         iMKR24xPfA+MEgVyQng5Au05jXnBbZNiUbDQEEWVRPuznFVgjlInQcPMX+z/ZSvieLJ7
         8a4uzoIdes/0SpwNBb/NeUTva5e1s1jjgjA9KMSyvr3sYstDv1hAWSwrCOCyz3MUWj2f
         lFoK/remPBc5v+tXmLt5Ref2ABYe0XsasgKs8m0iKJxqd/kfbyf0pIsk9iJwtCyqTgb2
         ypfg9IMCwEsq1x6Mnbk4Y4d7d/FfeVSYKaidEqoKloTQ0iu68+2/aJritejgG6oZ437t
         FmKg==
X-Gm-Message-State: AOAM532taCip7/CDZct0zJF8nl7ZNU4wJd9PXUrvwpBRW8fPU60ycPe8
        aNFBjwowxsj8C2rWUIig+2f+GgJAILlBSw==
X-Google-Smtp-Source: ABdhPJzMe3jX0N9ic8HJGDr6E5eSp24+tcYTttBa6k5/HflfzHAjMtqE+C6r50CverOnkMsMtyt1AQ==
X-Received: by 2002:ac2:50d0:: with SMTP id h16mr392980lfm.300.1610488539865;
        Tue, 12 Jan 2021 13:55:39 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id k10sm493148ljg.13.2021.01.12.13.55.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 13:55:39 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id e7so205495ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:55:38 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr525749ljc.411.1610488538323;
 Tue, 12 Jan 2021 13:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20210108171517.5290-1-will@kernel.org> <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
 <20210111142402.6euyktmcnpemanf7@box> <CAHk-=whYs9XsO88iqJzN6NC=D-dp2m0oYXuOoZ=eWnvv=5OA+w@mail.gmail.com>
 <20210112214759.GC10434@willie-the-truck>
In-Reply-To: <20210112214759.GC10434@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jan 2021 13:55:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi4tws9Haoccs+_D841tAh+5TdvdZyX+0T6gOKV_Fd3SA@mail.gmail.com>
Message-ID: <CAHk-=wi4tws9Haoccs+_D841tAh+5TdvdZyX+0T6gOKV_Fd3SA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
To:     Will Deacon <will@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 1:48 PM Will Deacon <will@kernel.org> wrote:
>
> > And then if somebody actually needs to pass in "modified fault state"
> > (ie that whole "I'm doing fault-around, so I'll use multiple
> > addresses") they'd never modify the address in the fault info, they'd
> > just pass the address as an explicit argument (like most cases already
> > do - the "change addr or flags in vmf" is actually already _fairly_
> > rare).
>
> Alright then, I'll take another crack at this for v3 and see how far I
> get.

But please do keep it as a separate patch, and if it turns out to be
ugly for whatever reason, treat it as just a "maybe that would help"
suggestion rather than anything stronger..

           Linus
