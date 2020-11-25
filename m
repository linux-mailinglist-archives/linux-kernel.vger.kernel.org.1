Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE32C46F8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgKYRm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:42:27 -0500
Received: from mail-mw2nam12on2122.outbound.protection.outlook.com ([40.107.244.122]:9760
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730196AbgKYRm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:42:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVdfPOYoEZtlO7PcXcaCy2YerbRvWatkcNSWsig3oxmXl1SbtsF7qC1nkHA9Yrd7aW7copx4aKtTKnNEpnlqvMzMQA9eCgJhRxvzx09Ts1cQiJZxl7GQRfPCEdMuKMJUliupqIYzaoMLT3VjxOmGdkGXMrhdrCxJBqnjaJwbdQuc3G1soDo6r7/znrPolb0GDW4dzWAOXtDMd8+H6AHPEo8JwyjoKhcpaVl0IU2XoMhww4kD5YBWiBsRNnHmmYz/kVuA/7W3Jlo1blxE7W7M8HiVpsjdetBa7tNB5S4gXmNToB0dLXwJLfop4JfJUiCc2Ka+uLmD0uigdgLni5Hb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONxaqtigXp+TZ871g2w0Es7PU68d7q1L3VmNAd7WYAs=;
 b=SMQ3vWx6LCo/p555exf6VZ8lKEUMMU0SrOiWEzO4cfLg5krqaJ7znnPr5bZSNqAGv1EUvjqL1UzauJISGN/6CYlYVPm0OVTWIO6LgTSMWHzD64g5msj6l2f8t3n9u9D07c7YL3GGdTYypOjfkUFcIme/gwEfBLZC4497TJCZefQvEI/NNg3rGtqKs+NnCVU8IlJ0RiG7zvuvt9HcYB/PNEda04VB5zbTgAp9o9ntOpLALI26/YzmIaiu7L5cSUk2EVYrg/Is1RpC8ytcCuHFYja5xKNfwlYfRIx6+1MAzTvMEspCESCN61Sc4Xe0FWvngmq2VYWrmsYRo4G1BlPS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONxaqtigXp+TZ871g2w0Es7PU68d7q1L3VmNAd7WYAs=;
 b=GSwPn0juK8RozTn4LVRm48gyEEDypw9SjkRPgntejKEiBbqnYJf1c2YETk2LVIxXrTweslbKT1BuW7WC3zYqEEO5JktHv1RHWXYo0go8NVKjEvHnDQKWC9piwlOll27l7kyvdT5+maVL++gxRWOLAVUL1fasKCWrELcXGGJToMw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4744.prod.exchangelabs.com (2603:10b6:a03:85::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.22; Wed, 25 Nov 2020 17:42:21 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::e87e:9b58:fa97:a4f2]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::e87e:9b58:fa97:a4f2%6]) with mapi id 15.20.3589.025; Wed, 25 Nov 2020
 17:42:21 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH v6] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <160631588213.1506382.10150338922271278043.b4-ty@kernel.org>
Date:   Wed, 25 Nov 2020 09:42:18 -0800
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        catalin.marinas@arm.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        patches@amperecomputing.com, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF41E2C0-C118-4FA7-80D4-554785F9505F@amperemail.onmicrosoft.com>
References: <1604518246-6198-1-git-send-email-tuanphan@os.amperecomputing.com>
 <160631588213.1506382.10150338922271278043.b4-ty@kernel.org>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
X-Originating-IP: [73.151.56.145]
X-ClientProxiedBy: CY4PR1701CA0003.namprd17.prod.outlook.com
 (2603:10b6:910:5e::13) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.148] (73.151.56.145) by CY4PR1701CA0003.namprd17.prod.outlook.com (2603:10b6:910:5e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 17:42:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4724014-44a5-4ad8-79b9-08d8916975d6
X-MS-TrafficTypeDiagnostic: BYAPR01MB4744:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB474470E6A5FEDDFBFAB7D530E0FA0@BYAPR01MB4744.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beDUaKQZbLuHyxqxmhSidt1H/w63Ax0I/IeuqGwHse9urcUoNz020cUFAGSuhIiGWcO85cQjz8hxdbMI/X3GHlqUNnlcXvfRMb9PiSdLD2eTBXAK/b8IVmpJJsguf8Ytaz/8+UJyTyRfrUb+XJsgLM0YHPdufxMy80BoL0EQYKdO9CPokDgyRnlCOQwI6eJ28eG55NPOaC4kqC4XK6flthMwlWs6JKPQMhs34zO+LA+SktqR5N2mEEF/C6qDCm1slZSdnwgOCcV5tq3txsX3JQzXX5dyOxAu/b2xw9s+JIl+MO+d19G0t8GD2gJfxh92UViV7SxdyaCMQ44TjORdTDVesrcOeCeV1bqYARcXfA76mY2KkSfW/MaOsetY+bwSoyh9hSCiJT+6a6JY9s0saQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(396003)(366004)(376002)(136003)(956004)(966005)(52116002)(2906002)(2616005)(316002)(478600001)(8936002)(16526019)(8676002)(4326008)(6486002)(42882007)(16576012)(53546011)(186003)(6916009)(26005)(54906003)(33656002)(83170400001)(66946007)(66556008)(5660300002)(66476007)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NyXvtrNfxTD/16Ei0RBiOj3sBO+Iqmj/QkzxMAJ15f9BlTKMniCp0BfMG3lv?=
 =?us-ascii?Q?gS/7geMjwkSmfvcC2UH2+EAIoLfQdUtMvgHwgjegisY2bdxlKiJbBeyP8yo7?=
 =?us-ascii?Q?PSs2k2GVs2YnFWbjoJQqB1XHmgB033jQfZfTqX0MlIS6kl3BPLutMgRAUBpx?=
 =?us-ascii?Q?ihxADNNxfJ5ttsKNy26CAhfUHPNdr4vFElSGRIzBYyZdbzz5sTxSDrqHcJ6v?=
 =?us-ascii?Q?8/GcTMVGk2Mkpjnj/Y6R4c6K7kEDqHZhS1oBb9yZJCpaL9G4PAxUH8jjwkg5?=
 =?us-ascii?Q?kMpFGxuHhoGPqmTNcZI8l66zNOMBOpOMN1sxGolNNecSyClGltzb1dsWoGAk?=
 =?us-ascii?Q?fXBQat8YlalCmO5ASZQSzc8vsbtxyyir19sQ3/bH7fXc5tJX0uK+3QHdT1VR?=
 =?us-ascii?Q?eGaQeGREcPW8cO3Z/AMZQlVGbWvnsgF6spgIVxUTgrAhyrpSMOv/vb1eXbSe?=
 =?us-ascii?Q?Eokl5TBs5SWrDeFh/glmvrEUzoseMY0hhenYwQenGSsJFrSSoYY64VY3pgfB?=
 =?us-ascii?Q?3/7DgP58uYqlcacT/HEk+w4vyu3xOq8bhvW4cyrMxYyTTxrHIkr8pTq9XvkV?=
 =?us-ascii?Q?8swqukxOr2qXnLkkmos6CXwULLukJPpQ65YVEGJDNhaHLvUuS/9X5V9AcZQ1?=
 =?us-ascii?Q?v+Mdc5mgEd3dhDsZNXnba6Zt7EoVIUi9wIZ6OOcC9j+vNu2Xe1IFkuYKOEkx?=
 =?us-ascii?Q?22ivszNsJ69WTRxKRmGx4+zobnoPbJHpQMafM6NJ/jqukBgfXIl8Di7U0i1d?=
 =?us-ascii?Q?wtAbgBjXW0L/SpzBboME82wZDQKQ8tzSQ/6kq2OxY8EiSVFumNYz7GBa6wuq?=
 =?us-ascii?Q?Vw5xAvms43GRLFc/GqaxQ2um2YY3tTBfJaJqfGlUZNw83NGdQxLZEWE15JKc?=
 =?us-ascii?Q?eR0ZWZhhV7Jd00gQUo8KJ6NQA/yHPfKNuDVF5LVrIYubOYxg9IyFyjiOITk9?=
 =?us-ascii?Q?p448za0F+k7BIeTjamxHRS7z51DU67ycRh4xvMEjqLx3wb26p1lScW+JHWrP?=
 =?us-ascii?Q?TMCz?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4724014-44a5-4ad8-79b9-08d8916975d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 17:42:21.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdDodXGWQILc6sWs6KAgvZSJLWZMH7L0r07QHW9/1hqXk2gI7WTJoQlWEHYiY8orHkezDpCXvzBsyc3xKL8vKkQYFDDphEw1h1yJnsROJ/so4pgGe4iXcVGMRpfB+mwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4744
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Will,

> On Nov 25, 2020, at 7:44 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Wed, 4 Nov 2020 11:30:43 -0800, Tuan Phan wrote:
>> DMC-620 PMU supports total 10 counters which each is
>> independently programmable to different events and can
>> be started and stopped individually.
>>=20
>> Currently, it only supports ACPI. Other platforms feel free to test and =
add
>> support for device tree.
>>=20
>> [...]
>=20
> Applied to will (for-next/perf), thanks!
>=20
> [1/1] driver/perf: Add PMU driver for the ARM DMC-620 memory controller
>      https://git.kernel.org/will/c/53c218da220c
>=20
> Cheers,
> --=20
> Will
>=20
> https://fixes.arm64.dev
> https://next.arm64.dev
> https://will.arm64.dev

