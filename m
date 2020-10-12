Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948C028C480
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbgJLWIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgJLWIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:08:06 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFF6C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:08:05 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so19902925lfj.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X34KQs/vcigGhxxV+79zHkAyVLY+dd5sS45uXaBNNnM=;
        b=K8mmayY1C8A3OlP7xuyLFiwDjU2CtJdTyFLrtI2i7KGl30eLu3tWr7gNXvwnGxt4V+
         5MeO5h51wBP+rl832pi5/0tBVKjrPmMisTkPYyw7701B2XeYK4nMbvbwCCqeKDlbSMiL
         q46EKkAsbOegX7aCeT1BOUgyyT4yt9hizqel4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X34KQs/vcigGhxxV+79zHkAyVLY+dd5sS45uXaBNNnM=;
        b=HIdn5TLmcl31mT7sbSxqxMzZqZBT4UfC8RC6oKr9YQz9XvFmhhz9U7qKDMsB85Bnec
         4WJm0Goy15vhOUdyg+ZlmeMhe8K+om0m4JuXYiyzLTa9Smx3alSdgmCa8d+t8JDT5WAb
         Qtp/KLjKO0XnliHQnQF85JvY5hkmHZevbqG7J/Xw6KdHk80QXIm+8EcwFwt4fc/0U1RD
         dOvY8sqvJxVnr6ICTfTHf2/66V9I1/dDp3nXd4a+QFlS5+nwPC3pLXCxJ/991/hVBwtM
         ovtj6i2856wAYcYWUt2IcLFNpAna8CneAmTHaz5KERgbYvDiSanXyTihgqsamZZIm+5L
         M6EA==
X-Gm-Message-State: AOAM532uJsE4TVua7Qdp/kF46bLay3EWpMo5Yeg14mLOItb6AhLNzSPe
        S6dm7rXnIOIXJPZc7Pv9fMfaHiYknGlOWg==
X-Google-Smtp-Source: ABdhPJyFZ/KfMxIJAIOAI530SOX8Y8+jkB0Bb+B4ncREYR7xVhSarbD6E1kkHRXI2V3zZX5OkDICGw==
X-Received: by 2002:a19:7d0b:: with SMTP id y11mr9431232lfc.305.1602540483650;
        Mon, 12 Oct 2020 15:08:03 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y143sm2117109lff.160.2020.10.12.15.08.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 15:08:02 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id a5so18311944ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:08:02 -0700 (PDT)
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr3735821ljp.312.1602540481791;
 Mon, 12 Oct 2020 15:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201012172415.GA2962950@gmail.com>
In-Reply-To: <20201012172415.GA2962950@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 15:07:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgf8ko=b-F74+Qc+EX6M36kHx5wEBCS8nJK1WSod9UO0w@mail.gmail.com>
Message-ID: <CAHk-=wgf8ko=b-F74+Qc+EX6M36kHx5wEBCS8nJK1WSod9UO0w@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v5.10
To:     Ingo Molnar <mingo@kernel.org>, Joerg Roedel <jroedel@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 10:24 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Do not sync vmalloc/ioremap mappings on x86-64 kernels.
>
> Hopefully now without the bugs!

Let's hope so.

If this turns out to work this time, can we do a similar preallocation
of the page directories on 32-bit? Because I think now x86-32 is the
only remaining case of doing that arch_sync_kernel_mappings() thing.

Or is there some reason that won't work that I've lost sight of?

                   Linus
