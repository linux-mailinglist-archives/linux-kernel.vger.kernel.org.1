Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5FF2F0663
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 11:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhAJKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 05:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbhAJKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 05:21:14 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C618BC061786;
        Sun, 10 Jan 2021 02:20:33 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id t3so11083651ilh.9;
        Sun, 10 Jan 2021 02:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s2e3i6ekxjqpU6/uYaJIRv9nQC6V3zhYxhm4oqeJjAM=;
        b=s0Q4jUgXrr7RDyOyccXZM+LpdpxQbPp7MO9SMPskkzLjtRZ+6vRpKUvhCGP5sn6V5n
         9HRe/hfl9wuTN5lhB/ZbJZ7kZ0R888lcj7kbk5YQC/U43PhXDnaFzStaYKQWNNoULrx7
         X11SlQTD06dYe/cQaEs9PPWwZbiLWzctra8eIJZ5LVOkdWQntAT6fbMfGEE+hqueC3Pw
         ehBY5MuuVPHI4WEwAppDg7Hv/3kCZ4dEPYGsxoZDRnBHQbyIEnu4AtxTYSsEZkz8DOnZ
         /ZGzLVLZjDJ9/ppEVkfxR/kjRsTRB0XCtcO966+NS1Ig1aM59Ht/daTBbKyi2Jud6Oa4
         WAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s2e3i6ekxjqpU6/uYaJIRv9nQC6V3zhYxhm4oqeJjAM=;
        b=nJkxZAPCvhk8+/+luc/yVca+xHncqSfcpMYHvdC6vAKQA3BABGjlpF9vE3pjJOYjg5
         zhYNetL62XaHSuQ9c1zR6FqjGDhN+YuITKwLV4cbnUxKH5wWyEejgcCPNpopUjIQ60Fq
         HSxhnbCF/3UtjpstypDVn3h/XzDVDBYG73+6S/5EsX6emWNUtSjtzzyBIzrxM2z/04ZK
         K68ii6kcHz/eIdA7vlSRkEVuI2j4zJDcMHDUEFLWfMV/2/T5iLlTnikn7fxJXv6D10ab
         cxBqJ/8vEJbDYr4PQ7ltXT1VEOgloWpyP7cfI6ELEe0UQ5BVwUR8VP9FqrEB8qb9rdFe
         QjFg==
X-Gm-Message-State: AOAM532DHc0kq9LYIDSPdG2gxE8YDdz3rQoDNbYOU8Y5TjZ63zA58Fvi
        llsUOIcl6TZ8jDNs+a0SX3Lvwu/ftFN+VJzkhA==
X-Google-Smtp-Source: ABdhPJxpAMRH1U7W5ODkByqNOQv/TK3JjpYyqjXOM5f3V5yVKUAJYIiXwpbaDWICmirUML3j/AdxTIxbWpmsctpgzM0=
X-Received: by 2002:a92:6512:: with SMTP id z18mr11172342ilb.220.1610274032127;
 Sun, 10 Jan 2021 02:20:32 -0800 (PST)
MIME-Version: 1.0
References: <20210108163004.492649-1-j.neuschaefer@gmx.net>
In-Reply-To: <20210108163004.492649-1-j.neuschaefer@gmx.net>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Sun, 10 Jan 2021 12:19:55 +0200
Message-ID: <CAKKbWA7Zx-Jq8c=ExE5SY_H--vk5+TqhTRCJig=7xq1smnKS-Q@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: timer: nuvoton: Clarify that interrupt of
 timer 0 should be specified
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 6:30 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> The NPCM750 Timer/Watchdog Controller has multiple interrupt lines,
> connected to multiple timers. The driver uses timer 0 for timer
> interrupts, so the interrupt line corresponding to timer 0 should be
> specified in DT.
>
> I removed the mention of "flags for falling edge", because the timer
> controller uses high-level interrupts rather than falling-edge
> interrupts, and whether flags should be specified is up the interrupt
> controller's DT binding.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by Avi Fishman <avifishman70@gmail.com>
> ---
>
> v2:
> - Fix a typo in the word "watchdog"
> ---
>  .../devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt        | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-time=
r.txt b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
> index ea22dfe485bee..97258f1a1505b 100644
> --- a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
> @@ -6,8 +6,7 @@ timer counters.
>  Required properties:
>  - compatible      : "nuvoton,npcm750-timer" for Poleg NPCM750.
>  - reg             : Offset and length of the register set for the device=
.
> -- interrupts      : Contain the timer interrupt with flags for
> -                    falling edge.
> +- interrupts      : Contain the timer interrupt of timer 0.
>  - clocks          : phandle of timer reference clock (usually a 25 MHz c=
lock).
>
>  Example:
> --
> 2.29.2
>


--=20
Regards,
Avi
