Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE0279D6A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 04:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgI0CFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 22:05:07 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:42101 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726311AbgI0CFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 22:05:06 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Sep 2020 22:05:04 EDT
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1601172303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1JoAQ+dcjwZuG93IXWZlpEmKIUn+A5R6DAQKKab5MDs=;
        b=EoiCu4lvw+Py+OUq+akrXs9lvUMG2nHVWiZWeO0HWt2fvaKiULlGkynIt7xuK63CFtH/Yu
        K4iKjGkN79BdUlyalmWrL2BYNY5QXi/PKYJfg88HbPpGewsWmIXc6IZZWNEwnL6yh20sCi
        kgzEuBAg+nYSYmuqR6eVoxHEJo3p/Ms=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-2-AtXyf5s2Od2lkqyZBQ-69Q-1;
 Sun, 27 Sep 2020 03:58:45 +0200
X-MC-Unique: AtXyf5s2Od2lkqyZBQ-69Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3AltAK3jr6SZp3jhn6mPVrUbLgyE2v/cUc2dT8K7HdSeDr11uSkPLQyWg98wHe8aVz73rXoLufGVA0qp4kn6GGXi+F+c1MmeFHXXcTpW1NAATf1cBtrbweybi/ADhPcW3f/WTRtd+yy2YVbYOln2IGO4uU9Mq8FpeRiIIEzWYRT4ck5ZB/E/WxgoUH52gSAmevXUdqOfn60zoSTVHWhwBU73NFRqT2oRqaZlwtVS+TEtuYg0bbcEBlU65cw7kZSHNsi1zfZI5sWf+T3KvKQE/W+Sp+5dd39u+9QPa9bCrdNoa0z2GLARmeSDmcols3F0XjV0AJcXjTdOONI/s2TLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JoAQ+dcjwZuG93IXWZlpEmKIUn+A5R6DAQKKab5MDs=;
 b=DffPxzToriI4nPsrEK3hcc+HjEJ1kD/4azqqNuvVbR4VMbiC4+Wassu7ZqTskmekLjCCbnIbuR+12up4Xbi77DBnYTo9l1IxMBbIievW+M0RT8uYc8Alb+AQwLPqL3v8+Lq3PASFZOaF9SjoppMF46gio/qrW1kVxPFQTa93IWX4qHpigzTXMoNtSaVPvIkgG3cvUAssII4iFBT3f4mMpgSD/qRZF1ADdC/A/ra5rG92G1rKGwxsDP4/UFzX2MKJ0yzjeSZgVgl667c5v6u7Qn+2e/kCXIolbxOM6leaGucnGx24lq4K0jF0SGX5v/yF7IQEoXpJJf+S/cgdLhNA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: fasheh.com; dkim=none (message not signed)
 header.d=none;fasheh.com; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3514.eurprd04.prod.outlook.com (2603:10a6:7:83::19)
 by HE1PR0401MB2379.eurprd04.prod.outlook.com (2603:10a6:3:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Sun, 27 Sep
 2020 01:58:42 +0000
Received: from HE1PR0402MB3514.eurprd04.prod.outlook.com
 ([fe80::2c5c:be94:3a07:4528]) by HE1PR0402MB3514.eurprd04.prod.outlook.com
 ([fe80::2c5c:be94:3a07:4528%6]) with mapi id 15.20.3391.027; Sun, 27 Sep 2020
 01:58:41 +0000
From:   Gang He <ghe@suse.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     Gang He <ghe@suse.com>, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, akpm@linux-foundation.org
Subject: [PATCH] ocfs2: fix potential soft lockup during fstrim
Date:   Sun, 27 Sep 2020 09:58:15 +0800
Message-Id: <20200927015815.14904-1-ghe@suse.com>
X-Mailer: git-send-email 2.12.3
Content-Type: text/plain
X-ClientProxiedBy: CY4PR2201CA0007.namprd22.prod.outlook.com
 (2603:10b6:910:5f::17) To HE1PR0402MB3514.eurprd04.prod.outlook.com
 (2603:10a6:7:83::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ghe-pc.suse.asia (60.251.47.115) by CY4PR2201CA0007.namprd22.prod.outlook.com (2603:10b6:910:5f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3412.20 via Frontend Transport; Sun, 27 Sep 2020 01:58:38 +0000
X-Mailer: git-send-email 2.12.3
X-Originating-IP: [60.251.47.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a725b491-9745-42ae-48df-08d86288dba3
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2379:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB23795743D5DA622C0E05F142CF340@HE1PR0401MB2379.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /naKFuGTB7ehtoABqUwhQs1h5kxo2H9qdg6TdnSeMX5PrRtny06BNnUdJwYP4YFwhpIFVb2c00xSQZUqBX+OUAzaxm6G+opnRzEycb5WGOUxyCJdopSttldhW4U6UGKjQItabAxjM++skaRGn+b5n0320oFA3i4Rn2YVrwfN3VIZexsHWZSb2twI1zHgYiaOOo3ZEvu9Zg9zR39MVJB9K3UbidcJeqOy0QhcmwEKhR3DQ3ZNoSOoN3rBQCxh9rtvBN8mKBAbixsCY0zeqHU+EJTkoivHgBgTzrdxXdhCTZTaQ0Kccd5pSrq1H9hgHwue3YMPLcvMAHazYRAhgBLvq5YRXH39vKR/71cVgfQu7CMibGpyRmCV1Vf3F4aED1d2K21/M3pXKgvTYGY3aiCmmWpk2H0c6wqFQDBl4xETzYxP1Ycztl3ERfbE5B/f4ILQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3514.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(2616005)(8936002)(478600001)(6486002)(8676002)(5660300002)(66476007)(4326008)(66946007)(956004)(6512007)(66556008)(6666004)(16526019)(2906002)(1076003)(36756003)(186003)(26005)(6506007)(316002)(86362001)(55236004)(83380400001)(52116002)(16060500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oMWU1AtSedkpyfUdanYD69RbuRxbLrE+p5ebXMuGn+WkvFxylYLQx9CrMSw1s2FCOjzTgVXxjZdXLEL6HYMSpBthql84IGhLqyTvB8wWim9H68BqXXc6viHvQHVG4MTH5ln5e0KSvxBuzojXehAT19sw+YFSoq7XFrpnwbryNy66eGxlHIz9X0BoBVK5ApDTuX+C8diF/vwzgjWDd20NMPFXQUUNG65w10oco6OiO594vvzzOlQjZHS68YnyeSNXBKCU1FlEyemNUI/2f3Ok7Byyap/ET4CkViPy8t/wzuDF+HPZtIfw5KlnNp/RLMvcaEBgnfrTil3dEa+AA2VVwNi2tJsxjd16q/uP1zTYxk8IdozDA2hNOV6OoNf+gs7neLIWmt/AKexazqBGA/usQp1/Fyez1NiDJn9ZIF2Rs04HVRrF22gCKI2/YYlU+nVqCgGjQFzc3i0P/Q3e5gC5X8d23h3l8qtp/3lGzeV/EXDtnPvaZkja4PQySpfCOBFnHXjhlNQoCc4uH3c6ewyW2ZihDUfecs/md8CtQd07dY9nS7M6shXxfcL3eM5sQ4avBFaVFpKBYI2ioSVa5igih/UnyA7i7X9yQVC6X9VfF8zzW1/P6efNUwg7dqSCgIpJ8xGPR2a+14GNCYxaij4gjQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a725b491-9745-42ae-48df-08d86288dba3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3514.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2020 01:58:41.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFYRFUc4w6kFPn6oaDETSk+h+sbUY5Pp+HnY8cNP9/DaxV8faZUGvhrDK+0dx/6x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2379
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we discard unused blocks on a mounted ocfs2 filesystem, fstrim
handles each block goup with locking/unlocking global bitmap meta-file
repeatedly. we should let fstrim thread take a break(if need) between
unlock and lock, this will avoid the potential soft lockup problem,
and also gives the upper applications more IO opportunities, these
applications are not blocked for too long at writing files.

Signed-off-by: Gang He <ghe@suse.com>
---
 fs/ocfs2/alloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 4c1b90442d6f..2cf9321919b5 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7654,8 +7654,10 @@ int ocfs2_trim_mainbm(struct super_block *sb, struct fstrim_range *range)
 	 * main_bm related locks for avoiding the current IO starve, then go to
 	 * trim the next group
 	 */
-	if (ret >= 0 && group <= last_group)
+	if (ret >= 0 && group <= last_group) {
+		cond_resched();
 		goto next_group;
+	}
 out:
 	range->len = trimmed * sb->s_blocksize;
 	return ret;
-- 
2.21.0

