Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0320927A6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgI1FC1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 01:02:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40919 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgI1FC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:02:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id s205so7187670lja.7;
        Sun, 27 Sep 2020 22:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=98fPA5hAP6rCEl3IEufuD9Lb3X1TaFuj1wbjNl6NBDM=;
        b=oqeQc6THerXQAdNlyHw82nmrQmeCF49IH8U64igcINsEcH8qjG0HwfJfOFZMeCjdoA
         ly6CA8fPdeyln3rQgdc5Y6A+D+jzOpDTF3r7iZKoE7qHCeiY98DXSbabXRnqpoPGHm/I
         4E6k7j2VueQSV/InpGHU8IDGRf5pz3F4ubIzetZbX9CchnQufi7iFhJcWjNtJDsAc0oO
         +JAdWYVkrFsXw5jGi5vXj64UXMxgoupSYir0qAvDrBbsthy+nQuLHp33P25fxZHJFZFf
         7LPljWTT4H3QkHYeKt45WbaPR5t9MELFaq/mnryH7Aah/R8n5fzCcmkxEcVg4LInp0xo
         lRtg==
X-Gm-Message-State: AOAM531TwwwlO5nVMlcpb7RhvXkW6crU3FS1Hh0xQ6QuVbSLSKsyExay
        wsXETa25ojk++O70MIXcBXcnO8EqFWblew==
X-Google-Smtp-Source: ABdhPJyxeTsGyJi6B5yJpQ++2uV6635XzPbnMSCX608rOPI7lSaAInNlQcco7kunsuU73C4sB5JaYA==
X-Received: by 2002:a2e:9854:: with SMTP id e20mr4603982ljj.152.1601269344731;
        Sun, 27 Sep 2020 22:02:24 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id w30sm2664044lfn.102.2020.09.27.22.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 22:02:24 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id u8so9576455lff.1;
        Sun, 27 Sep 2020 22:02:24 -0700 (PDT)
X-Received: by 2002:a19:c6c8:: with SMTP id w191mr2894029lff.348.1601269343999;
 Sun, 27 Sep 2020 22:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-4-peron.clem@gmail.com>
 <CAGb2v67gFTrGVs3pw5ospdSoogaA15cbuWjPQK=-Z2f4nMd9Rw@mail.gmail.com>
In-Reply-To: <CAGb2v67gFTrGVs3pw5ospdSoogaA15cbuWjPQK=-Z2f4nMd9Rw@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 13:02:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v65c2NzjxN4FSksvzQKOvZz0e9ccsKT9OuLpmUVr_WNtzQ@mail.gmail.com>
Message-ID: <CAGb2v65c2NzjxN4FSksvzQKOvZz0e9ccsKT9OuLpmUVr_WNtzQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 03/20] ASoC: sun4i-i2s: Change get_sr()
 and get_wss() to be more explicit
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:37 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, Sep 28, 2020 at 3:29 AM Clément Péron <peron.clem@gmail.com> wrote:
> >
> > We are actually using a complex formula to just return a bunch of
> > simple values. Also this formula is wrong for sun4i when calling

BTW, it is entirely possible that the compiler optimizes your switch-case
back into the original complex formula you replaced. :)

> > get_wss() the function return 4 instead of 3.
> >
> > Replace this with a simpler switch case.
> >
> > Also drop the i2s params which is unused and return a simple int as
> > returning an error code could be out of range for an s8 and there is
> > no optim to return a s8 here.
> >
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
>
> Fixes: 619c15f7fac9 ("ASoC: sun4i-i2s: Change SR and WSS computation")
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
