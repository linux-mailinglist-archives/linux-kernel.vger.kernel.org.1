Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D0F2FAB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394336AbhARUet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394349AbhARUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:33:50 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5FEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 12:33:09 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id y128so13839491ybf.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 12:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cjViKl7dLsD4jbmeBrsSqGceLo2g/gU02xOGA0AjrXU=;
        b=byuEMhZfK6TiUTCNZUnT1+Yj5tSUV7T6j2yzslqZ/BssZzG605a8Mw6VqUlAl9NT56
         Y53QIiUW/pGxb+3qCj40uU6uaoZi4Fq3RzCLd4KOH6XLg6Ja7/ORmXc3V4IV7DCwWjFg
         KYULuIQZHyhoeN39KRKPIji0uclSIS+QBNPO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjViKl7dLsD4jbmeBrsSqGceLo2g/gU02xOGA0AjrXU=;
        b=C329dAnzEYxFAFZAHOIW9YuNKnshKlrlg5V9bqBqLPf9BuBFgKYYwqC75ufbKGGHDl
         8zW0TdV2QOMnq9CTVw8EFNBwqw042Kgj7ewCHKBpa6SLjRIvi6LakUN2JKTsj7nZJ9qW
         tcQnyd4Xd7m6gQL0b8uhrCwC/nm0LR6fLFJJeHDquhu4ZnMqxBOVJ4UDjU67WMiZJ1i2
         nHB4bJKJFeptq4rKK1unjcedyb5mEwg9yeP8tiozgeH34ynE1n0/A2EFeF/hXrVIHRSo
         Re2qUM/qZ4o35xHS/6A8M/6yYkvF4Bu/L9SB1GTNqm+/b9vbeG/ZiaC3cQu8TxeJQV5k
         gEiA==
X-Gm-Message-State: AOAM533G3/KNBshsODQqQmX6WE4ZHdaksn2QMMpL+XH9ddCIC0Ya9Hno
        FgR4Q7fWdDmaeUBJjKq5Wvrt3NdRHCHo8tl8TJZg
X-Google-Smtp-Source: ABdhPJxGXi8s6cRCj8vRTAq8L6wBHsz9XsiKr3wnxKrj3WqflWrOcfOvfRxcEXwu1UbXfrnvWDwvobloSP4xnfHAHeA=
X-Received: by 2002:a25:77d2:: with SMTP id s201mr1140925ybc.424.1611001989056;
 Mon, 18 Jan 2021 12:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20210115211543.33563-1-alcooperx@gmail.com> <20210115211543.33563-3-alcooperx@gmail.com>
 <YAXJRDhS1HXeYaZz@kroah.com>
In-Reply-To: <YAXJRDhS1HXeYaZz@kroah.com>
From:   Al Cooper <al.cooper@broadcom.com>
Date:   Mon, 18 Jan 2021 15:32:57 -0500
Message-ID: <CAGh=XABU=jdLWo8AfSBZPwn+_gDfCNN07cg9a58nxknjjyEfxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: 8250: Add new 8250-core based Broadcom STB driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000050f29805b932a16f"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000050f29805b932a16f
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 18, 2021 at 12:45 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 15, 2021 at 04:15:43PM -0500, Al Cooper wrote:
> > Add a UART driver for the new Broadcom 8250 based STB UART. The new
> > UART is backward compatible with the standard 8250, but has some
> > additional features. The new features include a high accuracy baud
> > rate clock system and DMA support.
> >
> > The driver will use the new optional BAUD MUX clock to select the best
> > one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> > the baud rate selection logic for any requested baud rate.  This allows
> > for more accurate BAUD rates when high speed baud rates are selected.
> >
> > The driver will use the new UART DMA hardware if the UART DMA registers
> > are specified in Device Tree "reg" property. The DMA functionality can
> > be disabled on kernel boot with the argument:
> > "8250_bcm7271.disable_dma=Y".
>
> Shouldn't that be on a per-device basis, and not a per-driver basis?

There is only one instance of the UART DMA hardware and it gets muxed
to just one of the possible UARTS.

>
> And why would you want to disable this, if you have support for this in
> the DT?  Why not just rely on the DT setting?

The DMA feature is used when the UART is connected to a Bluetooth
controller and the BAUD rate is typically 2-3Mbs. The ability to
easily disable DMA is very useful when debugging BT communication
problems in the field. DT settings could also be used to disable DMA,
but knowing the correct modifications to the "reg" and "reg-names"
properties is a lot more complicated.

Thanks
Al

>
> thanks,
>
> greg k-h

--00000000000050f29805b932a16f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
yXmUToMxtlREK8ddtKO4bV6ekA5Mxh5jo4JcHCHlgaNowvQgrCTX+FCX8utZUxwNAgMBAAGjggHN
MIIByTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAChkFodHRw
Oi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEyZzNvY3Nw
LmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxz
aWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8EPTA7MDmg
N6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJnMy5jcmww
IQYDVR0RBBowGIEWYWwuY29vcGVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUgzDqs/CvVCxhgdEnsBOO
IpL3nHAwDQYJKoZIhvcNAQELBQADggEBACPmJjK2ALJm+IX2DvRRxd7cn7ZA10wn9zxy4ifd84Y7
MSoFpkcgMBFNZB0BF05H/KXZGTFlQm+DdKIIhg/LbPsca/s1i8rXgk1mo2wqn+/mNCtwllAfHe8j
gvBuVbTIhYXp5o/JC2AX639UdQaVAV66YQUpyj5KiMA79MRQU3fbd62/7ynokd5Ufw7XbkhqG7uK
8H7iL6o7IlMM8F5Mf22eZB8hM3WZGYFEyl8V2uYLFWiUDXcp4RiNeCV45AnT+Jg83AWNwTr0TxuE
tlnxwkojsM1vKTuxUQ5kNI8Aq3v/obzat389kqxBjAd7HTjWDFso5KRS9ZVH2tsbKB1dZtAxggJv
MIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYD
VQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDEzVwUNs2XQM
HDSO3jANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg4IUyD49KVvbQpZgd3GYD++78
/0Q6HA7GJ4sKccK5cHQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MjEwMTE4MjAzMzA5WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYw
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZI
AWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIeA9mCU26fn6nq5H4CRolepAv5hVojZcl9n/dCA0wPJ
h7cOqTV+ggziCHt3FhQM3VgkRCRhx4VoBgVuJiWe6Vifh0e1dSScDYvvmAhKu6y50OtI0hPAzvWg
mEV9vVPJ65oRkBkJR86YPiAPpN442eJJftl2Ea/aMCTkJ0J8NUlrJ3JPK8rU6Bdu1b7/1oDSR6Lr
3FYiDUFu0CvqGAi/SPUXmUTwh25Czs3etfPRQJJLA5/P+MgnZChJMMtIuBNynrodKn6QLjOh5d3S
mDYjRUf5dJ4DdFgoDH1H+8HTAhtlFPrDTLlqpbAch0MM0warXHdNyFd/ldMqXUoJjO9fIE4=
--00000000000050f29805b932a16f--
