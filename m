Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD29E2C8C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbgK3SSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:18:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbgK3SSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:18:17 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ACE320705;
        Mon, 30 Nov 2020 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606760256;
        bh=tN5fsrJ08eQUu84BANI51m0Lex4+/PW8hjq6/8XCCgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6oD9FLj1GG2rZL9EFmQj70L653085AubiqJlmK0SQklrvj7X19HhTEjAT5JJT6sw
         emRyogggM99WpxHItY9nBVBfC0XkjPkXAzWfZ9YQTgRSrpuDAxR7alr0+PWdHL3Hu3
         /XH8f7IaFHeHPrCgvpZosGB8T8zmwHjx91hOK6HA=
Date:   Mon, 30 Nov 2020 18:17:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 5/5] ASoC/SoundWire: rt711-sdca: Add RT711 SDCA
 vendor-specific driver
Message-ID: <20201130181708.GF4756@sirena.org.uk>
References: <20201103172226.4278-1-yung-chuan.liao@linux.intel.com>
 <20201103172226.4278-6-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline
In-Reply-To: <20201103172226.4278-6-yung-chuan.liao@linux.intel.com>
X-Cookie: Space is limited.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2020 at 01:22:26AM +0800, Bard Liao wrote:
> From: Shuming Fan <shumingf@realtek.com>
>=20
> This is the initial codec driver for rt711 SDCA version.

This and the rt1316 change are failing to build for me on both the
regmap tree and a merge of this branch into the ASoC tree in an x86
allmodconfig with the errors below, I assume this is a dependency on the
SoundWire tree which I guess I need a pull request for?

/mnt/kernel/sound/soc/codecs/rt1316-sdw.c: In function 'rt1316_read_prop':
/mnt/kernel/sound/soc/codecs/rt1316-sdw.c:83:6: error: 'struct sdw_slave_pr=
op' has no member named 'is_sdca'
  prop->is_sdca =3D true;
      ^~
/mnt/kernel/sound/soc/codecs/rt711-sdca-sdw.c: In function 'rt711_sdca_read=
_prop':
/mnt/kernel/sound/soc/codecs/rt711-sdca-sdw.c:182:6: error: 'struct sdw_sla=
ve_prop' has no member named 'is_sdca'
  prop->is_sdca =3D true;
      ^~
In file included from /mnt/kernel/include/linux/printk.h:409,
                 from /mnt/kernel/include/linux/kernel.h:16,
                 from /mnt/kernel/include/linux/delay.h:22,
                 from /mnt/kernel/sound/soc/codecs/rt711-sdca-sdw.c:9:
/mnt/kernel/sound/soc/codecs/rt711-sdca-sdw.c: In function 'rt711_sdca_inte=
rrupt_callback':
/mnt/kernel/sound/soc/codecs/rt711-sdca-sdw.c:245:31: error: 'struct sdw_sl=
ave_intr_status' has no member named 'sdca_cascade'
   status->control_port, status->sdca_cascade);
                               ^~
/mnt/kernel/include/linux/dynamic_debug.h:129:15: note: in definition of ma=
cro '__dynamic_func_call'
   func(&id, ##__VA_ARGS__);  \
               ^~~~~~~~~~~
/mnt/kernel/include/linux/dynamic_debug.h:161:2: note: in expansion of macr=
o '_dynamic_func_call'
  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
  ^~~~~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dev_printk.h:123:2: note: in expansion of macro '=
dynamic_dev_dbg'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~
/mnt/kernel/sound/soc/codecs/rt711-sdca-sdw.c:243:2: note: in expansion of =
macro 'dev_dbg'
  dev_dbg(&slave->dev,
  ^~~~~~~
/mnt/kernel/sound/soc/codecs/rt711-sdca-sdw.c:308:12: error: 'struct sdw_sl=
ave_intr_status' has no member named 'sdca_cascade'
  if (status->sdca_cascade)
            ^~
make[4]: *** [/mnt/kernel/scripts/Makefile.build:283: sound/soc/codecs/rt13=
16-sdw.o] Error 1

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/FNyMACgkQJNaLcl1U
h9CurQf/dC37HxzASt7AqvuCkJ5753Qh0YsZluT4wI82h2wobMpmWzhQ9IszSaGr
cXQOcGZgisQ0/O/Z30gtnucNy42ji6zsfQJQbwBawx9nR+pzufpR4dK8+GGG8cbf
I6P2MDd92DIHJOsqqFXTNRP33dvHcPJRHzpgWefyPOfwRk3veWLTWEVRz86CtIkF
5LVs0QYh/NTi9M2A+hYATFBlIOGBU2QP/7cwMq6Uop+QfjGDTP/Sbg3W3ksBfpz7
Bl8iUWmxyIJbuqrw/xfwFoJUHXSqlEtOyuryTzDBF09BppbzUU6DIRkDhEDH9Ak4
YydjxKIlbjLN1k1iaAvhZGNL8t0c+Q==
=7AgW
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
