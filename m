Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202112C4EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbgKZGbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:31:02 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:28705
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388013AbgKZGbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:31:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGOTh7Dkhf6PvU+03HI4X/gAedGLEPFGKWG8z4wJvEF3oUWuiveFnj1L7te98DUKMV5W9TN9C2FPfvwYwErzzOhE7IHfqbTtorDzPKX5F86KeJCTP92KlXP8z/wZRs0mNI03YqWTPmu1ljn92jq8dJcdpjEoiHsi0WXswg1urZnlyLt2Br8YT3JskVeuZUK5dySLNmkJ3bx8lVNs4WQUA64n3SQST76sZlCClb7ApBpu6KhZCcG6iswCAicSe4P5KobVxM1hD6gm3co0bL0CfZcz3U3lbXpyBMgrdteH96kVNYc53C9E2iH5NrcJjxbuxkv+pGgfvqCm4Uzk/nz3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXYdColE1uGAOesZVHptGGuiMaYhfEuLQsZLPM2xhso=;
 b=PtD836YGs6Q3+PlP9/66hPJvEz1bEwSlVTjFZQimySYZMr7yfrqFx0lbwk0x1aKZ5bLe20HKqM7XssUOGu9Iw5/wilyVoqhba4vx/KyBaRq5Fo8TRCKIfrDXvhSIMtknSi5pCeZKPEfzW4s+337p0Ht178iOcGwYlviisaZJo5HFVVh7KlRcXJJSq5bSv10uzwf0qjQFON3h6t+QccEBfm97jaNoTsq2u+KRvE+nJCdlFWLRp9riB1mTOmqLlo5+QH/bfRWUBk13jsZaEi/zd+jXtvGD5H/SJcOS9FlNfWV5HZOiscsmxfu8x2bsMzj+SvNdZxObppG0ymuuXNn9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXYdColE1uGAOesZVHptGGuiMaYhfEuLQsZLPM2xhso=;
 b=LrDS52mgVJEUOw+fP6ubtH3XH0WKXPvDz3YK00O+/dom0nx3Mp3fL0KGz5QuMCeK/ux29tzzq0BWU+5L6x5BeItsyigeXxuQrDkcCBj1XtmYP0IyEfEmhSnyULIaEyh3nDDuf+o5L9SCc//7PHCldYoXKtTlKYExrs3CIE50tqw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2762.namprd11.prod.outlook.com (2603:10b6:5:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Thu, 26 Nov
 2020 06:30:56 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 06:30:56 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 3/3] clear_warn_once: add a warn_once_reset= boot parameter
Date:   Thu, 26 Nov 2020 01:30:29 -0500
Message-Id: <20201126063029.2030-4-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126063029.2030-1-paul.gortmaker@windriver.com>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hackbox.wrs.com (128.224.252.2) by YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 06:30:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6128f4c-ca59-4854-9606-08d891d4d4ae
X-MS-TrafficTypeDiagnostic: DM6PR11MB2762:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2762C540F1D1E2B061B50D9683F90@DM6PR11MB2762.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWvhEfFJpFQHd6xOoSDoT99bDjJNYFwHcFv2albjMCYQDUDIwQ41VX7NZrFx8dbrnrbjMvYtpBNTtJt01VFGC5fhNbJc4HUnVFZLxbyZv5CdIlMj7vQ9Uwyfxsf6bgdEaXBe2G3V3VYL1pZvURWbUnjk4mtzSsUpNtl79/v5ikohQh/XQLVo6M5+kInat9PjIZRmlAjbITDYLzFfqCuH3hbKEEWlzUzztrAsOv0m2RU0nzQXkpjdTFw1e+UVKtzw6fWq/FaOb5IWlx5drE/UEz44shsdYeYMcL3KQ9P+ko7HkqujEr54CNC3heog2flHVNdqIe583E2Ouv1aoRckoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39850400004)(376002)(2616005)(66946007)(6666004)(66476007)(44832011)(6512007)(66556008)(478600001)(956004)(2906002)(4326008)(5660300002)(8936002)(8676002)(6506007)(54906003)(186003)(16526019)(1076003)(52116002)(316002)(6486002)(86362001)(6916009)(36756003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vJSiA81sOp0IJ7zXtsnTQt8zJ4WLFZqUBAT/RfE2FEp4raoAxcillOS/xnpU?=
 =?us-ascii?Q?IoRFcR2eoYl/6FT279nOzV9s3tgU+4fhbyQhM6RzWSbJle8KtpswdIcBo2a1?=
 =?us-ascii?Q?lU0etBL22zxplwk4AzL6HzFvj04A39j2+3NfSyQ85qrMlt8KYHLsRlAsFzqT?=
 =?us-ascii?Q?YDC5xaXHzBVPTKJrRIEVi1TRwE06xTUJb8hNnN6MR8mHSLohpvD/GTqldgjy?=
 =?us-ascii?Q?wLXFNIzj8ill25oHziuI/IkiJ5U0m8ReQMQ+4MfOBgn3sMrLcietF2TNUGtF?=
 =?us-ascii?Q?/WyWX56eVMRJreskWWUO5odb//dpLpaFhVjQp0c9O5HiqyQ4ADbaHtgxL1bP?=
 =?us-ascii?Q?IPPTOQq47iY1OfVFERw3za1vetqPtDaJCL9ZG4kIRKrqnZREu74HFgXlIOs/?=
 =?us-ascii?Q?4/4SxaQ8Ljn0pO2jCCXP+TyX8ej32Yv7qmYW3MWBxqGRhyNG2Ma0M/I2QmTR?=
 =?us-ascii?Q?jHvx4IkrWuHFWC/7wOKypS8VJbX9/cxpobKv/ghGPAZrjiJ01ugd4c1cvcJc?=
 =?us-ascii?Q?VNbp6W+azhJx3wjOEeRs2hZG3Io5rnnTL9XvEe1v7Zj4CGAocIUpjcD68VT2?=
 =?us-ascii?Q?UY4XoqTB+XDdjJJT98Mk2kHRJQcRyO7L3pMLjlGeLtk3fzzcxl3Y16MPL31s?=
 =?us-ascii?Q?wqxKsJTqRGpZo1mog/VrGdaKzRi/L460jarHkYv8n+DNqF1SZqbsD4OxZUBV?=
 =?us-ascii?Q?BQC/b8/S0DAU51AyMBqzg5TqcbKL9ugsYw342rSAukerQ1zb02apcUgkkmSh?=
 =?us-ascii?Q?FeZqPre4iR7lvFOyj+UKTSCveLqr1YXHcalyJp+r1guUEhMyGAbbv1IsOv41?=
 =?us-ascii?Q?yFa4hmT+SJjdXTbZIoKChTTTHH6itHxYKik88NhOxVM4dVaiJTYGhsPNZfTX?=
 =?us-ascii?Q?crV8MyMjXWTBueAf44UHFSAi0XJ/HJRvq3voxQZzTc0NYEocSw9BU4zYzhjV?=
 =?us-ascii?Q?D4+xxv7iGPPzSPbfYJOfOyHAfM5qvPzLEIuynjp9IMVAtYBrxpFgjkVqfM4B?=
 =?us-ascii?Q?jrwp?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6128f4c-ca59-4854-9606-08d891d4d4ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 06:30:56.1913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpwyX79P5WW6GbAe5TJ9C99gLUdf9Sf9T9jefnmDvxqACnZ7p7CnioinEGcYicuFgWDE+GTSoqdfS6sCK9rpF5rqnysp/SeOi1c202rAYKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event debugfs is not mounted, or if built with the .config
setting DEBUG_FS_ALLOW_NONE chosen, this gives the sysadmin access
to reset the WARN_ONCE() state on a periodic basis.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 +++++++
 kernel/panic.c                                | 21 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 44fde25bb221..89f54444fee7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5863,6 +5863,14 @@
 	vt.underline=	[VT] Default color for underlined text; 0-15.
 			Default: 3 = cyan.
 
+	warn_once_reset=
+			[KNL]
+			Set the WARN_ONCE reset period in seconds.  Normally
+			a WARN_ONCE() will only ever emit a message once per
+			boot, but for example, setting this to 3600 would
+			effectively rate-limit WARN_ONCE to once per hour.
+			Default: 0 = never.
+
 	watchdog timers	[HW,WDT] For information on watchdog timers,
 			see Documentation/watchdog/watchdog-parameters.rst
 			or other driver-specific files in the
diff --git a/kernel/panic.c b/kernel/panic.c
index a23eb239fb17..f813ca3a5cd5 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -716,10 +716,31 @@ static __init int register_warn_debugfs(void)
 	/* Don't care about failure */
 	debugfs_create_file_unsafe("clear_warn_once", 0600, NULL,
 				   &warn_once_reset, &clear_warn_once_fops);
+
+	/* if a bootarg was used, set the initial timer */
+	if (warn_once_reset)
+		warn_once_set(NULL, warn_once_reset);
+
 	return 0;
 }
 
 device_initcall(register_warn_debugfs);
+
+static int __init warn_once_setup(char *s)
+{
+	int r;
+
+	if (!s)
+		return -EINVAL;
+
+	r = kstrtoull(s, 0, &warn_once_reset);
+	if (r)
+		return r;
+
+	return 1;
+}
+__setup("warn_once_reset=", warn_once_setup);
+
 #endif
 
 #ifdef CONFIG_STACKPROTECTOR
-- 
2.25.1

