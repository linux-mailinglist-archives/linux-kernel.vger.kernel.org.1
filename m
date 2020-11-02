Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9792A35BC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 22:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgKBVBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 16:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgKBVBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:01:43 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FD6C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 13:01:43 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id q1so4687109qvn.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 13:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=sfssJoSVarUrVMLVURV+BvhAdC7/uwArT8ZmhaNO1+Y=;
        b=Zj0XH4GpUc6+gpMRh2RhlFy5ROiQJ/QdeeWeLLNEhIH/tedSB7zeX1UfCOgmwMQJ2b
         J8JrNgPJiXdnGVTB+1pyA5lOUruh706QskZmam4gGhKW+odm+4SC3AD67PNqO1QvNkMW
         VHxflaF8RUMBRUbTdfvrsPS6cBRMxscKQ+co/+7DDODfrBtf7A9+1Y+OTl04xARGGv/B
         MM8bccZPgF71lc7IeQbdKqo3CUMRNloPObxAnpQGohyRKjVP8Uwyh3QevOqv/gRgVBl8
         Es+nm53gtl+jRCr9So8QaCgUrUGUq/MqaVu3sW+uCS2HIwO5hkeZVRra+uLeNRdIbdoF
         zBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=sfssJoSVarUrVMLVURV+BvhAdC7/uwArT8ZmhaNO1+Y=;
        b=I+2Yox+J4j34krB6xWgVY1+F6jQJbyjqSM+ppu9T9o/keJYF8+gc25+QIKsQU3LHq4
         zPoVdBKmIpy2hC4YN06Tcc4tE25amme4lu3yedAqx7zBBb3pFsaJJmFGu9auDXt/4QBT
         4U9znOa0lLQAo48w/whkUlpwP8xoFFEQYwU57uKkg812Nfa6rVX4NpAVSJ7rCHTBzjgp
         s2hWtwM8KbRZOX73NT3OYX2JjEtgLKxmzasF4mDPoNAxp8fYjzFE4ZcyoeyG3ugGa6Ff
         /jyS0x6QWJ+3+XCNrNeF3h3wTf++BFMEgIXphTHmfOUv1wqGpM05WzK2LyDtDom7/0qM
         Acaw==
X-Gm-Message-State: AOAM530e4VHYt1Q08WQyT9HBI2aGEpYNwtZjqsB9jJyIjV/dzFC7RL6L
        0xT/T3Pv4b6yyztqWd33tANT4A==
X-Google-Smtp-Source: ABdhPJxjFuxtaEy0PCizL0CmEhKqRKfoe98V4mJlXUms3rhVSIcHT8UkAbapQUXa2aa8X7flf2Dn+g==
X-Received: by 2002:a0c:f3d0:: with SMTP id f16mr15065713qvm.42.1604350902180;
        Mon, 02 Nov 2020 13:01:42 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id y3sm8751323qto.2.2020.11.02.13.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 13:01:40 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] clk: imx: scu: Fix compile error with module build of clk-scu.o
In-Reply-To: <6e5a8fdb-0a02-5eae-ca1f-37df8a454e34@infradead.org>
References: <208469.1604318525@turing-police>
 <6e5a8fdb-0a02-5eae-ca1f-37df8a454e34@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1604350899_216810P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Nov 2020 16:01:39 -0500
Message-ID: <238534.1604350899@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1604350899_216810P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Nov 2020 09:15:20 -0800, Randy Dunlap said:

> also
> Reported-by: kernel test robot <lkp@intel.com>
>
> However, this driver does not directly use <linux/module.h>.

Just my luck - I looked at 3 or 4 other things that include of_platform.h
and they all *did* include module.h.

> platform_device.h #includes <linux/device.h>, which is where the
> problem lies:
>
> <linux/device.h> uses macros that are provided by <linux/module.h>
> so <linux/device.h> should #include <linux/module.h>.
>
> and that fixes this commit:
>
> commit 4c002c978b7f2f2306d53de051c054504af920a9
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Mon Dec 9 20:33:03 2019 +0100
>
>     device.h: move 'struct driver' stuff out to device/driver.h

OK.. who's going to do that? Me, or Randy, or Greg?


--==_Exmh_1604350899_216810P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX6BzsgdmEQWDXROgAQKfjg//RIaEOb6EyTQqKOPfGtJ4KcMOdHgJwcC/
tYMiOn2Em2wycFf71WP/tBsIDqUXcPVUDfU5zyQPYPKjbRJjMUe1PraO3qrSlhke
N6XwkcCo4V16PVFJFpcdVJfxo6nPxlIZ9lq3Hd4T26gnUPfS9p5rPHtGNYDAKyD8
c3mlwDN3inQnuBuON73p7pS+OopVJHjmU6zvvEgbsiJcUpoJk+13uKvTG4RbWmNz
i1PKb1+dk4uEETAZCMftFqfji80ugWUuMXKRCapS12nqBOkLgxUmWED5XZJC4H5X
pogktUAGKxTivLqhVTz/JWvrAnACKiM1OUfRCNcJh40hgt3wGvuUxLpALT2Rfiqp
ANRl4q2UzivUIhbee+V9h4m+ZthBkOmHU7nfDQDeZYzKHAGthUfKGdmTXEG2dAmH
R5p7E/k4GfKvBdGYp86LL/s+wlARvqbfg/R0fTIlsTgfPsnOkigP41s5w0Ccm656
7YIXHJomsOL8cjWyvLI/FpbhFs92c11Pt8nlKj2PEl+M9GjoL7gp7NSSJM7DaEri
UrEcmlaNN12hu5giSsJ7N1olVqkgMqylM0JptP33eObCC5uHx+Tz/sOWpFrKCuBi
kZVXKKFL6QOe/fAVvYPfcP1ThTbRv5Giv4iDLVB6AXxre74nb7QbUYPDeu18DIMv
bcY4c26AjmI=
=PXZH
-----END PGP SIGNATURE-----

--==_Exmh_1604350899_216810P--
