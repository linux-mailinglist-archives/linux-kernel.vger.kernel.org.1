Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCDF2ADA44
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbgKJPWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:22:32 -0500
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:10075
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732447AbgKJPWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:22:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe8CiWTT/HMS+x/Tq6I3fJL4F7RaS3A+VFK9ZRNq9O7CfX/Nryp/httPARvmj5iCdT0oCTp4inZ3BHZ8rXDYA6AlbZMjXVVBzV5uiTsCO6QisHCdIorOf02bF1tbGKgIIjK8hEpB5MOSruZUiVnD5ILwjDIwd75fINMqmpJglbKNQH3V5JTVLyUatS2AFh6YOWgdQIXX76+6Wy6JlTRQug+Qw9FS5KNI2qKLaOY0/HfTm9GuL/hI8AajCY77M9Cif2QRlnRCGfTpqQ3Yjjg110YN+wAOjMpP+EXnlk3XdtvqALFMOqa5m1Z2i/HI3jxerE20OprCAwTm/eYTACc1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYTuzDsYVXlx1KZz3pNkMeyEk60Msi5G8+1GvtTBjLU=;
 b=hLBEiJngDRoMyQLBNeC5iP6N4MxXDYsZxurs41qFsPbePqkK/Wf0T4aOOnJFO4K0GdE8x7iAFEh/E2WT8SYmL8mrHrcv7zJoheEN49ZLL8UNCGeG5OZpXgYVOgN2i0XUracLsjv8aHf3g7Gee6farDJCnLoM1YO03Nx9UrlHr54XWmLA4y4iMazfxu7soMOSk0aRQNNviHC1LCM7rK1ggVjvYfM5qFcw6a23vJgb8tJlPI7yyEZCcl5cw1fsYYu8PbhKS/4ubHOGLUpKgx0cwkRxjKu+vu7gEkEIukM1/fr/NOLgx0L1CHkKgFn3Mwr2Hdsi7dAfbkItWT1wBbiE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYTuzDsYVXlx1KZz3pNkMeyEk60Msi5G8+1GvtTBjLU=;
 b=pbHTpo/Iy0yIjQhkNktGxE0CPXnE67bEi+GhSmFU8JlMqfJ6PqflxHWrXbPK+uydObE8EvXn/BX1tFXTFnxvB73KkCKlLiO1KO1xqiGw0XVLbBM9QEmm1ZTn76PxSC6GuMwPYrCEwXG5+lpHAU/FsDG1cmBhhH/Xtidi+trXELE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM5PR13MB1323.namprd13.prod.outlook.com (2603:10b6:3:28::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.15; Tue, 10 Nov
 2020 15:22:27 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::d55:1263:fadc:b6f5]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::d55:1263:fadc:b6f5%5]) with mapi id 15.20.3564.021; Tue, 10 Nov 2020
 15:22:27 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@esmil.dk, atish.patra@wdc.com, alistair.francis@wdc.com,
        anup@brainfault.org, yash.shah@sifive.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v2 2/3] dts: phy: add GPIO number and active state used for phy reset
Date:   Tue, 10 Nov 2020 07:22:11 -0800
Message-Id: <1605021732-268521-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605021732-268521-1-git-send-email-sagar.kadam@sifive.com>
References: <1605021732-268521-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-Originating-IP: [64.62.193.194]
X-ClientProxiedBy: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma15.internal.sifive.com (64.62.193.194) by BYAPR21CA0005.namprd21.prod.outlook.com (2603:10b6:a03:114::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3589.9 via Frontend Transport; Tue, 10 Nov 2020 15:22:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3b8fad0-30ef-4181-84a6-08d8858c6ea6
X-MS-TrafficTypeDiagnostic: DM5PR13MB1323:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR13MB1323C63CFF71B10AE54CD6FF97E90@DM5PR13MB1323.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+H/CY6hv/L1/Tc16gm2qtKKT9hVeVFQeV3XYVWjEEU2Df8PNV4Mxz+vBX1KDhO2DwUUEMzWkkJ4DjVbi18B40ehu2fM6AvVTBElrTXc6G/5z/2Pnh62UjZyKqH42vKRian3c/qCxCs8PrjDi+dXcuVpq68UpxFsrD0pvPZUT4/AelOCoteewuLxcgGMD5b6CMk1UCGM2Akxo6RgGV1DJb1NGKw9d7slOou6wgd0MNE8w71pKnCMJMn29diivRqQ2dyf3COxST+Qei4GDnsta4njga03Nkh1OWNZVrpNgA3XSPWk1CU7X7yOPiNtq+VIhNJXGIN1snmWHLqbitR7HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39850400004)(376002)(396003)(366004)(4326008)(83170400001)(6486002)(16526019)(2906002)(7416002)(186003)(2616005)(6916009)(4744005)(8676002)(956004)(66556008)(42882007)(316002)(66476007)(107886003)(8936002)(7696005)(66946007)(36756003)(5660300002)(478600001)(26005)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: G7vSwP0Lef+n4uZj5aoOqCiVkmxVQe2I3tWeCm22GTLIy1YKmip371uJjJb0YvaeUkcv3CFWF45gvRzOHYwgKxVZEAEDuH4uGIdDCdPjIF9+50FZWGcBjg9htMFJ8dQP37Xd9eK+J3FrTsn2mxifX0mD3dchDUxf3t+TsG2NgYEyI3NzEZOMI3M5qTJaUKdY7OFtdLoSmpnkiLhmfmCDvcPSZB4hrfzbe0LdOktm93uR1r+rUEQS6V+LANGA4NxMds9gR2IKNCVavzZeFB2AgzAZNLTDhIco0Uex/ny+lzGGfj3kLFkzMqCrpY8UIdPbtBWB0cmsIcDmi+LH95a/gSr/5PfpgtbJypqjiw4fDcjFFr1HlQMPDkCqnJ439JsgVHf5fr2Zg0ct15l0OVv+lZoxcWm9gTFG/y7pF2a6Le7uv2azraZ3Bm7LLHPexcmDwT3D7cmWaVUPTAMo0SeFQl/Mmwp4cj5np6xRA80BKArrxIL4NAP4d7BwEuKUyDHGSfKSuQ/hFZppn3PVp9BbC+o3Rl3ZGpH959hkIEBGwi1OUvZ7jd5ZOLP6K5RL6hCq/viyBuwdkBgNgYxb5feMVbJeSJcFkGMEOVVrN+AuWUfREab1gEuPBqBQYd8DhXP1GpCYzf7PFtZas2Uv6ZxPBPePzuOtq/EPFM4z4QUbOBtdqyinlgCheTmZVGwfDLArCsD9sIVip//4pcg6IQLWxX/3fxa+2Ac0zBmbJIaiUVfoXlOKPkN5n0duLHMv6hXBmF/q4P/DVi+dGUW7RKy4Hr6pB2FToLbuliVArkshMVCbmWe+7Lt0f7oCSxPMt+sW0zXHqO2FSQXFcV2f43pGiinITAtWMS53EF/n99GrG/NBzTGkngjW3Pt8P90UnzGC4dq4h3Nn7bGF9hPswKtuOA==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b8fad0-30ef-4181-84a6-08d8858c6ea6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 15:22:27.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bEvHcmlBpxlGFKkOFx2J5a+0r6te9E9UuhZKkvMg4yVTvmgrqP2iL8J/Wf2nMnKkfAciD5oXbhZkKwwRo6cZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1323
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GEMGXL_RST line on HiFive Unleashed is pulled low and is
using GPIO number 12. Add these reset-gpio details to dt-node
using which the linux phylib can reset the phy.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 60846e8..24d75a1 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -90,6 +90,7 @@
 	phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-id0007.0771";
 		reg = <0>;
+		reset-gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.7.4

