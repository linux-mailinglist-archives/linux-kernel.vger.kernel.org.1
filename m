Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D72FB34B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbhASHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730726AbhASHU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:20:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52C2E23132;
        Tue, 19 Jan 2021 07:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611040817;
        bh=vWlNWoexDWnARx1InVT9kBcUWp8ol7xoVdoAXYJZ4ZQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=L1UAhVGuIcr5OltWL0RV/BiL1VD8I4nSTEz8gOrgbuft8kKN0yM2Ahyu5Ta6IlSMD
         NP2QwxG6EglPoHmt+fVBoDE2FwhaTZwui1CV87kk4fZ28ewYYxOlftW6gnUwdaaUVp
         W6/ecSFRSQVM9lgYMTd8ktPEs2rUYrDNsEQnUnOKxuOOjqHRE6JoOxxhtQqL9/FC+w
         W0bJZdlmkfeFUCLg4YvyzIV+TA2OZcerr0QoFYYjbPuGyQdwKw84w8y2J+eIEkt8ke
         U2BxfGaP0LUTnZ1GEczHRbrUSXrAo61TnYBBeQkThAOytZZR/5kLJ3GjuyO9NSkoGV
         pNY3YSVd5VhnQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] usb: gadget: u_serial: Remove old tasklet comments
In-Reply-To: <20210119001321.127750-1-dave@stgolabs.net>
References: <20210119001321.127750-1-dave@stgolabs.net>
Date:   Tue, 19 Jan 2021 09:20:10 +0200
Message-ID: <87h7ndv1ed.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Davidlohr Bueso <dave@stgolabs.net> writes:

> Update old comments as of 8b4c62aef6f (usb: gadget: u_serial: process RX
> in workqueue instead of tasklet).
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmAGiCoRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQb/3hAAya2vhv/vFDAHC/DuZE9M4GrBtwav2kif
UscVHLMFMtu78a/mFTbqVB9sJfaHG/8PMblBJqHfUDzP9qIsSCVyv3+AB6y9dDpa
cAhXV+N2HIeOGuLolhOSqmFierJZv2p3Qyu9EETZOybvVlEqklLQDLXgvYigBC1J
yRF375U/pk4mQwIBJcrt5MrcqcuG48CYnSlPVY1hRxeWYhcK6+nAvsksLRXGd5tv
J/kgSmXvSoeJiBVR/oAppmwBK+WgtoxjPMPTINSiYg96SeflHV/UXUWV4V2B0k5G
RrV36bRbikrmTW3T1XZZmKGVWwfXGZUEpleTjvCZLgvPhLVlRKrmXwBjLWUs/HBK
ge4E82cEEXaDA2tPkvjrUnuHTH89JChsVtZ6zKzjZjQiXcEfXHsWTY5uTaAKSa3X
TI5BTZQLkVZAenCeQFXLnYiIKwqKNdWdQbokTACbfs7ztNnisaGEeQheEygkCH+z
ZOXftV28NMBY3zXp7SfCqAlHJnU2wduTbvftTUKdLo/TzGO1S0tkmiPGZ4Ceyc+O
32XbnLZqnnGa2Fzhg2SD3GjHw8QdWtySjc7/07qc5tHHlpFn/ET+coUVcXA9pNOI
DXuGDXvk6bgPS7ob1bFu26D0bQQzvW71yYHdz7IZQ06LBgAP0yNopBLzrUMh95BX
7cjCNoDpnqE=
=a+0J
-----END PGP SIGNATURE-----
--=-=-=--
