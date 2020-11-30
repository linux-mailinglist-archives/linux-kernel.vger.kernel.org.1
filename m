Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6276F2C8CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387959AbgK3SYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgK3SYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:24:04 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97833C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:23:18 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u19so23507328lfr.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wsPs7gnC3/t/rTahaWNN74dCjJuviyFHSHKHhvgoAY=;
        b=T3JHFa6MTkq+VOk0GAbb3Hdo++K9Cf6gCbjyoUak9gPGSfjnbUXNChVlLfPmr6VD80
         sx+p1+g3CNmEyeSgqaqqDxjcC3VE6QGe9DAfNtjRjGt8UgxptHZBv2aWCdpfx1MX9Bof
         wglxUVF2HbnRMwq1on9b36hH9zdcb3fjSSpE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wsPs7gnC3/t/rTahaWNN74dCjJuviyFHSHKHhvgoAY=;
        b=UwS74kIgtmL73swKh4nwGQkHaRt0KPngTDtY7p+PDMtkj0pnjKCdx7e87ggSVH+9S2
         AN//AGxRLRYSHE+vzcd/yPP43RA/gOZK/9b64090ovNMhDAr9+NNCfcGFBVXvgwWuk/1
         Huk1ByvUrekJG+NSjY+19RSqgW4cGGUHw7GPl36lbhGxVlTD0P20l4v9tWMC1Ur4PWZW
         pdUINAgC/i//OQ1jvSTmz74gJ4cxptaVFfuaOSffQe/l64FW3+Kg6ofo8gmtHedx8nyJ
         RJOeqvexVaacq9VzZZZV+2oeEhZ0UCYVF3SpoLRjIOLDHnG6mQq2S5DiWaAIJOk0Uvji
         Sykw==
X-Gm-Message-State: AOAM531E4EJtMq7nVW/Z+0/+4qbLNv7vbVTb7Hkt2vcLUap9XCoRetA+
        JSjgUMJNOP7r5SIbSGId+RDNc2llyW2osw==
X-Google-Smtp-Source: ABdhPJxrTM2qbC0NHwmpg9XeUjY6z1nk1ToAa6Vvb1ur54CWdJy5WzHYfvpTZHPJFygSe/yFXv+Ugw==
X-Received: by 2002:a19:857:: with SMTP id 84mr10935359lfi.235.1606760596601;
        Mon, 30 Nov 2020 10:23:16 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id u21sm2611948lfq.90.2020.11.30.10.23.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:23:15 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id d8so23521663lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:23:15 -0800 (PST)
X-Received: by 2002:a19:c301:: with SMTP id t1mr9587473lff.105.1606760594943;
 Mon, 30 Nov 2020 10:23:14 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
 <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
 <CAD=FV=Vow5_jv=-O=f2v4_5Nb4DiOUB1sQUx6r=-y5A-6rP4hw@mail.gmail.com>
 <CAHk-=whtySEgkH+VFy9oW8Q-+iuivGBo0hOUcee3DvrsBAQUrA@mail.gmail.com> <CAD=FV=Up-JW8RtMLQ_pAG3e0d8NnpT+rDiguxcz3DnVUz_7Jbw@mail.gmail.com>
In-Reply-To: <CAD=FV=Up-JW8RtMLQ_pAG3e0d8NnpT+rDiguxcz3DnVUz_7Jbw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Nov 2020 10:22:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2CQwAnKucLwE8vNZgXxyRy6L+DcgjGqxKHwbacKgaMQ@mail.gmail.com>
Message-ID: <CAHk-=wi2CQwAnKucLwE8vNZgXxyRy6L+DcgjGqxKHwbacKgaMQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
To:     Doug Anderson <dianders@chromium.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:11 AM Doug Anderson <dianders@chromium.org> wrote:
>
> So I guess the answer here is: strive very hard but you don't have to
> guarantee that every corner case is covered?

Yes. Covering every possible theoretical case is basically impossible.
I mean, it can be something like "the firmware glitched for whatever
reason, and didn't set up a device, and it didn't show up at boot at
all until you did something explicit".

(Example: airplane mode wireless switches, but also possibly things
like just slightly unreliable USB hubs etc - I bet we've all seen
those).

So the rule should be that you strive very hard to make boots have
reproducible behavior as far as practically necessary, and avoid
obvious timing-induced ordering issues.

> In a traditional PC I think there are fewer dependencies?

I'd say that they were "different", not necessarily "fewer".

> I guess the question is: why is static assignment of numbers not an
> acceptable solution to the problem?  It gives us the desired fixed
> numbers and automatically avoids all weird probe ordering / dependency
> problems.

I think that if this had been done originally, it would probably be fine.

But I still have this - possibly unreasonable - expectation that the
promise of DT was that it wouldn't be 1:1 tied to the kernel all the
time. That was always the promise, after all.

So the whole "add DT markers because the subsystem now screws up
ordering" smells really bad to me.

             Linus
