Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF92928A914
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 20:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgJKSBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 14:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgJKSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:00:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53613C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:00:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a4so14614846lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNNvgBzHamQEBglLQj/Di7Kf6nIIxTZtQxib6fmM/9s=;
        b=LwvBPBXOsYu3VL8vTTMrCtrcy1wgM6KNHsABoO1JkU/frPQI1Qi2yfa1XkCB0q3+wY
         9nUg/fcWLSc7IDbq97X8IAKMy/sE69diwe+ljGLUSewMbt+9wCLn8PZoD2zcKjKIG8I1
         ZvGN6r8Su28Sv94ILcFEMsDNOAm9m8kdgbZJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNNvgBzHamQEBglLQj/Di7Kf6nIIxTZtQxib6fmM/9s=;
        b=pztM3p7VQmTPqmGqVfeMlNFQMnwiT+pF9I1DcEU/dHanxRPF91iitAc3D1w/BgwJN+
         nepouDhR1jpZZm+sc6r+tvNnD3Ur16W1sV4pVa1CAAW8Ww3i1cUisoc3qP9CAYAkUAeB
         IKrgR8BrtrQAFEEBPJ3aVUToaUhuicid3ATsa4+ROaZ69Vy3t36ZXwpE1vLpzNV0teeo
         PEemDU8e7g6VgneuSS+k4O1HL+8jgr36OMIXZxbtN/M0KVIekjpjq7T7DDu7fkOWIpMF
         MTg8j8msPfIjRxE/m06lEhK3Yxz40RiIWMsMCwS7EHcCEVuWFI2fxz+sgwso3kS4zTKi
         xFKw==
X-Gm-Message-State: AOAM532DRh7tESqGND5KtM8CizE4A/KYc0xN9y7eCG70LYopSdFP2c1L
        PRwmJpRgdgQTOY5jSi7+h1vjXf+obSPBPQ==
X-Google-Smtp-Source: ABdhPJxGQGZWCrVDh0+pIOb5yWRevaTe/Un61GtwZyykCZtqcKlhZiuIHebKRthmyzN/BpPv37nmBg==
X-Received: by 2002:a05:651c:1077:: with SMTP id y23mr9608231ljm.245.1602439254478;
        Sun, 11 Oct 2020 11:00:54 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id q8sm626255lfc.3.2020.10.11.11.00.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2020 11:00:53 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a23so13858682ljp.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:00:53 -0700 (PDT)
X-Received: by 2002:a2e:8092:: with SMTP id i18mr8504355ljg.314.1602439253284;
 Sun, 11 Oct 2020 11:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201011080859.GA3598074@gmail.com>
In-Reply-To: <20201011080859.GA3598074@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Oct 2020 11:00:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_Uc6uFAXRa+3PAi0eRpu0Uw5v40VjKTj3B21VbOd1rg@mail.gmail.com>
Message-ID: <CAHk-=wi_Uc6uFAXRa+3PAi0eRpu0Uw5v40VjKTj3B21VbOd1rg@mail.gmail.com>
Subject: Re: [GIT PULL] x86 fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 1:09 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>  - Fix a (hopefully final) IRQ state tracking bug vs. MCE handling

Why is the nmi_enter/nmi_exit thing not a problem on non-x86 architectures?

Put another way: x86 does extra work to track IRQ state across NMI.
What makes x86 special? It _feels_ to me like everybody should do
that? No?

Please tell me what I've missed..

                   Linus
