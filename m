Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C15260A9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgIHGLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 02:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbgIHGLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:11:22 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 884342166E;
        Tue,  8 Sep 2020 06:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599545481;
        bh=NGnTRbMnwMKN2xt6hmTyWPxnCTo3R/+8tWl4r6eWj8k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=vG5uwtBXYMzyrxnayYHInbAuHP/Txyp3ATmi4IjBEAkEaW+lQovUkiguvSSS50Cbj
         N/RauU71sQ0tGZYaVhuPZYkjLweTTiYuBxMfMXsEKNm+lEcuK2wc8zqiUrLJIuJ75i
         pqe7nYQFwD4QD6sVFuca4dY5f+1OlB5kK/EQ/b5w=
From:   Felipe Balbi <balbi@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     pawell@cadence.com, kurahul@cadence.com, nsekhar@ti.com,
        vigneshr@ti.com, robh+dt@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: Convert cdns-usb3.txt to YAML
 schema
In-Reply-To: <20200902133543.17222-2-rogerq@ti.com>
References: <20200902133543.17222-1-rogerq@ti.com>
 <20200902133543.17222-2-rogerq@ti.com>
Date:   Tue, 08 Sep 2020 09:11:14 +0300
Message-ID: <87o8mgn6gt.fsf@kernel.org>
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


Roger Quadros <rogerq@ti.com> writes:
> Converts cdns-usb3.txt to YAML schema cdns,usb3.yaml
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/usb/cdns,usb3.yaml    | 89 +++++++++++++++++++
>  .../devicetree/bindings/usb/cdns-usb3.txt     | 45 ----------

Rob, should I wait for your Ack on yaml conversions?
=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9XIIIRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYKiRAAicIudE5HGASs4Yp4QH0UF4VvVIE+3F3l
UuKJANBsRK56cEmdkuJ5j9UKU3L0M2lU1BozvaVrJqGvw9Yn2AfjL9CMFjrL9n7B
xpmeII5a4voUIWXZDrVx0kwAIjA7zG89pjcovaGzMXvCl8Jfb6ckR6QcNXwTbwc4
VrpmEKr4nmrC03XKFbxkBLlMMyqg9E4nUSiLWrRbiG9SjlZIPPajHSRcn9NA3uqi
0ivXaLSJynfjjudx6K2s1zC3TWgytW8uRjSiZpWZja6ewGk1nDHjFWAwEjGO7kC2
w+zo7moXousOwjSgytGqoQcpUkQLaaJa5ZAT1KN3SH1aDuVK23lN9G+v5Q3TE9RG
aYWySxBkAItgrY5OaDOmsPfyKSbqcfgVuIvJZW0H+E1RnlB+OUI4C38vVfyt++4K
HEd3OGjG/rJtBsCNLb3aRMpHqhpFbMyF/XELcTFFzctaJgvVnQSwLn4q0kbpZFGP
b0aLUD/pFIUnHYuL+cU8HClzsQIwoHIyRtmAkMT02awW62vLcdg5oa7x2fzNucf6
s+exKaZZSgsYaeqk+KuoGxSOrEgIxa1w6XSRqmHDS54e6bMyLWTPtS+IanmzURmA
ydugTajDnSD9Tiw05z9nMCFdKYVTecXas4BqgIfZK2yRBACJXsco+86uT5Fo20od
+NuhWc7AIX8=
=NHm0
-----END PGP SIGNATURE-----
--=-=-=--
