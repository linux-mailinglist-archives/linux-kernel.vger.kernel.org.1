Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A842EA17F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbhAEAfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:35:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37118 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhAEAfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:35:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id A4C361F450BC
Date:   Mon, 4 Jan 2021 19:34:30 -0500
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        hsinyi@chromium.org, hoegsberg@chromium.org, fshao@chromium.org,
        boris.brezillon@collabora.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] drm/panfrost: devfreq: Disable devfreq when
 num_supplies > 1
Message-ID: <20210105003430.GA5061@kevin>
References: <20210105001119.2129559-1-drinkcat@chromium.org>
 <20210105081111.v6.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20210105081111.v6.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> GPUs with more than a single regulator (e.g. G-57 on MT8183) will

G72

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl/ztBAACgkQ/v5QWgr1
WA1dGw//bJtIv+4vzSRzSNAQitDrJAY7AdKGkgonfTYEme9fQbjUKIsPa/m2q5/2
tJZ1fFLF5gL7wgPV6fD4PtxyDUaZncaFUwIr6LDvCSu7a0AhoVk2OcO94Dr8IENo
T9TtuWNEerkypeQ/XZ1VilsNawl/CqeDpje5g7lOncXTPpZ9/emeBhj4VyFrWmZn
2X7J9FOOqUAZpKZbs4MvkEf2Vubxcme6fY3w6KTaaqNG8gHm3wdoHK0ZuowB1NXr
X1LvSeXgUvah7LZN+RWh0fhZKXjP5LkuJGAYDFRRpYO25+SJ6km67fD91zQVfVGj
WXYJyyLk+8u9ZiFvfY6dUFlKSbG3Srn4mk98lSyxkttaxv91Nom0V0ZSFeQe7tSC
xZusXiy4Djj2Oe1LYadi+ujkBY+aRtb/ysafhIp5ahc+2L+BNImDiChOqQ3RJe8+
t0iX92KnG8Pzmj/fZGQmCrgHMfRbl+soLYZqlbQ3rAri1RY0SihI0zm0M+UbFkTC
ijcEMTeF6Lcvc9CDD2o4uB+G7VZpoozTBN9BJQAep28wcsCRD9hhMo7t56ZZNDFr
6hpbEVrSjY9NCSno/DpcBSkyEdOFQZTIUr6lcSz3AbI810FbEsqqsTcHYYyzfJnQ
pIivSpzS712jcaYu62/odpsDmfciHNF1o/K7n2UXIPzGQFAXvxw=
=fUi4
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
