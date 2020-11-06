Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE062A8C74
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbgKFCKU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Nov 2020 21:10:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45625 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbgKFCKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:10:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id t13so3676516ljk.12;
        Thu, 05 Nov 2020 18:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TCAkol59pNC4A1Ep6Vh2I5icEcF6Xj0QtXarfZ1GeIo=;
        b=Ik/fiFDSuiOGh478UJJ5WEiYLaUMzefzYkfeKRLJLZ+E4v1YQNTRMeb5WoKKoqq2J+
         Kuun4pRezAqUPZtaRL/CPGFGWWfTuElZ4PAqaBfI9cX9ysIEYMQobRMinSkPFgftrqdJ
         9PQOfztkTo0FlfcvKyNdQGwzKNd04Zo/n8bluh6mq4xdLEQWmalPU3bGzGrABxSGg+mM
         bfg0D/QME1Et9ZUbup1K/3CbXkVzyFyDR7uVznqoFLnCmn7IT3itJ7E6uJPD5hCczjlm
         v0w5Fa/uurP/Db/no3hVgK/wMvsuXrvly2wPN2ay0JhNXUkfekjTZo//zm5tEMvF8Xhc
         Dqpg==
X-Gm-Message-State: AOAM53140NPtFVRuOP4NT6R9vwKPc+K4Ig7/vL//53ctc+0dWotp0VLn
        kZqGVvlaA/0rN07PW+gZd9HT2SdxL3ptXw==
X-Google-Smtp-Source: ABdhPJwJcrJ1KHjp3J3gAxuQLQr6pm5I/n5CYQaoK6doApH7OX7iFot5iPkkMw59tyJjjlU9AyUeQw==
X-Received: by 2002:a2e:884d:: with SMTP id z13mr1796164ljj.413.1604628617172;
        Thu, 05 Nov 2020 18:10:17 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id c26sm358154lfh.107.2020.11.05.18.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 18:10:16 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id a25so1866848ljn.0;
        Thu, 05 Nov 2020 18:10:16 -0800 (PST)
X-Received: by 2002:a05:651c:336:: with SMTP id b22mr2007851ljp.75.1604628616262;
 Thu, 05 Nov 2020 18:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20201102100157.85801-1-mtwget@gmail.com> <20201102100157.85801-2-mtwget@gmail.com>
 <20201103113743.5764tj2ryrht4dfs@gilmour.lan> <CAHRgzyOao=w6Yyqqvi1Z26=rfJgumkzDbWLxD+_5uaLmyAWiQA@mail.gmail.com>
 <20201105171051.ducvxcdj5jfarmgn@gilmour.lan> <CAHRgzyNzXk1uJzEVLvrqPu2CT8jzF+5UFEubT6kEtF=8HVgROQ@mail.gmail.com>
In-Reply-To: <CAHRgzyNzXk1uJzEVLvrqPu2CT8jzF+5UFEubT6kEtF=8HVgROQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 6 Nov 2020 10:10:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v64HyUn8KjPPA0JBA5tPaxX7-keNfs+M22pL5SmETN0FQg@mail.gmail.com>
Message-ID: <CAGb2v64HyUn8KjPPA0JBA5tPaxX7-keNfs+M22pL5SmETN0FQg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>, Yu-Tung Chang <mtwget@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 10:03 AM Yu-Tung Chang <mtwget@gmail.com> wrote:
>
> Maxime Ripard <maxime@cerno.tech> 于2020年11月6日周五 上午1:10写道：
> >
> > On Wed, Nov 04, 2020 at 04:07:48PM +0800, Yu-Tung Chang wrote:
> > > > > +&uart1 {
> > > > > +     pinctrl-names = "default";
> > > > > +     pinctrl-0 = <&uart1_pins>;
> > > >
> > > > This should be already set in the DTSI
> > > >
> > > uart0 as the debugging interface, uart1 as the external uart port,
> > > uart3 as the bluetooth.
> >
> > What I mean is that since it's the only muxing option, the pinctrl
> > properties should already be set in the DTSI, so it's redundant to put
> > them in the DTS.
> >
> I can only see the definition of uart0 in the DTSI,
> because uart1 as the extension interface is exclusive to NanoPi R1.

Maxime, to clarify, UART1 can be used with or without RTS/CTS,
so there is no default muxing in the DTSI.

ChenYu
