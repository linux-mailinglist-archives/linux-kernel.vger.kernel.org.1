Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FA028E769
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390847AbgJNTgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:36:43 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:48384 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390799AbgJNTgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:36:42 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09EJOFvY031201;
        Wed, 14 Oct 2020 14:36:37 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0b-00010702.pphosted.com with ESMTP id 3439x032h2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 14:36:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do9oTHt4UJ98j9N0beodZ/S+S8436VL1/ojJPyt/NWzpjoeMaLkrVH9eb7P/R7VaOrFURNKqFXQOx5ljoDKXTVckFru+4ikXoXohZo6I2RO5HDGSDvwAQ3BTlllNjqE+mmrYrkRbdugWidH8vSsKy30p9LX8k5nBAAX4/RaYsLIAGLkWyt42qFBBHroWfhyVCRtz+Ri/Td5GmXN65+uAaPFDH4BUp+K7PuuBRFnszg69FQYUDdJruvRy3V+6QRtFuS3BB4zCxeeH7eAAwmBxnc3HcfgoQi6ZB72LEOxPhwlbarrycbz3NcbWpCRQsQ0jxG0Gzm0gOFsR60tLTMPXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geguh3SZSez/cwRvHsMM9axattbuMecw3p+c9P/ObT8=;
 b=k0KjDdpfAyTW7WN708vXPZtXUBABT1oQG5IKX8ME+en75EU68e7QNZRxVFdZFcfq2VwDxvewOrjqxLhJJ5TmWljraTZQpgLPbVvwAQbPNVh2wXb3lw1m3LexKPj0Lb+GAzgyOTa623xqiLp1Pie2DBXtlJNYWW7gh2RVoMcHz4eb9hO3kYjd3F6dEfMSsXj9dXu0aqDYAnZ8uEO6FpkXGjcCDjcKFwjzkgYL09BW/xnLPkLriVn4G4Eyh7k9lxpFH2pRVMXOvBkjYJgMUvasiqvrH+w4/iHFnA1B8P92fio23H4c0syCakvGtNt9MmVR3i6n1z7joSacWzftLabY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geguh3SZSez/cwRvHsMM9axattbuMecw3p+c9P/ObT8=;
 b=oTLSlC7OaoJJx4eMOtJciAW+KuAIB35V5pVWXMiOZkMUPKT/MfdBp3oKjzVH5VkRr3xBozr9lfRcg7FhSPa+KoBGcd7p005ZlANPns25IOv9Bnzm8sCRmfyV7jsFx20wHJ6reIFTjRlhlSRB94ZNVtd0O7qAujhPR+SQocrsYvU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB3854.namprd04.prod.outlook.com
 (2603:10b6:805:48::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 14 Oct
 2020 19:36:35 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 19:36:35 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saravanak@google.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Michael Auchter <michael.auchter@ni.com>
Subject: [RFC PATCH 1/3] of: unittest: add test of overlay with devlinks
Date:   Wed, 14 Oct 2020 14:36:13 -0500
Message-Id: <20201014193615.1045792-2-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201014193615.1045792-1-michael.auchter@ni.com>
References: <20201014193615.1045792-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43)
 To SN4PR0401MB3646.namprd04.prod.outlook.com (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 19:36:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70b02257-a885-4aee-468f-08d8707875e9
X-MS-TrafficTypeDiagnostic: SN6PR04MB3854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB385436885CA01B7DC693942F87050@SN6PR04MB3854.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFrNhtvYEGzAEkKTZBwJXKv85U2xger5bqnEjUhGAijFBBxGxQhB998SW68ENln/sbTeDzQ7ZWZ1Y4yyMME0XapknTionGVBWqju3TSgddmt+xSCirFR9kV4mNt+fvfJAIHFEtb8LVa2rkE8kJBBTxv+HWhbnQubV1Ji3Kca8pdw5aqv0vOeyknQV6FCRzfoiZYMw12sBUl+Wj2qxDWJCcobkue7MyQys4l3SXjPd/XurhOgYfbcB/hcOxNyBXVdPT3flLbt0DrDIrzZ3mfH6fq5m2/cGjBVx1nlC+eGNczRMTJW6I9ap9su5FOkKaSUr67og1Ho0qOpg92PeFX3R2zm2teHeaFgLpZUaZfKaU/qxotcGbtMEpghlyReg2gi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(346002)(376002)(186003)(16526019)(6506007)(2616005)(69590400008)(66946007)(83380400001)(86362001)(66476007)(66556008)(8936002)(6666004)(5660300002)(1076003)(36756003)(4326008)(6512007)(2906002)(478600001)(6486002)(44832011)(52116002)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: jgbOZGcfTCIVra7rKXFzssqPcQBkbZsJq1Oa5zcjWKoFMbSYvToLh9VGphwscy4SIqsBiG+mQzwCs2ymFKwZ/oPKrrGq4P7h7xH8/FPKDr4VP6vhie8KOTvOtJSXTYtyTffhJiUqC9rxAL2uvZJC/c7unBT30E2TrmXrciECaA8Elkt9rGa8d0ezp+DqV6RBAU5Fe3OxrN+vUIX4VDpKRcey+9vKQCVmD/ihfOeduT4qFQKJOgxAI6ujRbJXmee5c0pUHHLMIcKKk7llsDT3pP5neK/C5rEBgRDk93L9bSEA0j+8f6yRtCeuMPIJaazjcxx2xp2W1wFp5sfYw53V1GYTY1OuvmRrxfq35sbWe8tzv5Xd9zTD/MsiB3l1BoKaQyur34XVgd0Os8Ftfu6mrxG7NKO6ndnZZqrI5ipWioeQlliqoWqowDnMa5UIAmO662Pfb7FwUKgdBKdtE5sFbzq4t8HLSVQCgaK2ZULeQpcZ4OqCyITmH06b9ZlQ90nbyQ/Fut7+AMwy+bDtASvlFuZ9p1hzV6a6BcYZ9B+RRZeiiPodJunisdn3mzVrLnvter36lcliiwGZVi0LWJKje070BkW5QFvcHm90RJ1MQopPnu70jDW2VhfOGT2uuTBNpLBmMwbkhWWVqXsbl+eVnnon/NqCJCx1UIrVZVrzi6vmfsKsAIZa3AR4tQ7+t9779CW/YHN0rAvs8qoISDTisQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b02257-a885-4aee-468f-08d8707875e9
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 19:36:35.1152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMqtVrryhadwpsmUKEx9BPbfQZRA3Cq9tntoxw0OTSPLD9NIHnx9K9VCxNhqiPg3ett4rwJaY1aD2LBYNCVQBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3854
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_11:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010140135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a unittest to test applying/reverting an overlay that contains
a link between two devices.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/of/unittest-data/Makefile       |  1 +
 drivers/of/unittest-data/overlay_16.dts | 26 +++++++++++++++++++++++++
 drivers/of/unittest.c                   | 16 +++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 drivers/of/unittest-data/overlay_16.dts

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 009f4045c8e4..91a1ebbc451b 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
 			    overlay_12.dtb.o \
 			    overlay_13.dtb.o \
 			    overlay_15.dtb.o \
+			    overlay_16.dtb.o \
 			    overlay_bad_add_dup_node.dtb.o \
 			    overlay_bad_add_dup_prop.dtb.o \
 			    overlay_bad_phandle.dtb.o \
diff --git a/drivers/of/unittest-data/overlay_16.dts b/drivers/of/unittest-data/overlay_16.dts
new file mode 100644
index 000000000000..eda206e2ebca
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_16.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/* overlay_16 - device links */
+
+&unittest_test_bus {
+
+	/* suppress DTC warning */
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	unittest16: test-unittest16 {
+		#clock-cells = <0>;
+		compatible = "unittest";
+		status = "okay";
+		reg = <16>;
+	};
+
+	test-unittest161 {
+		compatible = "unittest";
+		status = "okay";
+		reg = <161>;
+		clocks = <&unittest16>;
+	};
+};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 5579584758b7..d94dafb3746f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2369,6 +2369,18 @@ static void __init of_unittest_overlay_11(void)
 	unittest(ret == 0, "overlay test %d failed; overlay apply\n", 11);
 }
 
+/* test insertion of an overlay that references another node */
+static void __init of_unittest_overlay_16(void)
+{
+	int ret;
+
+	/* device should disable */
+	ret = of_unittest_apply_revert_overlay_check(16, 16, 0, 1,
+			PDEV_OVERLAY);
+
+	unittest(ret == 0, "overlay test %d failed; overlay apply\n", 16);
+}
+
 #if IS_BUILTIN(CONFIG_I2C) && IS_ENABLED(CONFIG_OF_OVERLAY)
 
 struct unittest_i2c_bus_data {
@@ -2757,6 +2769,8 @@ static void __init of_unittest_overlay(void)
 	of_unittest_overlay_i2c_cleanup();
 #endif
 
+	of_unittest_overlay_16();
+
 	of_unittest_overlay_gpio();
 
 	of_unittest_destroy_tracked_overlays();
@@ -2812,6 +2826,7 @@ OVERLAY_INFO_EXTERN(overlay_11);
 OVERLAY_INFO_EXTERN(overlay_12);
 OVERLAY_INFO_EXTERN(overlay_13);
 OVERLAY_INFO_EXTERN(overlay_15);
+OVERLAY_INFO_EXTERN(overlay_16);
 OVERLAY_INFO_EXTERN(overlay_gpio_01);
 OVERLAY_INFO_EXTERN(overlay_gpio_02a);
 OVERLAY_INFO_EXTERN(overlay_gpio_02b);
@@ -2842,6 +2857,7 @@ static struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_12, 0),
 	OVERLAY_INFO(overlay_13, 0),
 	OVERLAY_INFO(overlay_15, 0),
+	OVERLAY_INFO(overlay_16, 0),
 	OVERLAY_INFO(overlay_gpio_01, 0),
 	OVERLAY_INFO(overlay_gpio_02a, 0),
 	OVERLAY_INFO(overlay_gpio_02b, 0),
-- 
2.25.4

