Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AEF277AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 23:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgIXVUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 17:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIXVUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 17:20:45 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74287C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:20:45 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id r10so231768oor.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwiUYRS9W1C5pcKuYLLY/Mvk+3HUevzfSS92myNcc4U=;
        b=MLiKBzU7eG6u1Z/cGRcRTW/IvgE0Ugw6tA2RVdCNbCpRibsl54FbgQNGtPDO09KVWW
         laSauLqO5a3ly2kpMKGkHhrYAfe+eotJL4MKJBjaBMglmZ6kA4l1C6trSTQFEuonSTth
         YVEqqeDnCHiQ/+O+ovy1A1g2bmjqEPdMCm0qWjLv2eRT4BoXzRshtqzCH5k+C2B3jJeP
         SeaXFNV+IIsJth2SN44mbwvnL0Vvb1aMbHK2bmUMQXmtGMqUkFIY9SlWBxNdkTmPQwHz
         S30TODI2DIIR6puEOE0CaSAlxpAgrQ0/KG0iNmmkUiVMolMla08u0R0hWwMQH0EBZ8YZ
         an1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwiUYRS9W1C5pcKuYLLY/Mvk+3HUevzfSS92myNcc4U=;
        b=t9txLcqjlmxotQ6/V8/a3b1Q9/+VB+kJHIEjjgJ9pNP+Wy5MaUZCmQWu5nnhWbl0md
         gLJWo1R0l74hKoHJa76EQelWIz29w8ggtOgafRbGrf5K0DvlEz3ggqsY7H3fYFuxiq2B
         hB9I5FOORDZ7op1Lehw0IcCZx+MIgff/eWot7wZCgs1XssPi7yiWS6+7phJuRthFW9Yj
         Yvb2u2QIdk5Bob+ZvgGtm6ifj9ib8vtaoRV3YdE9ksQSkcWqGB5gjKB7U5tAzXUa7kRe
         c00/1VCyIYaeNoBGlm9zqDjyeiwCVtmJCRmPwg83zA/hnhOasqzx63RxrlRzIJidpeM+
         DoUg==
X-Gm-Message-State: AOAM5311fbDXAy4UDog8Fg9RtDyBMmUCP+soK4JHf7MGMha0QAf3W/3e
        aSxwh2SzYN6jhdgKAG2U4X6/5AnzjsjeAS0nuOq9me+1tZw=
X-Google-Smtp-Source: ABdhPJxc6/CsfJJe80x2UiPvXGURYoMAvRyTh+3i8yuKipBwagzD0XQvTxmmLnmMmpryvrF9Y/dN+25KPc3vdZau89w=
X-Received: by 2002:a4a:9bde:: with SMTP id b30mr850198ook.82.1600982444597;
 Thu, 24 Sep 2020 14:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600972918.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1600972918.git.thomas.lendacky@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 24 Sep 2020 14:20:33 -0700
Message-ID: <CALMp9eS2C398GUKm9FP6xdVLN=NYTO3y+EMKv0ptGJ_dzxkP+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] INVD intercept change to skip instruction
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 11:42 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> From: Tom Lendacky <thomas.lendacky@amd.com>
>
> This series updates the INVD intercept support for both SVM and VMX to
> skip the instruction rather than emulating it, since emulation of this
> instruction is just a NOP.

Isn't INVD a serializing instruction, whereas NOP isn't? IIRC, Intel
doesn't architect VM-entry or VM-exit as serializing, though they
probably are in practice. I'm not sure what AMD's stance on this is.
