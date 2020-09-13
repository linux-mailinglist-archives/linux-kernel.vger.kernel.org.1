Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB84267E32
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 08:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgIMGuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 02:50:05 -0400
Received: from mail-dm6nam12on2092.outbound.protection.outlook.com ([40.107.243.92]:10368
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgIMGuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 02:50:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaSmTQnM7z+xPPl7ncduBMAGpAkybvw2YW1m/AW5rcHdxuavhCWb+9YBRWOtDxNl6HQP85VFWIKvreSfq6NskzDKySCDQqHUv/VE7IPoGJHhN8OF8TvOJMFRkxhY+uVpOtsjxlEW/Luq2LloQazni0ffqdmmJ9oAZ0gMDRzU1h1rD9a2UU/l+eKfnJj6H05O2XEt9bqEk5h0TWtNssH8d2AdX2L4gsYtbnMtrxDQOWM3RI+9YwTdIer1QbiNU7T0AdZeyrfPQI9Ob8gSLU55oypBqjMWS/Kr91ZlY7tjOiL9pzhQucDokkDjXHWQ09vfqA+IhVjrMDeNTrlfkTYuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjdIf9P32dVOtcLTf1H3N4ZSDfQMyRUHiVcRDpJc1SQ=;
 b=nkki04mUdIjpCmbFujpLW3bPX/SBLfoIrDQEwOFXPKW1+FnA7zpMlz/XsNez6ATxPm515fqlSC8O7GCLfo2R9Ew/IIx57hqtejSHlhKOh1MBf18rkGxNXx4QwAeYP19zZUoI3DWN+/cHBJODt0WDbgn+JUy0tERgDecDYXBULI9UAc1WjTqKjMJe0gREYZOuJgi4SKAp9K8IVIuVyDzLzuRCfVxCMBCCZl2rgA16WaYqH+JipYj1EaO+UFtv0NsNbbN8J7VvRLmNyC/2LSdjLqlxj854NwejforA9d8YoHUUfHKNsxkWNsUlNDxXOphOp8tUzVBcSYO0xZjkvLAW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=learner.manipal.edu; dmarc=pass action=none
 header.from=learner.manipal.edu; dkim=pass header.d=learner.manipal.edu;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=learnermanipal.onmicrosoft.com; s=selector2-learnermanipal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjdIf9P32dVOtcLTf1H3N4ZSDfQMyRUHiVcRDpJc1SQ=;
 b=L58oGT08Bs9yBwg7plHodLmjEvycdrf/ckDr9x59C95oGsIsa5QmxT4d+H+CT1/otJ9xvizQCvX2HPehrwHZ9EilcC9DjsV2n8u9d/omqKi4+lh7U9ibBdh/oYumICpOFH38ekzmv7iuvLRwVxgmbFH3qFveocwHei6WGxmMR1g=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=learner.manipal.edu;
Received: from BL0PR01MB4338.prod.exchangelabs.com (2603:10b6:208:37::12) by
 MN2PR01MB5886.prod.exchangelabs.com (2603:10b6:208:188::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Sun, 13 Sep 2020 06:50:01 +0000
Received: from BL0PR01MB4338.prod.exchangelabs.com
 ([fe80::1951:3615:4c27:fb9b]) by BL0PR01MB4338.prod.exchangelabs.com
 ([fe80::1951:3615:4c27:fb9b%6]) with mapi id 15.20.3370.017; Sun, 13 Sep 2020
 06:50:01 +0000
Message-ID: <230f781dcaadfc797a016cc6036d63efe6542062.camel@learner.manipal.edu>
Subject: [RESEND PATCH] staging: rtl8188eu: Fix else after return WARNING
 (checkpatch)
From:   Sohom Datta <sohom.datta@learner.manipal.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 13 Sep 2020 12:19:50 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::18)
 To BL0PR01MB4338.prod.exchangelabs.com (2603:10b6:208:37::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sohom-E480 (223.191.54.119) by BM1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Sun, 13 Sep 2020 06:49:57 +0000
X-Originating-IP: [223.191.54.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e2c4409-7b77-4550-f65d-08d857b13c76
X-MS-TrafficTypeDiagnostic: MN2PR01MB5886:
X-Microsoft-Antispam-PRVS: <MN2PR01MB5886EA795840ADEED632D0CAA7220@MN2PR01MB5886.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ue48ayXtszTTkYR7NDJ1el51gq1sbkglzVk0EOu7Sk3Ugf7qaeZGUMEAqNS2Qwy6mZDcIgKIniWZqTsgmeSy/PSjIJKAkomUAWDH30vOlwNsWwxYoGCqQf6Tp57RT6xJk7DoTjngCkSmYe3FWBkp2XFy+CK3TRLqzuRS3Vf4fZWIG2IomeEq8L95cbSnoXApDO2spPUw7RyeYGC4hqqwg4pMKSQHrrZKGY1wcl4wvKVCFj+E0lcaOcupeV5r/7d8MCM3Rez3SOz0DUdhcaF8mdM/Th/53wdtei2a69zwMvJ1SQk8Sc1cxlP3e9AXogcBgmme8NHpTBe5Uo9t89xL7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4338.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(39860400002)(346002)(396003)(6666004)(316002)(83380400001)(52116002)(786003)(8936002)(2906002)(4326008)(75432002)(44832011)(6496006)(478600001)(16526019)(8676002)(66476007)(66556008)(5660300002)(6486002)(26005)(66946007)(186003)(2616005)(6916009)(956004)(86362001)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FnfoCFOVPzh6r+w1v/bHMg2G3qQ+GvMzIXH4ed2buTWbaXqnpF/5CeDf5Dj4LwNzvssqkEeffQDbKCW48br6GPoImJpUwed13FgAvZB6uSxBavJ/+8Cj8FeXNT0Ybj4Wg2vmHSPvgzC7bjOL9KOZo3GZejt08amDrE0NS6A6PwAXrYMF9wRYOnkSRSQVzi9CGYtBbRrCZDponAdcrJx2MUjR6H3V085ufjcp89K4GqvZvGQiRS8ASeRirbcqHugmNLfuL9aTfVnufr2H3VNNx8OhiGnYxvzEiyf5pMk1oDkqZi+bYR3AfMlivGWdUEEvU/T42USbvhGn7XBinSY7xQ9qi/qJ23iLugu+v27UDU7lesAw1J+iAHp9khJL0vgPFPEVn+qXPeJx9J3CbnJ65REJZu064PqxhGRJzkbuNfq+Uy5tkPmm3I7WeSFHJF/PZlQQt21rvkathE7xiORMIuOZsvHOMKtAtCWwHC4uR2K87GJ05TB7Rchhyc+2+70/SDEM/XqazmBFHchWm1P2WsnxTDfML8EZziFmd2MeAMgsBWG0cHdThq+bpl7ojAuuNnz0Hl+x3IP7zYQ4CVBOmvOI4cUm8xr6wUAvcu4TAI/H2YPub59A/8cL7fdCMP+UZym/sIAEmDY93atUuReprg==
X-OriginatorOrg: learner.manipal.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2c4409-7b77-4550-f65d-08d857b13c76
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4338.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2020 06:50:01.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 29bebd42-f1ff-4c3d-9688-067e3460dc1f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tk59OXOEs2hdI+zhwPjGP+xKCmjdqJswOxBdrBj4eesGvMa7Awo62j22CmA8eHBjPAlvl3cgzSQSmrdxxvROkdhD3wofHaXFkGJXB/WGajY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5886
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 4c8c8f3ff7f4d711daea4ac3bb987fcecc7ef1ed Mon Sep 17 00:00:00 2001
From: Sohom <sohom.datta@learner.manipal.edu>
Date: Sat, 12 Sep 2020 18:04:56 +0530
Subject: [RESEND PATCH] staging: rtl8188eu: Fix else after return WARNING
 (checkpatch)

Fixed:
WARNING: else is not generally useful after a break or return
1636: FILE: ./rtw_recv.c:1636:
+           return false;
+       else

Separated the return statement into a separate block since
it doesn't seem to depend on the SN_LESS explicity being false.

Signed-off-by: Sohom <sohom.datta@learner.manipal.edu>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 5fe7a0458dd2..5e81134ffb6d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1629,10 +1629,11 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl,
 		hdr = list_entry(plist, struct recv_frame, list);
 		pnextattrib = &hdr->attrib;
 
+		if (SN_EQUAL(pnextattrib->seq_num, pattrib->seq_num))
+			return false;
+
 		if (SN_LESS(pnextattrib->seq_num, pattrib->seq_num))
 			plist = plist->next;
-		else if (SN_EQUAL(pnextattrib->seq_num, pattrib->seq_num))
-			return false;
 		else
 			break;
 	}
-- 
2.28.0


