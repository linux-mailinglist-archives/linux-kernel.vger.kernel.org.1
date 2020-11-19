Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB42B90CA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgKSLSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:18:01 -0500
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:22656
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgKSLSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:18:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awSIONBXMjV8tbweTDmvaCxErryjGCxAtpgtuLB7twKCCATqmIDR9OcV271yA6HA3RkZ/rVznIT+yf2AW4f0sCxtxblJfmyiEJQr5omSF67waMjbjSXpb/J2D700rz6emcQ8uG5b6ThVQpWAAHwKB94cHobY5cpSn0KTXSIaTQI5ED0qeGr94VgFV9gsXQ9vQjca6UAfyRFRQTT9M0STHvPQcgQr+Erwte9X/iIk76bFm14DwPwqdwjD8rQ6qtjjNZkNJ9yNyzA7OHlm8jnRa7oQ394mnnzRP9iGRDRHm50fznUKo1+Utt6Vwm5+MzpAWNeVfkTLKwtVVzscZV+rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g784nD/VVvmmt5hBphtXKt7f1kPIYsYpVPxBFGO5po=;
 b=R6jFb7aIbFUtKV+cwcn0WrF3ptsOPz/m6XUaHJ1CKS8A5o/SGfzqvzvBC9Jwdkp9NluVTV51Pz/sKC5PgmGOAfejA3677Y7rDrRP9iTEfou9jYYBlWcRKSRlYiYINvQWshjqFR5QM2zJuUjg+gLqDYM7ngzZ38sxiTr0h6ZYLCdVogETvH9//kmL9YIa6a365NppkUUQtlsf4kUCD6FNmXA9zLTGVheBjf6d/MBwLV3Fow3sXPc0lp9zHdeDhLzXrDsJoJEO1gz5FM7h7wVS+bGmUv4bDzt7KRiAqdib4COzwWNWO7ckFAteL902ScfuIcba8KlyV3FvytyvPQmlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g784nD/VVvmmt5hBphtXKt7f1kPIYsYpVPxBFGO5po=;
 b=MCi71j1zEy4ulAMrQ9/YAncqBVPMkH5WIToCYrKtZvNc/MI3zrcshcHHTtzrB42RyfPJFzOYlqdy6FwUANah2IDXP/OeUT+MSzIyebkeJG0Ts723qpoxD+FyXu8hCPkSNKiAynagQsfVxCCUWGqgJ5DVdEQ+jMXBqEOXyD6mJsE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 11:17:56 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Thu, 19 Nov 2020
 11:17:56 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-imx@nxp.com, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 1/3] driver core: simply go out if the same device_link is added again
Date:   Thu, 19 Nov 2020 19:00:34 +0800
Message-Id: <20201119110036.19959-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3589.21 via Frontend Transport; Thu, 19 Nov 2020 11:17:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7c943f8-41ed-4868-0ae8-08d88c7cc3c7
X-MS-TrafficTypeDiagnostic: AS8PR04MB7687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7687D27DD22139EAC71C4EE280E00@AS8PR04MB7687.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgmftl7jOnsJJ1cqSty+l6+//X+hcuSUB9rdlGm0EYDVzXOmd9YLZdwwScXSsj28rd9zq2U2GLMAt9b39SwYE+UmWJUdlT4n1boYVD5380hQD+4/J5FYpoOkAaLRBY77QnXW0OuSKtK7AxuGCWu0Hn/7KfspF+1SKmvGS8BlbQhJ9GsGiIqTK3pmmcOw3gpYg1G//h79oNL/mlH1/kckFzveeuU8OacTXw184zwZ2wUGwZkVu4vKn42EIp3QMuc0av5f0xGLa1A7P+w1KI2OpG757AuXJkRMk2udYVzvh/cYFRdna4de6D+vpS/gu+cN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(66476007)(66946007)(66556008)(6506007)(83380400001)(52116002)(6666004)(2616005)(6916009)(4744005)(6486002)(316002)(1076003)(956004)(4326008)(478600001)(16526019)(2906002)(8936002)(86362001)(26005)(186003)(5660300002)(6512007)(36756003)(54906003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ewbTlF9STv9a+XVuPAjg6eDQSBa62bhKtHU7Wi8Fj66Gmn9yXaAZiw4o41OCFDtipxmNdDcCOE7YGLLm0ArVp6x3S9T3CTS+67vbcStNR/sriQ5CHB7KIp1vAGxSguJO5Tg5ZbCFGpMk7qN+MwhgmGqPJ9xeZzabmOckGCy9eCj+/A1CXTf1AcQlXAIHyIBLH/HFeCPr/ihBdJniou2IJ8abSh+bfSA7S73lfz8yJ7CoaJ6F7R/dN/kVpaomKjgSITqNKIkZ06FIfqyErFTqp0CkwcvAGMnwyHCwusGrpoy9saNG6m5HJCdSTQp/to5KtTBfopf3uYGXF7GECfAvgXcKqUhNueFduLBocrhgDBvgRdrlbPg+nIubS+UXUGBdLXxOul18kLerZiCUY77ypAYtldxDYLNrxFaeFu0LccA5s7O6TQI/ao03LcQCXc2EI+pIYyZdAPbGvwMEQz8HfI5LQdJKwTq2UIPihn5I3s0SYyqgEVHo1Xj9tC4ZyIvynhNO6p2cZet+rDc2VL8F8+eePSNHEcLhqELIwtOMvHwQ+ZfruEg4MCnYzQffZHz+bOQzB5mkKt0NaChBrArLyEqa8eOpbiOfOGKzGtT0mTgBxuL5jRjJRJZk97LXDQqHFVKOH8S5xZwEdgIszJgUHg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c943f8-41ed-4868-0ae8-08d88c7cc3c7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 11:17:56.6527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AM+4kV6zpbZWxTfWmUDz6nz70N+aq20bh1LBZmNtiVGLyX19pwD4NaeyDPDoRT9wY3q+aBc9097V3sjhy9eU0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that the same device link may be added by parsing the
function dependecy in DT. e.g. clock/gpio/regulators.
Simply go out for this case.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/base/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c03bdd3a268..7d91d4074136 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -567,6 +567,9 @@ struct device_link *device_link_add(struct device *consumer,
 		if (link->consumer != consumer)
 			continue;
 
+		if (flags == link->flags)
+			goto out;
+
 		if (flags & DL_FLAG_PM_RUNTIME) {
 			if (!(link->flags & DL_FLAG_PM_RUNTIME)) {
 				pm_runtime_new_link(consumer);
-- 
2.23.0

