Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732422F51A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbhAMSDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbhAMSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:03:07 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68C9C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:02:27 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id z11so3023383qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=fUXJJK3InTCGIV7ZAe99E1ezMLxV/olFXGPan1G5q1I=;
        b=ZFY+WChPGcAOl0Euup4fNuUfz/JJNcsmzvhh+XVgXR+yBJfvm7mBCBFvNS30ufNw8P
         fgaRpRhL5WCyKF6GmwG/44MBTxYbeIVmRHxdQScVOd36qchETQYKH8r5YREkj5Uq824I
         zDxrVp52itBMO9NG0AKWqXsvzMJi13sjJEztXE5Lulr8732GT+XYIEqruue7mpPHNVeK
         s7Mtn6k/oXOyTR2q0Y+iCiRjdKbA1WoZFbpJjoSKEV2Qb9KgjiuBxKjDmPpi1sCOmsn1
         /cHJT/HhZwS0+z/xpREP5O5ur7D50n+Ymv6h+GpHonAgP+9QEax6Kuw3DmE4hI5vMmRS
         0Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=fUXJJK3InTCGIV7ZAe99E1ezMLxV/olFXGPan1G5q1I=;
        b=jdSFAlHHvU6h6+psFQxhJ3dgFO+nsM26eIZQHZjfvl5Yr150FF+NSo08gVWjJBTod5
         XarKyifNNMLDuMC3Q4CGlWi7q1UbK4w+nox4Gs9Lo885mYjn88gbGaV0kxF7fd8ekxRv
         +RLxW3xTBtCFDhqWYy/jtw/7z4N6hHe5S+MHBcScypfa0bSB1s9dDimpvAtzhSvqob42
         0TGOQ/a6Pj6aoYsd0JhjLyBKCc+3aWjUiuBSEH8xUmN+v3KNcgedVEdqvUQYLffcnPPQ
         sz3+8c4sAGB1D1wJENonsOxAHpzcwJXHrcsPIii0zKp7PmKgjEagVv+4lrdVRG/R1J+r
         ldNg==
X-Gm-Message-State: AOAM532LlEAdnJVlRPNu7UlUqAGVYS6vdTXnB3vkcm/FYNZ9C4+Nfk1R
        Ajzh5HYVR/YyIp4X0YvA5Sv38g==
X-Google-Smtp-Source: ABdhPJyZAkYUy5dOU4MhO6mvhRYN0Eb1LTOmCbi8TXiHMtCB1HnaaF3jcHFOjMdZylLkQpdAYEyKLg==
X-Received: by 2002:a37:5b85:: with SMTP id p127mr3337519qkb.180.1610560946855;
        Wed, 13 Jan 2021 10:02:26 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id j30sm1397975qtl.43.2021.01.13.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 10:02:25 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gcc-plugins: fix gcc 11 indigestion with plugins...
In-Reply-To: <20210113170836.xvlq5xlmkjpi4zx7@treble>
References: <38485.1610500756@turing-police>
 <20210113170836.xvlq5xlmkjpi4zx7@treble>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1610560944_6220P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Jan 2021 13:02:24 -0500
Message-ID: <93580.1610560944@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1610560944_6220P
Content-Type: text/plain; charset=us-ascii

On Wed, 13 Jan 2021 11:08:36 -0600, Josh Poimboeuf said:

> The first patch has already been merged into Linus' tree, so this
> probably should be an incremental fix on top, with a Fixes: tag.

Gaah.  v3 in a moment. :)

--==_Exmh_1610560944_6220P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX/81sAdmEQWDXROgAQLZeBAAossB2dxplTQEbLOpEzZeIguttkET9IE5
6qKP2TDHdIW+pEtBaRra2MWgpzKn599XFqixusZZHlGn5MW/tX1VOPlydUsvr6Fa
r8e4JvPvAMxW2bmm7ohJNpYYLvs67KZOE4OhECLCbsxekfaagCiWUzPxoqRRpLYT
onFOsI1Ei0fLDyU9vVmae+IRcLdfFDVmwoeDyObI3TNGpP6nJH+ymSb4z8G9Zu8g
KEtizsufiAiYEu5Qu5YyZLCYuxQvhjU6sl2Dw7nxm58I594SQpJhrLxCnTEakkyW
v9XVwgYRV2hB5Cmj5+tYEznSjHG2lM5cd78BSU9r1a8iE4/rVXVCuwQ+4hszNbJg
fiJw3CBv72dch/CYo0TmISs/WWfVwv4MagxNLHR7e/W9i4MmVptcZC6MH/edjb2l
WJ4LJrPaw3xlB5zS2Oo0ZHprVd5eEpd+gQ1nrXD+DCrh1IivwzdmJMFqMgZjYHgL
YvFYtPamE14BHTIomMBINCjs6Cl/qGtP2ediWgzxtCU5dJCa1P/hft1LTB5g9c2z
vn0iSKsuZLu6ct44gHYQzCC6mPcQ4KIZPLReb3EpGlWVcXb/Jxi7pkPNIKoR8rEt
dXm+Pi3suj2Ki8zgy927Tysx08O+xKtCM2nA22UXl0WjIOAmoGjTvfknMg76RF8Q
6m4eawG9wbs=
=k5pC
-----END PGP SIGNATURE-----

--==_Exmh_1610560944_6220P--
