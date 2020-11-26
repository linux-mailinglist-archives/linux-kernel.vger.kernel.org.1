Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8694D2C5705
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391079AbgKZOW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391063AbgKZOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:22:57 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E759DC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:22:56 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id x25so1665820qkj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=m89IS3+NJnDZHLlfyB8HbE86AZvHXf8J1YjiWjq9clo=;
        b=E3fZ/jdU9968O0s2ILjpyJ51lX9DOxSdtXs8xFOWOIoajHhN/q7/hiI7aiPSDYtIBZ
         Gti2Ekbzvz7p2ys15jaTQOCzSnT6aNmHfLA+z2TA1ws0dGbvicPvgrVJ5a1ONvT+Vqo2
         MFi3nsnjjyLSaJH14RGpd2dSrxWNX+C0Z4MRvfVrV8sysgmKHpXVGv3t3lu7O5uR5hep
         9MaILucx82uu8elQ4HKL6ZNbKuZ/kBLaTeCYGe5uet7wexVZxAjARR/jEVh9Goi8XCdk
         VadA8fG2QLZz+70vw2tPGstmK1OGy8wzo55DWjqGRPdTvgPUnjKlIgJpnNctZPfeAJZA
         W72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=m89IS3+NJnDZHLlfyB8HbE86AZvHXf8J1YjiWjq9clo=;
        b=V9HqV6s2XyKMqbOCdyZQaGZlzngrUqv8Tj2ofY/FqRRkhE2/1KdOvRzkYmA/QHGCmz
         dOdgCVmPbKapC3wcDL5MlJ2lY+Axxe/aUkzBlVpOwi84ruQB+4SH6o0LO87th292cTyn
         8nmzE65JVqyKEdQ2t/cZeg8Zif7+3A98sA76Dt4D6fuThJoyISZTzKL8iREXKDaLjByE
         9hJpTqeuvmR0a/ENuuhW48oHcUcTCgr7Xi6gDDG62Nh95yo5abB+qBIuQJZ3aENMWzkq
         XQ8AjRhgE3c5+zGPhdJ22UyvgKg1T8U/4/N1B9jfi10TZrzTt3q5awn4wikXhunrdDRU
         N3rg==
X-Gm-Message-State: AOAM531MYAflaHhy7+Po1qc4duTDEzto9jdKhaH8lKapmpDuXJUhwP4N
        Dbh3UeSjeQLQQv9foXmKWt6HWg==
X-Google-Smtp-Source: ABdhPJxI8vrVYjQ/pMpURrbO0oQ6+YAXh9fxqMy+8Teb+FQeWfhQQZ6IGK9b0lHDHVVhAzyFNHjR5A==
X-Received: by 2002:a37:8681:: with SMTP id i123mr3346233qkd.54.1606400576123;
        Thu, 26 Nov 2020 06:22:56 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id 68sm2726148qkf.97.2020.11.26.06.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 06:22:54 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next 20201126 - build error on arm allmodconfig
In-Reply-To: <20201126141429.GL1551@shell.armlinux.org.uk>
References: <24105.1606397102@turing-police>
 <20201126141429.GL1551@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1606400573_2385P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Nov 2020 09:22:53 -0500
Message-ID: <28070.1606400573@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1606400573_2385P
Content-Type: text/plain; charset=us-ascii

On Thu, 26 Nov 2020 14:14:29 +0000, Russell King - ARM Linux admin said:

> The real answer is for asm/kasan.h to include linux/linkage.h

Looking deeper, there's  7 different arch/../asm/kasan.h - are we better off
patching all 7, or having include/linux/kasan.h include it just before
the include of asm/kasan.h?


--==_Exmh_1606400573_2385P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX7+6PQdmEQWDXROgAQJNBg//fVo82C2jT44d3GrdMgaG7Zjcuk1EqjfD
Qetxzjrku4UIYGH5r/eWkzI05j+qf3hPy0zabd+LMwDmg2J67RaLHq28GD0z+s5J
fjqRLSwwTtaHySdSXyQjoX0MH8dWHzaaVRLvUXYwzgv6Ku7M9C9KN1tJAWJAVkxX
HsweS+i2lPhS6TueQBpayhxLCBB5fe9V6jagshYzxX11ZhctCXpz6sAjgeYDZS/X
hAf0JvUe5f4Vy4l4AY8RJQ/tn3EagVZE3O02IY0zCTHo3/vEqXcUerT1ZslqeRMP
Gbutin5Ftl2BHSWRIrVhHTUKVR2DvvyRmq3bRSg82/Gn4E4AdDyqcxsOsMO1zaiD
8hmEt/oIveEtaKK4a2BxSZkOlcScehS7yBsO1RkaUKaoKozPOy3N85Wm6v4TdEoj
i/0J7kX3RJNvE6kpndsBZYxeb48drtc1V+JGlrpv4wARwqyzLxAhPtVN1EaRbutb
tALyIGGGti+UYxo4IKO9t3bhQptd8hWT/YxCH1tqqFnLeiTlddNFedlCiNOKWh2G
eX4TlttqeaJz7Oekuu/86ZXX3A2vBT9wA0+499uRDytggddtz6JG59r8Nte5vf3/
oiWnO9HDGmkLKbAF3GhIXwFoZRbuV7krit0JpNZ05HzxwGvWdoCvnsebFSEyZc9N
ClOec9Hx8Ik=
=ameD
-----END PGP SIGNATURE-----

--==_Exmh_1606400573_2385P--
