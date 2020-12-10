Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF392D699F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404803AbgLJVU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393973AbgLJVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:20:17 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4447C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:19:30 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so3444040plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=veP7V/HQ/WMNQlyfeoVtrVGMlMOws8qy4woYupL/Nmw=;
        b=MrpOYYK/7ABE0JFRS7dcSryaUhC0xeP4ZeAM0sES7SGC0D1PRgNaOyBZ3ObHUC4gwp
         oP5bWGYOQ0JKGBzkdYVBdHL2jHLkuEeLahyjG+T42LGZZL/zYdy8p4ymwEz/8ndmMYgT
         0Z1IVxUjsykmnHMfpF2D3iIrhpvQ4RvPm7LxXAjHXXoublduHXwqaDqMc+Mbce+y/kQ3
         1Ia/PuyeUBZuKUsSKy4IgQUGOq5C+30HRGOAW77hQTZLgjSmhAK+BofG3CWSI2yLf6KX
         oIPbg8FgBBc63c6gMoxdNFgyL2fKF2sqBGHL4tcYYUw8Umoke/AGO2+kQsgQCDbqbDct
         CTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:in-reply-to;
        bh=veP7V/HQ/WMNQlyfeoVtrVGMlMOws8qy4woYupL/Nmw=;
        b=ReAcMnc/74YmXZfi7xNbaSCNAOvDezn2qOiDkjQlFPTGfJ6sxZRkx6BedyiWlyNOMd
         VX06XmB8w7O+SJx7X8YP1n+wIgzJ0yYT8MwscxgvZef5odT1qtPnimXA1vbEeoC4mkCw
         Tur8DrotxglqPEjgtINALeh4bRLHQ6RqOS/BUbEHqk+7fkBjsuvw5HBHz/isZCYpfell
         VPZPu2fFRGGjYDWumhH+GlBc1lxTe76SwWD2vMsWxHXTkKLHYl4MMMe4/NWxl6/pBX5L
         kAxaN1hmeqaIh1vMvR6DRdlzfeAzgSS4g1/xXFnDB8Et/T+mdeRVWqmzA+LjrWxOFQH+
         Y9mA==
X-Gm-Message-State: AOAM531GXocOD5kHPAgd4A5PW6GSs3pXy63OORNKqfcdzNo+F7/wvP29
        lylUWr6EC6Xc2JZaC4EmnkEHmG5fKuLqfw==
X-Google-Smtp-Source: ABdhPJxtmgyNrWXwAVwrSUkmxeLg/43cVs78Kt2Ky2uOe8hMRNQjHfC39WvPT2/b/we6ZPOrfCGWfA==
X-Received: by 2002:a17:902:22e:b029:d9:e591:7bd1 with SMTP id 43-20020a170902022eb02900d9e5917bd1mr8207935plc.50.1607635169808;
        Thu, 10 Dec 2020 13:19:29 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id d6sm7529353pfd.69.2020.12.10.13.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:19:28 -0800 (PST)
Sender: Benson Leung <bleung@google.com>
Date:   Thu, 10 Dec 2020 13:19:23 -0800
From:   Benson Leung <bleung@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Keith Short <keithshort@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Tolerate unrecognized
 mux flags
Message-ID: <160763499543.2901204.7100892625900686343.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yVrKpOyAZl/IFjqI"
Content-Disposition: inline
In-Reply-To: <20201106020305.767202-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yVrKpOyAZl/IFjqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2020 18:03:05 -0800, Prashant Malani wrote:
> On occasion, the Chrome Embedded Controller (EC) can send a mux
> configuration which doesn't map to a particular data mode. For instance,
> dedicated Type C chargers, when connected, may cause only
> USB_PD_MUX_POLARITY_INVERTED to be set. This is a valid flag combination
> and should not lead to a driver abort.
>=20
> Modify the mux configuration handling to not return an error when an
> unrecognized mux flag combination is encountered. Concordantly, make the
> ensuing print a debug level print so as to not pollute the kernel logs.

Applied, thanks!

[1/1] platform/chrome: cros_ec_typec: Tolerate unrecognized mux flags
      commit: 6ae9b5ffcaeba64c290dfb8bd7b0194b1fdf0c92

Best regards,

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--yVrKpOyAZl/IFjqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCX9KQ2wAKCRBzbaomhzOw
wl+9AQDtNgbLb6KigLYvd9ZXuEika2vo5LaSBM+GhRd9QfppaAD/VK4Wm6MRllrI
IAsoZyE61V82JOs6beS+ybDWODYMvAc=
=tfHu
-----END PGP SIGNATURE-----

--yVrKpOyAZl/IFjqI--
