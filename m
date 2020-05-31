Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3771E9661
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 10:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgEaIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 04:41:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34938 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 04:41:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id 69so5536299otv.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 01:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhhqHeZBf2NBcL6NS4/8J6McKxeRLMMjf81gIVoAbbk=;
        b=XDiTMzUWuGHoVMiNMXfw9VJVDH0BBEdLtZtcy1eaThFy8nZNpR24eFuX1Xw+obuavy
         5FE4hgE+A8w3SbFrBf+5NuJDAxpPXxQQluN873qstVkPTng7zHbgo7OB0Weh0v/0Ahnl
         B0bE5UTc57rXUCeAJrgJQyhGrJk3LCAhlUX4jtBLUMtejSVE0fIVvBJPN2zRxHedabrN
         jbxRSfA451ofYH91vt92aTtLtNWrxIhodHNSpzG0R1nyHj2P5cS4k2haYERJGnhqf5Xk
         x+yCpDYSBk1zpJfBR5UVXA+K8nIOq2fMTjtXeKDn1F9SSVscSFkd9oKIE7m7DdGEhwZa
         qFNA==
X-Gm-Message-State: AOAM530hoVokMjKoEZcU1AKCbSMGQVcUDAOaQ+aaUQ/VP8dw3VGN5weH
        0+MfDuWWrPWOBRDXx89Y22O1YMwY423wrMy6Po0=
X-Google-Smtp-Source: ABdhPJw5XtUShQ228hZwf6/S9PJg+4GolOTeI2Cwsk00CllMO7BCEY4aPmr0oBAAJec2PsN236AWbD/9ruGqtXG7G5o=
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr722368otp.250.1590914481117;
 Sun, 31 May 2020 01:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590880333.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880333.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 31 May 2020 10:41:09 +0200
Message-ID: <CAMuHMdVb2C7asip_-_zbc3JP+nqn6siKqmikOK98tM5=2BYqcQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Mac IOP driver fixes
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sun, May 31, 2020 at 1:16 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> This patch series has several bug fixes for the IOP driver and some
> improvements to the debug level log messages.

Thanks for your series!

> Geert, please consider pushing these fixes for v5.8, if not the
> whole series.

I'm afraid it's a bit too late for that, as I expect the v5.8 merge window
to open tonight.  Unless the fix is for a regression in v5.7.
BTW, how does the issue being fixed manifest itself? That's not clear to
me from the patch description.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
