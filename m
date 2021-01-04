Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4212E8FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 04:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbhADDg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 22:36:57 -0500
Received: from mail-bn7nam10on2120.outbound.protection.outlook.com ([40.107.92.120]:27617
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbhADDg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 22:36:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iK7j0Y0BXB/GtG4o/Mt9LGAnLcmgG3CPyF0skZq0mse8ERFjabZKloV87gf3E04bG/ft+pZHitROi+zN8YRDhpk5gqPkTjorLZNQMKPvlXJWiLhPDDAXN8XsgGsNztIhrnb2Eik+8ezEcgpoBbtS7SySf7qFaNCXbKNMTWIchYSsEox/cXi2v1fsWOEHCF6sKrk93VsA9bkS56tc8OHmj0TiNRRZpRak56jXuYYhkavRmNG/qO4cMl+8Rv9FCMrm/erppJ2sAxsWppo883x97U4oxYoS2PL1tGt7QKFESGL2mD5BCM1D1bNfR/GFCOr7wDRm2OY3fgqz9ALju3AUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VonAcHGsb1vJg8C4XQ9UpmmLxZ3dXOH0pdhMcbsglC8=;
 b=TOQWw1XDy+CfLAYrDsQY9NUUDd+rMfbo56EoZrw2KGOqTXhJe/lRPi3PHaTXxsQzc0LcTbIfUSNUf29m+gV9WGR5ANbBaq0V97NBwnwMQuz2KDM1mte+BiBUzDr6P4aIbvzq8vfZzGonsv/8wafpWZrIVPh7OpOqlYfnhbypFT3adx6vWgtFIZzGqVhetQrGepfGenmqQWz7EKXVaFI1LJK46FhNv+V/iGJTmJATTNg49nkVFz2chAN8XNOnsrdw1+sCSTHmoA16N9yO8PZ4Pc3fj4PHRq6oW1wsPLdF/b7h5r8xIrTfsDvYPO9wZfL9XovCQ2TlMZoTa4GuJIQuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VonAcHGsb1vJg8C4XQ9UpmmLxZ3dXOH0pdhMcbsglC8=;
 b=s8+XFA8QiFbmf+NAmKgYMPNveYOoimU58CUfH8isjwC0JItACzMER6pSVS0PW54pBSJHhEYb0USdJkFo7FaDk1cOT6ZZr7wIVYtEBvPK5Jw28Wv7df0SOTWM9dtzky8IsRu74h21vhRVbUS2F3SHxV6ep/fuJ0e3rTOnjSoanqY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR01MB2493.prod.exchangelabs.com (2603:10b6:300:3e::11) by
 MW4PR01MB6371.prod.exchangelabs.com (2603:10b6:303:7b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.21; Mon, 4 Jan 2021 03:36:03 +0000
Received: from MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::65bd:45f4:7fc4:b742]) by MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::65bd:45f4:7fc4:b742%5]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 03:36:03 +0000
From:   Jason Tian <jason@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org
Cc:     jason@os.amperecomputing.com
Subject: [PATCH v2] arm64/ras: Update code to trace out more data for ARM processor
Date:   Mon,  4 Jan 2021 11:35:46 +0800
Message-Id: <20210104033546.2428143-1-jason@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [45.135.186.71]
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To MWHPR01MB2493.prod.exchangelabs.com (2603:10b6:300:3e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 127.0.0 (45.135.186.71) by SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 03:36:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d1e359f-d13a-44a3-e56e-08d8b061dc89
X-MS-TrafficTypeDiagnostic: MW4PR01MB6371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR01MB637177351F23EC9FF66AB8BE80D20@MW4PR01MB6371.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qB6sL0xWNz72CHWSgWt8fY7WeoQ2bbRB9KaHucAuuN1/n4jfAeL3EIpyxpBsFEFtMCszxT5uHKj70JArJc4IRyDDfo4d5b6K8dU4tuUl0OZ0SIDQp7zDxx/tBeHsCpFDpzVU5meN2tHHVHf2cg83xV+ukJsClHT3/KaGXWloaSo1JdpMg66VuLcH91untdhHV2N2FtkrYT39or8TV1xFHcIkIpbzCR2aChvGgqTlG72SwXAKc+m2mDkUIXkX4YWCeZ+imY9Gco2TuzS8+Kcg0vhkIy3poRURz45I2OLSFL95IPPIDkUYbNTQq4c/0bIXOQozctedXMlcd/mepm7YfVnioOn1Wu6S/hK0w9pYtUksKhO/BwlLlEj4ydMmCuc9BsesaVILcUVWZymrrxFYMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2493.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(376002)(346002)(136003)(396003)(8676002)(956004)(8936002)(2616005)(478600001)(1076003)(5660300002)(186003)(107886003)(16526019)(316002)(6666004)(4326008)(2906002)(6486002)(83380400001)(86362001)(26005)(66946007)(66476007)(66556008)(52116002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ioaM96RrceVdugUXiDCPSeTbN5DafuaLilJlrC3MeLBhvPA6WlXi95KhL0tX?=
 =?us-ascii?Q?gAso4nVG0hYgiK2HmOt6E8QcDbv2j303HkWN+6gA7AeTly7i5rHy213gxBAL?=
 =?us-ascii?Q?/qK/U43dV0tbAdWYGzLdlNly+lzjf59a5mlFUAM9nV3Xc+gDqz3DL2N3COEt?=
 =?us-ascii?Q?c0IZoBQqpZbmyoewIyKTqS1PMs/jvSGAm+k24lntgB4nLIZd2Q5dtR4OrxrN?=
 =?us-ascii?Q?u0+iYoMhIa2tjXUkOPEnr4djStgvseDRpo1Z3QezZe3c4qHEjYDIUCmHtD6P?=
 =?us-ascii?Q?q/1fBRSNBnO+Z7pAq82y7AlRDrnQiKAXYZdYjNz+n483cExmn5r+kh9SHasr?=
 =?us-ascii?Q?nM2yA5pTfnDd+JDQLFdSRImrcTJC11Tm3i9PanB86L52DhhLaUXp+XnEvNBS?=
 =?us-ascii?Q?QPCBxHfqz4vDY8tvNlTyC9u7SOi7LZChzbsJj5RsHceymLT8qWBkj5hWwjH8?=
 =?us-ascii?Q?yTmbW/9ZQjfevy25gEG6MYbnPX2xzTMr7VflOIPmw6danPRMNdY9VNwL11X9?=
 =?us-ascii?Q?SHaXmRHOo3owAj7fZeiBwI/8gAtp1OGBsgon+5AveWdJPlu7CzE+BoyCXD4q?=
 =?us-ascii?Q?WMuXtgy0/IlL5kY3TkSmMtmQWZZsVhoni4M8s7PAiemFj+Oq7ORbchbOKoyN?=
 =?us-ascii?Q?/LY3luwG0nsq3CvrS1abPwYT5nz+0zXnqCOwz/IX6DAtzSyFud9Rom9uukQ1?=
 =?us-ascii?Q?6K/iE6jTPkXAJNHDlp5sO/C7JCtoiBKhRIzmUZjTTmF7ICNjV5Y7tIQQXgu/?=
 =?us-ascii?Q?Vr0k4jVA0MaGlkd4ecOYNf2K+wsfzKP3CZMWZQCzLYLUgbhPCZHgx0yGVtuj?=
 =?us-ascii?Q?gzUfAMZjtbUb7b3Z1kbSPtqvElvKFpy2pxBvqeLIlRMrV7gvI56O/nGxXRge?=
 =?us-ascii?Q?nNVbndvRH5VvgBmZYHjZ4IZns8/WNs1qG7YGrJiElfacG0LpE6GsELAIp/w9?=
 =?us-ascii?Q?wPykn5OiEQBsDFC0QPhRu/980uO3xE/3cN2TxBtv4dtVsZe5BbTjd+ToGz/o?=
 =?us-ascii?Q?5/T8?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2493.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 03:36:03.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1e359f-d13a-44a3-e56e-08d8b061dc89
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaNUAjfLdrJ9KoJD/Fi6wyzOlaRH3R7RGBNasqkPGLyEd6PbpPK/roKVWz1i9IZz6kIVA5JD8N5YSwwk9ncNt6gA+QIko16KX1M1KtNhxuoEmKROvuT3IYDFJAlKQPkh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6371
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

