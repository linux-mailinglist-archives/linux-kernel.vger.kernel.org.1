Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929AC1CC11E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgEIMEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 08:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726600AbgEIMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 08:04:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F315EC061A0C;
        Sat,  9 May 2020 05:04:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so5473816pjb.0;
        Sat, 09 May 2020 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUpvglT7RVI0VhxUEBL660l9QrPqkvdcztJEgEYZgVE=;
        b=NQoyld5OELIut/6UkNs1QRfi9i+epuoVHUKNHesyhNiHwyCgMz2dsk95CM2YAjdiPb
         OZhokEcTwLonbVkoSEHArg5P11YL0pYA7FrqZ5Ea6n7pS8ZFYaRk/a4CrGJN24wjf+sT
         6RVOq4a9iM5M9plD78kt081Z9pD3ZlqQqqb9ibpDiCEzXfhTKChPdU+g8X02t/Jtgxdj
         iqqIDP79VMLiTWKUI1mPtfu7uKlTsNaJRGGZTyYs61iZLUmBUC0HkymmOUxIBJtsGoE1
         tAjtALvt8Uwo82olkqA+E8DUC9qhhlv0TRtkv1bkkP/dYmiN0vTUUvvnAmdZ57tDvUjU
         Fhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUpvglT7RVI0VhxUEBL660l9QrPqkvdcztJEgEYZgVE=;
        b=GAwP5H6ciMIPEGzVn+qj0QpuWr3N7m/coVjcLHfjpNl5El6cy8C5ho2+a9SefevO+J
         zQUq7sDld5bTuZ6MeANrai0eFwtPbQrU5e3A7izhuZ37kK0b8vQQ2I3CknUuXwV0HSYf
         S/0cNmNfGHpvzRPEpERGxAAw0lzWOQL+6PmZlsyjM73tkSvaqewWWsUuF1m10jfrKQZ6
         Ve17gY3/XBFYIzxEauUfLEJOMzWkiOTz1Ol7ptXzBNPtSDRS9uMtiPSUpvUMWLnEO2fp
         ponzYiRF0ikAtW8Oc1B9aqKc1N+Qv+XXz6+SAGNVDFmSLF8sgi2JJaeLYU1JYvOpPYxk
         zYrA==
X-Gm-Message-State: AGi0Pua1QMtVckhkRxodc7X58Kkiu5F/cg7974Ahp/tcxpScfPSsPCT2
        xqI1C1p/x8ICWwklHYGMzl3PQvF/p8vyupQKJeQ=
X-Google-Smtp-Source: APiQypI0HEt+PVZf/6IcEtjlof5jsVdsR0hAD/QMKEx2hKai3zkGEHMgEwx0que30ynyNsOLHyxo3+JbdKXsfI5mkvA=
X-Received: by 2002:a17:90b:94a:: with SMTP id dw10mr11395860pjb.228.1589025877306;
 Sat, 09 May 2020 05:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200508211929.39020-5-alcooperx@gmail.com> <Pine.LNX.4.44L0.2005082035460.2445-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2005082035460.2445-100000@netrider.rowland.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 9 May 2020 15:04:26 +0300
Message-ID: <CAHp75VfV8SwKG5aX-POce5aHCoqCHdnfpxzq6C6buJ_TaSacsg@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 3:47 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> On Fri, 8 May 2020, Al Cooper wrote:

...

> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq <= 0)
> > +             return irq;
>
> I don't want to get involved in the question of whether or not 0 is a
> valid IRQ number.  The consensus has gone back and forth over the
> years, and it just doesn't seem important.
>
> However, as Sergei points out, if 0 is going to be regarded as an
> invalid value then we shouldn't return 0 from the probe function here.

The most of the drivers rely on the fact that on platforms where it's
the case (yes, we have you-know-which architecture has some legacy
stuff there) request_irq() will fail anyway.

> I'll leave the decision on how to handle this matter up to Greg.  :-)

Me too.

-- 
With Best Regards,
Andy Shevchenko
