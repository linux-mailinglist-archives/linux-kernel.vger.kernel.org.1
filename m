Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A91F26B81C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgIPAgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:36:25 -0400
Received: from crapouillou.net ([89.234.176.41]:36722 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgION1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1600176026; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RdA+JRpVHiP5MDtkOjJK1oaEwH6vxkqPM7nbk1uE/Fk=;
        b=MIZkN8vITD3b1NHBf3s1XvYmuEzzynKDmA/vOMo+cKH6IY+CXXFhILXVfbmqHULpZ4frnp
        RuC22APg8kNl3S/H4SnygqFugh88nX3Gz7RF3BNz2wsq+ByhqkUL0/8T+XO7T4FfyBFXHn
        x+PbDC02IREPgUXrTz/K3PwM3sK9q3Q=
Date:   Tue, 15 Sep 2020 15:20:16 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: drivers/gpu/drm/ingenic/ingenic-drm-drv.c:undefined reference to
 `clk_get_parent'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Message-Id: <SPBPGQ.UQS754BTO0FA1@crapouillou.net>
In-Reply-To: <202009091012.ctqRlkdT%lkp@intel.com>
References: <202009091012.ctqRlkdT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer. 9 sept. 2020 =E0 10:28, kernel test robot <lkp@intel.com> a=20
=E9crit :
> Hi Paul,
>=20
> First bad commit (maybe !=3D root cause):
>=20
> tree:  =20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=20
> master
> head:   34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8
> commit: 54fe894219903e32f5154265f46ed1eb5cdc2f5f drm/ingenic: Rename=20
> ingenic-drm.c to ingenic-drm-drv.c
> date:   8 weeks ago
> config: mips-randconfig-r022-20200909 (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=3D1 build):
>         wget=20
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross=20
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 54fe894219903e32f5154265f46ed1eb5cdc2f5f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0=20
> make.cross ARCH=3Dmips
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    mips-linux-ld: drivers/gpu/drm/ingenic/ingenic-drm-drv.o: in=20
> function `ingenic_drm_probe':
>>>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c:(.text+0xc90): undefined=20
>>> reference to `clk_get_parent'
>    mips-linux-ld: drivers/mmc/host/mtk-sd.o: in function=20
> `msdc_set_mclk':
>    drivers/mmc/host/mtk-sd.c:(.text+0x26fc): undefined reference to=20
> `clk_get_parent'
>    mips-linux-ld: drivers/mmc/host/mtk-sd.c:(.text+0x27c0): undefined=20
> reference to `clk_get_parent'
>=20

clk_get_parent() is either provided if CONFIG_HAVE_CLK, or it's a=20
inline dummy in clk.h otherwise. Given it chokes on other drivers too,=20
I would say this is a false positive.

-Paul


