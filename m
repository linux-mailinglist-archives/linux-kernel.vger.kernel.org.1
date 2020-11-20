Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCE42BA13D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 04:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgKTDfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 22:35:08 -0500
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:19361
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbgKTDfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 22:35:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQvxfPIYkuPLQZmWgoyGZrvFQVGEoYG1sXM2djnthGaf84ozc2+eraGG8mCf80l9mDY6ZNi7La+gfinysLJCtbLR23EyXweuUiwx5pOtaKa1xj19DqDeT4IB9+daHHIzpKBOTy+VkrbWjzE3ML7gct/5O3XGSCWIRX+f/eL10jzOUxJaUj/KB9MYS2Okoo3h27VorarnvcD4wk5bz4gvxGk+MxTGg2mMbTfDnCmv7FQTF734E9k5PzHs5nkXh5tTnskJVfsov5F2rjsWDdLuLb5ztlEQb+fFWRv0T7fqpFOWBPsgmr51hiNzn8eey9jQ+ge3lOnI0izpxzai4cHI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6mEVF02OPv4d+M90cTy+gXVeJNPZFRAWrN0dmTMqLQ=;
 b=L5ydvxFRlU+kgVG9dhJ8j7raI0D/F22ZKLs+iab/dQyfMgnbK4darzCKVkgut0XsLusDLrirpKdhWExn+Wgq4bkemhqKkBDkuDk3PhRRVrLH2qqNk6M2dQo3txvIKzCOGbhjtFeMkPffHsTUfMhonw3x7Qyp2y57JiOZ7OJEe8pVeqcHqHuyrDM7QBS9ZMKrQFal/dXGVOSjCkX7WK33SZNcZ1uQSQq7OFPhpHeY0Kdl6Oe5QIDnbM0GIBes5F7JEzLsSZUycmzSPF23HjabW8lM0RO9pKD4fF5BeYaLEpyiMwVnVM9vOUpeH7eW/Q70iryu8J6X4JXppr+FwvL2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6mEVF02OPv4d+M90cTy+gXVeJNPZFRAWrN0dmTMqLQ=;
 b=E9SzBaZna2CYxZ3CUupH7Q2Gsv/QWL+vBWWdYbLsYQy+OgCif0d5s4l+vaXmqq6uRE0A4aqZyJXEhS6iwKJelegU6NGaNIiM4PcsVD1Wf7WIuonKfWZVEhjv2jMtZNRU+ZBS6jtv1hQOLAQgWQZujJySoHQ3xhTc2ieY23ql4jI=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3815.namprd11.prod.outlook.com (2603:10b6:a03:fa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 20 Nov
 2020 03:35:05 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7%6]) with mapi id 15.20.3564.031; Fri, 20 Nov 2020
 03:35:04 +0000
From:   qiang.zhang@windriver.com
To:     akpm@linux-foundation.org
Cc:     paulmck@kernel.org, aryabinin@virtuozzo.com, glider@google.com,
        walter-zh.wu@mediatek.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2] rcu: kasan: record and print kvfree_call_rcu call stack
Date:   Fri, 20 Nov 2020 11:34:51 +0800
Message-Id: <20201120033451.29946-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 03:35:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3b0de1b-4a9c-4c05-cd1e-08d88d0544de
X-MS-TrafficTypeDiagnostic: BYAPR11MB3815:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3815D48E0B5593483F07BD2CFFFF0@BYAPR11MB3815.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97yBxsorffVJET5kVCKnsQ1DggDudfcNXvKdx2OVqT0XzBs9qEizwlgCi6m77BEFm93AQZ7NJYtc/iA4uZ/qcVo2X9IQjAVCL19uiFJ0WPv8xs5vR8bC1C0Sz79Hg2/uSOj4gafYzk6f8SyPf3OIgU0Fyx27iq4Fr+WZHc+g1WQJ3PTmeffKj0dxrnqlV/ydBgoYayPQq3etp5+Ry5kLUeDxU1QX/DSw6bWBK4JlEzDJqPfil4VrTGyRDkayXsoGEZCgZKcvSFj8UcBIJYJPyx2DFAfs7G3udc970Hno0Qjgm3hsCoSEHg04L7Eh8g/BfQhDXjTjIFVlxBttqX/AkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39850400004)(366004)(16526019)(9686003)(2616005)(186003)(956004)(6666004)(8936002)(6916009)(83380400001)(6512007)(4326008)(6506007)(26005)(52116002)(66476007)(316002)(66556008)(36756003)(1076003)(8676002)(6486002)(4744005)(2906002)(5660300002)(478600001)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: R7yU3R7czDj/4Keu3eGp1PoyXGf23bLzbyBjqrRzXQupV+0gcs688GFatIeTk6vRlT+Upb843cOVITrliUOxn9oOX58OZZxECxB1b9zIYha6kGaaLTDBuhIgJLaV7LIlrmfKn4y2JHdz0xAhUd+Fv6/FJ1J1lBwEsGjBANWLL8cc5A88QDoYMkOBCfffdJyhjldtPjx/Q7v/wKE8qBx8siGoofOb0UGsu65noUbElYQ7tEdaSne7jejG9F0QjWuYfndu4dXGj9vwH1WfVZETfZgG1aprmTSPjetlssgmI3OdFdOB50FNc4FeBEldRUuFnKY/4/HNpCY0OFBTxzhSRbzfVYl39jeQa3Zsob4znZG5CtySTZYo7qN9Sw/geVnczeFzCyZDZxAnVptUPn4h9i8fi4LAxO7r5Kg9ypT0c50ejUBpwqUhVrJ1wvRoF+p0o5k/6nxQWTOe+2rqtKN6JPk0unv+dcX8/xDiWSecvwQVR1/bosfr3Cg/dvmPsr/29DWp4i6K7eagt8bTrp3oRTP7sZU1AZ0wN4JNJ4pSJ8jOQwCtw2o8v3JE0iv+vR7z3dpAF3zsqJbKxFlB7ZwIqsenWOi7foqR0bg9Bj1ClKD6Mgsd/2tHGpnrse5mSdJa0SoxssJrRzKiLoFewEDkZg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b0de1b-4a9c-4c05-cd1e-08d88d0544de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 03:35:04.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwsaZrfKaZ4JAwaHDdT3xWZlhupZnIdMPZQNYOa0MhHA/RmcJP0Mhq1m6tJtZPRhluuaMp9wf0lKZ6ozfem5AONHXrITOtExcwZvUoaqrlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3815
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Add kasan_record_aux_stack function for kvfree_call_rcu function to
record call stacks.

Cc: Walter Wu <walter-zh.wu@mediatek.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 Add Cc tags.

 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da3414522285..a252b2f0208d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		success = true;
 		goto unlock_return;
 	}
-
+	kasan_record_aux_stack(ptr);
 	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
 	if (!success) {
 		run_page_cache_worker(krcp);
-- 
2.17.1

