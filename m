Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE46C2D3D29
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgLIIOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:14:50 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:30526
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbgLIIOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:14:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFLLoocanpNNk6zvUjvZOY9ATXlMjw5Sc+HcYXwi++kvVRhb9daohWL7loHTq2vik8zyqHH1mfktvLJnwROH9dzinGbsrrscvQHERAm4TSQbQQ/gzvu87vaNee2iNvnhalwYf7Mgkgr2WvdO2GUQ/TqjcLyY9SB/vvUbo3KlRDRPY0vRAaWRngBFSZhDTS/ivlPrl7f1KSrU0kC60nLFIlWnsXmDzOd9sLyiQnyag+EGcp1MQCEm9lVc1VYS2MlaELprgFkL7CoDrRMao0npfLdg77Ic6fLG2ri08ipGEtgJezYDCRQde3cNhYKIp4G+z54hG29oG7NxkroMv/km5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miZXG6JRdR2qUlsdCNAWGOma5DsF+RuV/cmizD2H1JE=;
 b=jvY5P363WrgZGrpqowbopsqoPaG2gnn9ScyUafcHvuItWfKcm/aChSxtQVhh0GpReWk2dFTHmX/34zdvB5L73WDQ5c7+yLoyapkulAroVgWwyfusnGCOe/BhmDGelZItkgjp8YYBgHePnV5Tp7P2yBD4QWelmgr9WpPzY/wnKyHjPexBzW3r+zd1uZTsgVEg7Nx7SNEjlM97z9TYRjRheay8lN/TPx4j4O4d4mQMR7lIDKd9EaZs8a41gXCBCBnuFBHsvp/ngZAxfDLqFidHNFdayrl6u5xkusAhus8qxWnd97qqXWqnp4Um70/1kXNGw27U8KJWurXZEDKVN865UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miZXG6JRdR2qUlsdCNAWGOma5DsF+RuV/cmizD2H1JE=;
 b=Qbk8xWsupiMQRhWvf/zwzBfhL+ed9jFm3xi3kXnDyf6CcZkTwhm4Z9Zvw1VRHRb3QaTmrTIwbRUSnxWiVcwqP5ZPUS/hhDBHuPu2PDFQmyhvT+BaZX+YNQbMGvhH8OPErlbC6CaqVHldNbfhfreVwNd/S69nWBDrD6ZxBtd5jEM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 08:13:59 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3632.024; Wed, 9 Dec 2020
 08:13:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        van.freenix@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] tools/virtio: support aarch64 cross compiling
Date:   Wed,  9 Dec 2020 16:42:02 +0800
Message-Id: <20201209084205.24062-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR01CA0122.apcprd01.prod.exchangelabs.com (2603:1096:4:40::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 08:13:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b15839ee-6508-45de-b71f-08d89c1a6179
X-MS-TrafficTypeDiagnostic: DBBPR04MB7515:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB751534F3D0014BE95FEC94C8C9CC0@DBBPR04MB7515.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ct4BewLFhKZAdtjOAQPZWshCuHmBTuoPwxjVdswuU0V6mBZP23SFIkHqCgXhxaFoc+UYgv/j04ywBOu+3j+ISdA/N7+nmmc3SBW9pGK6eoFEoM6fgW/HDGVF5m1p8c3fe3ik1mFanrWYiKhbd3tiA2WZ0f60ciI/aRaL7BONki4c2p37XgVhNvYOSwWzvgz4h5KVJSISTQ7lgWJrXFdN5ajsDJLE8i8Lx53WLnBZDmdpthzz1ujqxygasOcgdBaFIhQ3eWH7S1q4ltgD3cZ29E3fUIia1Qh9ct9pzHoUFFGJi4b83BQ59/06SO/nfRI1dQEqVw/rRoqF4ZsIcdQJ+1JQe9ci8dwQublJtV1/RobJFQR/5jaGzNDD7vM+Vbml
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(66556008)(8676002)(66476007)(956004)(8936002)(4744005)(4326008)(1076003)(508600001)(66946007)(6506007)(6486002)(5660300002)(6512007)(86362001)(6666004)(16526019)(2906002)(2616005)(83380400001)(186003)(26005)(34490700003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dCczWaKxMO9IZl6dtJqZutbpB1Mf2HaUNgU61c7maew7xxI5L0890go2nlxo?=
 =?us-ascii?Q?L7DtCg0gPg473gQCPwaHguxjCUsW+FQEhK1q7ZjXQ3znNF4aUJO/zAYiWHMC?=
 =?us-ascii?Q?pChBGL83cQViTMdLfBKe+aG5sMOz/Xc/QWpLmRZV/CBRgDb+3mn7Ta7kD3zO?=
 =?us-ascii?Q?zgngXss3hTEAGGSgGkUDVMc4vohOXj0B5eS7ZkrV2gD+8MHGedk4pw+7bGwg?=
 =?us-ascii?Q?Z+N/rOcBAsH/3vdMraxjNoPA79YBTOWHpdZYj+HYuesJeGG0CeVStL8WF8it?=
 =?us-ascii?Q?l6aqn66TmYxfH1dK79hriu6b02TfxO02ORYmtKt7+UupT9Nn6PCcRX8O/9YR?=
 =?us-ascii?Q?+79hh4jyx7h97G5HWh5h2TlyFZNGErMIyr157mcdg5cFwgC/OWQO2RzC+X1v?=
 =?us-ascii?Q?aahCbTbswNToGEjmxaT0mQpCfWIzSbyt7FUqOTPW4fL+xUWaF/2ln2vC0LdU?=
 =?us-ascii?Q?mQvXSO3+sMaXkw4EdG3ZJAfrtE3wCa/1SNWlQkX7BYYNt1C7bZWPetUsXrw9?=
 =?us-ascii?Q?KQPed6qW6zsg8kwVa2PFwwiKtkGcNwMbeNCpcOxfO82zYqAC0mxVexLomO4A?=
 =?us-ascii?Q?XXAUr732otlk2d8h5RDI6E+Aro6pahwYnFdx8agmBQWTqfgG6RLb7jcRyINM?=
 =?us-ascii?Q?O/arGpWXgGNCj3Bs3BKpGZVnEVFH2sXFLi3ymkYD3fMhAuPV9mf6tZpGHz0o?=
 =?us-ascii?Q?XYq+tQNgXy0ywgejzQioeq4uTnRAV70o/GCYgrSqWir2WJaKcrQiaBI1NApa?=
 =?us-ascii?Q?sloLRpaTmuDPh5Fa42ZPoVn5N2MukQ3pV+c10B9vHZT39FgZ6w2Yco4m6Gpi?=
 =?us-ascii?Q?8cPfcRjBJ0GCxyxgMsJj77qynZ54sCKE9J2YBavVF9xRQEbrzHLOy3W1o8zr?=
 =?us-ascii?Q?xxC9bpgUtOW3qDhYI4olTjNicYqI1U6POwICDdKbE/XGjnR5nUTYSFJ3nrGS?=
 =?us-ascii?Q?tqx9o0Tz9DtSzpT410wdQnxqFPAcJAYU9NP4evCMSJzzfDjH7IgoEnIDV1md?=
 =?us-ascii?Q?hAH4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 08:13:59.0844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: b15839ee-6508-45de-b71f-08d89c1a6179
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVZM61ES9Cyhwyu6LR6R518AgaMP27IqmLQETiRiyFcyQqKVaFLBaxzxTJRW+qYlX+tSh2ApbL/B86ga8IY0zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Not sure whether this is correct fix for aarch64 build, just a try.
I still need to drop -Werror to make it build, but not included in this
patchset.

Peng Fan (3):
  tools/virtio: include asm/bug.h
  tools/virtio: add krealloc_array
  tools/virtio: add barrier for aarch64

 tools/virtio/asm/barrier.h  | 10 ++++++++++
 tools/virtio/linux/bug.h    |  2 ++
 tools/virtio/linux/kernel.h | 13 +++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.28.0

