Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7B2F01DB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbhAIQqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 11:46:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:37197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbhAIQqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 11:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610210693;
        bh=t0xRRcpfx8CmUrj1y7gu9ysNwQrKAhLNtKpvWeALyxg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=isZU4laO2OzDxt/KjIPRBHbCwFG/mvKeOM/aQmd0HSRJ+Ue4qpF0j86enCX5h9tbW
         /WREGJNburZ9MANkfdYomHfEFV79EjXaj93Wwl5K3pkiVP0/lW6963aiuCwyKyXIXf
         n4jF8Ic7NM6YCAFBGm7KIEgpWdIQ79Gr+iurp9mM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.76.99.44] ([185.76.99.44]) by web-mail.gmx.net
 (3c-app-gmx-bap17.server.lan [172.19.172.87]) (via HTTP); Sat, 9 Jan 2021
 17:44:52 +0100
MIME-Version: 1.0
Message-ID: <trinity-5d8f37cd-9d0e-4790-baf9-30b8ea4bc743-1610210692928@3c-app-gmx-bap17>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     matthias.bgg@kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Gene Chen <gene_chen@richtek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Axel Lin <axel.lin@ingics.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: Aw: [PATCH v2 3/3] regulator: mt6323: Add OF match table
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 9 Jan 2021 17:44:52 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210109112612.1221-3-matthias.bgg@kernel.org>
References: <20210109112612.1221-1-matthias.bgg@kernel.org>
 <20210109112612.1221-3-matthias.bgg@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:O7Fhu6dDxIRzG1n/8s2FEsKtZnQCyjn3b4/8rlrNW+9i+pO5gq9bgwt5ga3BGG+JtOzn7
 LHtoA0I17+bYi/JQVNr3an85fGpHuPJXYYgOT02FBAfxtFzZ/UqtohgY/5dJNjKHMmIFWoTiZP9/
 lw16wdkYauCkKtEROtwcaIuFeBR8vTllcSQgAMXAWPGrLrgUA5n2ejtdWhhmJwXnQ7oRTm1JbwtG
 52QYyzeIZ0AT6XbYLrue8dxc+yUOrgL7lGMPSpJXlQKrcsn/l0SLQMxRvWfeQj9tz8YMABPS8Yr4
 /I=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yx2Tj72ja58=:psqyfhGbFlzDpc5LVeng/W
 cEqpwE9wpFHa9LDMqu8AdfPO2d/o8Mi/UWCW0ldAsAVrXeQJMZPbq6sLCiwzH/E9LPWb2MmkL
 gug2MsIth6n5V/SkAlmeCryQrH+Wxlw3j3l5LH5hVNIbsLhGl76+vhvEE9M+WEji/im8s6DBl
 j6hJ3uZ/qNdEB+lC8B8pkaaXFnMQrLXaMHybmrnIkV6wkJRJLvrYwEOq+B8hlnLYfaqqHSy4Z
 CeOu8J9Im6Mv/wMZMwioizTrHnnYRzUxSr1yHcGrpLidh+KNQoHj2kVUxCnVfFMdG4ZaD9iZp
 smLWkZp9fbxfYoHr9vv+Z7IeA27daqQgVI4cTTv4GPz1TaZKCIR0rCu+Dqn5zWbDskfZHpjuQ
 85alAOcywdF6tqxEUgNm4eD3WDNwrx09R/JXGETldge8uWa+ZK+QG+Vo52HgNfdcZmhheI1Jc
 keszR396xFVjWGv9CtpJ/3X2vh4YEI/6F0IfWnIJQUWsqz32CsAeuJyhES+Ei2WkBX6uW6se1
 Gd10QoxML94KVVN4g3tXkfVnyB/o1fv677LdCdwqjW+18eQtbtJP29dslxlurR8HLPqxf+oBB
 o4KIYRo/05QwQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Samstag, 09. Januar 2021 um 12:26 Uhr
> Von: matthias.bgg@kernel.org

> Changes in v2:
> - check for CONFIG_OF
> - add Fixes tag

> --- a/drivers/regulator/mt6323-regulator.c
> +++ b/drivers/regulator/mt6323-regulator.c
> @@ -406,9 +406,18 @@ static const struct platform_device_id mt6323_platf=
orm_ids[] =3D {
>  };
>  MODULE_DEVICE_TABLE(platform, mt6323_platform_ids);
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id mt6323_of_match[] =3D {
> +	{ .compatible =3D "mediatek,mt6323-regulator", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, mt6323_of_match);
> +#endif
> +
>  static struct platform_driver mt6323_regulator_driver =3D {
>  	.driver =3D {
>  		.name =3D "mt6323-regulator",
> +		.of_match_table =3D of_match_ptr(mt6323_of_match),

imho check for CONFIG_OF is here needed too, else mt6323_of_match is refer=
enced but undefined

>  	},
>  	.probe =3D mt6323_regulator_probe,
>  	.id_table =3D mt6323_platform_ids,

regards Frank
