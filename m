Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65992E7857
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgL3MBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:01:42 -0500
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:17665
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbgL3MBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:01:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW1iGPIMz/2l+uCjBuNp+Sqybrbi6GykF0DoFyjCrHveY0dr86pRTPRPO6B2Vd+hJ2uhcJBeyn9fGC11sbc2aNCIlQgc9TD8zmjGhK6e5g3TGTARSrNjYBibR0pjeVHHNrl46Z1GtTvePieCIzmvxpe3KNyxlhRyGSw/vxPQput2Zh43UWskruDf1iMmF324OFc61OUDnW3QgHVyd4OztuO977xP8gnC7EQD9eureNjY+jlkScPkHeKrhEPO19cjhLMzvMKFO2GL9qcFQurCGJ0IoacKV6Vmu6A4AMxK1KiamQcFuoI2rA629emc/qGjGSn8779nWS/4O9ep3g6CPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni0JsyRoG12NSwgH7JD0l3pAOk4vwS1ciNdSt1rlYq8=;
 b=lhespQuNjfdCJOIQ/XAAaryJj1lNPbijBTDoCSrHzRsB8ri89YXb6lNRBxgy3N+tqSHzOV2C3aUriYnppou6oM1QRPToPngF4UV5YULkTfENMmOuTrWb8YgOEznr44Rb//csNR6F3wTV0FsMnAgaeBN1kJwYt26b0hHr0Jw9WbBFEwQQpPJnE4Apl4o1smiXqNh/4DlMZQocnOpWWV76et+CbelJ9tw5bBe55fz3cAv5ATkAHaXA+LjjI76pByj4BgemElaMuw49Owr5KfK8bRTGNNxRj3u4QVJgyqFlPstZrdbPsSAvLlnjL5LSCCRPFUUsPAHAw2SLmWl86xEUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni0JsyRoG12NSwgH7JD0l3pAOk4vwS1ciNdSt1rlYq8=;
 b=ccrKt+nTlBqvEG2tVx62TDZ+IMBwoJOFZYsM5zUA+rMDaM0fFyPdvsk6F2ZWW8y2FEAITUWxohntsLUat+wOY0CtYc/2+BTeko0E1TmwMz60V9HVJRfgJfWqfP3a2+PXXAXT0N6OWATtQEjVjWbUSo/a3IPhPAQzCQ8+vyuH+Dk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Wed, 30 Dec
 2020 12:00:52 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 12:00:52 +0000
From:   qiang.zhang@windriver.com
To:     akpm@linux-foundation.org, manfred@colorfullife.com,
        gustavoars@kernel.org
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipc/sem.c: Convert kfree_rcu() to call_rcu() in freeary function
Date:   Wed, 30 Dec 2020 20:00:38 +0800
Message-Id: <20201230120038.19489-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK2PR04CA0065.apcprd04.prod.outlook.com (2603:1096:202:14::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Wed, 30 Dec 2020 12:00:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5259f800-6ff9-4221-5922-08d8acba8e71
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4829:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB4829723AD63F720A82EE59DDFFD70@SJ0PR11MB4829.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9uc0mf0NxOj2BBn3sgDDAPSzKV8su+L4dWjEgabeqrKFjhXlI+7eELFTXcpAt5Elt69XJ0JdbBeubPSlKmuUEihmTCFhwhTskYInhbYri7Gl9CegQRzNgxCX9kMEyqPf3dUcB0jNwv8Fr2WrgVfb0w2hCCcXJlf1H0Tz58dqz1Wad1w7Hkn9jW/uMrpAyFMe5MnzAYNBCvr2nFSnTA86xWPht/Vy+4DhJIAm3DhHnSrqmUfz1XjqwJKXnHHAJZYTLEWZ8QnUZYHDlH6Txps9mqV+YSTB/D24LgoQLpyT+n/xqCYYfOI7pBApy0sVWfCg7I/vVxXs+lt7txFu89gXQ7ABczWCcjM9oOH1DOwJbYn8Hf7oxcZAJHZ7hd9rq2VGo2/RTVaFdv1S0gQZ34UKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39840400004)(8936002)(26005)(2616005)(8676002)(316002)(52116002)(66476007)(6486002)(186003)(478600001)(66946007)(66556008)(4326008)(956004)(86362001)(9686003)(36756003)(1076003)(6512007)(83380400001)(16526019)(6506007)(5660300002)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?52770caLwXgX27s7i+1jXHzuiZGNnBUhJNHHEcBll4VyLpgSzjzw72OPlflH?=
 =?us-ascii?Q?0i9BS6vh2rOB0xtWj8qBUIN7ZJnaGa++A94X/ITjN6EGo4oEXZwuUH8kKZSx?=
 =?us-ascii?Q?iC/HlmeXRlS9aUORL85uOxdR6dsZEg102M2YSeOxnjl1p9w/D2Bx/wZSQhhW?=
 =?us-ascii?Q?p6AYYROwkGHTmNybOgTgD5SUnV09ti5JA5HH2CKdIpdm9Mgf2mUW0CgD0aCH?=
 =?us-ascii?Q?WfE7OslJUvZYXwcy17rPGsXJB8e56VJJNgc6f8myI4DRZI5gGgA7/rbQFNPx?=
 =?us-ascii?Q?MujJXazhO1BR9MQIXe5+g42VpSjg5fPjec8BknnZJqITRKltZq2oC8LqMa8j?=
 =?us-ascii?Q?Tb10KMo7bFv5W2Wy/AqErH1bfT/yPXlH9URzk/mVcBE71qoMPV4aAWMz7Xlu?=
 =?us-ascii?Q?q+sG6dHn6XlQfv7s9ISh+kIpc4pzg+m5NN4zt29GQv1kR+JZaYnnr5pbpVf4?=
 =?us-ascii?Q?3quRikdbyvz6qxnY17QUaInTR8jbCjfmS9rnZQTb+/OVCTNOhES+nQWJ7+fy?=
 =?us-ascii?Q?M0DAIlqISASF3vfU2bMkdbu1JfP8iwsqeKssknXGvLTxP2xNhp/KKPZCS5WV?=
 =?us-ascii?Q?aD8IjPzAN+Q5aaiRNV5Ca12bzKiPqNizpUjdBWgIC9hsQIPwXx1+LdIPsLp7?=
 =?us-ascii?Q?yyP8SpHsg1K33U1X2rr7H/4A9X6whSzOMmFMSHi4ZbdlCwuvJCzMn83KxpjM?=
 =?us-ascii?Q?nuSuuUD50dkpZZF9Mh4NDQQlfpMkFeh3yYwkSAZ8TB+1sNFb+1G6GPfezlNs?=
 =?us-ascii?Q?s+fpsm+FPUWkhgO854YV9C2VvIfE2H4MExFcKsVz8UHwh1phoysRCXXsrTs9?=
 =?us-ascii?Q?MwvKJOUY/zMNIKUM/BToFhsSqz43y9gxYwUR064PXIq36phjHhFwG6/ZjuYx?=
 =?us-ascii?Q?/KhgT6KNWZa9A/TwCJNm/q5v+KkWnaFI0ChNKJZxljS1On8UPLIzXh5B6JU5?=
 =?us-ascii?Q?VH/QaC2u/ryz+wQ+Jfl5qQZQeF4cPIB8gCOQDWfoiy0=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2020 12:00:52.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 5259f800-6ff9-4221-5922-08d8acba8e71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXJYY3McwKGatRIL2y44mOz7ztLeHiM4fFBahf+yEGFJ2BqsDy9YwbKqefDv6CAUOvHPEC7TjNMez0SJqs8oXKBw8PGEbXhme8FbtK2/V0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Due to freeary function is called with spinlock be held,
the synchronize_rcu function may be called in kfree_rcu
function, the schedule may be happen in spinlock critical
region, need to replace kfree_rcu() with call_rcu().

Fixes: 693a8b6eecce ("ipc,rcu: Convert call_rcu(free_un) to kfree_rcu()")
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 ipc/sem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index f6c30a85dadf..12c3184347d9 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1132,6 +1132,13 @@ static int count_semcnt(struct sem_array *sma, ushort semnum,
 	return semcnt;
 }
 
+static void free_un(struct rcu_head *head)
+{
+	struct sem_undo *un = container_of(head, struct sem_undo, rcu);
+
+	kfree(un);
+}
+
 /* Free a semaphore set. freeary() is called with sem_ids.rwsem locked
  * as a writer and the spinlock for this semaphore set hold. sem_ids.rwsem
  * remains locked on exit.
@@ -1152,7 +1159,7 @@ static void freeary(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 		un->semid = -1;
 		list_del_rcu(&un->list_proc);
 		spin_unlock(&un->ulp->lock);
-		kfree_rcu(un, rcu);
+		call_rcu(&un->rcu, free_un);
 	}
 
 	/* Wake up all pending processes and let them fail with EIDRM. */
-- 
2.17.1

