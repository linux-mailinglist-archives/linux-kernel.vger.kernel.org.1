Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16C228D574
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 22:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgJMUjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 16:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgJMUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:39:22 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7C6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 13:39:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f29so828429ljo.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 13:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxhREohTRt7aIMi/HOv94Pe9LYwqVQIqE0xbuTR1CP4=;
        b=N4c+g5mIW5lhhea3XCFO5IQXqJEdpwJWh8PsfFZU8/WjOws17hry3IDWGV+GGW2kFk
         tFqJz48m0K0U+HcdhfeWDqmOukdJyeZB2kcN+D1zmWM3HF0cw2fwCR0OxB+QDEiim9O9
         /VAQyrVizVMyHng44nXC432wNGVduhM3qcC0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxhREohTRt7aIMi/HOv94Pe9LYwqVQIqE0xbuTR1CP4=;
        b=PKFSCN9kmodvymhQ/ieXGmoGUI9Rbh0+ygr3EvgMvkVnWBwunUTpDku6R6K1z5uM9M
         B8YBqAhoY9/N5mFJWAlG4rJtYASQUOGriLxyIZG+vLuiZ7EKwZqinFZP1ZFR5gqTNAic
         CMHosWYOYVRcOD23Bo6jnLuK6Fk6G8Sp+mHKYUg/ns/LsHNCLpNadJVvSdzEOcm9beIv
         HX/NXmNVmqkyOmPsMmr7AkizYivKBS5pez2BJo4M5Gcz5VVzCNizTb1TLbel4MDHa67u
         E0rZe0068kwh84WDPNcb4kTGafMWVu5dDb7rzd3YrargZeF4mUkYA+N3IA02+vRO/1PN
         IlZg==
X-Gm-Message-State: AOAM532Vh1Pde29TncuxvanQd4STnN5iFrXTi3M/i+acPn5iXoyN1paZ
        4yMU0O04//8hVdehut67d5B/FSQo/4+H4A==
X-Google-Smtp-Source: ABdhPJyFN4G7Ag3jyU5Da7oCXUJ9d8OVhWyLGuWDCMEDm4oTjFSUMLb7uh28FrDRTnlieCoeRTau2A==
X-Received: by 2002:a2e:9a4c:: with SMTP id k12mr460603ljj.388.1602621559938;
        Tue, 13 Oct 2020 13:39:19 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id t17sm278690lft.104.2020.10.13.13.39.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 13:39:18 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id m16so807261ljo.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 13:39:18 -0700 (PDT)
X-Received: by 2002:a2e:9152:: with SMTP id q18mr431948ljg.421.1602621557990;
 Tue, 13 Oct 2020 13:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201012110557.GK25311@zn.tnic> <20201013094149.GA32151@zn.tnic>
In-Reply-To: <20201013094149.GA32151@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Oct 2020 13:39:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAQd22+EWBL6TzmOJom_H2TjU5AAOT+ZkxjW3kbYymcQ@mail.gmail.com>
Message-ID: <CAHk-=wjAQd22+EWBL6TzmOJom_H2TjU5AAOT+ZkxjW3kbYymcQ@mail.gmail.com>
Subject: Re: [GIT PULL -v2] x86/asm updates for v5.10
To:     Borislav Petkov <bp@suse.de>, Uros Bizjak <ubizjak@gmail.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 2:42 AM Borislav Petkov <bp@suse.de> wrote:
>
> here's v2 of the x86/asm pull with only the __force_order patch so that
> it can go in now. The other one will be sorted out when the matter has
> been settled properly.

Actually, I think you forgot to push out the updated thing, I still
see the same contents of the pull.

Which I guess is ok, since Uros has convinced me that the xorl
conversion is safe even for the byte cases.

So I've pulled that unmodified branch.

                 Linus
