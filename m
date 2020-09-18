Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA67126FB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgIRLen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:43 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37321 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIRLeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:34:20 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MTi9N-1juJGu2Jg5-00TzGO; Fri, 18 Sep 2020 13:34:17 +0200
Received: by mail-qt1-f182.google.com with SMTP id r8so4592851qtp.13;
        Fri, 18 Sep 2020 04:34:17 -0700 (PDT)
X-Gm-Message-State: AOAM5331lbpKJop+RpHXhr+BmIY9mKunn++UU++H33RDSavq4PKO4ChL
        nd/LKxDmzh+837zwoxDoATT3b6675qXfaRTeZtI=
X-Google-Smtp-Source: ABdhPJyR7zz5So72V6SYhWYgwZh755GPHRackIOcSX7igL5IA735dwZVSQSG8A3tNsW/k/LOoRgJv264m3fyry8q1/w=
X-Received: by 2002:aed:31e5:: with SMTP id 92mr23933594qth.18.1600428856277;
 Fri, 18 Sep 2020 04:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200918104949.3260823-1-daniel@0x0f.com>
In-Reply-To: <20200918104949.3260823-1-daniel@0x0f.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Sep 2020 13:34:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0maQhfaerwG4KgFZOrUPwueKOp2+MOeG9C=+8ZNzc2Kg@mail.gmail.com>
Message-ID: <CAK8P3a0maQhfaerwG4KgFZOrUPwueKOp2+MOeG9C=+8ZNzc2Kg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: mstar: wire up interrupt controllers
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, mark-pk.tsai@mediatek.com,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ZLTm1dOtWm2PCZmPhXJpOWUvMIa2mQq/w3KitFF+MUsUBHcqSMU
 x/u2iMUH9q6NpzTNjuKhQpeBIYpdk9rxa6f+5b4a4dhcB6SX4nBH7vX2E0dY3FL4KoAXsOe
 q4tKtnGAljvEpfW3W1TVJeH/XBuBj4PzSdRMFrKdo4G+p0LYgbM6HtqZBwGKqsuwuDz5ZTH
 BVtPJC8XkPUieR/9KknoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TyPM4WjUnNg=:PQzblxIzVPwuOfqeqXxCUO
 wOybMMnSk77BkU7l/p7Xjvl1YRY984uBGxM7/L7YSJPu+dlBNN78Zf0RFXqbrp7Zlf3M/iGce
 cer+nQ2g2nmQpNswHKcyFS2glw2Z2akUTKo0wMUO9HX53zl+2OBnbT4uD6+WOj9LA/gjbwrlQ
 DZUgd7jP6RrSzAvWCMByoinqU9yxEuCRGf37BLXfWFRcPUHmGcgWKTBVOOH0SQ64MUtChT1+R
 tgn4gkpY4Yls8+ZtOgVEDD+hciKSFzBb8FQVbvMexztLLECi8ihEpZr38KGcrCpgjT89oCFvL
 2mAji43TyaDc+q3F007ESjL2fnUo5ovzBHlrz6inZLTEZ1UP+o5doX4pqN+b9yThhsyuGonxt
 AH4M8tSc5lTEkdPHEuUhpTRp8ZkToPuY1qJzJNsogekpAQjpuH2Pa1Ig40awDdu4KiI5fhe2r
 /+3aEQN3yrinaWUZnUXJ1sbOp/VZcGnRrqqoEQs5LZgoN8FwuWEjD7j2dvuI8dS96rrMw4huV
 ZYL0ACRKhlC3bz5LRq6xOhdtdtSDzQkSWAhs8KRktCk1FqvP901cBoi77vaODG0zGjNBJboy+
 2dv+SkvRvLHR5clztDNwgXyRzJgGi2eumFka9AM2mNQvder4qLcQE/mNVgb4Nh6pi/OBSIPTO
 eqvsUWfSlY6zpYfY3I1lNpH9wpYdQpybqMOKpCrhSZUDzEUMbGG1bNW2Gm7wqi9u3ugCMTMaL
 xiTNYGWwbK3tN3mlxxWqAHE2augrnd498TV7Gaj3QZ9xGEWvhk/dYaGJ3+7iSIoCTAI6msWI9
 rc48xvIR3/A4lVSAyMsKD78qesT4kZBnxWbZ8T6x8hPwhUKOiRX9MZ6JK8jrstuHTp1yX4U
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:49 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Mark-PK Tsai's driver for the MStar interrupt
> controller should be going into 5.10[0].
>
> This small series selects the driver when building
> support for MStar/SigmaStar Arm v7 SoCs, adds the
> instances of it to the base dtsi and wires up the
> interrupt for pm_uart.
>
> 0 - https://lore.kernel.org/linux-arm-kernel/87lfhdr7l6.wl-maz@kernel.org/

Whole series,

Acked-by: Arnd Bergmann <arnd@arndb.de>

Please send these to soc@kernel.org for inclusion.

On a different note: I realized too late that the dts files should have been
named more consistently when we originally merged them. Can you
also add patches to rename the infinity and mercury files to start
with "mstar-"?

    Arnd
