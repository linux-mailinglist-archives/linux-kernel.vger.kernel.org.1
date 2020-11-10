Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC85E2ADA40
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgKJPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:22:25 -0500
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:47035
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730200AbgKJPWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:22:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tg6VFAttXPH+vZskn59i1luFCBMUfCpws4FVCwyaGwpiH4WlNDCEFb5erC0eadNchfn3sDLz86ybTAMNOVCHl8l4hElQO52SkHz+ZS5Jpq9eHdgvnqFzHXirYzrhf2NtS4UeiV9PDR/wNC33M0Ddp9BJvuIJvjhmArXQyczlekihXFE8XPLrwJQckCnvXEqiR+mps8IoQHzAhesq1x8HPXZpJneQJv18DYxzlndgaF2q9C34JlUIBX7VdCglRtJMwhRwitbGAaAwnMp9mHvgYOS5YEM9m8xYHXUbb4Wik6d+ZJBvBDUG1fMlZGCUQHXkhQyo9b6jt9xOd+aJRgbXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT0vG7lTaAnAHZ6D9o3Gc9f09lO/oNmOynXrHMk8380=;
 b=PyoFl2C5nk8/Cuj+vM37C/VuL0eQFQTau7zCd+vztNsgdZ6j+FI2DxorDuLwBxTH1RtLHg6Ysv/xe5nDl1MHQSd+FST8wMNwYDbmH2gnmIJTnd6W045FTnt/Xxu1uy/TNoWYwarZ7SYXPSgQOj78hqFxSnQzvXGkcZ/ZcdlkYAehxO1mXnvqEUMfW++cVywqtNOZQqx12AzeowbQDLoQqEtAeZ0a8juZ7KLCI/Bw0aUHSad/n046p4I1bBDZhevKg66iSStgmC1H8mz4eXXvyqoOb9mNEAH9u8SEX2Pvc39dpQzqmwaUBZlf6qmb1N3QtwaxBpHfWhkB0MQuxfGplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT0vG7lTaAnAHZ6D9o3Gc9f09lO/oNmOynXrHMk8380=;
 b=pxyET/GtaVi6eSw0jCak5AGIwX4FIVjOF2taWlErL5svFJK4yFLgyAm7CV9gQgtQOAuoiroST9p3cnS0RMURA5WZnENheF+D/6oU8Pz3Sp2Q7jE8SMZLeKtrv82VkRf1NAiz73BSGG5uhxcbadXCoGm11wsf16yDA0iKwjEN4uQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM5PR13MB1323.namprd13.prod.outlook.com (2603:10b6:3:28::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.15; Tue, 10 Nov
 2020 15:22:22 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::d55:1263:fadc:b6f5]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::d55:1263:fadc:b6f5%5]) with mapi id 15.20.3564.021; Tue, 10 Nov 2020
 15:22:22 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@esmil.dk, atish.patra@wdc.com, alistair.francis@wdc.com,
        anup@brainfault.org, yash.shah@sifive.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v2 0/3] fix macb phy probe failure if phy-reset is not handled
Date:   Tue, 10 Nov 2020 07:22:09 -0800
Message-Id: <1605021732-268521-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [64.62.193.194]
X-ClientProxiedBy: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma15.internal.sifive.com (64.62.193.194) by BYAPR21CA0005.namprd21.prod.outlook.com (2603:10b6:a03:114::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3589.9 via Frontend Transport; Tue, 10 Nov 2020 15:22:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f0269cb-5fad-4d1c-f873-08d8858c6b74
X-MS-TrafficTypeDiagnostic: DM5PR13MB1323:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR13MB1323B1CCF4554934B708AB4D97E90@DM5PR13MB1323.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oM4n+ZyPM86wEcDPNVSzc6DLW7E1Iu8Be6u7qhSqRUTRSNIZbbm03I+wakU9n2rdGlj00uPRCTh0MmwoZgeqNUMAig2loG5/LU8ywNzRjB0+wk/fNxNXjfPcUGbR0Yf825EdvfM1kbuB3wMTSdScB3JJfS/aMj23ceqK5Xuo2N2nR+4HK1SZJd/UJn5pcsEkSY31KJLzvwRl3aPqo/ws4H21OcAHly2Cq0HCv9l3qqMOknNcn7YhQIsF30+06nlPvEMijQqkWzkrMRQrTuSadA37yNNk9+WoAxIcinwslWTT99llx3qeRYJdvI9Hk9XmH/lIWgfBzKQBKOuspHPVeTAkv5JBzRa9+8Zot85nHt1qC/B3ezbVwMFOCe257ymaHPa/AL6qw1dFHuVRa8SxXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39850400004)(376002)(396003)(366004)(4326008)(83170400001)(6486002)(16526019)(2906002)(7416002)(186003)(2616005)(6916009)(8676002)(956004)(83380400001)(66556008)(42882007)(316002)(66476007)(107886003)(966005)(8936002)(7696005)(66946007)(36756003)(5660300002)(478600001)(26005)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dQFgjAjDuUWPYzmHDesqlhLxwsGGuDWMEyHwdmC2QX9b+NDHRBCq49SzdGUMe/khGD+1j1FJnwLdXxlU6kBKE11kJ+2T0/aAXCCGbVM8WLuYU+06REtmIJQ3M8uiLfEwn8gdn2Hps+/PQpzKXmk+7ryVWPlXAAyS1vqKkpDtr8U66VsOqKNe6Ikx8QIk2gSuA+2mwtDEEMeWF/4Wcjh6fxHm3ycsSxwQiY2P2YszqyctQIWrovO+I1s1QNrvunvEd1D2YpW7gmdUs5DNwAGmJrjR3+iPEgPZkK5onPFUPrsdMIKgB/IgSTR3OceB0JEjD3ySzwzXCBQuJ8GS2vy+4WgaE5lY2g6uBYt5ReJXsTtC3/CMD+7Gkw1PJ2tn24/3/YmNLCYoFzmk0kDFyDJ98QbZFI93srYNF6fgc6jgVAqtF3qWFXk06PBy6/+h/0FwmEVp+dgdha6bKGCSYepBPSgjXScJ4irl+6+x7vHs48LAhhif69H5S9H6aIPoCUcSoi5gwjRGOah566e6QfAy84aiHckCAVtEA2H9Xhs1wZ3FKxsGIkAlVbv3S4Ru98Lq/8P2GZJvDKKuJ5k3jgbsGoJZSHqzonfG1DZwHNsOVYNNi5NZgVqw6UaqX6up2LVSQ03UFtqxWnNdtnwXR8HOGkId1LrpUq9BKXoearbRB5mQM+jcfFrDhGq3JKNzPq7OvWBrvKeGlpUGh7gG2tBYWVW7hn8nudDsTPpb6h37QNrWLMUbMng15MHyAZXUxNx5LCdEKQK+V01VT8TvEpuhivorVMQEEKHPQ6lN5lmpRHZaNG04N57QaL02wYNsopjYL3Nb8OS0GweSZa4ZA/OBkBqJE2+x5JXfA4XRoWWrsa5imBnovS4ZXN904uaz7j59x3cb0iw9sUOnUbeUI19HLw==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0269cb-5fad-4d1c-f873-08d8858c6b74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 15:22:21.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoxQ6eE8gaQeON/DD4kFq3K+JXCWxdyItO95GcU+A9d+ooh2HeeGtZQrJt9gG8xTyqwZeJr6R4zhFC2z9RUFvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1323
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiFive Unleashed is having VSC8541-01 ethernet phy device and requires a
specific reset sequence of 0-1-0-1 in order to use it in unmanaged mode.
This series addresses a corner case where phy reset is not handled by boot
stages prior to linux.
Somewhat similar unreliable phy probe failure was reported and discussed
here [1].
The macb driver fails to detect the ethernet phy device if the bootloader
doesn't provide a proper reset sequence to the phy device or the phy itself
is in some invalid state. Currently, the FSBL or u-boot-spl is resetting
the phy device, and so there is no issue observed in the linux network
setup.

The series is based on linux-5.10-rc5.
Patch 1: Add the OUI to the phy dt node to fix issue of missing mdio device
Patch 2 and 3:
	Resetting phy needs GPIO support so add to dt and defconfig.

[1] https://lkml.org/lkml/2018/11/29/154

To reproduce the issue: 
Using FSBL:
1. Comment out VSC8541 reset sequence in fsbl/main.c
   from within the freedom-u540-c000-bootloader.
2. Build and flash fsbl.bin to micro sdcard.

Using u-boot:
1. Comment out VSC8541 reset sequence in board/sifive/fu540/spl.c
   from mainline u-boot source code.
2. Build and flash u-boot binaries to micro sdcard.

Boot the board and bootlog will show network setup failure messages as:

[  1.069474] libphy: MACB_mii_bus: probed
[  1.073092] mdio_bus 10090000.ethernet-ffffffff: MDIO device at address 0
	       is missing 
.....
[  1.979252] macb 10090000.ethernet eth0: Could not attach PHY (-19)

3. Now apply the series build, and boot kernel.
4. MACB and VSC8541 driver get successfully probed and the network is set
   without any failure.


So irrespective of whether the prior stages handle the phy reset sequence,
the probing is successful in both the cases of cold boot and warm boot.

Change History:
===============================
V2:
-Rebased v1 on linux kernel v5.10-rc3.

V1:
-Ignore 4th patch as suggested and so removed it from the series.
-Verified this series on 5.7-rc5.

V0: Base RFC patch. Verified on 5.7-rc2

Sagar Shrikant Kadam (3):
  dts: phy: fix missing mdio device and probe failure of vsc8541-01
    device
  dts: phy: add GPIO number and active state used for phy reset
  riscv: defconfig: enable gpio support for HiFive Unleashed

 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 2 ++
 arch/riscv/configs/defconfig                        | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.7.4

