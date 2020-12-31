Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40732E7E90
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 08:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgLaHT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 02:19:56 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:36095 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLaHT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 02:19:56 -0500
Date:   Thu, 31 Dec 2020 07:19:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1609399152;
        bh=YoZwhQ90gbl0VD+Jy67qWsHVGWfPpx7CAqbFb3UqWG0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=JdD0MUs49CsDlCBBZxTXzdWXsfPIu+AlmvPebT55ElvH39wdfIwASwbEvALSLiAMf
         JchC3S4hYfmO1k6P124n82m8wpjYsSpqzsw62NS9pkflzfGcE3LN9x/h4byTi4GAbj
         mcL0Ie2d0xviBC2R165wpWXohdvX6V9FXucf50dU=
To:     kernel test robot <lkp@intel.com>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH v6 3/8] power: supply: max8997_charger: Set CHARGER current limit
Message-ID: <20201231081754.09aad125.timon.baetz@protonmail.com>
In-Reply-To: <202012310753.axvdsSG1-lkp@intel.com>
References: <20201230205139.1812366-3-timon.baetz@protonmail.com> <202012310753.axvdsSG1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Dec 2020 07:22:22 +0800, kernel test robot wrote:
> Hi Timon,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on regulator/for-next]
> [also build test ERROR on pinctrl-samsung/for-next krzk/for-next v5.11-rc=
1 next-20201223]
> [cannot apply to robh/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/0day-ci/linux/commits/Timon-Baetz/extcon-max89=
97-Add-CHGINS-and-CHGRM-interrupt-handling/20201231-045812
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator=
.git for-next
> config: arm-randconfig-r004-20201230 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 3c0d=
36f977d9e012b245c796ddc8596ac3af659b)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/0day-ci/linux/commit/3a597219bbfc1f9a0b65b96=
62b7b95bbb7cf728f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Timon-Baetz/extcon-max8997-Add-C=
HGINS-and-CHGRM-interrupt-handling/20201231-045812
>         git checkout 3a597219bbfc1f9a0b65b9662b7b95bbb7cf728f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross AR=
CH=3Darm
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
> >> drivers/power/supply/max8997_charger.c:261:9: error: implicit declarat=
ion of function 'devm_extcon_register_notifier_all' [-Werror,-Wimplicit-fun=
ction-declaration] =20
>                    ret =3D devm_extcon_register_notifier_all(&pdev->dev, =
charger->edev,
>                          ^
>    drivers/power/supply/max8997_charger.c:261:9: note: did you mean 'devm=
_extcon_register_notifier'?
>    include/linux/extcon.h:263:19: note: 'devm_extcon_register_notifier' d=
eclared here
>    static inline int devm_extcon_register_notifier(struct device *dev,
>                      ^
>    1 error generated.

This is failing because CONFIG_EXTCON is not set and *_all() don't have
stub implementations in extcon.h. Should I add a fix for it in this
series?

