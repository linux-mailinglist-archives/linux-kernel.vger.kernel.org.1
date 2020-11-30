Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968F32C8332
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgK3L2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:28:31 -0500
Received: from mail-eopbgr30126.outbound.protection.outlook.com ([40.107.3.126]:40594
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbgK3L23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:28:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERSdmeBZufdbqjnCgSjyipOVNVQ4DLin5HdPiGc8nzmBDNug688ZyYPxB55R/uzcY9J5Gdki6XgPTcSk+763zDDJdfx0HZ+lylJrBkQ5YTmk0SnGJdfhtlunixLxvlQC7OFib+JXJdjgh7/jEQJGgiUyPek7e0rNuUjT4PCOTbQKjJV8YSc01js1uA3DJoz7XE6nP3xT+leX+MHzTz/xHx5ogrml4gWh9ZjixLuauiaUlmwyZYtvyp2GUBKdYJd5LgzO1wIq0FuL5sDAv/1A+FEl8OVQimW6cby4DH28CZiof45ROzPm5vVH4GNewpv57kM+QEA6xHeHidjQfYfuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP0NF9LWSwkQIj9p/lJqQqR9oz4rMdmmeo5wQFoMIsQ=;
 b=G3z+p2N+NePCc8yQ8UwYHzKYjIG3CbfR4yUmVZfiWYnSyWAxe9mIBToSsbKm2qO7xXtDXX/qX0tkLf0AkVBY+benJHy3Ymz9GzwUDOXWLox1AXTpWElq0jrAd+NaDnJod9w7AjrHknDPWFFDa/bKUx/yrARsT4wAQ83lTbyCXGVe6PtNFTw+BisULgOowENwUfsyYZwkLEGsLKN7mNsnUHGKd3OJvvLAqDj+qKp8QqWGPS+/+anXUdT0Jr+F5CieZDWBFjpnxlhhGX9cE5R5LuJkeY05K82G5FOpXHrbYR9IxTbZSLWMZH5nL6rYjVMoN8hgQEBl8X6Aw8il/wbdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP0NF9LWSwkQIj9p/lJqQqR9oz4rMdmmeo5wQFoMIsQ=;
 b=XQWAKY8IL7zAit/NQ04CujkjfRrBUJiPSwdiaglBjNtAwSb3r6WF4kHb0G+sliPoKbYv8stX2a+8yl580iBqSsIrI0walYaEpsHMS7ronqPDL97A2wFsh1KtMijyMxjIGQyKMCK8VpDv4IZ6uolPo4ZxiLjR1AdluUHj867YOyM=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=leica-geosystems.com;
Received: from DB6PR0602MB2886.eurprd06.prod.outlook.com (2603:10a6:4:9b::11)
 by DB6PR0601MB2455.eurprd06.prod.outlook.com (2603:10a6:4:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Mon, 30 Nov
 2020 11:27:39 +0000
Received: from DB6PR0602MB2886.eurprd06.prod.outlook.com
 ([fe80::49c3:4b5b:289c:d62c]) by DB6PR0602MB2886.eurprd06.prod.outlook.com
 ([fe80::49c3:4b5b:289c:d62c%12]) with mapi id 15.20.3611.025; Mon, 30 Nov
 2020 11:27:39 +0000
From:   Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, vkoul@kernel.org, geert+renesas@glider.be,
        Anson.Huang@nxp.com, michael@walle.cc, krzk@kernel.org,
        olof@lixom.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: [PATCH 0/2] drop unused POWER_AVS option for ARM/ARM64 config
Date:   Mon, 30 Nov 2020 11:27:29 +0000
Message-Id: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [193.8.40.112]
X-ClientProxiedBy: ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::10) To DB6PR0602MB2886.eurprd06.prod.outlook.com
 (2603:10a6:4:9b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.112) by ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 11:27:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: adc8b383-ceac-4de3-49f0-08d89522f1b2
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0601MB2455667E652ECA87E007920CA6F50@DB6PR0601MB2455.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Li3HEVUE0r5lznIOQGKlIAchDkWfFUGEruY6V5nEePC/vNbe5lkuBZzWO9s5GeANZorkcOdfbqwfNv0twDxZJHtA/HRzgMif3nNkkihehmAgSTlgAKgR0gsoLGqpqm4B8sLtkFAbsN4aa8Dx3kEhN+OOJ7+sQcn6PvwzVwRMoc2o1czt7bUIOnrAWbv34h0f2Suq67abJHKkQ83Y24hyxWb4CLNuKUxQt8/T9sSXz9dq4swvUpy2mDYSgZ/Qday0QrNt65KE3DlTid79+rVfaK9Eg9sQx3QNHuetP/Iz/liN57dON9+rQSgPEPywS2EWfwJKMg/1ieEs1aROxBqDeAUmsHTun5HOpasuePAyDoM8O1LkVcCvPGtMC0wwp/8P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0602MB2886.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(6486002)(86362001)(83380400001)(6512007)(66946007)(186003)(26005)(66556008)(66476007)(107886003)(921005)(16526019)(7416002)(1076003)(6666004)(44832011)(956004)(2616005)(4744005)(2906002)(4326008)(52116002)(5660300002)(8676002)(6506007)(8936002)(316002)(36756003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dvt/XhyiD40lWwZ5Wp+guXkgAxSclB01K/xhAEum16bTg9NthQVjRQunKSOX?=
 =?us-ascii?Q?nonWPgHd0TGZy7w7yYTR+vrt0HPFEU5Y2OH9CNMGdvkD7eWJxzFUpNHyJyQI?=
 =?us-ascii?Q?LVpcI4mIFIXkAfXub6/0TPFwjjVYsi4Gl7n69EQYDHOkoeooLAHv85azfTNc?=
 =?us-ascii?Q?9AIYVrNh+ycQJlScqjCBGG0MO3I3NDramCSLFlxcTticFNMBAdiLVHopMrTs?=
 =?us-ascii?Q?szS1xDcq4u0sSSZTMBis2/CJPzOXD9VaZ7J2HnToo54F6tfl234i1d5UIpcW?=
 =?us-ascii?Q?kPws9sIC4jOD4EwsDvCL1Y/Ae5kMWHRkTDiaMzm/dcizvsimeJ2T6T/G8Bzz?=
 =?us-ascii?Q?CQwOLhMcubOKAQPg0YYQWr8Qax1v1GezGozFpafd1DfaS9dGLD1LWThb3Opc?=
 =?us-ascii?Q?r4pMYNH2809S6dOBN7J+zgUT2lmeZQ+qHaWMLrgR1MLL/Fbi/Fhgh1k6GxsS?=
 =?us-ascii?Q?n/2xNSl3CemNXX7/LFxwb7/bFmZOi3nalxQIwAmqbOfZuyLg90lgjgMB4+kZ?=
 =?us-ascii?Q?rpLStnITb/GsTSSRoNfCzoJLcpCoxndi6VgB+i/F9A/5N2Adl48heeZ+zFcX?=
 =?us-ascii?Q?erLRiIdxl8KDuqqxoK0BvXNgHHAYUxvuhKUz1D1sIsKKLdrzxKnP4mg2piYD?=
 =?us-ascii?Q?rOCeGRXjejDrxxf6P6FejsuRRtIdfiLyM+jDIKVIIw8q4ltKBU3dauFZdX0h?=
 =?us-ascii?Q?YY/TxZF9BoAkV4CQTfeGX+j0X1rSo9KAPODeDbR3Vo8k2m1Yxu+x5LSTROK5?=
 =?us-ascii?Q?VLuo1ow3cImhjtiuOsWsxD84FnT3J7AWbmgQwSp/J9EbHmg4R7a5opyFxhXW?=
 =?us-ascii?Q?hkgiv/Z+8kWsqZTMgeoTh2IxH6+z6WZqs4BkL9lWVuKKB88vlZAjMaor+ZTl?=
 =?us-ascii?Q?CixkQpau+iPJIaXnsmihJ9QzCzpKDvAS8+wMQ4+GPvB0R0Yr+wa4TWVb2HSs?=
 =?us-ascii?Q?JgR+4eSIDWNkxa03zif+lXLvPPVzFMQYV9F43Egy2fvJ6dH0FS37cyGpo+bk?=
 =?us-ascii?Q?RZ7y?=
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc8b383-ceac-4de3-49f0-08d89522f1b2
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0602MB2886.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 11:27:39.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0SDnnnEmYX3wmjgdoDwnxvI9cngaCRA07q8k6cgTlZqIkQxsmTX2dRVfX5Koiuqo47S1cCNYnu14eDIuj2oHBHw2DV1vd63CiRFxZdT9Pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2455
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up kernel config files, removing the unused POWER_AVS
option.

It has been removed in commit 785b5bb41b0a ("PM: AVS: Drop the avs
directory and the corresponding Kconfig"), from the tree and
therefore should be removed frorm default config files delivered for ARM
and ARM64 builds.

Andrey Zhizhikin (2):
  arm64: defconfig: drop unused POWER_AVS option
  ARM: multi_v7_defconfig: drop unused POWER_AVS option

 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm64/configs/defconfig        | 1 -
 2 files changed, 2 deletions(-)

-- 
2.17.1

