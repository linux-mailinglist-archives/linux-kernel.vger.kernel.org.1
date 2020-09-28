Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B87027A895
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgI1H1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:27:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34080 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1H1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:27:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S7RiZ9025024;
        Mon, 28 Sep 2020 02:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601278064;
        bh=t2xZIzE5nCl075Nnf08l0R3sMqtDPH99mtG1NhcRZU8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=e1qAVQdpkpGOCqfVQa2ZE7k6Pv7EKRfPSEuvjnNdxoVo4vWjR9+AnuHxVk2yihqWq
         keG7eFjp53E8bIdRYjH6JqdUOApCUul9AzIgvWfy3QovGZWMdgIQ75Zl0i8EUzQB9B
         JbcqTC6XTUGSCfiow92oYz7NiWsUxOodUACprh+0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08S7Rimn098755
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 02:27:44 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 02:27:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 02:27:44 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S7RgSg036259;
        Mon, 28 Sep 2020 02:27:43 -0500
Subject: Re: sound/soc/ti/j721e-evm.c:528:34: warning: unused variable
 'j721e_audio_of_match'
To:     kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
References: <202009271553.4OjMpGkX%lkp@intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <76cae106-b643-57a9-e82e-48e46ebf1b70@ti.com>
Date:   Mon, 28 Sep 2020 10:27:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <202009271553.4OjMpGkX%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/09/2020 10.27, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> head:   a1bffa48745afbb54cb4f873bba783b2ae8be042
> commit: 6748d05590594837e42dfa975879fb275099f0b2 ASoC: ti: Add custom m=
achine driver for j721e EVM (CPB and IVI)
> date:   3 months ago
> config: x86_64-randconfig-r033-20200927 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project a8=
3eb048cb9a75da7a07a9d5318bbdbf54885c87)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D6748d05590594837e42dfa975879fb275099f0b2
>         git remote add linus https://git.kernel.org/pub/scm/linux/kerne=
l/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6748d05590594837e42dfa975879fb275099f0b2
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
ARCH=3Dx86_64=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>>> sound/soc/ti/j721e-evm.c:528:34: warning: unused variable 'j721e_audi=
o_of_match' [-Wunused-const-variable]
>    static const struct of_device_id j721e_audio_of_match[] =3D {
>                                     ^
>    1 warning generated.

Right, in the attached .config:
# CONFIG_OF is not set

There must be a clean way to handle this without extensive ifedfery...

> vim +/j721e_audio_of_match +528 sound/soc/ti/j721e-evm.c
>=20
>    527=09
>  > 528	static const struct of_device_id j721e_audio_of_match[] =3D {
>    529		{
>    530			.compatible =3D "ti,j721e-cpb-audio",
>    531			.data =3D &j721e_cpb_data,
>    532		}, {
>    533			.compatible =3D "ti,j721e-cpb-ivi-audio",
>    534			.data =3D &j721e_cpb_ivi_data,
>    535		},
>    536		{ },
>    537	};
>    538	MODULE_DEVICE_TABLE(of, j721e_audio_of_match);
>    539=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>=20

- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

