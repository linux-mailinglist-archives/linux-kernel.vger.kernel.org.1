Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDEF2E0562
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 05:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgLVEe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 23:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVEe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 23:34:26 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999DDC0613D3;
        Mon, 21 Dec 2020 20:33:45 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x20so28840928lfe.12;
        Mon, 21 Dec 2020 20:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbYP0hqHELlwFm8jLY8K9W/rgTprJeSnITI+tRUDBEg=;
        b=rsT5Cz706j748+z38cglXo8YG28hBN2qB4I2+a9JADon78PzCnjK9/Qr7XTV8N7kUT
         7F7Uqo+wnBHbqT49+WLSbNNDEZJ2E4yoXKpZdddrzXkjEYcjlHBEV7Leu6wtptp+3Lap
         fT6cPDc0q5QhUiI2L39Q2XV4vUDD2hzDNo4QFVJYwo2mywp6F+FaLdF23UpHEptFf31x
         J7BzdpuJmBtso4/f89erdKTuQNbpWE3Kg9ReDNzCpHY1QGpMp7TvP+TG/jnlHQYGRJVz
         KSlzV0+M2wWyU0JKXBbS0baKkDVH5aMj23QUxunWka+5UsdDFplxflBcMqcGnp7VkQrG
         24WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbYP0hqHELlwFm8jLY8K9W/rgTprJeSnITI+tRUDBEg=;
        b=iKgi657VLGGyJBCh4R1k5Rjn58JAxWYuc2eScjQTKcKiX0AzTJu/4S5vFNmuLDL1xM
         Fd64oPXddQrTle8m8rrAGwJCYyIadBm7hVA6CnaB3HhNlIClVMQj1hLAQHZ2HjcnyQRh
         iCoIfbSY3VLwEND39XfNrGkOIxdX1MUSumk7UWuqLxIHTWoE1D2TM/3tzssHdZekz6hE
         MspisapygWRY2cv+i9VCASJIi9SszJX/HgwIDbaLQ+9Jj7vlCmkAJ16iNnzAycp9Zy9j
         UWPAogdCtKMippMXHjWNLb5aEla8IKOMgRnSeVwu4rc3JwrscA/nunJR/D37jZaGrmyO
         GYaw==
X-Gm-Message-State: AOAM531mqDFwY+9n7vYZWW0mjUg6OVWSnqZSTE2/NaHJrBlgptlWXWbz
        QgSnRRFwcrPTrMvnxQpBV4Sgqc9qx59xrPjbkg==
X-Google-Smtp-Source: ABdhPJxSwso215Rak791K2fIAid0DaEQkchAmaZvur3DWC1NKMy0d41avHwSWiwDYJyP/WCIk3ibXVgttK90UXs8iZY=
X-Received: by 2002:ac2:598c:: with SMTP id w12mr7401299lfn.526.1608611623919;
 Mon, 21 Dec 2020 20:33:43 -0800 (PST)
MIME-Version: 1.0
References: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com>
 <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net>
In-Reply-To: <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Tue, 22 Dec 2020 05:33:17 +0100
Message-ID: <CAEJqkgjFVBEDxCVB+P3CjirRkCZW1_6s18AgOKpe+6er3VShpA@mail.gmail.com>
Subject: Re: k10temp: ZEN3 readings are broken
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Wei Huang <wei.huang2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 22. Dez. 2020 um 04:58 Uhr schrieb Guenter Roeck <linux@roeck-us.net>:
>
> Hi,
>
> On 12/21/20 5:45 PM, Gabriel C wrote:
> > Hello Guenter,
> >
> > while trying to add ZEN3 support for zenpower out of tree modules, I find out
> > the in-kernel k10temp driver is broken with ZEN3 ( and partially ZEN2 even ).
> >
> > commit 55163a1c00fcb526e2aa9f7f952fb38d3543da5e added:
> >
> > case 0x0 ... 0x1:       /* Zen3 */
> >
> > however, this is wrong, we look for a model which is 0x21 for ZEN3,
> > these seem to
> > be steppings?
> >
> > Also, PLANE0/1 are wrong too, Icore has zero readouts even when fixing
> > the model.
> >
> > Looking at these ( there is something missing for 0x71 ZEN2 Ryzens
> > also ) that should be:
> >
> > PLANE0  (ZEN_SVI_BASE + 0x10)
> > PLANE1  (ZEN_SVI_BASE + 0xc)
> >
> > Which is the same as for ZEN2 >= 0x71. Since this is not really
> > documented and I have some
> > confirmations of these numbers from *somewhere* :-) I created a demo patch only.
> >
> > I would like AMD people to really have a look at the driver and
> > confirm the changes, since
> > getting information from *somewhere*,  dosen't mean they are 100%
> > correct. However, the driver
> > is working with these changes.
> >
> > In any way the model needs changing to 0x21 even if we let the other
> > readings broken.
> >
> > There is my demo patch:
> >
> > https://crazy.dev.frugalware.org/fix-ZEN2-ZEN3-test1.patch
> >
> > Also, there is some discuss and testing for both drivers:
> >
> > https://github.com/ocerman/zenpower/issues/39
> >
>
> Thanks for the information. However, since I do not have time to actively maintain
> the driver, since each chip variant seems to use different addresses and scales,
> and since the information about voltages and currents is unpublished by AMD,
> I'll remove support for voltage/current readings from the upstream driver.
> I plan to send the patch doing that to Linus shortly after the commit window
> closes (or even before that).

Yes I saw that commit, and it is a shame how AMD is unwilling to
support 'sensors'
in their CPUs in 2020. I can understand why you can't maintain that
mess, but I don't
understand AMD.

However, it is not only about the Voltage, ZEN3 Ryzen Desktop CPUs,
 have a model ID of 0x21, meaning while only 0x0 & 0x1 is here now we
only hit the else code and shows some weird temps, and no info about CCD's.

See:

smpboot: CPU0: AMD Ryzen 7 5800X 8-Core Processor (family: 0x19,
model: 0x21, stepping: 0x0)
smpboot: CPU0: AMD Ryzen 9 5900X 12-Core Processor (family: 0x19,
model: 0x21, stepping: 0x0)

etc...

So we need at least:

...
case 0x0 ... 0x1: /* ZEN3 SP3 ?!? */
case 0x21: /* ZEN3 Ryzen Desktop */
...

I believe 0x0 & 0x1 are NOT yet released EPYC/TR CPUs based on ZEN3.
At least is what the weird amd_energy driver added and since is only supporting
fam 17h model 0x31 which is TR 3000 & SP3 Rome, I guess fam 19h 0x1 is
TR/SP3 ZEN3.

( BTW off-topic this amd_energ driver should be removed or depend on BROKEN,
since is working as root only and breaks the sensors command output )

 If that is the case, even if you remove the code, I think I
understand how the PLANEX registers are working
and can at least help the out of tree driver with these.

Maybe one day AMD is getting serious, who knows.

>
> Thanks,
> Guenter

Best Regards,

Gabriel C.
