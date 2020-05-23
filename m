Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28CF1DF941
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 19:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbgEWRYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 13:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbgEWRYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:24:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A936C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:24:51 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a4so8290929lfh.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlHqWoJPjXHQ79+scWCNRdLZe+da3t+0ob3BwzrJz1s=;
        b=OfpCmV3Wk8f44llkgbCEnH8RQU7yYtGsB0Ya0n1Ert+pZV10Tz1xVBNMEaVTqlsrWn
         Wuvfab4agWNIdo+EcL9UoTfxhJ4SY86QWt4i8hJxl/3FEWnX+rN9QxtcUu5w1uXvCeO3
         gbEhMa7YoEuhuVFFKusyFb1ic8HDh1VrBDDMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlHqWoJPjXHQ79+scWCNRdLZe+da3t+0ob3BwzrJz1s=;
        b=F1A3TWGGvoNRmbOJLt3/ulpS63hQDYttclYqO4GkByv2lb2f9B3q7uh2sWr2kCLFFY
         joJ+bMyIvqpojB3UbOX/5TwQznqdBp89bzJ+d+Kpf9yI0iDIhJ/QeEdlL0KjyO31/1el
         fIvKX/9Db5mC6D4b3AOFrCarjJP3Gq/f6jrT439Xy6z9RwLVHFJu4xxICjpvtQSbtY0E
         lIjcZYY0fsB+o0oxZbsQEjQ3iyu0XNyFVWzOD66MQhwoCTO90UmgGqB1JrtASDKfGnD/
         EEXPrhBngqjboUsnlcXYoUhpRV4/ooWjjYk3kGkdQC6I1/CPTstFXQtmuyIPZXQryj9P
         NLHA==
X-Gm-Message-State: AOAM533CAuaKMmqedMGjPy+Vu9fv29PrwVjinLtNc7cPFXOFZtJpZZGO
        q9QPjtqRKIyC7r5D0SSD0ZxROdXjink=
X-Google-Smtp-Source: ABdhPJzoehX4vMYwqWr1WXhVwpOeV0InLx0Ia/UxcnCgce8cLvWaBd33Q6LCbrj90TlvXq/XLo19jw==
X-Received: by 2002:ac2:5f69:: with SMTP id c9mr10337615lfc.2.1590254689562;
        Sat, 23 May 2020 10:24:49 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id r11sm1116236ljd.101.2020.05.23.10.24.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 10:24:48 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id m18so16394736ljo.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:24:48 -0700 (PDT)
X-Received: by 2002:a2e:150f:: with SMTP id s15mr9908536ljd.102.1590254688346;
 Sat, 23 May 2020 10:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200523155737.GC1189358@rani.riverdale.lan>
In-Reply-To: <20200523155737.GC1189358@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 May 2020 10:24:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkXWbmRmbkOUxZWnh+stxSQjoCsD=E_ZuZr98CAdUgEg@mail.gmail.com>
Message-ID: <CAHk-=wgkXWbmRmbkOUxZWnh+stxSQjoCsD=E_ZuZr98CAdUgEg@mail.gmail.com>
Subject: Re: x86: Question about state of general purpose registers on switch
 to 64-bit mode
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 8:57 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> (1) We assume that registers that are set in 32-bit mode will have their
> upper 32 bits clear when we switch to 64-bit mode.

Realistically, I don't think that is what happens.

The upper bits probably won't actually be affected at all by the
switch to 64-bit mode.

But they will be clear in practice, because any 32-bit operation done
in 32-bit mode will _probably_ still be doing the same thing that a
32-bit operation does in 64-bit mode: clearing the upper bits.

> (2) We assume that 64-bit registers that are not touched by the 32-bit
> code will retain their full 64-bit values on switching back.

Again, I think that this is the same as the switch the other way:
switching modes does absolutely nothing to the upper bits.

> Given that we don't keep seeing random boot failures, I would guess that
> the above assumptions are actually valid in practice. However, they do
> seem to be more than what the processors actually promise.

I think you're right. It's not an architectural guarantee, just a
"this is how it happens to work" behavior.

                  Linus
