Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72262DAC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgLOLi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgLOLil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:38:41 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F0FC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 03:38:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CwGTZ34Hwz9sTX;
        Tue, 15 Dec 2020 22:37:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1608032275;
        bh=d9ZH0gSQ35C9d62QQnvUVBuHezmU6eE8PdFglz1NfxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qb/c/iPia3E0SyI1jdjpZXxuK+oKSh2dKwyOk/Vk74ZIuSV4tle4Qm2i0/d2MZMX/
         msb+b2mwlSqarI7l9ypkU2p5rUJfNAP+jzrolR4T2DvfzWGKz+5Cwhehbn7R2MDi6y
         97Pd207ERL9wXdWYAO74YwaFPM3ppau0RL3el+bAISmR0OJ4i2meslc0qooFuz3vLA
         Dx3H+GbFIn+vG5GXaCL0hAll69FBM9fPDLmbaSBsUCEFzSFAMjLrlldcL1nsfDHTV+
         d5systmDxZb8p33p/QscED2RUoj6p/RKB7lavXLMK4HByHMOU/jEDuzkFNYxk9thDZ
         OR+Dhnk7gg1pA==
Date:   Tue, 15 Dec 2020 22:37:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Staging/IIO driver changes for 5.11-rc1
Message-ID: <20201215223752.42c377d7@canb.auug.org.au>
In-Reply-To: <X9iNTajXvwiLa1bV@kroah.com>
References: <X9iNTajXvwiLa1bV@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LQU1/MB8tSV+lD=OJGR5_rL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LQU1/MB8tSV+lD=OJGR5_rL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, 15 Dec 2020 11:17:49 +0100 Greg KH <gregkh@linuxfoundation.org> wro=
te:
>
> All have been in linux-next for a while with no reported issues.

There is, however, a semantic conflict with a commit that is now in
Linus' tree:

https://lore.kernel.org/lkml/20201207164601.2b9cefc8@canb.auug.org.au/

--=20
Cheers,
Stephen Rothwell

--Sig_/LQU1/MB8tSV+lD=OJGR5_rL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/YoBAACgkQAVBC80lX
0Gw0Mgf/Q6o96pqFTmXYchSeu6vGPpgA5HWT4gO1fwvwgp0gais28XXU/zXTET6x
EZLfuVBIkcm8JgDkY3rfFYQ86PzD+bkugvwdqi9HxkFXOctM21K+AsWATBPz2Whw
i5hgN1WvFgdAtfRlXLLa1pZeHEklNZPQMeQbUBA7xHtEXXLqRFOhOrMgbax/feJJ
iDfjnY+PHbXcg8IK8b0A2+C1x6TRCE4quNzEBl2Y18ZEcchEtpLFAKPwhS416AV6
5ahapng41mTpUiIK6poq6Fc6CULs0UpyVXnw4QFS0hUv0xSPeoNDVzRMCB6H206p
67Y7jeDbItfei/ZOzjvzh+/mo0HYrA==
=cKEQ
-----END PGP SIGNATURE-----

--Sig_/LQU1/MB8tSV+lD=OJGR5_rL--
