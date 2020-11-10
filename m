Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE632ADA45
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbgKJPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:22:33 -0500
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:10075
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732494AbgKJPWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:22:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLsrO8KxZnjMNAWHGjszM8xlDXeryKjZOAs47OlCNfFpwh92GNDmoHQeYoaB6Ok1i+nhWggO5Skq+JB4jMcrHNszWPYx8Xf4YfPCum3O3Ml0tpmq0koWs+8F8F7YlEP/9npQcNiHeUAgqKP3kFJ5aLyFO+YDh7hWQhy0NrqdPYNPtS3cwjviCgisLTZud5yXQF2DedwX8Q7WATMxxfdOBamjlKA4QPkorBMab2R5Mx5dGNrkzKa/jwZxx8ZwYXK911z+Ok70keqWg9AmHNj5m4uQ6y7UAHdEwpjZsK29JPMtP92C0V86LMD4xl5Byhxks7DQcjAUSsJOUoDv6QVoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHHd3d1b6gpGvERk2hwBholvC0mjpe3/uhOcS3bHfJU=;
 b=Q4f7FhZNqHJIaVC6kFtGM887gEjcWObfmj9dU1FZEOsGeb1yVWBsVmOYQFqbPEhnEPssdj1LYh7cBmAdysepM37xWbuuXk3BaYqA/ncq8zVXnobQkTG02SZDraF+SW427US7wUU614cuGasYvRHMyl0sObFStV6WLk1Vn79rTPfhWliosfAODzxvuiDbrC9HCytmLfzRnPOyvcOywSnq7CVgeBPTcIT4d8bqs475DMCxOfuGTHbrG2liOwadW+WOVCy3rLARsbdZG4da8xmx9TygbL++WynkpTf//dpPM2ged/CarDUW+SEsmRO24lOiMB9Eva/+FSXOoqD4stTFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHHd3d1b6gpGvERk2hwBholvC0mjpe3/uhOcS3bHfJU=;
 b=Yb+41DCB26e5e1JvL7XZ8zWQT52RH80wSTgDrvNayRH61/yii2V38VR2/KR+epIUhB8Qpc9ZoXGXTWhMD8spjppp3HWFVwGm+rCKy6kNfQUuwwoucBC67/0aFJweBrJh05AJ1Ywii5baVtKseYvRE2xFI1Jc+VeQ8KcViViYx9I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM5PR13MB1323.namprd13.prod.outlook.com (2603:10b6:3:28::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.15; Tue, 10 Nov
 2020 15:22:30 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::d55:1263:fadc:b6f5]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::d55:1263:fadc:b6f5%5]) with mapi id 15.20.3564.021; Tue, 10 Nov 2020
 15:22:30 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@esmil.dk, atish.patra@wdc.com, alistair.francis@wdc.com,
        anup@brainfault.org, yash.shah@sifive.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v2 3/3] riscv: defconfig: enable gpio support for HiFive Unleashed
Date:   Tue, 10 Nov 2020 07:22:12 -0800
Message-Id: <1605021732-268521-4-git-send-email-sagar.kadam@sifive.com>
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
Received: from gamma15.internal.sifive.com (64.62.193.194) by BYAPR21CA0005.namprd21.prod.outlook.com (2603:10b6:a03:114::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3589.9 via Frontend Transport; Tue, 10 Nov 2020 15:22:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 038c66cc-3370-413a-ab09-08d8858c7051
X-MS-TrafficTypeDiagnostic: DM5PR13MB1323:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR13MB1323ADB612F48E204720862197E90@DM5PR13MB1323.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnN7lcfo8koNmgJnMfrJxQM0HowSTIi40a8FlINdFXdj6956rYwouA0GBtXQ+dE+2Z+Zfy977QsNEcAqPveUn5eiMILR9qcL14D+5ousNti8PN6WjJQ+BLRSCOZ7yEljjAwlz3mqUlH1iBtihB0YJvctuVVOuCjFpV93fCmjlfqP+4jFIZqdg5ar2t39CwOBMnPPn+5suJjs2Apbwq7HQzWCZJ89vcaSOGQYUxrctqdDApFwnrzt7IogqazOcZSEXoNoGNRxVouq9t+vwvp7Rh9v3t9vszOB+lhJzRlgWLt4fnOdaauTvtQFBzl5g0a7UASCj/KKS8KkMCqbVvB72A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(346002)(136003)(39850400004)(376002)(396003)(366004)(4326008)(83170400001)(6486002)(16526019)(2906002)(7416002)(186003)(2616005)(6916009)(4744005)(8676002)(956004)(83380400001)(66556008)(42882007)(316002)(66476007)(107886003)(8936002)(7696005)(66946007)(36756003)(5660300002)(478600001)(26005)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bdNf7tZ0n+Gsvw06fLAWJk4tF2gHmBZnGewAjCbUeRfqlT+OFbOcQOU4yTpagQBi/8DTKKaUryjS553FLjsNRT1bm7cx67LI77Uhr43tPDk/su7c/97BVHyR/pFTKGuw8SzhO2DIMB0PVrQawLwi/axZ8OajgqCw3XveIatu0lvyGa1SVH2BXllUUpadrFCIxNt1RiOxweqNbS9HZpIgXtmATXxdZ0hOQUtZE3e8S9xVvFlzLReFYQNjSSoH/b9lWrYHBEYX8Wo9c5OunsJMWNUj3dPI3ZSvhdF8yx8vbo9oIwPB5BQij3ylyZK/1oLke52ycRvgskxetLLRItD//WHEhWV7d4unZu0erhKj4JmgtUqQ9zWsg4xT/ocSuOgN78CngJQzI2Kc8XoY8KecD+BLaDEocXaTi6G/37xMkua6E7kONwR7VEuEMOLdbSgifG0KFYMGqC0Z+aT6aRGy5YeC71uHoLC6iwMpH7zxEH96pkdhMPbo2COlPR3b2nXN48RUz4Z3csVtAQk6/MRsWk3pnjyMsiC+P2CHFe5+Ga7qXWfTLTj29ZuhZGjgB3jNTg/ZAvis6nDK/EDqxd7/HCsODgXARKOFH/85r8R/TpV5vbzevDLO4OkKNzPWLI9yt/bH6ZzlxhxfbtMw2Kl5E/d8YRXNiLrYu4zKJiyDOtZDQ5eYPEAIpCbWNJpqCJOQ/vJmJOBYH8sTQexNfIlVNSfJ7ZKBoJVG6u1YKoSktL/XqDA2edwKcvnY5FhgHPoPZfCzzXZJ51Z5xSrdRcXiVzwXld1rwCI4SgTSBi8oXbHdRzVsBH6t3uQTys9F9CUsI2VS7eNI+w29F9Wy00+WYJqfUnyTBnyRMf/bBf4e8z3tQwTpyPBAKZvyMB9AYhrtqk2wlWOP64CLFppAUdAC/A==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038c66cc-3370-413a-ab09-08d8858c7051
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 15:22:30.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXDY4q9uMdxuxSa6H5TlMzBtyPhMX/eFGDP04AMT7P6V3X5RUeYLXcF3Y/JMADrOO0TU22zgcg9epEt6YKk4Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1323
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ethernet phy VSC8541-01 on HiFive Unleashed has its reset line
connected to a gpio, so enable GPIO driver's required to reset
the phy.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index d222d35..8c3d1e4 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -64,6 +64,8 @@ CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_POWER_RESET=y
 CONFIG_DRM=y
-- 
2.7.4

