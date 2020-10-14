Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962E128E76B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbgJNTgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:36:49 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:8540 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390803AbgJNTgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:36:42 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09EJOFvZ031201;
        Wed, 14 Oct 2020 14:36:37 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0b-00010702.pphosted.com with ESMTP id 3439x032h2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 14:36:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh79fiP91iv9xSnXOsj79pAY18aPQ1khrVMgFXyQbN1VdzeD0FRUlSrEiHzMhPrUzZpThkO8Y94XAq1ZObCSo7iGHGjaBSkoixMLrYMsYaxHZsoUxka7jNFmRo0pWF++aXCucMekNJJILn77UhgZQodnA/TArBWblF7HrsFXwrLNDzQJq3pvPjeiq+P3YPDFAO5TXmyJ3BK+vuz+XkUlF7xz64o6zrxiUmufDWXQSFPgQpzAiXWVt0QreWsf3nI9BJgmAh/gHfa6xXJGX5g/atVEvV85BsNqe1YPVbxpL72jPDNPWxWKQX8uzaCZo/+sSh2ynKabtMmc+ebMlOMutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83lIL6Pti2VrfAg1OG+bPxPRA8DDQ/LtSiSLrC2CN4w=;
 b=JAM1wOsYD2w47f9Ki3dbElWmJLydZi5SbW2FdoXqsOOjDeZJTIIYn7oDWmad+7Ehh2fG7J/oxb1d0xZuhckhvo6j2hTyI2vMyy1gba+FWLlJPs97+9WZrjiOPrarQxhg2o4CE52wok8Z3/QZpj0P4J9Hvk7Gbjs8c4ZXSpFpydexVhhxFdCYnCq37soFen7VG6AVGukmsksaJh+g2etfZ/QJIbi4nuZHZUZNb2thOMob/3pFa25CyDT+M8LN13ApTBEty3jImKYLF2Fzo+V9+gouRmEtII6d6KGs3TqNnx6maTOL8T3syFdqk3Lkq6XfL5A1sstAFyiUAZWlDY6Zrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83lIL6Pti2VrfAg1OG+bPxPRA8DDQ/LtSiSLrC2CN4w=;
 b=ZHGlurfq3n9kOs28LAcy9pDTWhDaaklza6H5sVllEIcJZMNhElEBbuNJxW9N6Ag+EvcKg+YcjaGicc7OR8OQrLU3QyWTXk6cwfeipGUgssup0Zvk48rlOGgkqY3pEiqMecZgVsyZEnK+OuLxTcaxs2AhaoBUPOhF2Wx76v7LHQc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB3854.namprd04.prod.outlook.com
 (2603:10b6:805:48::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 14 Oct
 2020 19:36:35 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 19:36:35 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saravanak@google.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Michael Auchter <michael.auchter@ni.com>
Subject: [RFC PATCH 2/3] driver core: add device_links_barrier
Date:   Wed, 14 Oct 2020 14:36:14 -0500
Message-Id: <20201014193615.1045792-3-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201014193615.1045792-1-michael.auchter@ni.com>
References: <20201014193615.1045792-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43)
 To SN4PR0401MB3646.namprd04.prod.outlook.com (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 19:36:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e01727-5d8f-48f6-ffad-08d87078763c
X-MS-TrafficTypeDiagnostic: SN6PR04MB3854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB3854F2DE3FF7BCF4B1DAFD2A87050@SN6PR04MB3854.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DylzsFY+xbMb1PaFKRlRmH49sCIdEMUWSKUCnTsbORMW4H9D3tNA0N66O3rQgmLb38ge01OZNPNzwAzj6bhtcX/bwU9eGD2K0osExsCJpOAifJ4khT4z7wo+c9Plfh+f4p8W1L1kNrDd8sa8+FIbBRNEXqerFyYXBC5sDlAPZ46kEWKrm9cMU5hp0QBiCj+33wcwFvWX06d4JKU3OSqCKZxiToZ+f09UeYLCCFwONa5DAb8QCiBM8wEFbsonr1mmYJZfk4oix7GTx2CO+t4lho5bkZVqYZnAOSW04XeqG0FrBRTpyUogU/bBxPNu1M2VEIDjtjBKfPrBw1nDGLDbC3FYdLmrcFjxyrwpYxyzr863/g3p7ZQ99bfyB00D9XAA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(346002)(376002)(186003)(16526019)(6506007)(2616005)(69590400008)(66946007)(83380400001)(86362001)(66476007)(66556008)(8936002)(6666004)(5660300002)(1076003)(36756003)(4326008)(6512007)(2906002)(478600001)(6486002)(44832011)(52116002)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JAOiozgxVNIZuFR2V2hewjl7r2p8n6wNparyhW1lcOjjqO/1dcevpcFcVJB5C8kJWb54PRli7G8hjaWBK7lJQ2c3/UXNaejbEI93RJhleH/edhXZvANn9vcU5CO6zIVEio0fF29TQbp3KvqHrb7bX1a2uNwrI13NxkJV+CmDEmdk+oYAMCTQV299wIrL+8Lfx60fw8+DJYPJlRnlIqsfnudIwdoaIOdqXnmargEq452naoBnfw6/PLkT7XITtqF0XLkP2fzKV/DGZAein5MMwz8sllauyvg0hsWm8wahMaSgLFmjaq1UNrco5T0A49NogV9sLyqu89KfqE3kLmmtpSE1kEIiDRQfQ18BIodHQcUfBU+WQjyZzGQa2dF3aBFg710LYjo0F9kW+AH1B/dgFTQnoB384M7WYEyTaNLqrqI0RmX3WpD1M7NZswH1hMk8t0h8jYtVQbmMPqOnGaIGOtDcoUGfy75HH47kKmA1vXLoss13QcdPj7Wg54/pzz3FzAIap3rY5l4gn+jPe2qzmckvSt/sKEeqb7JmkkQTRxYLfLsTNvFFuAFz07+gymC2QKhDnCFss5n2QorSAxrzsVS5putVE82nZwXCvsFx6Sr0qrSMFAlNV/9IJia1LRbhc9fJVimDwpNLeKXteMIif1Hjrb3pUUBewHMFxFVIJkcDSMKMXXZWkbcWQvSIDUMh0fuGVyFWbNX/3yzivKJ1Pg==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e01727-5d8f-48f6-ffad-08d87078763c
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 19:36:35.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjJBE61AVyAwQqb3Qk9tPuzfe0bgsKScC1WT6idq/smsLjmed529Pj610mlEGmiBdcwn9F+uFvlFDQDxPe2X0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3854
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_11:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010140135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a barrier to wait for all device_links SRCU sections to complete.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/base/core.c    | 10 ++++++++++
 include/linux/device.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bb5806a2bd4c..ef4429c4b1f2 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -82,6 +82,11 @@ int device_links_read_lock_held(void)
 {
 	return srcu_read_lock_held(&device_links_srcu);
 }
+
+void device_links_barrier(void)
+{
+	srcu_barrier(&device_links_srcu);
+}
 #else /* !CONFIG_SRCU */
 static DECLARE_RWSEM(device_links_lock);
 
@@ -112,6 +117,11 @@ int device_links_read_lock_held(void)
 	return lockdep_is_held(&device_links_lock);
 }
 #endif
+
+void device_links_barrier(void)
+{
+}
 #endif /* !CONFIG_SRCU */
 
 /**
diff --git a/include/linux/device.h b/include/linux/device.h
index 9e6ea8931a52..8c47e0beb308 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -977,6 +977,7 @@ void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
+void device_links_barrier(void);
 
 extern __printf(3, 4)
 int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
-- 
2.25.4

