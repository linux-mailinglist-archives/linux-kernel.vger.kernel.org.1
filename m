Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FF62DEFCE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 14:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgLSNQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 08:16:27 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:49042 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgLSNQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 08:16:27 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D5FDA1C0BB7; Sat, 19 Dec 2020 14:15:28 +0100 (CET)
Date:   Sat, 19 Dec 2020 14:15:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [kbuild-all] Re: [linux-next:master 13538/13785]
 /tmp/metronomefb-846872.s:300: Error: unrecognized opcode `zext.b a2,a2'
Message-ID: <20201219131528.GA18240@duo.ucw.cz>
References: <202012191403.y8Aomjpm-lkp@intel.com>
 <20201219075606.GA20870@amd>
 <20201219102820.GA14085@intel.com>
 <20201219104006.GA14905@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20201219104006.GA14905@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Crazy robot, stop spamming. This report is obviously bogus, yet, you
> > > sent me 5 copies.
> > Thanks Pavel for input, sorry for the false positive. It tries to
> > bisect error like below (the new error), but it may be related to
> > assember support. We will adjust the system to not report this out
> > wrongly. Kindly allow some time for us to resolving this.
> >=20
> > > > >> /tmp/metronomefb-846872.s:300: Error: unrecognized opcode `zext.=
b a2,a2'
> >=20
> > Thanks
> >=20
> > >=20
> > > Whoever is responsible for this, please sign emails with your real
> > > name!
> This is Philip who maintains the 0-day ci, and lkp@intel.com is the
> mailing list for the team here to be contacted.

Yes, so... 0-day bot normally does a really good job (and thanks for
it).

But getting emails from robot is slightly annoying, and it would be
nice to include name of person who is primary responsible from the bot
somewhere.

If you are primary person responsible for the robot, your name should
be somewhere in the email. Or perhaps the link in the trailer should
lead to explanation somewhere.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX9388AAKCRAw5/Bqldv6
8iuUAKCwJvnZj9AKJe3lC0oq1dgqEjdquwCY4xqggoKVoSEcV8Pok0Z/qDfKoA==
=0AaT
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
