Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEEA2F276B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 05:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387407AbhALE5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 23:57:52 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23663 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbhALE5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 23:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610427927; x=1641963927;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vJvtbYKQoJ6csep19qOshXzJScicim53C8PDsgZFEUg=;
  b=ivjpwBUrTy6CTqiMORVslmG57v7jlTeBTTwDLJsTYjOVy4NfNEp4NEZz
   rJRNk69WmJo5s0HgJGLc1E9CBYfHAOtpgiw2UMTAKUhj7WrKzCedMQFRq
   hv+M2i4ACNPsyZyT9eoM/mtiNpDuzCb6Hw/P+tUD0db/V13kEJbLYnBsG
   3FRDXZNPH70u7Jj8oedNGIstx+w9KTZ5RmkqFORb05GSxa2s4LchPMgUT
   iaUeh93ZUxOJjKJlxpC5rSvbsghv3cYbxixhb/T1aMihQ51V4xpV6n2Hi
   Q7VSPdA0TIrFrIdI/klU6TioMec3ER0cEWjUfrNhuMVlUZKRrb9lg0aLG
   Q==;
IronPort-SDR: 16yNKk7Y62L6bqg/kLgoxXUk5ytHCq/igLrGmA9Ep8t6kKPjNiHelUDgxBfLGZvTEI0qnzIQrC
 nG1VIcbnx8H9pSylbWvnY0ibNH23ekijXCx7rQ2ja8GDNuuftbejxlS1mSNZbSlwNy3AAAEPw4
 x+X1WXLkWoxIDj0vkYazSr0yEIHugWArzaGJsiaxeUrCOaTp3MVipaSlWg+AOAbyTHOIaxccD+
 S5V25Wo1me/2rBmytp4NmKeSNKLlduAlvTCvfRV/4I0aIgMRqM0DmjYH0xVkL+mcah6wlsdiV4
 1gg=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="261101912"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:03:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNLYZVsLv0iYlGotohpvJ/qdMMbSdwepIK+UVS178RXkrJYudTaHsYIyTLlYx5RiOMNBuEDlegS/L8sYvRjeEcsYmEmc9zK4GBX8FXT/8hjS/MNarBVFPAkKKVe9Trd5xwz0CMlUyicKseKB8SSC1LvUYO21bSMy4N7U7KHPGCn9HBceG7CQzFC72yUECCe4tZcRJWl1yc5FkpZij3tXmGtA+5PmOmfZunbJ2FeqZSfGda+6ni+z8i80mwcwsG1NTLcD8S7nU8gnu1Iu2Tc2/sN+VAbaJ8Sl7aHN5LbFa0wpDFONWmVZpDlrlu02c8ugaVxyjGOsKC2W8xURhd2QrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itCe7Cvn9oWGdipIK9MP5Yro1SJFR9twwtcA4RPYQgc=;
 b=GqUJ0UcsxxXEFB5sb7hkgw0j3nTvKs3XkDkyZ/FAxhJzkCGicEIoz9uAvZXCH1430Lo/gSWVqD+7mj3lZlsfJIQVF+DHN5CpW+J7Ywg/J0i9pyZl3yxpwTJlyjglGqLXG+lw6VtRHfUYWgLF5Oz+Sx/Eyz5lYWHW1/otaMpifV6ITnasQzWR7SkCZGcte6bq/kxNDnC8kgilDmZdTs/g3RNxsSopr7oFKcFz9r191GODQMA/kIKzYcKaLTshEaaG8YiwmGlY8cNpT5zymnptpZUd9FRx4j9QS4YFI9uUqmnl9c1Eiapi9TiNvoF8cxI92pZ65bD9lmxbPCPhRjybwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itCe7Cvn9oWGdipIK9MP5Yro1SJFR9twwtcA4RPYQgc=;
 b=Iu8+jRrWADwJWDlBkjYmEkMT2Q4/pQWYXsW3EyXez5Q/JpoBSRv7zPt5ct9ukSAfvNvx3qceCHv7miaE0wQAsT+Lw3RBM9HxmZ6kuihRmJCTh8M3Tbulciljbx2yQR+tqee8uEWBWLhJwc24YZNHKe2ac5OIIY0WhO7ZwpZt91Q=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4738.namprd04.prod.outlook.com (2603:10b6:208:4c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 04:56:42 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 04:56:42 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: simplify BUILTIN_DTB processing
Thread-Topic: [PATCH] RISC-V: simplify BUILTIN_DTB processing
Thread-Index: AQHW6F+wb8gN2NR8V0SpNievsT3NMA==
Date:   Tue, 12 Jan 2021 04:56:42 +0000
Message-ID: <BL0PR04MB651404BE54D2D9297DCEFEF2E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210111212031.2422-1-vitaly.wool@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: konsulko.com; dkim=none (message not signed)
 header.d=none;konsulko.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42ca2df3-4ddc-4fa2-f19a-08d8b6b6746d
x-ms-traffictypediagnostic: BL0PR04MB4738:
x-microsoft-antispam-prvs: <BL0PR04MB4738ACFD5C168A9AF5974E08E7AA0@BL0PR04MB4738.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 70Ow8cfTd+xlRlBKNuJUlyo5gzgP1vzReFkK+Dl9p5NpOUHKZx/bvOZYBXqob44eiez3wBl/cYMjVDoEem3r5+1dZJiaSol9gD+Mknjj/WazzaH//YfAWKwft1J0IQa1HSM8N5eEzxoVzL6CpgVXqmP8DW9w8DLRCCGwDPFMnSBhzmhZd4aDwouc7MDyyARZd+p0UnZjDyX2BZTGS1wH7ecLKR81gzLVP5YJPwZs4OZCydqXxZ7e4XqqYy7FL5PeykUgDVfXDD+3GMQ0XGkh1EfwAjTzwTs+h3CVltTP/5sTOUxgu6QExZVAZ2OiGxWbe/yVyhJwZUH09/q39FB0wjN1Gc+7Nz6fd29Q1vlKrBn1e9X3Fsl5NkYAcpsSjQSnumy81zLnipBZaHFv4UC8bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(186003)(54906003)(76116006)(53546011)(6506007)(316002)(86362001)(66556008)(33656002)(9686003)(4326008)(64756008)(52536014)(8676002)(478600001)(110136005)(2906002)(55016002)(66946007)(5660300002)(7696005)(83380400001)(66446008)(66476007)(91956017)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YNqYf2voHV9yMNypfo0nlRvby5Ytdfks1pAwHFrFPtY585mA7vYYQCP+S0gT?=
 =?us-ascii?Q?L3uBgiPegmarl/he19yZFUJmx+6v7Lk0HcGlzxxC5yIiKGh2I7cAx3ZJo7ew?=
 =?us-ascii?Q?r9SdKDbJosQPzsoFL0YJAGu463782qx/a4apPnws8nT2taUv5Ha/hwO1aRGK?=
 =?us-ascii?Q?OvNKnxbV+Du+th8rX5t88qpPAJn3n2TtLmWQZC5owkN9sw8GuV2ogjfcex5S?=
 =?us-ascii?Q?N+fByQtzpzsUqWvNlB3P22+uQy39VGw8injjfcXta0ylOrVllN/PPu7yKqgH?=
 =?us-ascii?Q?jvCoxpCHW0FqnraS8vCsmK6OMxc8ty32CI6x/o7R43PcsWeeVCTueJNC3yK7?=
 =?us-ascii?Q?O1pRcpmtjKYoeZqpu1cMMbY0UOVnppOktXhtaGv8tWkpTOHGcro+E9lfeYtb?=
 =?us-ascii?Q?ZuGZtk6AJsF2100W2YYPs0ejNXJdM+SZ9Ih947z8a/fGwRVn8kIs4KI0gVRo?=
 =?us-ascii?Q?7OaDir/XnmCBuzMSt5gP/YaXu/B73YW0qZ0uTMcGCdlUBrLdMKaXVpRbDo+t?=
 =?us-ascii?Q?kmavPgSnVCDeFhf+l0o5XzvxhsQjy6iLs6CGbuozlzA6Q87LYT9wZlwCGXDf?=
 =?us-ascii?Q?goVdUYUSf75uuRabdD0Ulry7VmasoLNRaxJQb1Po4i9062VPMpeysnhgdpsq?=
 =?us-ascii?Q?ucx+UKtkfIDbG1/ftrv+hUgMsxR4bcduVyIctsoSK5/lqrCHITRxlweDWWoM?=
 =?us-ascii?Q?KFHT1Nx//30XV8Zl6WzRUYTxUciHioTxPBrhe6xg39CRqz4jILDbTOvGSwCA?=
 =?us-ascii?Q?d/auSuJz9iR8s2NvuWX+S3r3sGlQjC439FL0dOklJST9gS+seaWcsx9+xuD9?=
 =?us-ascii?Q?hNBZCc4RvXA5C+2CmxqPEb0nHLuGjut8GLXZUNat9YWTP9DhlS3JSAu0BU/a?=
 =?us-ascii?Q?9u3UB4Pajlq7lRdPdzpYcuJ0vB+P5dgtFG5ORZrZJvbz6J9tSF8cucPIS7rH?=
 =?us-ascii?Q?j73FRBwH30DYryv7BPv3O9oDnxoedX7JSAmTNrGsSBw7LLOnweHKYVB5Kd0Y?=
 =?us-ascii?Q?c6TKWVJxiciRNskCF9m2gUIKeCfg5MVQxcHOfI4kEQyZJP8Xo3w+3PK3TquC?=
 =?us-ascii?Q?o4ZGLr00?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ca2df3-4ddc-4fa2-f19a-08d8b6b6746d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 04:56:42.5873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kArmoArcbwvBbHUJ025AMhsGWIzLSeyTqAeDK/zD+cnE7xX5TwJyhv+K0js/upAgV0d6b0nydTSszkp96lJbEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4738
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/01/12 6:21, Vitaly Wool wrote:=0A=
> Provide __dtb_start as a parameter to setup_vm() in case=0A=
> CONFIG_BUILTIN_DTB is true, so we don't have to duplicate=0A=
> BUILTIN_DTB specific processing in MMU-enabled and MMU-disabled=0A=
> versions of setup_vm().=0A=
> =0A=
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>=0A=
> ---=0A=
>  arch/riscv/kernel/head.S | 4 ++++=0A=
>  arch/riscv/mm/init.c     | 4 ----=0A=
>  2 files changed, 4 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S=0A=
> index 16e9941900c4..f5a9bad86e58 100644=0A=
> --- a/arch/riscv/kernel/head.S=0A=
> +++ b/arch/riscv/kernel/head.S=0A=
> @@ -260,7 +260,11 @@ clear_bss_done:=0A=
>  =0A=
>  	/* Initialize page tables and relocate to virtual addresses */=0A=
>  	la sp, init_thread_union + THREAD_SIZE=0A=
> +#ifdef CONFIG_BUILTIN_DTB=0A=
> +	la a0, __dtb_start=0A=
> +#else=0A=
>  	mv a0, s1=0A=
> +#endif /* CONFIG_BUILTIN_DTB */=0A=
>  	call setup_vm=0A=
>  #ifdef CONFIG_MMU=0A=
>  	la a0, early_pg_dir=0A=
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c=0A=
> index 5b17f8d22f91..45faad7c4291 100644=0A=
> --- a/arch/riscv/mm/init.c=0A=
> +++ b/arch/riscv/mm/init.c=0A=
> @@ -615,11 +615,7 @@ static void __init setup_vm_final(void)=0A=
>  #else=0A=
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)=0A=
>  {=0A=
> -#ifdef CONFIG_BUILTIN_DTB=0A=
> -	dtb_early_va =3D (void *) __dtb_start;=0A=
> -#else=0A=
>  	dtb_early_va =3D (void *)dtb_pa;=0A=
> -#endif=0A=
>  	dtb_early_pa =3D dtb_pa;=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
Tested this with a nommu kernel on a MAIX bit board (K210 SoC). No problems=
=0A=
detected.=0A=
=0A=
Tested-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
