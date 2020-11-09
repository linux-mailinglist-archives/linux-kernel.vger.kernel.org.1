Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58602AC0AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgKIQWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgKIQWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:22:12 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6E3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:22:12 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so8473628wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2ghCghzfgavC7PqfaJTuv5Itogj5au+Xw7N+bWnNus=;
        b=bLMSrdodPV6wPjrI4CdQKFEd/r574WY1z/pyx3H5PaA4G3sBwsE3J2r77a2rrr7nsv
         YRkdjU+r6cGU1lX3Gz8rBaUYUtVWpfJc25P7HIcQ6WwLE8Ce+eac9EUs+HXkZL3kIN9A
         CeOV2rnMcOkq7AaUQBfuqzzDG5BWCZbePenmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2ghCghzfgavC7PqfaJTuv5Itogj5au+Xw7N+bWnNus=;
        b=mjZyOK6FUYA8KVGpn6JF8DFF/TEo9RJarWdW3ys0y5iPgT1AS8v3MFhnk+raz1kiSO
         5m85P+NNItitpOTX+6FgZs7yrQTTwrZAxpaW6WK3/yuDwNH00KVLE8Ju7+sID+ZUqsPf
         Pqm+9cGZY1fmBLvAvk3YltwdJG0Rsa/+2QBArGWEDCBx8qCoQXWgcu5X1OOzC188tA9t
         2bNZJYDNHVWcn5cfP41pmElFXDnVaQjP9iIwdOjJmv9bdbJxWfevBIOacxIJIhDht0DK
         hzrDjG3tDA6PByM7lHLb11k2LxyzGR1WZzNww/ji4oGBMIAul1unxBLEQ7UFZzP6JlUn
         /ayA==
X-Gm-Message-State: AOAM531jLa18bKrIwuFSk+2rW0wZ2I2yO1mcqNEftV2HO+/qHousANc3
        FOJpRU7SLVI6Ri8cy3tdC/xbvdoQJQoJ0kJURCS1Jw==
X-Google-Smtp-Source: ABdhPJyfxIKWvAq7bgbIQuQJL/+MSOu3NihbXpUGnuvMaRo9/PqHbaRCadGucSGW03qbnqKGYR4qy4lJZ3NJHSDYbUE=
X-Received: by 2002:a7b:c255:: with SMTP id b21mr149352wmj.72.1604938930561;
 Mon, 09 Nov 2020 08:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20201106191743.40457-1-james.quinlan@broadcom.com>
 <20201106191743.40457-2-james.quinlan@broadcom.com> <64aa1f860bf60ddac7a2015c87896c8a7b13b161.camel@pengutronix.de>
In-Reply-To: <64aa1f860bf60ddac7a2015c87896c8a7b13b161.camel@pengutronix.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 9 Nov 2020 11:21:59 -0500
Message-ID: <CA+-6iNzMAbvhODSX_Kn_DWe_T=9F3xzu5khdh-zdGNPyPs6FdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] reset: brcmstb rescal: implement {de}assert()
 instead of reset()
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000dcf8e805b3aef669"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000dcf8e805b3aef669
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 9, 2020 at 5:05 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Jim,
>
> On Fri, 2020-11-06 at 14:17 -0500, Jim Quinlan wrote:
> > Before, only control_reset() was implemented.  However, the reset core only
> > invokes control_reset() once in its lifetime.  Because we need it to invoke
> > control_reset() again after resume out of S2 or S3, we have switched to
> > putting the reset functionality into the control_deassert() method and
> > having an empty control_assert() method.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>
> You are switching to the wrong abstraction to work around a deficiency
> of the reset controller framework. Instead, it would be better to allow
> to "reactivate" shared pulsed resets so they can be triggered again.


True.
>
>
> Could you please have a look at [1], which tries to implement this with
> a new API call, and check if this can fix your problem? If so, it would
> be great if you could coordinate with Amjad to see this fixed in the
> core.
>
> [1] https://lore.kernel.org/lkml/20201001132758.12280-1-aouledameur@baylibre.com/


Yes, this would work for our usage.  Amjad please let me know if I can
help here.  The only "nit" I have is that I favor the name 'unreset'
over 'resettable' but truly I don't care one way or the other.

Thanks and kind regards,
Jim Quinaln
Broadcom STB
>
>
>
> regards
> Philipp
>
> > ---
> >  drivers/reset/reset-brcmstb-rescal.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/reset/reset-brcmstb-rescal.c b/drivers/reset/reset-brcmstb-rescal.c
> > index b6f074d6a65f..1f54ae4f91fe 100644
> > --- a/drivers/reset/reset-brcmstb-rescal.c
> > +++ b/drivers/reset/reset-brcmstb-rescal.c
> > @@ -20,8 +20,8 @@ struct brcm_rescal_reset {
> >       struct reset_controller_dev rcdev;
> >  };
> >
> > -static int brcm_rescal_reset_set(struct reset_controller_dev *rcdev,
> > -                              unsigned long id)
> > +static int brcm_rescal_reset_deassert(struct reset_controller_dev *rcdev,
> > +                             unsigned long id)
> >  {
> >       struct brcm_rescal_reset *data =
> >               container_of(rcdev, struct brcm_rescal_reset, rcdev);
> > @@ -52,6 +52,12 @@ static int brcm_rescal_reset_set(struct reset_controller_dev *rcdev,
> >       return 0;
> >  }
> >
> > +static int brcm_rescal_reset_assert(struct reset_controller_dev *rcdev,
> > +                           unsigned long id)
> > +{
> > +     return 0;
> > +}
> > +
> >  static int brcm_rescal_reset_xlate(struct reset_controller_dev *rcdev,
> >                                  const struct of_phandle_args *reset_spec)
> >  {
> > @@ -60,7 +66,8 @@ static int brcm_rescal_reset_xlate(struct reset_controller_dev *rcdev,
> >  }
> >
> >  static const struct reset_control_ops brcm_rescal_reset_ops = {
> > -     .reset = brcm_rescal_reset_set,
> > +     .deassert = brcm_rescal_reset_deassert,
> > +     .assert = brcm_rescal_reset_assert,
> >  };
> >
> >  static int brcm_rescal_reset_probe(struct platform_device *pdev)

--000000000000dcf8e805b3aef669
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINgAXILT4CkY
dN20c2IKrOwx4OS2jTdR9d/OeTzG2PKhMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEwOTE2MjIxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA8rM69izrGdjPPmbRgeKMyvn5Q+3J1
vWnS5Zvx9rP02RD8GAK1tXsKf91E65zT8P2/CRgtE4Wa/IgrBuIbSz+IDwFKCs4RtgQh55kObz/M
FDVbpE2pnu4TC6gq5jjf0+AlivsyIatIiqbR4SJqgiP6eip6lfF8D4nIZGFo2aaaWXA3ncR1hKdL
VoCNf5haGVLOe3ZpLHuul3yeTS0rQpDS90TyJCeElqiK5eqC76Z8jbbPfvEIIFy/E3oW4MkO5slB
nhMo84MTDUtLgVJV/1K2nn5KUFpFf4K2TZnBLVFa21NXKAb0RlVgoI/v20U8vjt8/CgodBgInMCD
cD2uUVKw
--000000000000dcf8e805b3aef669--
