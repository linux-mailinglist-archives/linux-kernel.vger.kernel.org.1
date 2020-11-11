Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CFC2AF6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKKQpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKKQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:45:38 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4006C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:45:37 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so3124765wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UB+byjwsXJtvDH0LP6ZHa2hHZex+cqsVz62W69Rv94w=;
        b=IZANG1KZFIAuJ0f7mTv603umOt/SOHTFSGxxkfBkV5Wko9aEfi+XtKczgvJhPlPKRU
         oI+urOenoXCxwSA5xhdYMNvByw8QRzaj9tMr3VYSDkgrhEp7H88yZsLznEhv6G/pNrIb
         vS9VHnXExQKdABA01g7wBKLcJtejcw3nyBSlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UB+byjwsXJtvDH0LP6ZHa2hHZex+cqsVz62W69Rv94w=;
        b=MZaQ4aTDpBKuXhepEmF5fVJKJWQmel43nxQaB5sPPSRUERa1/haGHjfq2Oeq0P/w8E
         Sn43lF+rJKzJYFcRqCbWAuj4NZ/DNstg3kz2F9+Ew5tEVeC9I/CyYqjvBp+4rx3d0MRf
         zqTt571P1wT0+JpyDoM4MRNi6DZ+T9FcrHxWv4f7qmEUJ5XOT9BfBgwQSwaQqb6IS5mO
         WskJJZd6316JFdvtVSMnEI5r+sJ7adWOstuYGlc8hYs7sMlCGcVIOo6gMqUFWLAE2Hq3
         qW18ZL4g1Hn613n3VtIcwF5zylc6D7V7Ot95t2eiGyqBjeP/+2sUwzeVdnPXN2E+Kk0K
         /J0g==
X-Gm-Message-State: AOAM531uoT7kkDpV3Lx2WJS2GzMsvbxShRkyhIOstBVtdhmb1LYd6kcj
        W9AO5DXj6foH/PPxYlJOcLBU6U6065XaGLrgRWROreP02oQ=
X-Google-Smtp-Source: ABdhPJzTZZyd16sexlq9ikqAMGabbqSPBkholudms1bhpO6EIWqXWnYXDe290ZzP9c2byOSX9fm3ljB23nkkA/S7wGE=
X-Received: by 2002:a5d:660f:: with SMTP id n15mr25659502wru.345.1605113136263;
 Wed, 11 Nov 2020 08:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20201110183827.19731-1-james.quinlan@broadcom.com>
 <20201110183827.19731-2-james.quinlan@broadcom.com> <20201111104157.wpll6en4qvlhb2ws@bogus>
In-Reply-To: <20201111104157.wpll6en4qvlhb2ws@bogus>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 11 Nov 2020 11:45:24 -0500
Message-ID: <CA+-6iNwqKKPzEWLJuRvS_Vubq1GAUE5zNzQobvR8Di4iF1ALwA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000055a43105b3d78691"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000055a43105b3d78691
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 11, 2020 at 5:42 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Nov 10, 2020 at 01:38:19PM -0500, Jim Quinlan wrote:
> > The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
> > message to be indicated by an interrupt rather than the return of the smc
> > call.  This accommodates the existing behavior of the BrcmSTB SCMI
> > "platform" whose SW is already out in the field and cannot be changed.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/firmware/arm_scmi/smc.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> > index 82a82a5dc86a..3bf935dbd00e 100644
> > --- a/drivers/firmware/arm_scmi/smc.c
> > +++ b/drivers/firmware/arm_scmi/smc.c
> > @@ -9,9 +9,11 @@
> >  #include <linux/arm-smccc.h>
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/mutex.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/slab.h>
> >
> >  #include "common.h"
> > @@ -23,6 +25,8 @@
> >   * @shmem: Transmit/Receive shared memory area
> >   * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
> >   * @func_id: smc/hvc call function id
> > + * @irq: Optional; employed when platforms indicates msg completion by intr.
> > + * @tx_complete: Optional, employed only when irq is valid.
> >   */
> >
> >  struct scmi_smc {
> > @@ -30,8 +34,19 @@ struct scmi_smc {
> >       struct scmi_shared_mem __iomem *shmem;
> >       struct mutex shmem_lock;
> >       u32 func_id;
> > +     int irq;
> > +     struct completion tx_complete;
> >  };
> >
> > +static irqreturn_t smc_msg_done_isr(int irq, void *data)
> > +{
> > +     struct scmi_smc *scmi_info = data;
> > +
> > +     complete(&scmi_info->tx_complete);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  static bool smc_chan_available(struct device *dev, int idx)
> >  {
> >       struct device_node *np = of_parse_phandle(dev->of_node, "shmem", 0);
> > @@ -79,6 +94,20 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* Optional feature -- signal message completion using an interrupt */
> > +     ret = of_irq_get_byname(cdev->of_node, "msg-serviced");
>
> So, looks like it is mandatory if "interrupts" is used. Please update the
> binding or if that is not the practice followed elsewhere, drop search by
> name.

Well, I can certainly change the comment. I do not want it to be
"mandatory" if just interrupts are used.
 The reason I prefer using "interrupt-names" is that this allows
unforeseen use of future additional interrupts w/o caring about order
in the interrupts DT node.  If you are absolutely positive that there
will never be other interrupts used  in the future for the SCMI node
then I will drop it.

>
> Also I prefer full name "message-serviced" if possible, not strong
> opinion.

Will do.

>
>
> > +     if (ret > 0) {
> > +             scmi_info->irq = ret;
>
> May be set this only if we succeed setting up handler ? I mean move this
> down.

Will do.

Regards,
Jim Quinlan
Broadcom STB


>
>
> Other than these, the changes look fine.
>
> --
> Regards,
> Sudeep

--00000000000055a43105b3d78691
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFX1M14MsOsI
zSvEE1YW/XT3bHtPGJ3hNDx0H6Tqo9j5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTExMTE2NDUzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDHHT+u88cdoAHsBqlSue1ejccAnEyH
GZpMTU39d3welNewUgrGSimTz9fTyhRkJqyhu9ePB7/vULGVj3s2prqU2gzJ7zJOugYanjIzO6Xr
XJI+jYe2ZwG0nQCJlkjnUGSqBEG2WflkH/OoOyCH0U4GmamsVIMwPUN6/7hGlhqyQx6Q+DFcXrCF
/GBx/aqGVSoYEzeVH0UvDx917L4SlMgiTcwGtoQyaoYuOJ1IC2USUUaHqYD+ibmxfnrFlXf8Pg7s
AX0ee2Y6QHJcku/RmqErqrNSwlLcI4jr4JpPZTW9pVapbFQLS2SdrzhG0oGQTYRqtL0u65qoZV//
so6DtyF8
--00000000000055a43105b3d78691--
