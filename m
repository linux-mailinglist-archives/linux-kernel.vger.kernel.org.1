Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71CC26ACB1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgIOS5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgIOSzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:55:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79883C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:55:35 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m5so4237583lfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXsyDbVr5yEsb37wNopfWhpCBZv90Q/bsc2OJ00Cmiw=;
        b=tfc56KAYUnr6MuSg1LOpNOvk677yL0xfXUFKSEWmhSp0iLOCMpKRw24XQ/uXi5WH2z
         OXnjyddTjvT93gML0OPEuCOCD0MFczZlHboO0q7qCzMEeYToXjrOWzuPv0Z677j//Pl5
         0TAJ6WrdOacGo05o/EYFU8VA5o/XhZ6R+NKOjhCK2Yf4h2/4chJMF9OKQIxNcQ5b/xtl
         /ldi1rAWLWHQV+0BJrKusQBj1XBYcXzZYgJBxwKLJ4LODVJAtyCZL9XC6lifrNvBrSMS
         amFM3H5Wj2HpS9oS+Dzsyvd2F68bIP2iBDm3ygR7kI2yHXZe/rDD/AxJc/P5cdq0TLTb
         g4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXsyDbVr5yEsb37wNopfWhpCBZv90Q/bsc2OJ00Cmiw=;
        b=MFHQdgYUx6aftX+cnVvscFLsIuYfu2MGRC8Vx0bzMOz0/VIZbANLUu4Z99VZ0cRK1k
         geYqpj8TzK5k+w6aOfl801+ZMt1yb1d79FfQR9dSkCUAdW5MUr/qlzYHyKVh/bLF1zg/
         iDp0oP8Vc072Lsiy81WGpA7DIfYStR61mvSTg7NZYlSWC9G6t/yt8ZMhm+r4Ak6KnuFg
         ZCBwbqRBueyp/P3hrCQpWsk77Xb0a1GqetPeI0HxdWBm7v0gP7OtaNjneFvoloABqpIN
         ayKqbGZh/OFvZz8eS5sHhJ8Ll7PZ2KxkbGFWLuG2MztuaE1RnpvkrpaX/LpKSVgl2Z+9
         IjQQ==
X-Gm-Message-State: AOAM532jIxM30ObIhEOLXPrnLFa/jOobxAOihW4FKjSEnHPdrXq4W2c3
        ymf+thkqE8O9ItkgYGfBlCIjE3SieYJEInr+CRFEWQ==
X-Google-Smtp-Source: ABdhPJxnBHvldJLq8O5w+u6tqm7YQBEdDP5mMvcqqzs9kVTAw3WbpW8xl0s4LUcUB7FkCx+1GKE8Unf8sXEaYt1KE6Q=
X-Received: by 2002:a19:a41a:: with SMTP id q26mr6357544lfc.121.1600196133555;
 Tue, 15 Sep 2020 11:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915174643.GT14436@zn.tnic>
 <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com>
 <20200915182730.GW14436@zn.tnic> <CAOGAQeqhKS48Kd8W4y13ATT3m+nJSksF_U1SJ=SBrOZFrDq9Nw@mail.gmail.com>
 <20200915185210.GY14436@zn.tnic>
In-Reply-To: <20200915185210.GY14436@zn.tnic>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 15 Sep 2020 11:55:22 -0700
Message-ID: <CAOGAQepHV=7Xk4Xw4vw4+56NhDDvEQ+sYrRr-rHYLUbH_oRUmw@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Borislav Petkov <bp@alien8.de>
Cc:     rjw@rjwysocki.net, pavel@ucw.cz,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:52 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 15, 2020 at 11:36:13AM -0700, Roman Kiryanov wrote:
> > This is fair. Unfortunately I am not an x86 asm expert. I expect the proper
> > fix should land into arch/x86/kernel/acpi/wakeup_64.S to init %gs
> > (maybe some more registers) before "jmp restore_processor_state".
>
> ... because "LLVM appears to be inlining functions with stack protectors
> into functions compiled with -fno-stack-protector" and now the *kernel*
> needs to init %gs?
>
> How about LLVM stops doing those wrong inlining decisions?

This will remove the issue for a while until clang/gcc/other decides to use
%gs for other purposes before the kernel initializes it.

Regards,
Roman.
