Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083582DB086
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgLOPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:51:06 -0500
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:46593
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730353AbgLOPuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKUcRPW8QLKOS3ZCjpG7AUSi1HRF8BTm+qoJa+tQPduooSgUKoGQQi3VGPgdQ5AxnrU38g6TzgmHq8rKZtr9+s3mBydDbNmUtE6aFrKh2km1dd+9Nettx6+7g99XiiwKJzuRkbJTh1qaiC/5zn/YL+Fhx4Vmg69Bh7Cv54mEOdUjlE46M6ZT/Sdszm15dxUU1h+ZfBnoD8cxaoJaRylBBeouF9Dwg8SwN28hFh0QjWCR6RpjD2X/AHTbSBlNGFqvWtoGgs9a8lSAHRkH5rqL2dsXXTtrfgj14Pwhm1jZcFCUUUJrCoJk3tbtCU5+89FHtHMB7HwUljI5w/1+eBMCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whjt174yyRhgiSc1AFkpZuce6t/z0hhK5GDsyXh4K7A=;
 b=mI5RXPketnT6DlSpPUtq+8Lf+MeUyWtk4l6bHlLoqHR9Nw6Q/VXbNl5UDrEItrFJYOX/zmcCEJpUhS/IDSDgNdxp3u3ATWCoyT43DajTlKThnIOc79wstsI3N0rFm8Xk9ut7lTBVcgM/vAPMoREEhULWDmFkJvhobgTsnj0VAytM3Q4DfRDPR6W6U5EVnxXGF9VpQpPtY41gotHStyoOUIeaQqPLLTskZe4QsclzUmVvyEmHO7zP4xu1xEjKIYudE7fLiPVhfTyYtyA2hzADXIqWKEdR1aAzDisX05vMttnm0lLn3uV8Go53F//PJEM/1bXB2eWQ7AGjY7c8AKW0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whjt174yyRhgiSc1AFkpZuce6t/z0hhK5GDsyXh4K7A=;
 b=upFDOB1L5PMpA4G6GwhKilPcI8KWTQEKwgtONqQkYiDr03KoHxz9Nb1DQJkxSgjTkzD7pLJrBtNhGxsJU79vlKq78PhpAQ8LD/+O9l2wTYDmbzjDV6zOS+iRZPGyRP6ZOJsepjzumEznhW2WhwXtAw/ZXRZUGeqKhEJY+8oKBek=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Tue, 15 Dec
 2020 15:49:56 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 15:49:56 +0000
Date:   Tue, 15 Dec 2020 10:49:48 -0500
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Harry Wentland <hwentlan@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Chiawen Huang <chiawen.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
Message-ID: <20201215154948.3muy72twmmstd3a3@outlook.office365.com>
References: <20201211155553.GC25974@zn.tnic>
 <CADnq5_MHqWqOd5ZngitF4UUDoZsh+fPrYJtHpJMbJdjAhFfhew@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gvycav6nmubjyxtk"
Content-Disposition: inline
In-Reply-To: <CADnq5_MHqWqOd5ZngitF4UUDoZsh+fPrYJtHpJMbJdjAhFfhew@mail.gmail.com>
X-Originating-IP: [2607:fea8:56e0:6d60::bef5]
X-ClientProxiedBy: CH2PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:610:50::13) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::bef5) by CH2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:610:50::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 15:49:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 00667624-0fd3-4adf-b61f-08d8a111121a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB41813BC4D2841B3429B7128498C60@CH2PR12MB4181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9K+05g31Dysn5P6RZfWJ8nath16ag1lSi2NVvNdKIuxVlCDME79dcK4YcngDcIHheVVrli3lkHWVSAcJqHJsj2YC/bgtlw369I9KeTyQMjTpTA4J0GyVsHH9VqJYzMoNw1VyUaeYXT3nPu23TiqEr5J9I7jZ9sO/yyBCtUkmqoNHR+VWOcvJE842LBI2+3aJ1XWb+17dRA0Rs25LUUuY5N5sLnq79CpYwghLN+D/rs+k0/GPMTLXEhhYpXLGePpNQgA8XpjKUFYaXM1ZXYkDe2BeIGPMx4E5N8oU81Ta8Knlq33oDjAiUx3nqNYhc82PVC+CGqnLvFCMPCM3Mp3VEQYKNOK+0EBzAB564nTHtJYjmoOHa4Y2evN09tp6/ZHXfaVavNXvzleicfO+yZ9qQvTQf7DALuFOC1u4J6RpDF6YifNs4MB2WWjKFB7twTpkbhkMab8/CYhx3lYbwMBSx15uV839gCnVmShKX2mzCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3781.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(4326008)(21480400003)(186003)(44144004)(45080400002)(34490700003)(7696005)(66476007)(6666004)(66556008)(9686003)(8676002)(16526019)(55016002)(6506007)(66946007)(53546011)(508600001)(5660300002)(1076003)(966005)(86362001)(52116002)(83380400001)(6916009)(8936002)(54906003)(2906002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TOLejD03x/PtIC1warj26Rq61ZHdkc6zEMXARVhlIR19mntS9ko/2Xl7Btpd?=
 =?us-ascii?Q?P1Brfr4DqfCyQ8AURXaLbY07Zk4fjsynhJ9vSPqHNumw6h455+EaV1CUowDA?=
 =?us-ascii?Q?II8oRzGU+9hTXbf5CjxAX5X6PGHhNWhgH4W9U5AJLi8yx6/a00pcPN4W2ZKK?=
 =?us-ascii?Q?LDHzkDcoPR3XwrgQgP8x35VSUZkmZPLZcvqjgxiYkhyvJbfGIpuqOPeygcj7?=
 =?us-ascii?Q?Tm/ONLCZVoK8bUyw/gyJEEQByy8KqIM2B8S5gbNxclwsmcJ3OJrZnSCTQ4SF?=
 =?us-ascii?Q?oBJn5y6kArAhFmTwsXpxTz34I/j6e16d2+VNV++L8XQKEya2m5M4OVrdL/oz?=
 =?us-ascii?Q?0xCofd4cntcL48PH/+scRMvmwK0KjotJL+eFnXBqO9iHOuQVzaSWDAciNVlB?=
 =?us-ascii?Q?+mWlJhFqRXORs0vOcRrmcBGBuNHQfDC9p3Y+TSH3h3TmOqAHT56/Q0DMY/HL?=
 =?us-ascii?Q?b3UVlkQTdjfKcoMyO3q2+G6tq3wTXYOfjIms8yc2S1CQaaCcEKgxgGsU0vLU?=
 =?us-ascii?Q?Pr8bEKc+CpwHjHac7xgr1rt/abIuL1OtiubyL9NYX74H2L6XN9aAEEpfRBYa?=
 =?us-ascii?Q?mfg3WsfhsWoxZR13HAh56LuMclpctTbR3FLNFWLqg6Hcou7kO8mWdMNo+VPq?=
 =?us-ascii?Q?uxzXZruXZR7NpWxmPShcOpm5ylrA3RoVMfMenhOGGErI9Vq1JjRCFbGkuzE9?=
 =?us-ascii?Q?HCLsbKAV/moQt1tAri8FSp9pdcoLOfmARfBhN5vBCHFcQE0ncMLSlWSeQThe?=
 =?us-ascii?Q?wODoTv6pmwfneJDx7mM8Pe/f95F0uAuLS03wPFefSFcKF4O402P+/r+2yugQ?=
 =?us-ascii?Q?wE5aB/KJ4LEaBhh1QXwqORkMQgNOrJavFh+g85WT1rZNKnurIEmsjvjYnLQ7?=
 =?us-ascii?Q?zsPy9MmgUG/T/WLqKSiXsEPAIypwTFtUoqBQ7S775mBDdfSQ0O077mMFC2zt?=
 =?us-ascii?Q?GwSPQHWnBraOhpslsjQkakRuDsGnOD/o1+9eGytrPYTrcM2LHMUuaeTe62V4?=
 =?us-ascii?Q?n9aVqnbc2GEElE/YekrHKAs0HA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 15:49:56.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 00667624-0fd3-4adf-b61f-08d8a111121a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qb5ArQc5QfKOs9m3xoW5Yr3JzuBGoO/eWoEUkF+GycotxAeKG4jhI+NrnMrrGui+xGYZfzrRPWbUCvss5aueJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--gvycav6nmubjyxtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alex,

I made the below patch that might fix the issue; I need to hear Boris's
feedback first. Alex, did you already revert it?

* https://patchwork.freedesktop.org/series/84965/

Thanks

On 12/14, Alex Deucher wrote:
> On Fri, Dec 11, 2020 at 11:49 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > Hi,
> >
> > patch in $Subject breaks booting on a laptop here, GPU details are
> > below. The machine stops booting right when it attempts to switch modes
> > during boot, to a higher mode than the default VGA one. Machine doesn't
> > ping and is otherwise unresponsive so that a hard reset is the only
> > thing that helps.
> >
> > Reverting that patch ontop of -rc7 fixes it and the machine boots just =
fine.
>=20
> + a few more display folks
>=20
> This patch looks like a correctness fix, but not critical.  Unless
> anyone has a proper fix handy, I'll just revert it for now and we can
> revisit it properly.
>=20
> Alex
>=20
>=20
> >
> > Thx.
> >
> > [    1.628086] ata1.00: supports DRM functions and may not be fully acc=
essible
> > [    1.632050] ata1.00: supports DRM functions and may not be fully acc=
essible
> > [    1.895818] [drm] amdgpu kernel modesetting enabled.
> > [    1.897628] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x=
9874 0x103C:0x807E 0xC4).
> > [    1.898256] [drm] register mmio base: 0xD0C00000
> > [    1.898422] [drm] register mmio size: 262144
> > [    1.898583] [drm] add ip block number 0 <vi_common>
> > [    1.898759] [drm] add ip block number 1 <gmc_v8_0>
> > [    1.898931] [drm] add ip block number 2 <cz_ih>
> > [    1.899082] [drm] add ip block number 3 <gfx_v8_0>
> > [    1.899241] [drm] add ip block number 4 <sdma_v3_0>
> > [    1.899439] [drm] add ip block number 5 <powerplay>
> > [    1.899573] [drm] add ip block number 6 <dm>
> > [    1.899693] [drm] add ip block number 7 <uvd_v6_0>
> > [    1.899827] [drm] add ip block number 8 <vce_v3_0>
> > [    1.911458] [drm] BIOS signature incorrect 5b 7
> > [    1.912551] [drm] UVD is enabled in physical mode
> > [    1.912707] [drm] VCE enabled in physical mode
> > [    1.912921] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, =
fragment size is 9-bit
> > [    1.913837] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
> > [    1.913998] [drm] RAM width 128bits UNKNOWN
> > [    1.915149] [drm] amdgpu: 512M of VRAM memory ready
> > [    1.915306] [drm] amdgpu: 3072M of GTT memory ready.
> > [    1.915468] [drm] GART: num cpu pages 262144, num gpu pages 262144
> > [    1.916139] [drm] PCIE GART of 1024M enabled (table at 0x000000F4009=
00000).
> > [    1.918733] [drm] Found UVD firmware Version: 1.91 Family ID: 11
> > [    1.918950] [drm] UVD ENC is disabled
> > [    1.919680] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
> > [    1.925963] [drm] DM_PPLIB: values for Engine clock
> > [    1.926106] [drm] DM_PPLIB:   300000
> > [    1.926205] [drm] DM_PPLIB:   360000
> > [    1.926304] [drm] DM_PPLIB:   423530
> > [    1.926404] [drm] DM_PPLIB:   514290
> > [    1.926516] [drm] DM_PPLIB:   626090
> > [    1.926629] [drm] DM_PPLIB:   720000
> > [    1.926743] [drm] DM_PPLIB: Validation clocks:
> > [    1.926952] [drm] DM_PPLIB:    engine_max_clock: 72000
> > [    1.927117] [drm] DM_PPLIB:    memory_max_clock: 80000
> > [    1.927281] [drm] DM_PPLIB:    level           : 8
> > [    1.927435] [drm] DM_PPLIB: values for Display clock
> > [    1.927594] [drm] DM_PPLIB:   300000
> > [    1.927708] [drm] DM_PPLIB:   400000
> > [    1.927822] [drm] DM_PPLIB:   496560
> > [    1.927936] [drm] DM_PPLIB:   626090
> > [    1.928048] [drm] DM_PPLIB:   685720
> > [    1.928161] [drm] DM_PPLIB:   757900
> > [    1.928275] [drm] DM_PPLIB: Validation clocks:
> > [    1.928419] [drm] DM_PPLIB:    engine_max_clock: 72000
> > [    1.928584] [drm] DM_PPLIB:    memory_max_clock: 80000
> > [    1.928748] [drm] DM_PPLIB:    level           : 8
> > [    1.928901] [drm] DM_PPLIB: values for Memory clock
> > [    1.929058] [drm] DM_PPLIB:   333000
> > [    1.929172] [drm] DM_PPLIB:   800000
> > [    1.929403] [drm] DM_PPLIB: Validation clocks:
> > [    1.929549] [drm] DM_PPLIB:    engine_max_clock: 72000
> > [    1.929716] [drm] DM_PPLIB:    memory_max_clock: 80000
> > [    1.929919] [drm] DM_PPLIB:    level           : 8
> > [    1.930148] [drm] Display Core initialized with v3.2.104!
> > [    2.003938] [drm] UVD initialized successfully.
> > [    2.204023] [drm] VCE initialized successfully.
> > [    2.206228] [drm] fb mappable at 0xA0EE4000
> > [    2.206375] [drm] vram apper at 0xA0000000
> > [    2.206514] [drm] size 14745600
> > [    2.206654] [drm] fb depth is 24
> > [    2.206760] [drm]    pitch is 10240
> > [    2.207123] fbcon: amdgpudrmfb (fb0) is primary device
> > [    2.301263] amdgpu 0000:00:01.0: [drm] fb0: amdgpudrmfb frame buffer=
 device
> > [    2.320735] [drm] Initialized amdgpu 3.40.0 20150101 for 0000:00:01.=
0 on minor 0
> >
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo=
ple.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D04%7C01%7CRodrigo=
=2ESiqueira%40amd.com%7C36709b101b6e4c353e7e08d8a07a1d89%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637435793657547591%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd=
ata=3DCpb2l3OjKBeFwx%2FHIf%2F0d%2BSFiJL46p7Bct3JAIThSZ8%3D&amp;reserved=3D0
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7C36709b101b6e4c353e7e08d8a07a1d89%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637435793657547591%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3DXdoPAac6FCjulOvtOsdzO4rh5Qd9wwNIi%2B%2F5lvkaUoI%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--gvycav6nmubjyxtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl/Y2xsACgkQWJzP/com
vP+iTg//Tza518PWyNUUmzhjsqDqMYeTRoR1f/hfyedzq6ZhqpWlhvZyagnLQ5Mj
5YNqorMOqY+D/DPZoJHX+t84mO6dJc9wpLvaAusJvwkJGuVHCYnZwticnXHQHVGz
fhq9U6p3aE0izYjg8M+PsagL79XFdU0v1p2B8A5UtdD4wWfVUToap2dxG3U2InAX
pdsKAmXltYFJS6wPSe/RSNPl9MovbXvJ7XJHekCIzTGpTYwKuhQkvgfm+Qp72d2f
GCtXcJgztR4pFdZZyjLsUCrJGDb2MtTyR2k3cmF5ABaM+ZPOr+yRkzIUp3cpZnla
12hGwhg0l7CsuM3ELWkUE1aw07BnRSEEYZue/fVzOdgnXc1MNp1Cet5Td9IHsCYx
Kj1ITxkO97xQRRuSE4iL6wFdhL0iFCe8HhyAT48lbqq1EpY04mvvMkdHh8Q0i2Sg
ZkEaC9ztwR02q2EXG1ijtpKEDmiol4ljeA9OakIDdnpq/oz5P/Hf0+lPTou/Ybcz
D3B4H/xpJj3NJ8CquDpcSUsEHnDVWKSgLvv3nXZ/pafsbop987XcH+TbKFfsVE+9
/biDP9msggFlw+mQKD7OHG6PxdHmiYjlnq/FqH0LDYX50gxYJ4bkJnngUKIEu5O5
tlMo8KFKXSowipvY+G7dml9n5RIkam9GqER2M1/fMh4Ob5+EusM=
=Tltt
-----END PGP SIGNATURE-----

--gvycav6nmubjyxtk--
