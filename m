Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9A2AB323
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgKIJHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:07:35 -0500
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:2656
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbgKIJHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:07:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWFJXnSonHCoo2ppgqnQssaRd/l8nS8PWE8+b6rDXpeVdAMqdDbc84YV7/wProII78ByBtdsDbOtG4rskZZvcjubOaB3Zb1Sg9ZIp/YEI+bKR51B7GY3FYKBQHOr0XVuKNH3pviT13RyLD2yaSRrsv2hghsnqDJY46y2eG/y52k93FQhmL3ed0R0+7p28bIzpYwr82+C26g/crSjYE5mBu2MfnAOMSVSkmH59BD1t0rjzHGNMx2eTmhH4OHHt/3EhZuKnpoYm/NG8KBvbd8zmpMy3GyMOwebGdaESc+oo5srHutSpv3AgkYaIaOd4AvNdRUqdh/ynpOJ31GLSf6QhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bhp/oyoWxEFyzMrN2G93pIjJLSPMqjG+d9vFlof8P0=;
 b=YzR+Xky+G9Ox9MOD063EXh4zrHDuA66DSr67P51h2Lm8UJXaXEqoGGEYVyuRDvWqgCc2eQ37Ld7qNGGpdH6YwOmpdIaG1XfzGqqftf3z/uvFEZ2Gclh9PdR38PcJDpuaiw9MJ++qq8tc5qagPzaowAQxEA94KWdhyK8GmgkKCgfnChk47kwk2R0mmSb81/0WwOZfkHpUThZNeFyfPmhMGoiWYYScA4HZTKNdHtOnZgjpvhYIonZ5z7UWaqupA/x/emO4yVcYdm3zUVg4HpkQg85/LoL5feypmdskcfjYP61icAbyjeOhu5FUfQLxOqJsD3h+ivu0zCssWuKuehuvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bhp/oyoWxEFyzMrN2G93pIjJLSPMqjG+d9vFlof8P0=;
 b=oK6y9MaFynqhKKmwKlZqR4c23mvJ6XNkSC320mQBJn8dvNNRyqztLlHO3GloSFVw09sThI3YdT+6deDJjJI0RP+iFBjPfbSjtIwDMPzpmyXtZWw8/+Nypnt7mbLWn/MzQ5B/tlbGXAHFgqY0is/4cKLO6xkB0kKREDzRIv7l/aI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SA0PR03MB5497.namprd03.prod.outlook.com (2603:10b6:806:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 09:07:32 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22%6]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:07:31 +0000
Date:   Mon, 9 Nov 2020 17:02:58 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/8] arm/arm64: dts: Use generic "ngpios" rather than
 "snps,nr-gpios"
Message-ID: <20201109170258.4a70c768@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 9 Nov 2020 09:07:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8de4d6d-18bd-4392-4ac0-08d8848ee3cd
X-MS-TrafficTypeDiagnostic: SA0PR03MB5497:
X-Microsoft-Antispam-PRVS: <SA0PR03MB5497126A0F9AC166F9A13EDEEDEA0@SA0PR03MB5497.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VAbEvp8VgnqbK/Ti86XU+0+mbjHzCh2qMPy1c+EYDFOyMoEu1gDG9/cVj8Og4avbWRG6rElcCNhtLs7aDCyv9Gjoott+1OB/+f3rmrx6h/p5sjlSCfLqCn16XvmPJ0ThrxLxT0iZPlYCGHZJV5tzI5NlsqWjIzqZEJ9NaxI0nSL4jmrs3ICHAH+l27uWRea119+cnaQ0gKbIuBj14Akxx2dSpkuPBWN8fEFyNTVYu2N01+x1RenVjXR37+3mnLR1x8uCFWTG8rcq2Y9Y0wD3rMzrs7ItKn0921oDRXXqsVB27EcGZA9GnmQ1mT7mdWeJljgoRNrjYaHnjhCkMTHA1qoINEuZnNLKHpPjVIAfoOIkjThgbgUShogZ2gTuqXw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(9686003)(54906003)(66946007)(52116002)(8676002)(8936002)(66556008)(55016002)(110136005)(66476007)(26005)(7416002)(4326008)(2906002)(7696005)(186003)(478600001)(316002)(1076003)(86362001)(5660300002)(6506007)(83380400001)(956004)(16526019)(6666004)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0HSZCf00dn7/dxnlCL0zIDVEktqaeQ5Khs7UsK0TUddlKSfiXThOHwHCjdmlQ+mmKtXK8dD9Jk4rWbjLeTskZFX7iQnLqkIzv5DdVkVtTZJCk/mDoeqSRKmn3CXOXNsl+bW+DuWMAoZQQQ5GpXjoY+s3cLxaV15T/juDWnZWw4iY8CnuYVhWlaRemduMNDYtzu96xy1e5Z0i54YviMA6PyTlOxytGnUn/XnFNp0agRL0OvoYwAqZpPIS5fDdYR9F2KusKgDSlRdt/ofli1+YyeUeO2cbI1AAyn7qHvSe2M/AE6L1qy3oD8QObs2CwCRr26kZ2QZgK6ZkI6D4ji6tZ/SFRWKW4rCv7kBOnuFMz6GcU6b1n6AvM68Ztt0PIVYDqmI2ZehTrDgWD+FkLxug7BidctQnr668yvhcgVgJtkW12Pi7+td8WZpZyJPWS5XvJAhyYBa0ryAIBFulktKOUFWaCTCSJ7xajTljh/t6b8yqWT0QfffrUJ8Z5g6y0htwFO7BGlUx9jY8AejQ8Tl9ykEXqFMepodMWaOW+fopCFZ8pUSIlHNqtpnJWPdigRzrp5Ygmgm+BvN+upi6v1epRw+2GSbRdwdbqGDBPin/aYMMO0DCn+Xw+1NS9dmbbnCbNhGYGUAT0pmOkna5bl3pJg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8de4d6d-18bd-4392-4ac0-08d8848ee3cd
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 09:07:31.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6TBySPl7CCtlady+5+vhDzDajJRrPQw/jCffdG1QviGhhkh/cDTS8e5phusgTIJASLafPQQAN2bCxA1XCywbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5497
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To remove similar errors as below for all snps dw gpio users:
    
OF: /...gpio-port@0: could not find phandle

Commit 7569486d79ae ("gpio: dwapb: Add ngpios DT-property support")
explained the reason of above errors well and added the generic
"ngpios" property, let's use it.

Jisheng Zhang (8):
  arm64: dts: socfpga: Use generic "ngpios" rather than "snps,nr-gpios"
  arm64: dts: apm: Use generic "ngpios" rather than "snps,nr-gpios"
  arm64: dts: bitmain: Use generic "ngpios" rather than "snps,nr-gpios"
  arm64: dts: hisilicon: Use generic "ngpios" rather than
    "snps,nr-gpios"
  arm64: dts: agilex: Use generic "ngpios" rather than "snps,nr-gpios"
  arm64: dts: synaptics: Use generic "ngpios" rather than
    "snps,nr-gpios"
  ARM: dts: berlin: Use generic "ngpios" rather than "snps,nr-gpios"
  ARM: dts: socfgpa: Use generic "ngpios" rather than "snps,nr-gpios"

 arch/arm/boot/dts/berlin2.dtsi                    | 12 ++++++------
 arch/arm/boot/dts/berlin2cd.dtsi                  | 12 ++++++------
 arch/arm/boot/dts/berlin2q.dtsi                   | 12 ++++++------
 arch/arm/boot/dts/socfpga.dtsi                    |  6 +++---
 arch/arm/boot/dts/socfpga_arria10.dtsi            |  6 +++---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi |  4 ++--
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi        |  2 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi            |  2 +-
 arch/arm64/boot/dts/bitmain/bm1880.dtsi           |  6 +++---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi          |  4 ++--
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi     |  4 ++--
 arch/arm64/boot/dts/synaptics/as370.dtsi          |  4 ++--
 arch/arm64/boot/dts/synaptics/berlin4ct.dtsi      | 12 ++++++------
 13 files changed, 43 insertions(+), 43 deletions(-)

-- 
2.29.2

