Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E841A2F72F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 07:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbhAOGgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 01:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbhAOGgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:36:19 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061ACC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 22:35:39 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id by27so8326286edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 22:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QhKlR9L8Hw7WXmoWGlgL9OWqdEKBdvG5SyTumfZXJ3E=;
        b=WH3fIQBbwJ46UB5a7J+cSBX1DnzjtI851hxeJlIrmuDiqHer4mr5tHJXPzO+4t/n8Q
         dJrGkQlS6kR5fj6cAWaK7rGtWjO3wuXdpBcYO0pRtOJ8AdyQQ1GT/LhmBOXZ+fzokxOy
         eSHRLQskmwiNKEi+bPd6yBQRjFqZmlf6yRS+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhKlR9L8Hw7WXmoWGlgL9OWqdEKBdvG5SyTumfZXJ3E=;
        b=qJMDE/Gx5+mYu/chinakKTW6XoGrf9B5tXpoqSRFto/28B7N9MK3yphJxwPIuPd3sa
         NU5maZA86eHdZTRoDsyPQJqqpnlH+WddSWxZrY+25G3CMvbPEaIDYOhTAf4nsWvITV2J
         s1UZtw/271RV31Q+3jG6gjwaD8c1X+UQ3b5ycTSofGAccPwIN5i5mXsUzC1YifcuI1XO
         1YdIoB56Z9aCuwO+pYXa8SskhqI/PWC0Mn+tu4txClUEOa7B1DHjmCPBPE2d80IYjiGf
         PfL5VooG1WaqUSj50cyPFOOD5IMTygReVTC3gotFvIHgUr7DndzPQgu7/oWT69vvPYZG
         xvlg==
X-Gm-Message-State: AOAM531FR+IndcNGq49UdVxdRP+jQNA9VJvPTL3k3UUJXZMcr/ZGP54J
        cfzx4DXvK3ldLQ/V8ozGzjO2UKNOOGf9vEdwV39hzw==
X-Google-Smtp-Source: ABdhPJxtXlKBGu9Dv9Wv+PKaKtwff2ZnxzVutZcQlgyrKXKIAEBzbiiZVR4XrWE0GpebBBMbCQnbbfPaC2zfRbsm21E=
X-Received: by 2002:a05:6402:510f:: with SMTP id m15mr8565319edd.267.1610692537419;
 Thu, 14 Jan 2021 22:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20201124161646.41191-1-vikas.gupta@broadcom.com>
 <20201214174514.22006-1-vikas.gupta@broadcom.com> <20201214174514.22006-3-vikas.gupta@broadcom.com>
 <b3dcbca3-c85a-d327-e64e-5830286dfbba@redhat.com>
In-Reply-To: <b3dcbca3-c85a-d327-e64e-5830286dfbba@redhat.com>
From:   Vikas Gupta <vikas.gupta@broadcom.com>
Date:   Fri, 15 Jan 2021 12:05:25 +0530
Message-ID: <CAHLZf_u860kCfpExucwOxWmTDzH_QXnR_O=X8Yq3NAtXesmZ0w@mail.gmail.com>
Subject: Re: [RFC v3 2/2] vfio/platform: msi: add Broadcom platform devices
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Ashwin Kamath <ashwin.kamath@broadcom.com>,
        Zac Schroff <zachary.schroff@broadcom.com>,
        Manish Kurup <manish.kurup@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000090c72105b8ea94b6"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000090c72105b8ea94b6
Content-Type: text/plain; charset="UTF-8"

Hi Eric,

On Tue, Jan 12, 2021 at 2:52 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Vikas,
>
> On 12/14/20 6:45 PM, Vikas Gupta wrote:
> > Add msi support for Broadcom platform devices
> >
> > Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > ---
> >  drivers/vfio/platform/Kconfig                 |  1 +
> >  drivers/vfio/platform/Makefile                |  1 +
> >  drivers/vfio/platform/msi/Kconfig             |  9 ++++
> >  drivers/vfio/platform/msi/Makefile            |  2 +
> >  .../vfio/platform/msi/vfio_platform_bcmplt.c  | 49 +++++++++++++++++++
> >  5 files changed, 62 insertions(+)
> >  create mode 100644 drivers/vfio/platform/msi/Kconfig
> >  create mode 100644 drivers/vfio/platform/msi/Makefile
> >  create mode 100644 drivers/vfio/platform/msi/vfio_platform_bcmplt.c
> what does plt mean?
This(plt) is a generic name for Broadcom platform devices, which we`ll
 plan to add in this file. Currently we have only one in this file.
Do you think this name does not sound good here?
> >
> > diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig
> > index dc1a3c44f2c6..7b8696febe61 100644
> > --- a/drivers/vfio/platform/Kconfig
> > +++ b/drivers/vfio/platform/Kconfig
> > @@ -21,3 +21,4 @@ config VFIO_AMBA
> >         If you don't know what to do here, say N.
> >
> >  source "drivers/vfio/platform/reset/Kconfig"
> > +source "drivers/vfio/platform/msi/Kconfig"
> > diff --git a/drivers/vfio/platform/Makefile b/drivers/vfio/platform/Makefile
> > index 3f3a24e7c4ef..9ccdcdbf0e7e 100644
> > --- a/drivers/vfio/platform/Makefile
> > +++ b/drivers/vfio/platform/Makefile
> > @@ -5,6 +5,7 @@ vfio-platform-y := vfio_platform.o
> >  obj-$(CONFIG_VFIO_PLATFORM) += vfio-platform.o
> >  obj-$(CONFIG_VFIO_PLATFORM) += vfio-platform-base.o
> >  obj-$(CONFIG_VFIO_PLATFORM) += reset/
> > +obj-$(CONFIG_VFIO_PLATFORM) += msi/
> >
> >  vfio-amba-y := vfio_amba.o
> >
> > diff --git a/drivers/vfio/platform/msi/Kconfig b/drivers/vfio/platform/msi/Kconfig
> > new file mode 100644
> > index 000000000000..54d6b70e1e32
> > --- /dev/null
> > +++ b/drivers/vfio/platform/msi/Kconfig
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config VFIO_PLATFORM_BCMPLT_MSI
> > +     tristate "MSI support for Broadcom platform devices"
> > +     depends on VFIO_PLATFORM && (ARCH_BCM_IPROC || COMPILE_TEST)
> > +     default ARCH_BCM_IPROC
> > +     help
> > +       Enables the VFIO platform driver to handle msi for Broadcom devices
> > +
> > +       If you don't know what to do here, say N.
> > diff --git a/drivers/vfio/platform/msi/Makefile b/drivers/vfio/platform/msi/Makefile
> > new file mode 100644
> > index 000000000000..27422d45cecb
> > --- /dev/null
> > +++ b/drivers/vfio/platform/msi/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_VFIO_PLATFORM_BCMPLT_MSI) += vfio_platform_bcmplt.o
> > diff --git a/drivers/vfio/platform/msi/vfio_platform_bcmplt.c b/drivers/vfio/platform/msi/vfio_platform_bcmplt.c
> > new file mode 100644
> > index 000000000000..a074b5e92d77
> > --- /dev/null
> > +++ b/drivers/vfio/platform/msi/vfio_platform_bcmplt.c
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2020 Broadcom.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/msi.h>
> > +#include <linux/vfio.h>
> > +
> > +#include "../vfio_platform_private.h"
> > +
> > +#define RING_SIZE            (64 << 10)
> > +
> > +#define RING_MSI_ADDR_LS     0x03c
> > +#define RING_MSI_ADDR_MS     0x040
> > +#define RING_MSI_DATA_VALUE  0x064
> Those 3 defines would not be needed anymore with that implementation option.
> > +
> > +static u32 bcm_num_msi(struct vfio_platform_device *vdev)
> > +{
> > +     struct vfio_platform_region *reg = &vdev->regions[0];
> > +
> > +     return (reg->size / RING_SIZE);
> > +}
> > +
> > +static struct vfio_platform_msi_node vfio_platform_bcmflexrm_msi_node = {
> > +     .owner = THIS_MODULE,
> > +     .compat = "brcm,iproc-flexrm-mbox",
> > +     .of_get_msi = bcm_num_msi,
> > +};
> > +
> > +static int __init vfio_platform_bcmflexrm_msi_module_init(void)
> > +{
> > +     __vfio_platform_register_msi(&vfio_platform_bcmflexrm_msi_node);
> > +
> > +     return 0;
> > +}
> > +
> > +static void __exit vfio_platform_bcmflexrm_msi_module_exit(void)
> > +{
> > +     vfio_platform_unregister_msi("brcm,iproc-flexrm-mbox");
> > +}
> > +
> > +module_init(vfio_platform_bcmflexrm_msi_module_init);
> > +module_exit(vfio_platform_bcmflexrm_msi_module_exit);
> One thing I would like to discuss with Alex.
>
> As the reset module is mandated (except if reset_required is forced to
> 0), I am wondering if we shouldn't try to turn the reset module into a
> "specialization" module and put the msi hooks there. I am afraid we may
> end up having modules for each and every vfio platform feature
> specialization. At the moment that's fully bearable but I can't predict
> what's next.
>
> As the mandated feature is the reset capability maybe we could just keep
> the config/module name terminology, tune the kconfig help message to
> mention the msi support in case of flex-rm?
>
As I understand, your proposal is that we should not have a separate
module for MSI, rather we add in the existing reset module for
flex-rm. Thus, this way reset modules do not seem to be specialized
just for reset functionality only but for MSI as well. Apart from this
we need not to load the proposed msi module in this patch series. Is
my understanding correct?
For me it looks OK to consolidate MSI in the existing 'reset' module.
Let me know your views so that I can work for the next patch set accordingly.

Thanks,
Vikas

> What do you think?
>
> Thanks
>
> Eric
>
>
>
>
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Broadcom");
> >
>

--00000000000090c72105b8ea94b6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2lQ6rFUP408r38ha7ieLj9GoHHitwSmKYwUIGObe2Y57xYNj855BF4wx44Z80uM2ugKCZwIDAQAB
o4IBzzCCAcswDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggrBgEFBQcwAoZB
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNpZ24yc2hhMmcz
b2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9nc3BlcnNv
bmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwRAYDVR0fBD0w
OzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMu
Y3JsMCMGA1UdEQQcMBqBGHZpa2FzLmd1cHRhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUnmgVV8btvFtO
FD3kFjPWxD/aB8MwDQYJKoZIhvcNAQELBQADggEBAGCcuBN7G3mbQ7xMF8g8Lpz6WE+UFmkSSqU3
FZLC2I92SA5lRIthcdz4AEgte6ywnef3+2mG7HWMoQ1wriSG5qLppAD02Uku6yRD52Sn67DB2Ozk
yhBJayurzUxN1+R5E/YZtj2fkNajS5+i85e83PZPvVJ8/WnseIADGvDoouWqK7mxU/p8hELdb3PW
JH2nMg39SpVAwmRqfs6mYtenpMwKtQd9goGkIFXqdSvOPATkbS1YIGtU2byLK+/1rIWPoKNmRddj
WOu/loxldI1sJa1tOHgtb93YpIe0HEmgxLGS0KEnbM+rn9vXNKCe+9n0PhxJIfqcf6rAtK0prRwr
Y2MxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDDTZ
lyNZkGMqSi5xbzANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgfUIxHkvkfOVZf9f8
PF23pnMiXMPII4DpxZU/L+WwfTUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjEwMTE1MDYzNTM3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEeQ8GaPlpdOAkGgdBEBSaFz8YfpVgFx2FCc
KOSB7XCMuqBbKs0lmVhjx59E4vVX1DNf8heViQ0TdyOtdNYVISbaIwb9yfM9ulCHY7/ofhMj8Loe
alSuAar8BK8KEAWZGY0rAcqq2V2IxePIBNdv9IZ3Hj3TXFZ+oeMudajcz9AAn6C7ZX9FU7jsBiQU
CnhHhTsrwxJvDgdUF6+DJD6E55C2yImNlp98DE5FFhd12W7aDAs06HN/sqYIRFewGWSnww/TfZ1e
PBizyj/H15QFA+XFWzTXhtbrzTbpmesEMwssOL4kepjUQ+tkBaRW1h2FwUN9KNimSdh0WIwEMqqO
DqQ=
--00000000000090c72105b8ea94b6--
