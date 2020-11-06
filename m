Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324BA2A97CB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgKFOjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:39:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:37517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgKFOjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604673571;
        bh=pQ6GlMpp2ca1qPGVYYHvrDLq6g4ftXTtpbGI1lgXwZI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CwGbSGPyrCJzXSu1NnjickBNrlVOJ45zUCv9WEwkB7jnuqW1calWlp41iLkmvte3U
         ZK1lCG3kf/2gBpr9EudyTjtCeCsB9jq/mhgD8GaQjBAaqUir1s25jB9wb1bqnhwlEd
         Aa+ijBygkAvGfAjUGXaF7XvhUJym/nP/qyG3t3VQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNpH-1jtzVW2Dld-00lons; Fri, 06
 Nov 2020 15:39:31 +0100
Date:   Fri, 6 Nov 2020 15:39:26 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Directory category for accessory drivers
Message-ID: <20201106143926.GA446547@latitude>
References: <CAE1WUT4SD8gBCzf1tKK0acV4iXmVq4FF8Z6RNex65Ntxgzb0Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <CAE1WUT4SD8gBCzf1tKK0acV4iXmVq4FF8Z6RNex65Ntxgzb0Jw@mail.gmail.com>
X-Provags-ID: V03:K1:MvSaDfRoFhxKU6lSSLLZ5+xv3t1hX6BYExaz1XciTGOCMPmTssG
 d5lbe3t9WmKI0mHmkiCAhqJ17+vro4Px+jeNmNqJnCuiPnJTvVtdFEzQsFbZIuC9/1gG1EM
 5/sNOUSjOZmKN2j79HFQAA/+v+ZClco/GTBUyyoNjq8AtRGSbqnkpnAr+c9HiwVCUpS+YKz
 O+2gK0RXeF2W7EVLL3arQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L/rIqHQN9BY=:iz7vcbO26gGhp1/4RRYRn0
 zj/E9FtHOXsKIZgnr4lETb7bl/Xc7czBuZBZ6OMVFht+N7LsK98thDkiMPhU7y4kM1216Ih1M
 pYWhaPLzASlroZRPF4aaNvXzkK+RDNLiGlARi+ANFPHebPsvxO5lFFvAVWFCfqw5OffeiVnd7
 v8kt8ODubmVr82JB1mpy3w2aAFM83Dw9kECGIpPECl4o7t9qYAVJG1F7IruLn+Hkj2/fUm7In
 xNXyxTnvGA0eHzLbFkbQx5izbdFT/3jjwuxgSkxTsdulIsvSeha40s4S22j3U7XKB1UXc4Nzq
 dkZ3U9beTFkUXKbvSrHvMjIZlOSAbjlh1kYhfjMFswlxS3iMuquOU6/5+NpR27IO0GYBd78fH
 zU9jH/dkV0IPle2lRv9rtT55Hg5jZum4kgGk1WElwm4XPqYo/Fjbc3uRXzJcqRGOqqQ67YB/3
 RBJAaK/n7IP3fpmitBGAC+3+QXwWm+H6/UcU8DaD9GyhKIrGVEmFAklASNAFGlBJIoZWmshHV
 2mMvJF5CWOK9VY1R5dBKfodi9fDYtxqgWFb5Pvwf8hkmgyozWTYZXrLX5xUVEtaD2d3VQK7v1
 Ft6ql2c0hoINjQwjM9eejmuKJXGC9a8f01INyuRrlDPZndEBapACZiyN1h/rX6/zGHc343gtK
 RQgEkqRAomosykumsbiBrHRDXSqIx3YHj2/M3mYVJniqY7waufb4f65Z3D2XPyMLbrCIh1NSU
 cXgYxQhKyqudJYLNlYhugitUQhDve+BuFrJMsZxGqLKemSDWfF7mWqa2YTvbPx4h9ewDo5RSi
 VuBqheSItx9GDOtsjAlUMi/MPJqCPAyNQhYxzlmKwJoiWK4WsVmMjl+5a2aJyowEyRicz7tfR
 B/ylzJRdZr6Dm9Rqb3Piw06vRAQfIKeGPZail8zSs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 03, 2020 at 01:41:59PM -0800, Amy Parker wrote:
> I'm currently working on improving some accessory drivers to hopefully
> submit to a future kernel tree. The drivers are assorted for headphones,
> mice, keyboards, and other assorted accessories. Which driver category
> or folder would this fall under, or would they require their own new fold=
er
> on the drivers/ folder level? If such is the case, what should said folder
> be entitled?

Drivers are more or less organized by functionality. Keyboard and mouse
drivers are generally in drivers/input, but also in drivers/hid, if the
device follows the HID protocol. Headphone drivers - I'm not sure, it
depends on what kind of input and output the headphone does.

As far as I'm aware there's not really a subsystem or directory for all
accessories, because they can have vastly different functionality.


I hope this helps,
Jonathan Neusch=C3=A4fer

>=20
> Best regards,
> Amy Parker
> Please refer to me using singular they/them/theirs pronouns.

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl+lYBYACgkQCDBEmo7z
X9vAMQ/+M9tP05goUoN7YQNH91HXpmBUjv3EjVVd9zNzKvjj/6CnVnUYSk2B1Qow
M68zyq6IDEtDyPVFXrLazvoH6WE1GaarlHA+GMVbdKLrjJNhWyiyuKJRt9yPM0kT
E3gjkgRotSw2nB7Z57n96+oIIBMTbPltfzoFqZlZ9CS4vSUQ/npBAIFtwdcJWgum
6iXyEb+qzOsak9dxf5wawO3lQBzJG/wHV9IwaNfBPMvlhoRUslpwVDcYRcJX+pNP
Zu2qnH2mSzbuf1hvDZLXPyeFcn7zeY2h2kjPpDpmujBbWNI5YAoL0ztM34yLBmSW
+/nx3TEaQ/08phcB9S9MD2MuGulpaFXW9or4Uvzgae63QBm5n2hTaCiUKyClGxl5
GE0w3RvvQ9r8iJnNUh7MemGWkNh3eOMzpCA/gI2X8D878Aru7PaOVOMTw46z90Y0
dabyWNKcylL8NeWrhuXS+HgZex4Ik8z2FmuLksfRBlNH0XuiNU6qLocnt7QzAWUh
abD8X+nRZuubRcwTboH4htPbT2jcBu3gRuUngNCQqPe01CrWDvqUQmfCeaWVAuwo
ohJHAaegKCuB2KYPWk6tsWPT/yKwTFQq+TKBgzammUMXuaVTc8+HCNiaBbEmzpou
yeP4yHadqSdZmELSv0DH6advZzsjkBxzl4DdfFxjhzbAx4ZEmdI=
=ZgpK
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
