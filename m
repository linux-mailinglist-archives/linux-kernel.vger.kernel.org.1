Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB20D2E338E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 03:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgL1CB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 21:01:57 -0500
Received: from mail-bn8nam12on2118.outbound.protection.outlook.com ([40.107.237.118]:9940
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbgL1CB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 21:01:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUTjyAbnkBj5jOBL9vFp3sLXbM0zSlvPe3Z1/EMt/mnQJelRc1yCcS/Dc7EzrteGj1gJkK4fa1tRwAxykadq00j6gsaKApjzdy/uIp2GOKsd2O8KE1heJwVt4bAq3RnXwM89L6+P58DcuWmv4xs0L45J5IxA4Aus2OQfgIxvVfsTJ0aBJM0QpnSnEAJ8CAX5rHh8CbC5Mi9FtGEp+sp2otJYenYzNGAtKy1d9H2zQF3ITDQu9gXfFxBzeOGbCKIlHcxpsHi5aDVSKIHS5Ydvv0HreZrp1Edxosm65y0iaymVKPpJUva3NyhcHei8IeEF9URGsU2IFJTvJnm10V8Wlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VonAcHGsb1vJg8C4XQ9UpmmLxZ3dXOH0pdhMcbsglC8=;
 b=lO29OWYfcsUGNHVkYtfqanpsY9MqPze2O4akEvSMyLpxdazhVbDlZu4LkMfptyU+CAA+slbxd4cx0yLd8oQIFmulVSkR2uGX30xBmVWdGyhWdG3Og+Wly/8/S0bJURcsBw2L5Cy13oHRA7QGmDDj67/wWg4KWoZZxbkd+7/NAFkJbrhpahUr9Ylh+qcXQb8ARogn3IvcK1m1dVUvkiWOkmKbU5HyTpCEBXrROsZiilB3VLgIBDCQq75qfR+1hey9z766f+mFtXvfVrgZS6B7bMsnO/qhcF/jRjR8nHcHD4zZHLsnFdFJz6J2HiFCxJwSJWiB42uZG+wtoTHjK+nwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VonAcHGsb1vJg8C4XQ9UpmmLxZ3dXOH0pdhMcbsglC8=;
 b=oavmPQKiwfc8JCtAb0x8kOL/JBT+I6CojPrpTLFETZduicP4SxEWkekpGdMjTE4MwPd46yWk3LQN+jqUiUujD0YayeNT5TrV8qEUZI5Xr4BtOzZFY4Zrg5zgDx7wDFlNT5iasE7FkQUQc8QgrxAS7wCiSREfyfQNbpbE2YuF844=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR01MB2493.prod.exchangelabs.com (2603:10b6:300:3e::11) by
 CO2PR01MB2183.prod.exchangelabs.com (2603:10b6:102:16::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.29; Mon, 28 Dec 2020 02:01:03 +0000
Received: from MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::65bd:45f4:7fc4:b742]) by MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::65bd:45f4:7fc4:b742%5]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 02:01:03 +0000
From:   Jason Tian <jason@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org
Cc:     zwang@amperecomputing.com, jason@os.amperecomputing.com
Subject: [PATCH] ARM64: RAS: Update code to trace out more data for ARM processor
Date:   Mon, 28 Dec 2020 10:00:47 +0800
Message-Id: <20201228020047.2283609-1-jason@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [45.135.186.33]
X-ClientProxiedBy: HK2PR02CA0194.apcprd02.prod.outlook.com
 (2603:1096:201:21::30) To MWHPR01MB2493.prod.exchangelabs.com
 (2603:10b6:300:3e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 127.0.0 (45.135.186.33) by HK2PR02CA0194.apcprd02.prod.outlook.com (2603:1096:201:21::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Mon, 28 Dec 2020 02:01:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 907ab0d9-6282-4de8-948a-08d8aad46e2c
X-MS-TrafficTypeDiagnostic: CO2PR01MB2183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO2PR01MB218369F2BEA588087F466FF680D90@CO2PR01MB2183.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0JlpN9eVl2mIghhRJksrpSjCp0zg+DpMnwEXH2SFXN40Ljwyh7/THj7HDAB13JBvA5ysKNdBse3Ri4yiLyTJHlguATM3b+h52LxKKLNc+Uj8p8KkR2uCiGZZdDNYRJILPKCb0nTM+fRTJXnHC58hPZcRJ8TlCqZJE9M037eS/cbInth/IzLFWBOQ77T/LyPuGht1YUqcoJa/4GlSvfSKIOcRJBuzwRZqHmASZeIGNjOlPzKQhmDJXeS0q9f3MxmcgF8SJkXmGcGmA4Wob3rgvKsav1zmpPy+JIdaQJJKUutEYONXRfKQRnM9lKkIbQKoY4C0Po1TxgAuI0J9OENn+Rc4NS3XkMBvGfx6j1j4XOy0w5ejhm8KgAdjIPHoNC4gSpRGZVgSU1qM+8SGKh4aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2493.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39830400003)(6916009)(107886003)(186003)(26005)(66946007)(16526019)(86362001)(6486002)(83380400001)(66476007)(2906002)(52116002)(2616005)(66556008)(6666004)(1076003)(8936002)(956004)(478600001)(316002)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9Aq7uZ/IUVv/a/S73jHB3zPWBlqnuyOnNv0dKiq64iED9dn/Yl/THFgTtf/g?=
 =?us-ascii?Q?7q40jYzeJb1kmsIAXCz1GOayfcUzimBJTQqS6+tzvZxqAJ++yEXiTEtCy2ik?=
 =?us-ascii?Q?Z3IyudkKQSTNq6949xdtOK5dbhoSYmbMYiB+gKjd04cXdbh5xRe2L8vMLjYZ?=
 =?us-ascii?Q?itLZqyFErz6XypHfqf0fHpKkU0qt95zfYBGi+XMS7q+LQQyqiDQ38WbXH29j?=
 =?us-ascii?Q?ezcAiuqhFws+v6eRLube63YOMggBdAVQTWL/fkFE/IVa++YMpTLrWzExxrCH?=
 =?us-ascii?Q?Yi4yc3lSB+/NdXnZ4J+WOQ115X1uZ5QwaTsoNUHhDujMUA///aAASJaNQ0SP?=
 =?us-ascii?Q?BsbugVEm4ehQvvEDkpSW/8n+UGSEm5J43znRI5JuEzxFXIcWsjL4ecteVrMN?=
 =?us-ascii?Q?RBhD4bTY/tTNaqeaN4ZP4EXc9Gz64CEDA4BJpPrJ/kJThBtNIW0Bk5bQ7gNK?=
 =?us-ascii?Q?B5ss5ap/PdVT2GRjZ5Mn4CAhAZ8r5F6h2yy/mx1x6Eq4RUIMwLX5Cmw5LEQU?=
 =?us-ascii?Q?Vj3hFxwAZgD5GDs2vARuf3pdwYZ9KzW+7dzmMO7/SH7zCledo24Q90pLJdha?=
 =?us-ascii?Q?2MBbZNQ0irjWMZPOiTxfGxyogL2CkULw08V2pBlO9H0FH04vzJY/YGvRi+Tp?=
 =?us-ascii?Q?84EAiwKGPgKkFsLTDIUaakTC8cPJqzI2oc8C1qretT9M4/mZ0fVdcdBQOH6A?=
 =?us-ascii?Q?ofdWtlQBFlsws3b0/nILQPHnTUeJ03sowIZrMYXmQin+xmaMVpwmqvo9zUcu?=
 =?us-ascii?Q?xstJgXdrhqOArvx2XB2W9VqtzOQ0KAhsPWK8qLs1u5GJel4MjTSG/hNX7Day?=
 =?us-ascii?Q?kBtzhc3XKCVGQvR4f2UP6/CS+1He5AnABamHS43BHYc30d7fBAk8iGmSx3Ko?=
 =?us-ascii?Q?o9loGbKxHn1zXGfiaQ56gSaIDTh5XGJyK/IdvNjtc3alcLs0LU/8sQmMNvcX?=
 =?us-ascii?Q?iJYdxWn7c9WmloGCgFu2lBA7r4yW/9kNysengMRp+rtqU5vniY8BtG6cuDzm?=
 =?us-ascii?Q?Zt01?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2493.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 02:01:02.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-Network-Message-Id: 907ab0d9-6282-4de8-948a-08d8aad46e2c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrqpr6mbTwUysMCwH4bZGAR6FM66bvMUrjOBBLvQRWyzeyIwk6CgylAcMOuNeQ64IgxbDVlPU5aV7578V/TQXkSrKjpmWfW55xhkn66fPnqRJnOmYXMZQrKUCqcybSb2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2183
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original arm_event trace code only traces out ARM processor
error information data. According to UEFI_2_8_A_Feb14 specification
chapter N2.4.4, the ARM processor error section includes several
ARM processor error information, several ARM processor
context information and several vendor specific error
information structures.

Add code to trace out all ARM processor context information and
vendor specific error information with raw hex format.

Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
---
 drivers/ras/ras.c       | 22 +++++++++++++++++++++-
 include/ras/ras_event.h | 41 +++++++++++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 3f3890732..a0a6b2f87 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -23,7 +23,27 @@ void log_non_standard_event(const uuid_le *sec_type, const uuid_le *fru_id,
 
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
 {
-	trace_arm_event(err);
+	u32 pei_len;
+	u32 ctx_len;
+	u32 vsei_len;
+	u8 *pei_err;
+	u8 *ctx_err;
+	u8 *ven_err_data;
+
+	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
+	pei_err = (u8 *) err + sizeof(struct cper_sec_proc_arm);
+
+	ctx_len = sizeof(struct cper_arm_ctx_info) * err->context_info_num;
+	ctx_err = pei_err + sizeof(struct cper_arm_err_info) *
+		err->err_info_num;
+
+	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
+					  pei_len + ctx_len);
+	ven_err_data = ctx_err + sizeof(struct cper_arm_ctx_info) *
+					  err->context_info_num;
+
+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+			ven_err_data, vsei_len);
 }
 
 static int __init ras_init(void)
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index a0794632f..7b1082774 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -168,11 +168,22 @@ TRACE_EVENT(mc_event,
  * This event is generated when hardware detects an ARM processor error
  * has occurred. UEFI 2.6 spec section N.2.4.4.
  */
+ #define APEIL "ARM Processor Err Info data len"
+ #define APEID "ARM Processor Err Info raw data"
+ #define APECIL "ARM Processor Err Context Info data len"
+ #define APECID "ARM Processor Err Context Info raw data"
+ #define VSEIL "Vendor Specific Err Info data len"
+ #define VSEID "Vendor Specific Err Info raw data"
 TRACE_EVENT(arm_event,
 
-	TP_PROTO(const struct cper_sec_proc_arm *proc),
+	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
+		const u32 pei_len,
+		const u8 *ctx_err,
+		const u32 ctx_len,
+		const u8 *oem,
+		const u32 oem_len),
 
-	TP_ARGS(proc),
+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len),
 
 	TP_STRUCT__entry(
 		__field(u64, mpidr)
@@ -180,6 +191,12 @@ TRACE_EVENT(arm_event,
 		__field(u32, running_state)
 		__field(u32, psci_state)
 		__field(u8, affinity)
+		__field(u32, pei_len)
+		__dynamic_array(u8, buf, pei_len)
+		__field(u32, ctx_len)
+		__dynamic_array(u8, buf1, ctx_len)
+		__field(u32, oem_len)
+		__dynamic_array(u8, buf2, oem_len)
 	),
 
 	TP_fast_assign(
@@ -199,12 +216,24 @@ TRACE_EVENT(arm_event,
 			__entry->running_state = ~0;
 			__entry->psci_state = ~0;
 		}
+		__entry->pei_len = pei_len;
+		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
+		__entry->ctx_len = ctx_len;
+		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
+		__entry->oem_len = oem_len;
+		memcpy(__get_dynamic_array(buf2), oem, oem_len);
 	),
 
-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
-		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; running state: %d; "
+		"PSCI state: %d; %s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
+		__entry->affinity, __entry->mpidr, __entry->midr,
+		__entry->running_state, __entry->psci_state,
+		APEIL, __entry->pei_len, APEID,
+		__print_hex(__get_dynamic_array(buf), __entry->pei_len),
+		APECIL, __entry->ctx_len, APECID,
+		__print_hex(__get_dynamic_array(buf1), __entry->ctx_len),
+		VSEIL, __entry->oem_len, VSEID,
+		__print_hex(__get_dynamic_array(buf2), __entry->oem_len))
 );
 
 /*
-- 
2.25.1

