Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D252EB376
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbhAET1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbhAET1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:27:00 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FD7C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 11:26:20 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b8so274191plx.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=j5YC94PUJukNzrZtum6ex9y7IH98VRbm1CbYMb/DRrI=;
        b=EDSMsVVwv2y5PGV/sagFGoHXOb+ORS3Yhhm2IG/+DlUgFK2380P/hOafjxJwEpJ4RD
         yuf9L9Wj0bOVNt4OcMhGYQn5Qbz2vNVqusyvlCFznGfzFxqgF6q1hG3+KtxE/PHgnLix
         WyL4JlmcmR/NCHy0okbqBwm73J7aaPrA8cyugBAgz/gTgM1ZSJmk1/NXt8+EXfaVd64p
         Wkewz4eAq6ulyFLDbLYnEooDrMATWzfkZs91IeOocToB0Z0/0dj+N6VcWqBg6EstmiWn
         I3LYh5AzA1n3OQvNtDG3PjQQuI9nXCH1h/toERdDhMk0D0bWSVHudnqUerWlaHp40O6w
         wt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=j5YC94PUJukNzrZtum6ex9y7IH98VRbm1CbYMb/DRrI=;
        b=Fgx//bDpzUhj6DwG100IMAs2do5G5Cm2nU2vH0v0VgbtEkGwT974zz+/htbzYwJ4Pi
         QNwgphuKX07iXcwI816X42/Rp+FbrMyLrLmEG4RwIphLw+f2a/8T1a/iLGh1LcbhhwNI
         NY3hfef/2GHMia5S+XeiQ1WkRNWI0j2AIvH6etTKSuM1D/0N2odO9b7LoBPyPZvxKRwN
         DpF7kR1qG64QIMK6hIga7E7G0NiwOBKUridPTUaywFgG2T47it4kQ58yDnDjub1wpJxP
         z5GJzb/mg/umzWcZlfRj6KMlWkV4QkETMsOY8lkWnxsiIV1dkjEBPkyorbJ6dbBYSMMA
         0rbw==
X-Gm-Message-State: AOAM532PYnbCGbHPaCy4wujw1zn0Evl8mIU0J907iJRYjqtISLZ88nDo
        p703EQm91jcg3FAYsdmXMZEbWQ==
X-Google-Smtp-Source: ABdhPJwaC09ywz0ddZ76E+p/nibNhTaf764nwtiyY6k3ZjKWErraTuIJCxOHeEROA5MTGgIzEaBwyg==
X-Received: by 2002:a17:902:7895:b029:dc:4bf0:2b74 with SMTP id q21-20020a1709027895b02900dc4bf02b74mr783475pll.32.1609874779378;
        Tue, 05 Jan 2021 11:26:19 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id j1sm148022pfd.181.2021.01.05.11.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:26:18 -0800 (PST)
Date:   Tue, 5 Jan 2021 11:26:12 -0800
From:   Benson Leung <bleung@google.com>
To:     enric.balletbo@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     Guenter Roeck <groeck@chromium.org>, bleung@chromium.org
Subject: Re: [PATCH v3 00/11] chrome/platform: cros_ec_typec: Register
 cables, partner altmodes and plug altmodes
Message-ID: <160987460685.847195.4276750003386377358.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eWbforYw+181ZeQA"
Content-Disposition: inline
In-Reply-To: <20201116201150.2919178-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eWbforYw+181ZeQA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Mon, 16 Nov 2020 12:11:36 -0800, Prashant Malani wrote:
> This patch series adds support for the following bits of functionality,
> parsing USB Type C Power Delivery information from the Chrome Embedded Co=
ntroller
> and using the Type C connector class:
> - Register cable objects (including plug type).
> - Register "number of altmodes" attribute for partners.
> - Register altmodes and "number of altmodes" attribute for cable plugs.
>=20
> [...]

Applied 4 through 11 of this series, staged for chrome-platform-5.12, thank=
s!

[04/11] platform/chrome: cros_ec_typec: Make disc_done flag partner-only
        (no commit info)
[05/11] platform/chrome: cros_ec_typec: Factor out PD identity parsing
        (no commit info)
[06/11] platform/chrome: cros_ec_typec: Rename discovery struct
        (no commit info)
[07/11] platform/chrome: cros_ec_typec: Register cable
        (no commit info)
[08/11] platform/chrome: cros_ec_typec: Store cable plug type
        (no commit info)
[09/11] platform/chrome: cros_ec_typec: Set partner num_altmodes
        (no commit info)
[10/11] platform/chrome: cros_ec_typec: Register SOP' cable plug
        (no commit info)
[11/11] platform/chrome: cros_ec_typec: Register plug altmodes
        (no commit info)

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--eWbforYw+181ZeQA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCX/S9VAAKCRBzbaomhzOw
whUJAP9s0BcmoZirb6unjOMhQZR/iRAR+J/LCITKhO4Bc9tEHAEAiNrwVDuub/gm
IeUeUbkN+K7EY1DKV7A/HAQBknfttgU=
=OVtJ
-----END PGP SIGNATURE-----

--eWbforYw+181ZeQA--
