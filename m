Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F392AB330
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgKIJIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:08:16 -0500
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com ([40.107.92.84]:8848
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729882AbgKIJIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:08:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMHXGaiOG7h0YsDcXesx9Z471xLWB7+gAcguZwlP/7+2wipLSByKfK9bkTH/PCf/JTKGycQAoKYzAnokW/rz3xabBPQkhJs7nFEKj0OlpqCBMSC9dtX6ziY5Wi7hc+MKUw86IQXorqv9ByInXxbHoCpafIkhP/XvGOW3/pFvSjrAsHZxcMwP9hf7JjByNlVa9k+KiYTRF4IWlBzkhJRYgTCYWkcI6Bl3A8ESyF/v+PtRv46W5YuODD1bvUCR8IP4TiaHKTDP20im0vbQcpQh4EA0HUp659z21u9sMW1o1pG2pFiALPmkM4IrRo9eMrMD8/40Ah91T8RKt4EwEBTC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HifD2sJV5rwTmvgQIMsNM6GrO/yiMfq3SEuPbcrW6ek=;
 b=RYqHbQ+u4z5Thj1rNAKxEFDe0HlqVGFd8DwlBhOyNa+idmUjPaL4eqiP0xnQcymDDbWLgAkH8uO6+yEBOnpxF7s3E0pdZJO/8mCgxeJAJVdrqk16jvAsz8//2x1FO7IrTggT43/0Wic6bepzdftxpxCJM4gXhkEtELRWYPDuQimqlXB49W7l6BJxBrMeSGOrpPrwYjONgc+3y9UkMr04Xn/Pe1VzJ0SOM2Nt/51bIfK8yei225ZLi7HtLubqGNvnLYvdWMSfMDq95MYrVml5jrqQ5ZzeCU9v8SOdoANnQb+zqQNVRutpsQrIIFruPzRo5rhgLvM7RgfW2nIeykqqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HifD2sJV5rwTmvgQIMsNM6GrO/yiMfq3SEuPbcrW6ek=;
 b=i2QIMl+cgs0QXx39CmPKWhNmZ8dLyItUbydN+J07kf1E4F/4NhRtLEQZK2hQocvdYU5BfAxB9/Yb8ovRpV7sIkID1Mzl7QnyvlUFsZOJDBVwhcUmgtYqXzDJk+rDKOJEU82kGFVYoCgTceSsd9kilEJ/eW341uACdvWWrJUrFMo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SA0PR03MB5497.namprd03.prod.outlook.com (2603:10b6:806:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 09:08:14 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22%6]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:08:14 +0000
Date:   Mon, 9 Nov 2020 17:03:35 +0800
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
Subject: [PATCH 1/8] arm64: dts: socfpga: Use generic "ngpios" rather than
 "snps,nr-gpios"
Message-ID: <20201109170335.00a0523b@xhacker.debian>
In-Reply-To: <20201109170258.4a70c768@xhacker.debian>
References: <20201109170258.4a70c768@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 9 Nov 2020 09:08:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 209107a3-05fd-456c-765d-08d8848efd32
X-MS-TrafficTypeDiagnostic: SA0PR03MB5497:
X-Microsoft-Antispam-PRVS: <SA0PR03MB54971FFC39A1CFC1D2ED88DCEDEA0@SA0PR03MB5497.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZX4j9pIoWpn77aUgxvloWQ/OXPtGqXuehaFMHs1A37KvUokvkVi/TrGJm80B/18biQ0iRqvfgrEpkBGRolGWO8QdsZS9OoGLAE442CkBZ2clXqQ4hXbTs3QoIdxc+dB6G8X78A6wiLOSrJl07XpQsHtLDhkmp3CQKJo1PQMRlYLYEOXmwEUSJ4pj/hcDbCi8f2jwINHU3Voj1vCmY955uKXANc2VVoD6s8RqydeAs15y00GhTzrFWV0ZHDGkVFr6k0OHylM5cO3Hlllf18gMM2Q960fANpdZ7nLPCoKi6nh5CMwrKC3rWJRcwLxOKH/aGkxTEMORnAY1Tm6OQFVteI/UmAMTXHVGWJj1XBsosYcdb7BAsWsHHSewL3yHcYW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(9686003)(54906003)(66946007)(52116002)(8676002)(8936002)(66556008)(55016002)(110136005)(66476007)(26005)(7416002)(4326008)(2906002)(7696005)(186003)(478600001)(316002)(1076003)(86362001)(5660300002)(6506007)(83380400001)(956004)(16526019)(6666004)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BeWXDTLe9Gd7ZsWmesYpNXey9MNr9EpSLVozWuFOq+My3vfq+k6NampKqn4gfg2aL36tww3g+B1dcGbyjoA17NagjLldPk7hz2nXffJ6a7CuU6Q4L+Z4JSTyAacJ8e1jR2B4dYjdu5Xb6vpftZukIJdLiKXS3ckMZrJ4m9ljPZaXN0iiTb+nWYfGLkfECnxtQOj31KPlFr0FEWQR8QN998Q4g9KsRM/2+F989rExKfCKvWwBs0XPvhkY4cBmsLt3coZ0M7eXuQH3ayqee1ZkST95igXSrMDoYc3Vx8AmozdZ7jLPWqIWwP+9SlHGEy8KGpYXXGU3T8/9N/YAzs1odK2mLJEUFhx+H7SbX3DgbcTaI8wR2aa4afh0i8ilFQ/UXDuUuLtu1gVbLVaVab70607uMDqSGm9R6wh7q0lXoYxYiPVIctTOu7CubqElLeyYTzA12kWPDenDYaOaGdJVlIOyQtS03zokXNcw3JchkJPlQQtOv90XQ+VmLR3MdTljZz+a/XnAeAqqWopUdfknHNM/wyV5sikYk0Vpt7NAbBh97vwsqk5dFJ7sIo/Q+XXxUC7PeU4e2D3rSRlr95wh7mqqnMb12S3v4EygpZ82u6zvK1sS0rlgoiqDpuL3vsoZJbat5ho+wWG0d/JsbPnaQw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209107a3-05fd-456c-765d-08d8848efd32
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 09:08:14.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17B52sJpiM9tZKGJxrHhXdhqylQIl1+dI8ASK2KNzqxFha0dyei+ChAEqLuDX14uiPSRMznBXoRh7zcFfj5MpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5497
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to remove similar errors as below:

OF: /.../gpio-port@0: could not find phandle

Commit 7569486d79ae ("gpio: dwapb: Add ngpios DT-property support")
explained the reason of above errors well and added the generic
"ngpios" property, let's use it.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 0f893984c256..d301ac0d406b 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -203,7 +203,7 @@ porta: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <24>;
+				ngpios = <24>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -223,7 +223,7 @@ portb: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <24>;
+				ngpios = <24>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-- 
2.29.2

