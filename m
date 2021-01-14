Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB90B2F5D35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbhANJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbhANJXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:23:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EDE723A05;
        Thu, 14 Jan 2021 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610616153;
        bh=rl/OZbF6JUQS9sIGmcSDh6QItwMe/RtTMl+EH3aVz6M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MZ3JFxZdid5QjCO73uxBdmV0E3WZ9pomx5Xd3Fop7TGiuyNvNi7y4ppH0EKygAy/n
         VkoHP9SWwF2DVnR3vTB0h9ouVbYPpFUHkE5umMcPk9PEKG3zHFoQPP06uAMhI6xCR9
         Jn5x9kLJiI/Tnx5cETNHjLIKk/nl6ESfb/8L2V0Mm7fVbCoZxzMmrcVTgujZ+nrg4A
         8VnAZS72WR1FsllNHR/uTJDFMu0kmCKsdAcdL0DXIJTM/Yo5eIX4c6ackED8O1kM8L
         Fwi65Nq1c4m7YHDuh4UACHrf6hJcUaXCI3HU3yaSuhPKXgaE+sTPuQsLXQVPGu7erE
         E9Hqt9wXzNjQQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com, b-liu@ti.com,
        hminas@synopsys.com, jbi.octave@gmail.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: Re: [PATCH] drivers/usb/gadget/udc: Assign boolean values to a bool
 variable
In-Reply-To: <1610615002-66235-1-git-send-email-abaci-bugfix@linux.alibaba.com>
References: <1610615002-66235-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Date:   Thu, 14 Jan 2021 11:22:25 +0200
Message-ID: <878s8v3mb2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Jiapeng Zhong <abaci-bugfix@linux.alibaba.com> writes:

> Fix the following coccicheck warnings:
>
> ./drivers/usb/gadget/udc/udc-xilinx.c:1957:2-18: WARNING:
> Assignment of 0/1 to bool variable.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmAADVERHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQazOw/+KYL6BI1GvbgwRPbFX2l90ThFvh1AGucw
TKbWohDlwgO5GnxjJU7ztN4VU4DlG29MpAkEBehredbmg6nfnCTcsSNG4rT1aQ9S
rAL2BXirGjDzVvd75kDVd614pLYm84V2Xqt4Q/SgMfKMGVz+b5XYmkCjoro7toDe
RGESq8JlHlAHXPC963vmd7YIpuvHf+K6CVweqPv8xm25C/iCTgE8wb0opTKc6/6W
ko1Lu6ghooCXTIs6HFsdoCg785IRF39noYlx+CS/C4BDvseZvinJMcSTkuzctNTC
SOZo9rOBDvcMvVJ3qQbu1t8mlzwFvfmog0D6BuQunEWJ2AYiic9sv/KwTbVmmuRJ
d2wLSXVQPclkmYh3ZCrsZxdZesNUS4LnOhwnr5llqUkERhe33YRRkbVMOQywzJ6+
DQP7R9tczw2TG++05Q9oYBVStI2rY3IjpElVM5AdIpfSQaxhLvl7N2xGT9tAfKGG
lqj1vrZvXdnfV16ChJ6s4ThkNt1cxqFXEcK4Hm5cbwcKq/EEiRHdkN9FEL7Ls0Jo
7tO3RFeBS/gYOiDZqtJ32KPn9EMrsOlLWe4gh/LKWb303iMPGt3q8cNUfnIRUJcC
wRcJ87ufSyEk9QuVoGKbO/nMwKgk04+utlOueG/5lv50gtMltScLKo9tTQFjt6QP
3pgCqJ0oV/Q=
=seLA
-----END PGP SIGNATURE-----
--=-=-=--
