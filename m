Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722E52DB431
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbgLOTCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:02:25 -0500
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:15777
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731137AbgLOTB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:01:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGuPm1k8UlNNky54PDfqfxXYvabTzWT2xjOFysHEOkz8ei4LMO1DOQ8obQnqK5MTR7vkSWoIQHTjJNu+OxAw0W+wsxfzj21ZWNlTl/1DVKrvxNP4L4rmUTBVTYgf3CX7lFUpYkP/cl/guLNYwQCmPay+5dcj3aiCfWvCRNUJSxSlAsxQay7bLFDTEXCwXIzrQQhFwORdWJbzUwNTjrHsetW4yGvr9p6CVqqma/pHMCbx/3hYPeRKJjun6NMK87XAGtAMK+3PW3jFj5YR2yeD2Po0CDI/jrToBIyPhQArnWkhEt9STpE8MEitZMhlOVLF/1YpAvtYcUdOyuIuhcq/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmFTfUNXngMYKIo/6i6UgX3pkI1h0CivzlSeuWu6E0E=;
 b=dp7yEsDVG0+C0HQvQnhZ7efom4Uofsic3VtqC65+I6QSMAkKOetvb6vUnrvo7/tLzA8DPRKFwocJCGxRAXjzhHjrkfwQGI43EhvLItDF89SLQ03K9PsM6/twLRfX0trbySjAIlrrwnVUL4JfBoB0AD7u+DDff6AjiFbchOntsc8OnkpvWnUcpNCkUVG8ZeakVxFQCAxBGYrPBzhf7FXn+cqV/iFimAjia9bl/4zvm625de667yXSVVmBTFk6MQKI2mhinpLCCrZT4OTxazp7QEX0uZIef0Gv1BGjC6JZbDz5J3ohSYDDR2w7mfjc6enRY+qyAKQr/pyKtQRwyEzcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmFTfUNXngMYKIo/6i6UgX3pkI1h0CivzlSeuWu6E0E=;
 b=qtZo6mFRI0YaA1Uz8bFj6zx3ck+lDUDz2ckHPItSUQ5YMDfa+QWMofbk0Qlcpr73fYYNPvNe9KadCIGl+2r617nqxVwQLHfbwAPz0DUYr5lJrNbga7TpBONPaQ/qXeHvJ6t+OOnQTadZhWqZaMe8FHzl3qQnXAJyGoFA2bCNkmE=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 15 Dec
 2020 19:01:06 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 19:01:06 +0000
Date:   Tue, 15 Dec 2020 14:00:58 -0500
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Chiawen Huang <chiawen.huang@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
Message-ID: <20201215190058.p6osaztp6wi6ci3p@outlook.office365.com>
References: <20201211155553.GC25974@zn.tnic>
 <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
 <20201215155622.GC9817@zn.tnic>
 <20201215160720.ewce4usgb53pzt2j@outlook.office365.com>
 <CADnq5_MSJdrmxNW9jhdQPOZLUdkJtZMyA6FmqjyZsgGHBWoXVg@mail.gmail.com>
 <20201215164234.ywgesdqup6zdjxw4@outlook.office365.com>
 <CADnq5_N=CiuGKe4V-4a8s=SEAR9M4W8X_vdshgbwXH2b9u+L2g@mail.gmail.com>
 <20201215184306.GD9817@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xspzhkt2dglhvknm"
Content-Disposition: inline
In-Reply-To: <20201215184306.GD9817@zn.tnic>
X-Originating-IP: [2607:fea8:56e0:6d60::bef5]
X-ClientProxiedBy: YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::bef5) by YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 19:01:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fefee6c-a1ad-4abc-cfd3-08d8a12bc6b4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4892F702244AAC0A2B879AE498C60@CH2PR12MB4892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4yks62o+S1voU7eCK8hJXOEn9Lubhgj1BVR9c1tD91u+zK8Z0+Sb646A/qEiIXtmYPhdyndYbBGw3ZtgcEdGScGN6S7aiHSDoJYvuDflfCMxYADDIEfqSMWVJEUhByNrj5xfpI113nbXd67sPqEBII0Wdl5q/cR/E8IA5Jhqw2iHVXc7YeVVg27XyERAxQ6fTFGEUAaeOF0m75H6KRg1VqNtXOsp+D3080mgIHo/0G6VywLBtSYxItD6AA4IEnuhOwfNUXee3hP3vvzEETgulkekPFVQoWz2Hw6xxAhcFCk668L7geky5K6LSDgVEIvq0ajVyfgk/44hK2uJf55P/x/mmT5zFMzkNgsGRpYcWY0TeTupoUD3PPd6UV1ceTTiJRe9srpL0D2/kkXFRNrFHWwN8+HC0fYQfhjMU+y44tYKwMGOoDw/m0/Zl12zgTtt3SAmR3B6DuPcM0jupd0uFj1deqv10Og0WBQjQLkvUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3781.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(5660300002)(1076003)(44144004)(4326008)(86362001)(6506007)(966005)(2906002)(66556008)(16526019)(8676002)(6916009)(52116002)(54906003)(66476007)(6666004)(66946007)(508600001)(21480400003)(45080400002)(34490700003)(186003)(9686003)(8936002)(55016002)(7696005)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FYbe/zOGpeg7XmWSw3796vIvr92Y+WvC11INvLT44RDrZaWWVDrsIynYPeHo?=
 =?us-ascii?Q?BP6d61J6BpY0nwe5v9TmCTmEsuw+F85gsgO2ykuEpRgt2KddVpNyycNSpNbK?=
 =?us-ascii?Q?w2ZykbOcwwQ7gD2dHvCSe3PIMroFk1nEMzMT+Npb7E5Pf2XTiZir5LvcWrKM?=
 =?us-ascii?Q?1lJXtPRdyQNtodN9gIG3a1JYVYzUs6Vg4TYhHckFzKgSmugq5WKx8JCL5Ryq?=
 =?us-ascii?Q?1nquQ+tjL3t9/bAu1XJ23LGucG/edLvkK/kSC9s1KiTfpQGOCWF6h8a6FjIZ?=
 =?us-ascii?Q?GaGElKXQCpfksXrTJ3beIaqXbx00uH9+/xzQtg7BQt86RhTVn3XJfxGOdeun?=
 =?us-ascii?Q?mp6b6/DGrldQD161GYilvO87m5/XdH5V7DVjKXa5sof7C9iT55CgFX6qPyE9?=
 =?us-ascii?Q?3l4qe5IqKKObRCt/0aL9yA2dtbRVJ72es5K9RX5FRJD4SRYEXvAo5XDztP5k?=
 =?us-ascii?Q?OMmhYvUCKEuwHlLq+R0j5TcG2Uqu2vx5xEAw7Qg285dNIZjl4FNuSkrXVkO1?=
 =?us-ascii?Q?YGE8XYNKXFtQp/amO4xeQxApG7jhU1P+n4O2gzsQC/86cfi0diVIC0JU0pOF?=
 =?us-ascii?Q?pFh8JNh6Kdn4NheRNEFARYka+8nh8b03WwpyKnyFMisg6J+olQZWGEGmFLrL?=
 =?us-ascii?Q?VtgGNwMMY07nohmkAWQdcwdscpmPUcZOCo3vClBpTldnAaQoEv+qt+glisqQ?=
 =?us-ascii?Q?fG1cY6QMB5cWLeFVR9KjESzIrslkkabEkwq4kkuvs5V474v0dos8eLYoL0GF?=
 =?us-ascii?Q?RKiZuOkNH4129/riJO1g2qz6hzAmHnSZWI3GJgwOCPVOH2urrH8t3SIQuyQt?=
 =?us-ascii?Q?J4Yq4sCzzKedSefOXEN6b3DGL7JfOltaiHSmvb7OR0xE1HPiRgGxfGdA7si8?=
 =?us-ascii?Q?8Mr5/ktzL9De8Fk0FXpPuisdIyZcHwRjR3uAOO0fDrPYqR3ievpEIIbU6HUG?=
 =?us-ascii?Q?azeV/6HimFbSVP+7BuWiAl+uZZTKc0WtQ6A2kiydYlvS6y1uI/oFiLU4N5g1?=
 =?us-ascii?Q?KYZw6G4JGhQWul3G+sbCmZyv7Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 19:01:06.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fefee6c-a1ad-4abc-cfd3-08d8a12bc6b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSvmTV/SUyeyVb5lj4oZN3KGKksfVD58k8ZJm6TXCGTmMkMfIqc46cJDLBZv02tH/pJR1Ooa6vPrKyaIi4i6qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--xspzhkt2dglhvknm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12/15, Borislav Petkov wrote:
> On Tue, Dec 15, 2020 at 12:04:23PM -0500, Alex Deucher wrote:
> > That patch trivially backports to 5.10.  See attached backported
> > patch.  @Borislav Petkov does the attached patch fix 5.10 for you?
>=20
> Yes, thanks.
>=20
> Reported-and-tested-by: Borislav Petkov <bp@suse.de>

Thanks for reporting this issue and test the fix.
=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D04%7C01%7CRodrigo.S=
iqueira%40amd.com%7C08fad887df0d48130c5008d8a12943dc%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637436546148511884%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DRSzl0BfkNzJy%2BJwphMSgwX1u9cehN%2FW2fTML3VnfTQY%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--xspzhkt2dglhvknm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl/ZB+oACgkQWJzP/com
vP/g/BAAnihzuTre1Rgz06j5d2t9oJhydfbg4WbaHu6skYvw2WnQNIiEZFTE5c2u
1alHuG40guIjvLweQZX9cEfIy4EuXBjd/m4p2FN9MG6+isoJRr+oOemlCFgud0zb
zDms6YdWAi7cs0TofB2PeLZYCzWA1KNHOrOkBxhsH1IpyMHumsmyZmwW4NSa9MqJ
dsb6mlW7P0L+OWfMBiYkCa+7e5mUzHzV1/26y51m647eEbKGTQBrjzzlNu5c7ybO
W6FtkG+IQemeHA9wZcyGbtgAwtJtJUCrGVtnoXGcsJArfVBXlnVQ2AB/nG7FDBlu
EpY6lYCUtAkZSdvIkab0hYeIKq5pw6T7NNpHB1ZWd2eVn2ewFTDv3SSBLATLjJ2S
9MoABn1xFg1UQYiUT2g0qOyBlvDJEO2yYJgkiVoJjjdtkGB3UwWE7iJtcIffD2Pk
LIKzDO2TrrhBvDp1s7E9v6lSW5hfwSh/FKRdAJgjSpfm2AXTwzE1Rb/9oOZd3IW5
3yBLOVmPLPjtaJFZIujZDtPMuVuZoQRU9qvNUWvhDcsqbT2cU9nXQA1hkPWzj0WF
djD0mqhfkz1NTjPnHjWt38K9MmrHxG8e9G6tXRlFx4xtWZ083CtsApFUJVY6IBOp
ojwPyI5i3LO/dYVpXPz/JO1TNhmIOqEbEiucWqmjI2AQDPGGK/w=
=Udoi
-----END PGP SIGNATURE-----

--xspzhkt2dglhvknm--
