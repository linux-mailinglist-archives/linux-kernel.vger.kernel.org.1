Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A62D31C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgLHSK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:10:59 -0500
Received: from maynard.decadent.org.uk ([95.217.213.242]:46066 "EHLO
        maynard.decadent.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgLHSK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:10:59 -0500
Received: from [2a02:1811:d05:2600:ba82:33db:3e5e:d545] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1kmhRJ-0004ID-4G; Tue, 08 Dec 2020 19:10:17 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1kmhRH-000fd8-77; Tue, 08 Dec 2020 19:10:15 +0100
Message-ID: <4286b16c32116b6844eccacdd6a9ec567738f696.camel@decadent.org.uk>
Subject: Re: Pass modules to Linux kernel without initrd
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Tue, 08 Dec 2020 19:10:10 +0100
In-Reply-To: <6fbaf375-389d-6581-55a1-78bbe2852e2d@molgen.mpg.de>
References: <6fbaf375-389d-6581-55a1-78bbe2852e2d@molgen.mpg.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-PrJRV1+3dqjqHCVQ6LJf"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:1811:d05:2600:ba82:33db:3e5e:d545
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PrJRV1+3dqjqHCVQ6LJf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-12-08 at 10:24 +0100, Paul Menzel wrote:
Dear Linux folks,


Trying to reduce the boot time of standard distributions, I would like=20
to get rid of the initrd. The initrd is for mounting the root file=20
system and on most end user systems with standard distributions that=20
means loading the bus driver for the drive and the file system driver.
[...]

I would expect most end user systems to use at least one of LVM and
cryptsetup, which need user-space to configure them.

Debian has the "tiny-initramfs" package that covers the simple cases
you're targetting, and can be used instead of initramfs-tools or
dracut.  The upstream of that is:
<https://github.com/chris-se/tiny-initramfs/>.

But I don't anticipate that we would change the default initramfs
builder any time soon.

Ben.

--=20
Ben Hutchings
The world is coming to an end.	Please log off.

--=-PrJRV1+3dqjqHCVQ6LJf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl/PwYIACgkQ57/I7JWG
EQnZmxAAmDO/by7aheXTXo7TePm82TYaQMzeK2H4WbeiJsfGg6M2JRfzytgtav+S
DQvLn6qhlU+XSnkSNxER3EGCsDJenh0XTFtfmdUHKoYFFLBivhXApCbfPM+GCee1
bSodvJ+FKstnSapukK4mvzhEgGGXC2CI6DV3pZ96zzRHpZaq76QkBHfKmGvnlaKy
6ZsOhhl0EBDpuwIg68tPx2Fav4G2u+GnqIFMAz5+hYzfnNaL3SVqtWvhJ4ySI6cR
6cgvlfbCQs5B6T/xKv+seYhb/VITMt7lPS1urExn4ZP8PEwsn9IyExeZxOjwqYz3
rcXyKS4RyopVTMbbAxSu/N8ncokuQIdhZ5ZAFPr2CpfuCMKKu7c4K8ZKdc8bNKAN
C0GyY8bBsSBqm4t4FknmYwBRg7JUePN2XiFSjbY12faXYOXUK6fT9hYmQP2hh+TH
75EYf0YdPU0A9dmovq1q/A1ETbxsddXwkJeTv+0mXRf4NzXHcKOYxET283lCRCnz
+QLcOoaV4oj0uzSVvGSqql70MARs9cTmsJQbWkIRnBOVqd/IkAwKbrlaO6XhSYpP
OqjULpE7FG/D6/AtD/9SVQ1Ov/h9t3KAXkCMyRLzl5OGsG3nsayG1LzchWBpBsLc
DCbpcTSIqEgp8mqUvsrqWPBgmdl8yys5E7qocbweao/NIbE7OAQ=
=lbIp
-----END PGP SIGNATURE-----

--=-PrJRV1+3dqjqHCVQ6LJf--
