Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C522DB072
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgLOPsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:48:35 -0500
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:9196
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730430AbgLOPsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:48:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkBs01ZpBYIY4IrmHMQri1i1kthHpRzy1jwS7k0IqN8IlaRFPRqRf/9D/Y/phWEksqIiVNZudmxQdZvN6p/WeRV/BmnHfoT6MTGzcxVO135Kxy0gZrfpOB4xlkV529/zr3wmaEJdt18xMbOVBoIxW5gBe7kLHlkf1fy8NXrdPBO2R3sJFLt4hT40vDg7wCmOBXJyV1+zDQmrZyOdzflgxniX5A0RLnMxGKVludgj0jWhY/6fDrQdhqxsuJPLfRicAneqdwKmErATOwFJQfTMH0T3uoL1Glh0qJAMTvE+bMtYY8gTxGjte/fG9tEeJTlPrne5uec6ol8XNcjdZL8Ekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as6vnfVI5PbtnCsgn4mJW+2MfK10AW8adP2dgOl1I8w=;
 b=mIpxRC36tAAWCqpI+XM9hNArGM4jiWCbAK5kejtyRDX2gqbxDEXFbekQH9SD7mrhG0A4NRSfAuWj5SJ/xD/eUz5KGMiFYc7sJs8B1T7XNNZh/gPJlH/0jvaTzDIcLlMJvHcPpwMXOSvJwqdcQr63A1WwFwqhLmNfU+VN1Ftkl7B0EmRu1ICyEJrNDjYsoefhv/qeaSx0LJW9nlhEYN7YxVMx3+h6RiU2WH0JWP6ATKGz3+J/dOWhu++bnD+N4ygIKl/MTm4l2nZu38kg1qLN7UPS2aTs+OWNdhLtfNFTDNAUNJvz0kj3H+onUbPJD+4hBllVWuTCrHYAjduel+9gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as6vnfVI5PbtnCsgn4mJW+2MfK10AW8adP2dgOl1I8w=;
 b=zWcEXvYSQHDcQraFmJ9K6v3Ha2SJCGxQJ/tmmwWSESttJix5b5Vktl3Azdofb9kfRuErHe6PpwLHRPk3Vm7FTZvlLvJFNPHjF/7fypT7QnTN3jnhPqSt7/fG1IPfdTw+2c+CgvlNt1DB2ddIvh4fxYpn2cp3/iQoGrUdrcyfzQ4=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Tue, 15 Dec
 2020 15:47:11 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 15:47:11 +0000
Date:   Tue, 15 Dec 2020 10:47:03 -0500
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chiawen Huang <chiawen.huang@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
Message-ID: <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
References: <20201211155553.GC25974@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r6crck3f3aqflpg5"
Content-Disposition: inline
In-Reply-To: <20201211155553.GC25974@zn.tnic>
X-Originating-IP: [2607:fea8:56e0:6d60::bef5]
X-ClientProxiedBy: CH2PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:610:53::21) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::bef5) by CH2PR17CA0011.namprd17.prod.outlook.com (2603:10b6:610:53::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 15:47:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6be21561-6e70-41b1-25f1-08d8a110af94
X-MS-TrafficTypeDiagnostic: CH2PR12MB4263:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42635E01F259594506FE150A98C60@CH2PR12MB4263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VMuSEKNPQcqdbIBK62pIF3PA3oTNtrNNAOJQODSjn21+vkZsNLFivh6fQu2BbtzY3PnqTmeTnaxGwxkZww0SKMhDCNz+rPHDjNWmZQXR3HRb58gwn/jthDlTmcDdniaULojL9Q10LfxeKh8ecWODCljEC+B40tV9O7ko2plMi2VMQoU3g+96BEo9viVBbUEAtHvUIv3f3sBFyOlzV8fqq3v5iQJW4zCdUy5nkxd7Rv3HZnUIpV2/iWAuQ/EOGLb2ccDS5JyKFBnsNMmsPBlD6nGEwr48MfPC0ebAfSCY1BZ/QsOXExRhiPyh/XpxTnsLhP1xLUdSNhky6XlJ/uZ4UFaOj6tUYoCKgskN+iubnRHOEpigTxgFxqOUJIeN/jFqfHCbK2Xn9f2S49cHFeY4km8WhwWHFCdZuEgikgFdje6l+3KXzGpDexyRbW/8RN6kVt9Id1OVCNL6aUSUKohieenF+npofOLztFKGjsum1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3781.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(8936002)(6916009)(55016002)(21480400003)(1076003)(508600001)(86362001)(83380400001)(9686003)(45080400002)(966005)(5660300002)(6666004)(44144004)(7696005)(52116002)(54906003)(8676002)(34490700003)(66556008)(66946007)(2906002)(4326008)(16526019)(6506007)(66476007)(186003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2sR1Ft8/SYO8aPZUbE3WR3IMEDmbsdz/NmzbP/7DfXmyWBUfvD8wfiF17/VJ?=
 =?us-ascii?Q?gbgYbFUUWGYB8WajUiUUhQbzUN/2Zp2zBoGLNLdY7N7Iu0GrtLqy0jfiGbq6?=
 =?us-ascii?Q?8KM7Rnv5c76FSiSYnYmbY+zc8fYtlYDqLCWkmayn38JX7qnxWClpdRl41d8R?=
 =?us-ascii?Q?QV2atNPyLAQXgNXvUilc8fqWaOpZKTYAwk3ZYZrbrkVFNh8/nbuW37W3TuSu?=
 =?us-ascii?Q?4YM3qW2TFqrXDbaShmcNlAJDevJ1nBXhwJfnQKQL9jV0hMjOimnuPxZ1Wodu?=
 =?us-ascii?Q?34+vTwg2eVsI8iKGpbJ+Bom62OyKIBNMuEZh9grvVU6PBqbyaOXWkLuvDVGr?=
 =?us-ascii?Q?/9Sz65Bgk3tkNm/pqYph9mPbC61U9asLxXavA1rH5YZlxIe5rid3H5wTC8c6?=
 =?us-ascii?Q?+aWd7f570jTjQFG/aSa1X4NZsbeKEYXiGIn7juG/lkYd8hzinuYrHPr65QCQ?=
 =?us-ascii?Q?t4UrJTB0g5h7NXggTS7s61sTr9tU34PVGE1icFd8YnjKTaLpUoKOrn6/7H2i?=
 =?us-ascii?Q?NQSNReea0KBG7NnK8ZeVLHpODjA7UHEq/ttL4zjO55n3riTkg51qe7c6QsLn?=
 =?us-ascii?Q?mjJaa7NbYunhCwULlbr281ZuIsEyR/6y428irN7k1RZsEpsT7xpO27BwIyny?=
 =?us-ascii?Q?Z1vUetBVo/TXtUIyxv8fHcI99mhgoFfh5KrCdYyECBBQwRn4e/5i97B2MxpN?=
 =?us-ascii?Q?s5HhQaD4/gP2/pYFgPb9lXJhql7NVho8HsEYuzqWqrV+CKs5AZ8fHbm/jYgV?=
 =?us-ascii?Q?NsgFqkT9Ezs1BVB3hedzk8do2w7aPQb5rM/CqA4qvbBEw5Gc3JfSQKcLTXuz?=
 =?us-ascii?Q?8WirqaClA2u/hD4IhvGxr6KgvK0lE11grdgvhTpMEoIBOJp/0r4uUrADFZ8s?=
 =?us-ascii?Q?YxWD7Lcb4AXdc2mo/RraNEQ2NXAVHTkvOW6D+oJnzf+eGbfseWwa7aIuneEP?=
 =?us-ascii?Q?taYS4Vh+R0TehEH5oQbn08RCJfc7pMaR4MvGBpbeCDQMRexopW0ST7Uphg4D?=
 =?us-ascii?Q?3nPkXEU+b9Mc/obKM5bTAhDmow=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 15:47:10.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be21561-6e70-41b1-25f1-08d8a110af94
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wmR08GuAKa/CqnYceOVMFfWZ7+8Y7LjvH86aZV/fS3OxdBdtcrZH47OcMt8KQRKsxuezcleeBE+yJrwFttn7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--r6crck3f3aqflpg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Boris,

Could you check if your branch has this commit:

 drm/amd/display: Fix module load hangs when connected to an eDP

If so, could you try this patch:

 https://patchwork.freedesktop.org/series/84965/

Thanks

On 12/11, Borislav Petkov wrote:
> Hi,
>=20
> patch in $Subject breaks booting on a laptop here, GPU details are
> below. The machine stops booting right when it attempts to switch modes
> during boot, to a higher mode than the default VGA one. Machine doesn't
> ping and is otherwise unresponsive so that a hard reset is the only
> thing that helps.
>=20
> Reverting that patch ontop of -rc7 fixes it and the machine boots just fi=
ne.
>=20
> Thx.
>=20
> [    1.628086] ata1.00: supports DRM functions and may not be fully acces=
sible
> [    1.632050] ata1.00: supports DRM functions and may not be fully acces=
sible
> [    1.895818] [drm] amdgpu kernel modesetting enabled.
> [    1.897628] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x98=
74 0x103C:0x807E 0xC4).
> [    1.898256] [drm] register mmio base: 0xD0C00000
> [    1.898422] [drm] register mmio size: 262144
> [    1.898583] [drm] add ip block number 0 <vi_common>
> [    1.898759] [drm] add ip block number 1 <gmc_v8_0>
> [    1.898931] [drm] add ip block number 2 <cz_ih>
> [    1.899082] [drm] add ip block number 3 <gfx_v8_0>
> [    1.899241] [drm] add ip block number 4 <sdma_v3_0>
> [    1.899439] [drm] add ip block number 5 <powerplay>
> [    1.899573] [drm] add ip block number 6 <dm>
> [    1.899693] [drm] add ip block number 7 <uvd_v6_0>
> [    1.899827] [drm] add ip block number 8 <vce_v3_0>
> [    1.911458] [drm] BIOS signature incorrect 5b 7
> [    1.912551] [drm] UVD is enabled in physical mode
> [    1.912707] [drm] VCE enabled in physical mode
> [    1.912921] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fr=
agment size is 9-bit
> [    1.913837] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
> [    1.913998] [drm] RAM width 128bits UNKNOWN
> [    1.915149] [drm] amdgpu: 512M of VRAM memory ready
> [    1.915306] [drm] amdgpu: 3072M of GTT memory ready.
> [    1.915468] [drm] GART: num cpu pages 262144, num gpu pages 262144
> [    1.916139] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900=
000).
> [    1.918733] [drm] Found UVD firmware Version: 1.91 Family ID: 11
> [    1.918950] [drm] UVD ENC is disabled
> [    1.919680] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
> [    1.925963] [drm] DM_PPLIB: values for Engine clock
> [    1.926106] [drm] DM_PPLIB:   300000
> [    1.926205] [drm] DM_PPLIB:   360000
> [    1.926304] [drm] DM_PPLIB:   423530
> [    1.926404] [drm] DM_PPLIB:   514290
> [    1.926516] [drm] DM_PPLIB:   626090
> [    1.926629] [drm] DM_PPLIB:   720000
> [    1.926743] [drm] DM_PPLIB: Validation clocks:
> [    1.926952] [drm] DM_PPLIB:    engine_max_clock: 72000
> [    1.927117] [drm] DM_PPLIB:    memory_max_clock: 80000
> [    1.927281] [drm] DM_PPLIB:    level           : 8
> [    1.927435] [drm] DM_PPLIB: values for Display clock
> [    1.927594] [drm] DM_PPLIB:   300000
> [    1.927708] [drm] DM_PPLIB:   400000
> [    1.927822] [drm] DM_PPLIB:   496560
> [    1.927936] [drm] DM_PPLIB:   626090
> [    1.928048] [drm] DM_PPLIB:   685720
> [    1.928161] [drm] DM_PPLIB:   757900
> [    1.928275] [drm] DM_PPLIB: Validation clocks:
> [    1.928419] [drm] DM_PPLIB:    engine_max_clock: 72000
> [    1.928584] [drm] DM_PPLIB:    memory_max_clock: 80000
> [    1.928748] [drm] DM_PPLIB:    level           : 8
> [    1.928901] [drm] DM_PPLIB: values for Memory clock
> [    1.929058] [drm] DM_PPLIB:   333000
> [    1.929172] [drm] DM_PPLIB:   800000
> [    1.929403] [drm] DM_PPLIB: Validation clocks:
> [    1.929549] [drm] DM_PPLIB:    engine_max_clock: 72000
> [    1.929716] [drm] DM_PPLIB:    memory_max_clock: 80000
> [    1.929919] [drm] DM_PPLIB:    level           : 8
> [    1.930148] [drm] Display Core initialized with v3.2.104!
> [    2.003938] [drm] UVD initialized successfully.
> [    2.204023] [drm] VCE initialized successfully.
> [    2.206228] [drm] fb mappable at 0xA0EE4000
> [    2.206375] [drm] vram apper at 0xA0000000
> [    2.206514] [drm] size 14745600
> [    2.206654] [drm] fb depth is 24
> [    2.206760] [drm]    pitch is 10240
> [    2.207123] fbcon: amdgpudrmfb (fb0) is primary device
> [    2.301263] amdgpu 0000:00:01.0: [drm] fb0: amdgpudrmfb frame buffer d=
evice
> [    2.320735] [drm] Initialized amdgpu 3.40.0 20150101 for 0000:00:01.0 =
on minor 0
>=20
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D04%7C01%7CRodrigo.S=
iqueira%40amd.com%7C9c55e386aad44fc9531608d89ded4100%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637432989642100749%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DWVk3xRmBn3A75KLQKaBG7FzktecRG6GS7rXJE7bEPBg%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--r6crck3f3aqflpg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl/Y2nIACgkQWJzP/com
vP/qGxAAsv0BmC8nDcY2I75iwcCkgTSTjlnqlYjzn0XfkQnFHIyjO17yyw25EtHT
/V2uxaZ57+OzjnghsNZ7+s6rz5YJtjxvsqzsdH6k1ljMt43UMtx/uEjK1YvcnccE
fYuYNgnfrnhVHngGIm8VABDkrQLXzInyGIXx2ZCmJcJR0gttee4ss7aDFKBOeCB/
K4Lp7Cy+xEuHge5AIPKBQSXB+wYQq/3oXnc2U1otvakhV69fkPdUUrSzoEcGoZjx
Wxm8FrY73AcEoAD0+Ulvp1vHvC7K3jvCA46q9n6yALzZWtL2N6WukFMLLsuv1Yib
fawh5I38LNlVqJpP6yeEywCYtxcgKnn1KCZgp7kP1RazALD5iLI4E8OkEpSbUh+7
PIy7+/y6DWwENaNlBE+A1d2daFPXdT+rDgQTGhaHuIt6B18mH4GLM5opQGstrukb
klG97nnBwKBOLUUKfm+paNwAP1f8mSFXQvICy8p/KT71nY+rmKU5nBd0VHgC2IZ6
pVGJ+/MidoYpFepMOyO6Bs4puisl45vSBqvmDZ7kfCd/+tsHUjLwDQQPn5DQksam
C31PVTiCd8rjLWUMwPmEPelZkwzbJosHrIyW/W1J+F4O/Vxyhb/Gs+1aOoQyQoQ2
K+3P3XrdFPkwvXDtkX2vKJsLRe3XdjawTnsCzYVlFPRI7UDJSRY=
=qkH6
-----END PGP SIGNATURE-----

--r6crck3f3aqflpg5--
