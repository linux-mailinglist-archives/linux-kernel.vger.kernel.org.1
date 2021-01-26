Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BE53045B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393474AbhAZRu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:50:29 -0500
Received: from mail-eopbgr760048.outbound.protection.outlook.com ([40.107.76.48]:40545
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390078AbhAZI3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:29:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4Zi7HADTmrHJvQc+JbP/RApmu6GhatEsHy8rGUytnlElF8Zlxf3UHcHFXT+IVh52ighSxMbiD3Y7dP9lSjdTWaqmFTIcdzKZLVZW1i6PVoYh1c2kQj4huVzW+uVRzA43z/TLpDBmgnjLxXkzk3YUtDMqKpk9yr+dbzES2OwcVFaP3yxXnl410tThveNu+Z8Kbc2L385Erqfz0n7IVcokBH5i13CB+P/8KQlMFNw1uVEnqQ8Gl6A7Jt/TXv4qzaEuWRZwU3QN2jcuZ7Zn1ERJA25pR80AZub90Khg3mOEypmTg5DSHQUeJgRGJ3ook+G3piDM2Gztzoqk6AB2b8NIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPhT/gOVbytf9mDwndHGMAXMDrRGR07OO7Riz2cxMqw=;
 b=Ujbcbbjc36SA973hbdAHDFR8QXZ/40Q5ZuuusFbwxfoZl75nxvVXwyPr0b8cqnFKSOZPADXenro4dCWZzuxXyIf55kc05leZBKiqtwpnC9n9xBmciUHjU4z2oVJdEhr4MMRPF/xuRKeSmwfsd1SEWfeTADAPndKPs19FhWONH6qC/KKzOZGpURSMOpKdo9gBKHG7IdwpvzB7NpWinrt04txN/I0mj1/p9VUUO71GFLfRsp9RLXFJiHiwIiFpizWkwI7gEGr6vCKGmCstwfxrv5x+absaN4hu+2CcOxHTNp7nPS5uRaP/KyVb6pfiFqZW4Ca5cTURvU8Z4n9mGYQZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPhT/gOVbytf9mDwndHGMAXMDrRGR07OO7Riz2cxMqw=;
 b=oo5CuI6LaBVRUYZa17qUSQg0fDfcnKdiujr9TW8BDw2gQTxJ1Uy2TCm5tK37dbJx45tRTsS74jgVo4+2pTudn2xhy2TdndVR8WCgXEPeCv4sPd9md2CXsVFVi3oIABmQyEvr0eEtMTdPVEjjqig72Z/P+01gT6rhTJUrdfc7t6g=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3720.namprd11.prod.outlook.com (2603:10b6:a03:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 08:29:04 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 08:29:04 +0000
From:   qiang.zhang@windriver.com
To:     valentin.schneider@arm.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: add rcu_read_lock/unlock() protection
Date:   Tue, 26 Jan 2021 16:46:51 +0800
Message-Id: <20210126084651.32277-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK2PR04CA0059.apcprd04.prod.outlook.com (2603:1096:202:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Tue, 26 Jan 2021 08:29:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e47f981a-a54c-4b0b-d18a-08d8c1d47090
X-MS-TrafficTypeDiagnostic: BYAPR11MB3720:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3720A7B4D9E89C2042ECE145FFBC9@BYAPR11MB3720.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:71;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aeAnXLnaWetqr1W9cN4FChQc4bn1tRqg6acNCnrx/XW42T8bLxLhAvPKbKSPMaBBQZEYM5OWb2JijMSoyc6bXDxJr6RDSh4edZdKN/CQw8aDDKLdjixf4kdDGfLQJ9Fzv4uhBzj5UeJg6d1H4RO+bb4cysApZ6CIBHYjx9QRVg8BoC0Qia6YxeE4wyzXEL1gjHPdLFd9I85zUPWXJ25GQRs4qoKc00qTUpBYJBV0mHetIy2nKBlY5RZ118UXOkdIn2tmbCrQ4kaq+yoMHXIyCx+pwC8mLzPfov2QKS6auJQI2RZyiMLJu8Oy6eojLzTQ2V9vorSZuOjjyFBcMPKCP60NCro6BdFytULEcdcfxlYKqDU6gLHSh8rLK3PzHBkpRseaIyKOmbDRPB0LkdYFKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39850400004)(376002)(8936002)(52116002)(186003)(6916009)(86362001)(83380400001)(16526019)(4326008)(66476007)(66556008)(66946007)(8676002)(6512007)(9686003)(6506007)(478600001)(316002)(956004)(2616005)(6666004)(4744005)(2906002)(26005)(1076003)(5660300002)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2yvHxXGtLrLCgRUPENT0gxS14V5GVakbcUxFZWUsL80yOLhrxyzPIL3X8yXx?=
 =?us-ascii?Q?+LY1KQqbRlEzynlr+a3C0Eng5NFaKsQoQNU3M06G0Z+3dMu6KTiRrTOGdnGJ?=
 =?us-ascii?Q?TQ2er42uH2tGue8H1avuBTI3gAurQ9xPk1SHJm/dm0Zi9NT6umdyYlORL/63?=
 =?us-ascii?Q?RtL5Q/ttMN7zztuDI6Pqxduq7O0eZV5GjVI7yG6G7qa9xZ5ujylPn0ykenkz?=
 =?us-ascii?Q?trR0NoEAeSelxHeQtJ/vt3QJ0FeJ3+G0r6chEHp9MYNhFbZHlcY8nyqJxN7z?=
 =?us-ascii?Q?c6Os5TJhQUfS8XFJfLn1P+4pFrmHAQd0WhKHMPImB2DvY6LuC/AcdCM53S9N?=
 =?us-ascii?Q?3uQAqggTF2RMjP5yK/YXKeGcJuWZ7I59CKAgu1Vv66wnH5PV8Dcdn7/dcRnO?=
 =?us-ascii?Q?s3bWZWbHdbU0VT9FYOdS+CXw0IUXXxH4irhT3M1OeOhDHB1FHyJmkBIm5jHZ?=
 =?us-ascii?Q?x0bS8K8HTSItnWMcpWJ43bV9Ti6Bl5eayRle/Cs14P/VGIMigkqhWhMBrFJd?=
 =?us-ascii?Q?fV1ce2j+JPBCfLSw/qZxSXhgR5zVnBTOvBzhmfBv9Jj9PtHY4RzBM1zcmmS3?=
 =?us-ascii?Q?7OgvcEd65pQL3H/vaKrrOoEoI1z+XFho0rudg6t8VjwGY4QQE+s+onyNOU31?=
 =?us-ascii?Q?Y0yxIcJwr6lnGg7d4aJbRrt8gHY8H20nH3JfvK4jhkK0Tybd/e14SZm7i9XW?=
 =?us-ascii?Q?ms6lLkSopdDPAfm8udrftbSNl3hriojqugVvZ+wKxo9yVRp4QArI9FgDHe9r?=
 =?us-ascii?Q?3QIyHm1Msq6dn8BSXwtYgQjksaql110sqwA7vknZhjQ9ZCQunBG++qXwnDnD?=
 =?us-ascii?Q?FSGeBtlP9eY2SCB7ntoTOdYj4LXx8e8rJ76fay9bxdcBnNHKKNlH51M/vP2u?=
 =?us-ascii?Q?r5BqboDmVsW0krm+QkmrMGu6U+INRYV728DX+OoT5XDjH5sfU1cfiWYKlF9l?=
 =?us-ascii?Q?xmg9M0dzREQk6QR2uuterIONZSPHfXUaj5ticZQwd3g5dsY+vGCM4OnE/f84?=
 =?us-ascii?Q?nPNnu3559Nb5Wtg32+i1a/eDriAUpkAvywUzSX0xFoSD1cjTPl5Rq+f6LT7A?=
 =?us-ascii?Q?Q2Z1obJo?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47f981a-a54c-4b0b-d18a-08d8c1d47090
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 08:29:04.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yd89RKub2uv2pL19+6qHiNpIanRHABTy05lYKvSMP4ZLrV0qXFy68FTrTn5mvq9Uyy/ocqKVVosu3t0EdSR0KLZK/YpM/OvxMAE7YFRGeWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3720
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Due to for_each_process_thread belongs to RCU read operation,
need to add rcu_read_lock/unlock() protection.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8c5481077c9c..c3f0103fdf53 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7738,6 +7738,7 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
 	lockdep_assert_held(&rq->lock);
 
 	printk("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);
+	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		if (task_cpu(p) != cpu)
 			continue;
@@ -7747,6 +7748,7 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
 
 		printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
 	}
+	rcu_read_unlock();
 }
 
 int sched_cpu_dying(unsigned int cpu)
-- 
2.17.1

