Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED653227CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 12:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgGUKWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 06:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGUKWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:22:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F91620714;
        Tue, 21 Jul 2020 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595326972;
        bh=fCuI9NDUWG+qJeWp5bvO7Fmt7ukBWKJvsnGX7Kb/OD8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fs5sSoyXdpl204j+Fkj/bOQ8AYB7bO6PymhUBJOVFlr8njC4ske+iggdXJUvuqcFk
         HGLPWJoivVcGqlmurlJLZJF+8GfElAtNJqq7cyRD44DBXHOQUfQEoQrSv9bCKvyNw4
         O/OIz9p4z9CnssDbAT9Yeob79fTDk/ftQ4V5v4xw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202007101225.ZBGNUOHo%lkp@intel.com>
References: <202007101225.ZBGNUOHo%lkp@intel.com>
Subject: Re: drivers/clk/clk-hsdk-pll.c:407:24: sparse: expected void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
To:     kernel test robot <lkp@intel.com>
Date:   Tue, 21 Jul 2020 03:22:51 -0700
Message-ID: <159532697180.3847286.18120516358909570318@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kernel test robot (2020-07-09 21:12:29)
> Hi Stephen,
>=20
> First bad commit (maybe !=3D root cause):
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
> commit: bbd7ffdbef6888459f301c5889f3b14ada38b913 clk: Allow the common cl=
k framework to be selectable
> date:   9 weeks ago
> config: openrisc-randconfig-s031-20200710 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-37-gc9676a3b-dirty
>         git checkout bbd7ffdbef6888459f301c5889f3b14ada38b913
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cros=
s C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dopenrisc=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
>    drivers/clk/clk-hsdk-pll.c:407:24: sparse: sparse: incorrect type in a=
rgument 1 (different address spaces) @@     expected void *addr @@     got =
void [noderef] <asn:2> *spec_regs @@
> >> drivers/clk/clk-hsdk-pll.c:407:24: sparse:     expected void *addr
>    drivers/clk/clk-hsdk-pll.c:407:24: sparse:     got void [noderef] <asn=
:2> *spec_regs
>    drivers/clk/clk-hsdk-pll.c:409:24: sparse: sparse: incorrect type in a=
rgument 1 (different address spaces) @@     expected void *addr @@     got =
void [noderef] <asn:2> *regs @@
>    drivers/clk/clk-hsdk-pll.c:409:24: sparse:     expected void *addr
>    drivers/clk/clk-hsdk-pll.c:409:24: sparse:     got void [noderef] <asn=
:2> *regs

Looks like openrisc arch has an improper annotated version of iounmap().
