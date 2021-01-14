Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DD62F5CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbhANJDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:03:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbhANJDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:03:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6274E239FD;
        Thu, 14 Jan 2021 09:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610614960;
        bh=8JWXn+104e4wLc5ViuSDBdATigU1sEcjDJ8JlrJKYe8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iAitPuQQqgqwfyDZtSbr4D/J1AIGcDdAi7UbVCwk2UY4brMJJ2zLexPmjmIxXKxuy
         EmglCHi24dO7w0zkykqi3mVht4rlXvDdN5RXJaltZFowF2hB3lMwvuzS5EcF/Rn3YP
         LYU4gGdIylZrNfI6eFpCHO/5fAihKzmrwLm6ApaGrG2+URjoVT0f3hIkl195/8xapb
         Flm42PDpgUysXm7vbbB+g9gy3Mc5gQHzvHa/YmrySoQzQ9ze2l21ZqJWXg09GLHw1C
         /Ux3fjifzxaRSzR39i32hS0CKr5n6wKroVFpcfSoh8do7BtqMcbAmRdMzPycxyRfXr
         q/45k2eONUHZg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 07/10] dwc3: document gadget_max_speed
In-Reply-To: <e9332e31bec9bcead2c7ced2b25462120488ca85.1610610444.git.mchehab+huawei@kernel.org>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
 <e9332e31bec9bcead2c7ced2b25462120488ca85.1610610444.git.mchehab+huawei@kernel.org>
Date:   Thu, 14 Jan 2021 11:02:32 +0200
Message-ID: <87eein3n87.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This new field was added to struct dwc3_scratchpad_array, but
> a documentation for it was missed:
>
> 	../drivers/usb/dwc3/core.h:1259: warning: Function parameter or member '=
gadget_max_speed' not described in 'dwc3'
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks, Mauro.

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmAACKgRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQajqBAAz4FkCxgMTAPnDGtlKXlCbZ7+iPH+XpEv
j6JB7Ha+qZAmRLlDBeUIuB5bPJuohKRhNzgHSDFoDAup7PUKw3Bk/HYsNTGlJe3e
0ltSiy6TTQonz5TVPCQCSxJCHOEi2T2EPkBRfIEPwRti0ntG2VVAv2+pB4fWbNsE
d/Y5RI+YJueNyNp0VKyS2F9ex5T65Hc6HsUJWALHUMx5B1sRPNg1JfVtmb0d80Kv
CUYvYY2DB7agJZdmyggLqV3hPozjOd4wDcu2HqzrMp4dGsVB7ZTcw/4YBaUhHW93
FEoFxkfTpqeERduHIxvQaGWlQtlX7bB2h4POpE7GfwY1WtV+G8ud/Tngd8D6BM3g
ksQD7HrM9rmpKnTx2ch/oj4GnvIMCC7vB/p1H4eDlDYinmWqaDmbaKy6lUQspip8
QW8FyBvspLG+jOauNjg5GYUeJs9pimEUrO7HF6d/g15qf/vflzKwfWM0vVOkOhMM
ygdnO/idFkyEmwy0pXctg04L72Dfcw09oacNniapbXrq52zIH8Mhq3h+fj+nYy71
jztYiYn/dWWcQDl6l7iFyoFW+4Pg7O4m79dltOBERpHL++DrYeyDXIcyPUpFs1TE
QvSkUyeOfQNJcRS1zFRK+Rrn/tR31tLUSd63eLGNuCx7pHlgWiPwlxnjG4BdIMuM
AQj/+pdztls=
=b1ns
-----END PGP SIGNATURE-----
--=-=-=--
