Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0A28DAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 09:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgJNHvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 03:51:08 -0400
Received: from mail-eopbgr770089.outbound.protection.outlook.com ([40.107.77.89]:39557
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbgJNHvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 03:51:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEi5AMZRSVXe851DUsdgo+NJ2Zbj+n2ZKJZJwVVgGCoL6iWU61UKpsqqBasaCfOcAb14dmpQZfcp2Lvw/rvefLnO8oWIfD7MVsWrUsl5gia+CYRCT+dhrZ9J6kUd5oyay2/kf2BvyS6xEApvDd7H7G2qoYJqDsZ43erhq27i3HKqX2UvNK4A7EyCXq1tgEa7EVoK8k7vnHVGLjmQfmgv7RuFkDF2zqs1HdzspvLQQrtyf5KGk6g9nT7+RJdsGPV/pU9SYZr8y04potH3yayFAlW2P2pZKxRCco6tSTPGY30OQlhNIF90UA5Xkl9qOhoi7rj95wQ5eZQh3u82o4+fxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+nq7Bh9SqXpbt9jgFOEP6/KSM2C9loUxuUwC6BW14k=;
 b=fAeJnGRFGsV7HR9PJMEn3+2Ux8X2B8sGKBWN6Mg+WQ5uneCWcVtxhL3LVPb1QXFWwRDXJzbV2S1Gn1tuNGjU/Z9lz0ifGQzd7JF6s+HdZu6oaxJIaEmSAb9eAUE17Q8fSIUUSIjgBb27E0uaBfLxQADPwQH6+V2D2xSOltxUhh9md/8Qa/GVjH67MvcTYcuQEHl+1y+5vyXa+RpsVyGTtb/E9kQbuju0BoeWPzh0Wm3p9aSx2sHKkvp6+bG57pRFyTgxlyTc+yNhsopET1LmnBLWVaG6HDN/QUqHjug8XTOInbUd5yNdfm+HZxsPTOiI4/KUWjZ84HXxZSt9tGtdMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+nq7Bh9SqXpbt9jgFOEP6/KSM2C9loUxuUwC6BW14k=;
 b=UZcao52bxO7dHJrcYb+K7OdYsPQQ1ChQHJM/vKL3IAEKJHfvqyyUj+7XF8k/Z/XAVGRFRpMGULtJvuF1tSBlKfsCHwaCl+QY/UcKCvd7hNK5fij1w7sOPq3PbRFDfOoVQqHsAsj4I4a57Yk3nen60ZV31uWyso10FoF4Xjfz2sU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3029.namprd11.prod.outlook.com (2603:10b6:a03:8e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 07:51:04 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05%3]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 07:51:03 +0000
From:   Zqiang <qiang.zhang@windriver.com>
To:     tj@kernel.org, pmladek@suse.com, hdanton@sina.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4] kthread_worker: Prevent queuing delayed work from timer_fn when it is being canceled
Date:   Wed, 14 Oct 2020 15:50:48 +0800
Message-Id: <20201014075048.15473-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:202:2e::14) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK2PR06CA0002.apcprd06.prod.outlook.com (2603:1096:202:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Wed, 14 Oct 2020 07:51:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8b8eed5-180b-48cf-3402-08d87015e605
X-MS-TrafficTypeDiagnostic: BYAPR11MB3029:
X-Microsoft-Antispam-PRVS: <BYAPR11MB30297AF88548C8EED9BFBF50FF050@BYAPR11MB3029.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2EUSGS1GJXfUZ5OZKPI8zIUL99D3B/AdQN03WFtgQL2CBaQ9+VXALGOOgtOictrxneNoapJ9lhPVyE+WfkN3qOErvax1QyqB8XcLVut5tthow92HkLf/myvexVdRi92XIvwx0Lb8mRRy6SoJroYSPbLf1vMjI37tGQFKAg3ym7JEHNtBvbjPN1NPD6djodpmdJcVbvvwQhAwjTrjXuGYHQZ+kfH7rwtJQP7yhuuTmj6aLUrZEGdAtNdOVqwm1VbntS/1F4M23dugFckPNGveUY/SGUSmrI4FOMT1lNfzK2WS8qKZpzSoqJwnqhLjbFtvGeF53uiV8nQq1hQSK1/tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39850400004)(346002)(376002)(396003)(6512007)(6486002)(86362001)(2906002)(36756003)(5660300002)(1076003)(6666004)(4326008)(83380400001)(8676002)(66946007)(66556008)(66476007)(16526019)(2616005)(6506007)(52116002)(186003)(8936002)(26005)(478600001)(956004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: npYlbIttf2ZNRM2FNDJ2e5X5v3ZDrzmdi62hN2PzgUIXqoz/QUh9ZB5EEpdwKsEKYyXDaTzOl9fqN5fh0vpU/cKfT2Ganb4hkHnlbK34IPV/kDpgQjwY2Is386azbR71+ajPPd6LhAQlIeFdiGWlPzWg46rY/mcsRVReHnoY6NHpd0ZGBV1ND8uZU0r+PhVMmkyk44OmIn5Pz9gtM3NnW0PaktNxuueOMJJDfNqDI277L9IMMvcHtLYLtxkdA4XqhP3vDeTvbXhKTjS84FVY+ilj26l+PFb7i5a1I78EYfGiCEctNm3X4qE2HtOjfh6+vBrmhZsG4pEnpVCq74ghZqGZoc/UA2Ph4Sp4pnJrgvmb6/PDqQm0AoQsxrcmfmr5YRXIPKkxftwa+nBDu3eepPinC/QG2MIop7V7ecCeh6NBMuFJIYkpcE3RBugfU0KQzlgW3RJQ6ie3nOnVW1dba7aWNnQFm0/kVUSz2HwqxvqoJe0Rg1wfGlX3EHsw+x14JW20Ps3D2AjL3tvwDXvPPWfVbwPhsBymvbCLjNSL3h/tNukhIWwp7+qj7FooSghLKyDDZLFLa1tJ/0ONip2xzm5pzvrsoH8jWJnmgV208arxdK9E2gEO/oitXd7M9aUoTYdY12Df9QFVHg8SShYpwA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b8eed5-180b-48cf-3402-08d87015e605
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 07:51:03.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crDl8iQn+3dz2ZsGVYUI8Hlk6o5OQCWP7na89XM1QQhV7VAg6wh6HYCFmRRyBNsUiZq4Z9NkAP/M7ai3y+7RPaW62B8j1ppZ5eotPnBzoE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a small race window when a delayed work is being canceled and
the work still might be queued from the timer_fn:

	CPU0						CPU1
kthread_cancel_delayed_work_sync()
   __kthread_cancel_work_sync()
     __kthread_cancel_work()
        work->canceling++;
					      kthread_delayed_work_timer_fn()
						   kthread_insert_work();

BUG: kthread_insert_work() should not get called when work->canceling
is set.

Cc: <stable@vger.kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
--- 
 v1->v2->v3:
 Change the description of the problem and add 'Reviewed-by' tags.
 v3->v4:
 Add 'stable' and 'Acked-by' tags.

 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3edaa380dc7b..85a2c9b32049 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -897,7 +897,8 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	/* Move the work from worker->delayed_work_list. */
 	WARN_ON_ONCE(list_empty(&work->node));
 	list_del_init(&work->node);
-	kthread_insert_work(worker, work, &worker->work_list);
+	if (!work->canceling)
+		kthread_insert_work(worker, work, &worker->work_list);
 
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
 }
-- 
2.17.1

