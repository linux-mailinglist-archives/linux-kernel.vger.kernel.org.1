Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70AE241E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgHKQlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgHKQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:41:34 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AC7C06174A;
        Tue, 11 Aug 2020 09:41:33 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k4so4652410ilr.12;
        Tue, 11 Aug 2020 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6L7FJ6xpxTKZ/sdV2/iPr2JUbCn9Aupkb6mFAAvK+TU=;
        b=W3/mn+FSAoD4JSQBtxIMkbYsT+HhAA3dEiyJ7apR1RrB3dMdZ9i9xhS5WfbVVC5JEO
         fCDRFwP35k5BoU+ItzCV1x5zLAo6VhXFFv2rm/qQPraB8KHRR5c8vFyCrSloIy54KRhG
         LKIfqGjBXMnVFC5yoYd4SCskpHPGzuy5usjJ0yEhKpwu9E1o6uNMd719i1CID7WhCVno
         1FxchZo47osr5uq+MmXar08cDx86fXUbL00ef8cKzTLr/iH29VS06jCHiD1TpsZTyaQc
         348n5fnxSmgSr/hyAFHoTHQD7qLHKRkkhZBs+CzI0B+YYGR6r+qVDaLKeGfVN0JH1CHN
         oO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6L7FJ6xpxTKZ/sdV2/iPr2JUbCn9Aupkb6mFAAvK+TU=;
        b=QzHidetJKz/SVXydy3pZpjd0Rz/OWYCnoPoA3xM/eQEmRF00hG0D4i18M8/BzrwvpS
         Hc4C/cxgNV38fRaRAPzAzz3GGWNOHg8/6Q80LyZGbZI47LnxgOkdYis2UnbwsbgEseTu
         aXTZHVyMywZ9dPUMj+X5lt4HIdGFjneN42Femu+iDqbuRtEFZ8nsd7UaCI3gGFOulcua
         R82iztalk4qpjpw6L3wwR2ef6xcjAy3VtYRUsAw6ysavQmfWnlRpKt7FYtPM5ECvHVwQ
         KDrm2B8phWHXkuMk36uBAKpZgge9/C+Jckfbu5a40158yv++oiZZH92z6q8agLaUbTCl
         LfeA==
X-Gm-Message-State: AOAM532nQqiqwpB5d8FZjlYJpJ9Ll1QI7/XYWPLeJwHSP8KY2tfMlPFu
        eA3jJ+p84gMlxV+uJ0Uk0Veyjqj2eTonYUtYYrur0QYc
X-Google-Smtp-Source: ABdhPJwtO81xN1qaQTPolCL82R6O6bly2aKgBxtwvn009icL+oQF+sAUlPk04HnxXm+WKbfAac9CS3v7Es/PLdfEvMI=
X-Received: by 2002:a92:cac8:: with SMTP id m8mr25098449ilq.168.1597164092409;
 Tue, 11 Aug 2020 09:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54@eucas1p2.samsung.com>
 <20200811112507.24418-1-s.nawrocki@samsung.com> <CA+Ln22Hfys7r2EDstOsdks1X88Fuv77DLTuXLWDynTt4kmiCiQ@mail.gmail.com>
 <20200811162358.GA7169@kozik-lap> <CA+Ln22Es+Mtokw91wzUaoWC2yCQHRJDEvW6=U1Rbt2H7PbDOeA@mail.gmail.com>
 <20200811163428.GA7590@kozik-lap>
In-Reply-To: <20200811163428.GA7590@kozik-lap>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Tue, 11 Aug 2020 18:41:20 +0200
Message-ID: <CA+Ln22FdFBPU5f0agknRN5xnUtJWOuGARfnsYh3ru_xdjoGC=A@mail.gmail.com>
Subject: Re: [PATCH v2] clk: samsung: Prevent potential endless loop in the
 PLL set_rate ops
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=E5=B9=B48=E6=9C=8811=E6=97=A5(=E7=81=AB) 18:34 Krzysztof Kozlowski <kr=
zk@kernel.org>:
>
> On Tue, Aug 11, 2020 at 06:28:18PM +0200, Tomasz Figa wrote:
> > 2020=E5=B9=B48=E6=9C=8811=E6=97=A5(=E7=81=AB) 18:24 Krzysztof Kozlowski=
 <krzk@kernel.org>:
> > >
> > > On Tue, Aug 11, 2020 at 02:59:07PM +0200, Tomasz Figa wrote:
> > > > Hi Sylwester,
> > > >
> > > > 2020=E5=B9=B48=E6=9C=8811=E6=97=A5(=E7=81=AB) 13:25 Sylwester Nawro=
cki <s.nawrocki@samsung.com>:
> > > > >
> > > > > In the .set_rate callback for some PLLs there is a loop polling s=
tate
> > > > > of the PLL lock bit and it may become an endless loop when someth=
ing
> > > > > goes wrong with the PLL. For some PLLs there is already (a duplic=
ated)
> > > > > code for polling with timeout. This patch replaces that code with
> > > > > the readl_relaxed_poll_timeout_atomic() macro and moves it to a c=
ommon
> > > > > helper function, which is then used for all the PLLs. The downsid=
e
> > > > > of switching to the common macro is that we drop the cpu_relax() =
call.
> > > >
> > > > Tbh. I'm not sure what effect was exactly expected from cpu_relax()=
 in
> > > > the functions which already had timeout handling. Could someone she=
d
> > > > some light on this?
> > >
> > > For us, it should not matter much, except:
> > > 1. when on A9 with ARM_ERRATA_754327, but we do not enable it on our
> > >    platforms,
> > > 2. it is a generic pattern for busy loops.
> > >
> > > On other architectures it could mean something (e.g. yield to other
> > > hyper-threading CPU).
> >
> > Okay, thanks for confirming that it doesn't matter for us.
> >
> > Now, I wonder if the readx_poll_*() helpers are supposed to take all
> > of those into account or on systems which would benefit from such
> > operations, it would be the caller's responsibility.
>
> That's a very good point. In case of ARM_ERRATA_754327, busy waiting
> should have a barrier thus cpu_relax() is desired. I guess the generic
> macro for busy waiting therefore should use them.

Is there yet another macro available somewhere or you mean
read_poll_timeout_atomic()? The latter doesn't include cpu_relax().
Given that udelay() likely already does this kind of an idle call,
perhaps it could be as simple as this?

        if (__delay_us) \
                udelay(__delay_us); \
+       else \
+               cpu_relax(); \

On the other hand, I wonder if there are cases where a call to
cpu_relax() is not desirable.

Best regards,
Tomasz
