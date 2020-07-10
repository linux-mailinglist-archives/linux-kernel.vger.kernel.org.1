Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D79621AF27
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 08:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGJGIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 02:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgGJGIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:08:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81421C08C5CE;
        Thu,  9 Jul 2020 23:08:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so5086973ljv.5;
        Thu, 09 Jul 2020 23:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=lRfwj4BHA5SmkTCLszGaorekKIYPb/tiAdhoiGB9VyM=;
        b=Kz6CctuCGvLTKE/zff1VDJnM5l9JFbToUmtSnV+Ak0hGdyS8MkDYxYaf50tYG6xVwl
         EhkoKRTzCKFutu5+uMot2oIkrXduH11LSNmTVZYoAZykJjqsMfKguC11TRqXwaoJqmIN
         VXUQgtsd0uNhcDtpKRPXKPRpoE6mLoXwo9o29f4sJmJMxiyDBaGOQTCWjFTQKE7i0LL5
         P+rCf8rg3fnKgRPuqTs+QdhbUEBARbhEFbwwn0RGyRbh6rM7AMo8kP6sI8UADZStU2d7
         BgZSOs9pGkV+wabPGNT3aqtt6bpLDIZKWy3upYwC5A7Vz+PbZBXCL84Jb7NrhkPU841h
         ZIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=lRfwj4BHA5SmkTCLszGaorekKIYPb/tiAdhoiGB9VyM=;
        b=KKoar2uwI4QtQIUwxNCEMS/TnhnimOpaZM7xHoSs/duO3qyR7r48M6RtrKKf8X2ihs
         KR2HhwLPw+/h4ZCniOWl91r5AdQbYL3fnZUH5wdMTZoiCTRNe7fp4HtT2HlbQlM9EpD7
         THqISFE2nhKB6SgZogBFtPoegf75bCJlmhvmH5usKkE8k69M1toYXb7HtOtuGFL6SYzh
         8q3lkJ1BMVBb2Z3ybFKzJMLKHw7AEM3kzPUyrQEAhbMYBUXRszgBFkq1nm5Nj+y1A0BJ
         9TmeDGkZSkocp9LQGNmCgkcw342aoFbypNEUJvmzAD3wxgXv8+FWtirsN0RF0wK7nTcN
         nCNw==
X-Gm-Message-State: AOAM530YE6ChIdfH9XdkmhQ9vxYGaSRj+0HnHei+MpC2OZH6SRxymiKL
        yW4QMw54FKZlrIAvnvSCobg=
X-Google-Smtp-Source: ABdhPJxGGMmuPkrDz1atQLdBX2QRyj5KbJAuPHduR2muUCVw+/VATbS8wijHIodTpTMmPpG0A/ezCg==
X-Received: by 2002:a2e:7615:: with SMTP id r21mr29940355ljc.124.1594361294942;
        Thu, 09 Jul 2020 23:08:14 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id s8sm1545691ljh.74.2020.07.09.23.08.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jul 2020 23:08:14 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     "Ramuthevar\,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        p.zabel@pengutronix.de
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v4 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
In-Reply-To: <20200617035818.54110-3-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200617035818.54110-1-vadivel.muruganx.ramuthevar@linux.intel.com> <20200617035818.54110-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Date:   Fri, 10 Jul 2020 09:08:09 +0300
Message-ID: <87blknrjg6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

"Ramuthevar,Vadivel MuruganX"
<vadivel.muruganx.ramuthevar@linux.intel.com> writes:

> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel=
.com>
>
> Add support for USB PHY on Intel LGM SoC.
>
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@li=
nux.intel.com>
> ---
>  drivers/usb/phy/Kconfig       |  11 ++
>  drivers/usb/phy/Makefile      |   1 +
>  drivers/usb/phy/phy-lgm-usb.c | 275 ++++++++++++++++++++++++++++++++++++=
++++++

new phy drivers should use drivers/phy instead.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8IBckACgkQzL64meEa
mQYZ6BAAu5MqDG/JYVcpiey75QpGHGvsHZBZTk7WOeelxqLVV3w2Nt2hv3678T0Q
MZE47NTCyKryH6pNph9WdUxTdPLWqIAnUNXEZYbyGJypSesojI+MDvOH/lNFLzn0
aJsg8mngVJoQeOe7vY694PvQYgpf2NlTiw8pqPRUkhaDRKTSyEZ03e0RQnsJx+I4
Rf3cKvvfhRY5o1PFa1XIZt8hBJ/6HbYBfXObxwdr3tNV8hjSArKzh8AnT017VGHq
THQPa1pxGRsyTthgUAT03sqiDIbeEmNdvjhST5OcfrH00kLztJflLO35c8TWiZGQ
P3vcM/jFBKYMSt6vkRWiejslL/wxFi+hDaNM3jYSGRXeblqfhP9wuTCXlymVJ3Oq
9sga4yDpXvDF4w89IVyOMyheXEM+L3TRcs+3EzLXnbOWzeJroyIPPvcDPzhg0X9J
VQp+ZirKFKJDBj2420O+a17l76m0q5Gru1qEDfmBiktYRw527RQkH+zU6Viv3PR5
H/cXhIEjQt2mofRiVfMyvOC37r2Fv0ucfHCAWRr1LHKsRLt6PyWztOqWZ6vuPlma
Nl5qRGSo7OHDYmETGiolEYqE09zv5zzCJT3D3eVf5nMyn2VoDSyEWH705Xq3XOSj
IyWcMERI9OthanyVYWeRG0lChTC1XAUHUltZ3TCvewjwAlK6b0A=
=i/Uk
-----END PGP SIGNATURE-----
--=-=-=--
