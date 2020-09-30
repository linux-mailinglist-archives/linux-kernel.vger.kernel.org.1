Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AAB27EA72
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgI3N6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729903AbgI3N6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:58:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFF9C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:58:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z23so2924136ejr.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48cYY9fCUs7qmGKNVy05KuGWxzPcUKDwzDxzj9tXpmI=;
        b=tjUAeQaVkXGGcEq5FhfrNYKu62uP/y55LgusVyQo5/NmXn4SLU2cLm+CB/ho9X+cO2
         HZF0Khp7EqAVL+UwSiIQjMIfwcPkBE1Dt4HZ78Bzb/lUE9kTqdZGfRoJSxBkIpTfTPnH
         l/XA0oZyNXWDswzsW4ELzu22M6HRTACOpknMFPfDxo5Fu/Z8Y2tmn8mqOKcLJ0x5sVYH
         LWbOfPPi1FSFBpN4a7Nlev/OQWjL5JjEIyly2Tt73ucq0E1aNlPwiLSGnLYG79iGD5Qm
         CrQo0bPXg8MOc7d5dT6mKnstSNaOXjoYUMbFT1rEghjO/5tD4j74MqpsgIJ17A6cF0IZ
         ViEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48cYY9fCUs7qmGKNVy05KuGWxzPcUKDwzDxzj9tXpmI=;
        b=CoqX/OU7VdL84rgYAjQRoJbMA/TY/XzNzvnNzTXrbZfWjKOX/s9MQQEx8yhjEisNfF
         8m0yBCo65or+LnxiS9emAnYbwsETo/d//ZC+vggjw8xUQrFtc5+I1EAgM1gk7vRLlC8M
         XNHAHvdrwfBpnlvK8AmmIr1Ellyn4yMVbZLUcdcxel/IUnaJuQrYBRRUTbhLNcEI2EIL
         +zpSj83o7TL4AjUEno1pbK/WZ0xJBGe9GFJvMtDOfsscxmbTNCzEYKQeKQG2AgS1IoOQ
         xp6VUregE6VEvXn3Z8Dgn2Cklzf1PWPZC2Z7L1qesqjQ91+BSqJlHaBtWtkjlRjxZ5r8
         5xXw==
X-Gm-Message-State: AOAM530StIPV9qn1kNTH20TqiJnmVRL2btGkdTeI6zctcYMzn4yOs+nJ
        BxAD5QEs7HVHtTVhRu+Px00G3fqnvm9+5PGJh3DnunHQB/0=
X-Google-Smtp-Source: ABdhPJzo9tGSm9fnGUSk/Gfwh2XahJvhcS5RGsJsYVpEf/U7JjBnHYZ8+MYs9RIZp2ckEem8iRxpOXPvE0v/NVZDZZk=
X-Received: by 2002:a17:906:4151:: with SMTP id l17mr3100975ejk.116.1601474293698;
 Wed, 30 Sep 2020 06:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
 <202009251301.A1FD183582@keescook> <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
 <202009251338.D17FB071@keescook> <CAMj1kXEWutwE-fP9bc=tsyPoTuV6J7bLzLpkZ213P9y9JszkTw@mail.gmail.com>
 <202009251647.FD8CECD4@keescook> <CAOuPNLif93a1uHhqsKFwhd35nfCnmRu_uxpB62shOEKyQ96hNw@mail.gmail.com>
 <202009260933.C603CD8@keescook> <CAOuPNLiM+ghH_7eNkAfA=jDgHrc+2_jB_n3FvYG-JMN0EiNfGA@mail.gmail.com>
 <CAOuPNLiw1FyzHq2DykRFwgG0BeaWaNymiV8_DmD=ump7P8W_ow@mail.gmail.com> <202009281248.6F601005CA@keescook>
In-Reply-To: <202009281248.6F601005CA@keescook>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 30 Sep 2020 19:28:02 +0530
Message-ID: <CAOuPNLijjua222eV-6bnLyidsuY49-KuQSERUSXLpc+u+qeqLg@mail.gmail.com>
Subject: Re: KASLR support on ARM with Kernel 4.9 and 4.14
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, matt@codeblueprint.co.uk,
        nico@linaro.org, Thomas Garnier <thgarnie@google.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 at 01:20, Kees Cook <keescook@chromium.org> wrote:

> Note that I still can't explain what you're seeing. /proc/kallsyms
> shouldn't be affected by these patches -- I would expect it to either
> report the true value or 00s.
>
> > I will disable kptr_restrict and check or, I will enable
> > CONFIG_DEBUG_CONSOLE_UNHASHED_POINTERS and check.
>
> I would start with kptr_restrict=0 and see if that changes the contents
> of /proc/kallsyms. If it does, then it is the hashing. If it doesn't,
> well, we're back to square one. :)

Actually in that board, the kptr_restrict=0 already in both case: 4.9
and 4.14 Kernel boards.
In another board with 4.14 and kptr_restrict=2, I see that the
addresses are 00 always.

I further checked that when I enable this config:
CONFIG_DEBUG_CONSOLE_UNHASHED_POINTERS,
then the addresses are remaining the same in every boot.
But this particular config is not present in 4.9 Kernel.
So, I think it is controlled using this config.

--
Pintu
