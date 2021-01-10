Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E0D2F0563
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 06:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbhAJFhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 00:37:37 -0500
Received: from mail-mw2nam12on2098.outbound.protection.outlook.com ([40.107.244.98]:11360
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbhAJFhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 00:37:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCAWPZJyJ88pnefy7DlLa+RhrQkAxwauEkIOROZQF8XsI8yOgBWlko75elogCe22O6T2hkrFKBrvcfurgpDJHH/WnxfMDVHTzJJfqsq5UBGXjh/aDyy716yWe/rX5qkoeCZgOFZAUKK7PUnS7/oD2dkguAxVzKSgAzL9waeabYzI/ZerV21hDjoHurjls5q70FSzRj8g5nWNifAQATf91C5dpabXl5PNgHDRtzLtKME96jM8ijhKUDMMShwIg2Aqvc/v0kK1aOGblnBbSqaaoly4lULmezwJYFYlfNxscab2Me02KhyFp9M6FdByjkS3XAvAoA3iWpKjDxaSqmvXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jttRjMqaxevqmozGhjkdg2/iQWV2VpiE5z2cU6zr1H8=;
 b=M5BMKD0oFJ/URHZusyTCuVfczF7hjJUZgQbKnVXdTPhiHhQm9+oLaTO/aM16ZQwYg0bYa/tEMvrq8kjS9iKrjYCmH9x00kXwbtFoii1x+55FnRd0VgEXjpFT3wJ5Q3mClWM1iaOVLWMFKBOnqS2sW2ey6mFCYLel6HEurND2LuOStzbIAlCUwT4w6SeaEctZ7ZgDXDqf0xgmWfArUchDdLe7tNijVwvBhe0OoOHH1spRSOXj9kFAXQAo3LnumBXKF/cHLz5Tfa2CT3kDWwoDm/FBs4y3wOy9mz60yg3YiozaE+TW8wf9ifIyaoUQqi0gC4k9csRIULg6rEZeYBLKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jttRjMqaxevqmozGhjkdg2/iQWV2VpiE5z2cU6zr1H8=;
 b=pKSDkMf6/64sOmkMmQZaZhC+KmB3qGZ1DwY8rJqEbbgV8i8PFSBlS4u7AAF46QC6YpcS+P4cnngmoWoGeOFV//Jq821QecVCSD7Aloiywyvvo940fAak2uOsY/FKf6IPsck6C8OlPCMRldWuPRZqtrYu1DN5C5Clo0fh0gtlxfs=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from DM6PR01MB4297.prod.exchangelabs.com (2603:10b6:5:2a::25) by
 DM6PR01MB4714.prod.exchangelabs.com (2603:10b6:5:66::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Sun, 10 Jan 2021 05:36:43 +0000
Received: from DM6PR01MB4297.prod.exchangelabs.com ([fe80::29c6:5b:9c33:7744])
 by DM6PR01MB4297.prod.exchangelabs.com ([fe80::29c6:5b:9c33:7744%3]) with
 mapi id 15.20.3742.006; Sun, 10 Jan 2021 05:36:43 +0000
From:   vanshikonda@os.amperecomputing.com
To:     linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, patches@amperecomputing.com,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Subject: [PATCH] arm64: Kconfig: Increase NR_CPUS default to 512
Date:   Sat,  9 Jan 2021 21:36:15 -0800
Message-Id: <20210110053615.3594358-1-vanshikonda@os.amperecomputing.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY4PR14CA0033.namprd14.prod.outlook.com
 (2603:10b6:903:101::19) To DM6PR01MB4297.prod.exchangelabs.com
 (2603:10b6:5:2a::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from con01sys-r111.scc-lab.amperecomputing.com (4.28.12.214) by CY4PR14CA0033.namprd14.prod.outlook.com (2603:10b6:903:101::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Sun, 10 Jan 2021 05:36:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f6af1f4-99e0-47f4-6400-08d8b529b664
X-MS-TrafficTypeDiagnostic: DM6PR01MB4714:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR01MB4714E025EDCAB069E89FEE679DAC0@DM6PR01MB4714.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0zatSNigb6ujpr7bE0ELLXKOVzj+JpvxjTg9ne+kVeqlrF5hUNFSpP1f9NcGzixaTrP1u3abfM1nO0iJlpJoV94sQPkYfwtjSbyHhbfYBCEisvGp8/LvyLxACRwGV8UU/XTXgS0kNpqMpzYMS0cuPimKOUmeepP0wH3YRXkb1DFoRX20JAAUStoH1UX98WD5FXdXsbO2WSHHyTcjlX43l/kkVn2Jw2qQsmfW64AEGhKbG1crbdsbn//wk5QqvNLrrQnkKKxJ6LqtqDuzTJJYFAs9+j7W6XuDKvFo2kTxGo0OzWaMH0xjzb0uA9Ed0NM3U7N2MGKwePLdBR3RCWQPDX8YK6gT3Zl7J7GZUeD2eV6BNDpFtuYccNipuZI1cFMjeIjPTdUEUiaEizsQ+Htpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4297.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39830400003)(83380400001)(6916009)(52116002)(478600001)(16526019)(186003)(26005)(2616005)(956004)(66476007)(66556008)(6506007)(66946007)(4326008)(316002)(2906002)(6486002)(5660300002)(6512007)(107886003)(6666004)(86362001)(4744005)(9686003)(8676002)(1076003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zVVF4iN+AEvcEfTbwQoKute+9mGXANkiXYCZCnidHtTtMy9f8MJKMBM+7yPQ?=
 =?us-ascii?Q?WlPzz4K7qKFe2phtLR6yYEMFpxjAUSLebOaDvs72CTt8cAy8cLxbwot7y9mS?=
 =?us-ascii?Q?jNXPVfpR3Ho3c2AT+XpRI5WVmpQqJEoAAjYSfhmldAzUqcahTmA41tyKaoS3?=
 =?us-ascii?Q?/ey/ucK1Lfk6H8mPxU3t/4VunZjBnXgZ2xRXwcOYPg/J778eNFd9pL0ASEfK?=
 =?us-ascii?Q?GmFv/BlsXKVefaD1N0X9rpz9M/A0XbE/2RjeZvudKqxYtKpvAQR44M5OzYgL?=
 =?us-ascii?Q?Hc0Pctbr5IqE0wkV5fJZbAIyaAyHMw9QVQeHp0bxbSmIWqCxvxRadxrVWk9m?=
 =?us-ascii?Q?ASeZGQSQzjfRsOgWqUXDo01yUEOy80D5JZ4yLKkmgJtQ3W8LUbbsWMKldSW8?=
 =?us-ascii?Q?YbwbgRQG2SRJAqGjNqM4RCdPd2cP52gcBoqyYFWCKW9U/qII4368D7uwdpcz?=
 =?us-ascii?Q?RDc9jeyo7p3SEB5o6JSd+YTwa6Rv1XSSQ/yLnzX1YdoDuXLNHxCCFtPJzJMI?=
 =?us-ascii?Q?ZDJELNw5lj7M0d7MpQIY5/zLKyaRWmEiqkZLIiu9b7v8OzzPPfPbJr0Sd5Dv?=
 =?us-ascii?Q?1J440uTleBLz2O+FDzvbceth63y1T0ELSGbdpxQn/q04YNioBIBaIt4qNppZ?=
 =?us-ascii?Q?nynbDvv3TVzgQB9ExIZDV4uSfPv3QGXE1R7pqWolINNOKe6JFKgSkIrH7G7N?=
 =?us-ascii?Q?VxguK9xtM+qQC31traRrDcm3wlkrhX3lqR+laxGyc93HDC+lXn8Q6wFpzJ/m?=
 =?us-ascii?Q?dNex/vPd9ZyGJKOot1JtLrbrrq1aTIO3BYBJT9DY7j49gicIhgIYKkJUd3g7?=
 =?us-ascii?Q?6dYcQXxFNsAqdQQIdoFFI8niRibcthnS9FLt/1N77kRIg8htxVBtuiD2yYu8?=
 =?us-ascii?Q?fO6k26LG/9CIHmNeeAFHeGLOBBW2wumKdZ0hVryZFtoURNP7iBK5iP3nUzI3?=
 =?us-ascii?Q?VhmMTppGzqzrZyfXb42ALygexwzIRsZ3tQt22O9+rh0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4297.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2021 05:36:42.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6af1f4-99e0-47f4-6400-08d8b529b664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gU8dM04m2HfFb25mIdoglWC0OjwP7u/H9+reEDicxN1BtLn6yWLYpOPKHxw6oPUgC9sM3rhDDKI7dNr6he3c034oSgxTiJXXkzCuJZ0hTEonAWkcOowHo7Tu5+ADsAc2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4714
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>

Increase the default value of NR_CPUS to 512 from 256. This will
enable the defconfig kernel to support platforms that have upto
512 cores.

Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 05e17351e4f3..23fbbf413f58 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -983,7 +983,7 @@ config SCHED_SMT
 config NR_CPUS
 	int "Maximum number of CPUs (2-4096)"
 	range 2 4096
-	default "256"
+	default "512"
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-- 
2.29.2

