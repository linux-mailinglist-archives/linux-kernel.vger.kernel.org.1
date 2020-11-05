Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F912A89C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgKEW2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:28:24 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:16910 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732370AbgKEW2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:28:23 -0500
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MS8gT018279;
        Thu, 5 Nov 2020 22:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=bDbfz9wOcCrFkJl1QOnLZpd4qktsjHY8WKcw2QZZhg8=;
 b=BeiZfr/kZtzIhZ7Q8gFuhkBlk5FFIcY2U3nKHmedGXK4nxe33w/nbIH8F9Hdj0SVlRft
 dxPIYRzF9gldB30MzqzqU3kSq6W0DW0kDCRj/g13vlM2dhBtEYo58aw1LwPMj9waT8sP
 /uveeErrL5XZcLJcjsziRUmvvtLp7mEr77AXHu8bJtQVxgxJNjSgl8fYaUnPrHSGFAMi
 NYVwB+XV5G4OrIf8CqWc+upYfVbECT7IKuIzHU+UMLhjEo43i4now7ZuyAGm1qdtBYh3
 criU1TcL95dhylBt4EG6eQ16dSElEweRvIWXddhwEl8Wa5EefrMMKhKW1n8qjUU2tNZg MA== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 34kr4tg87w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 22:28:08 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 52D0462;
        Thu,  5 Nov 2020 22:27:57 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id B1D6E48;
        Thu,  5 Nov 2020 22:27:56 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/platform/uv: Fix missing OEM_TABLE_ID
Date:   Thu,  5 Nov 2020 16:27:39 -0600
Message-Id: <20201105222741.157029-2-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201105222741.157029-1-mike.travis@hpe.com>
References: <20201105222741.157029-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_16:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxlogscore=955
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing shows a problem in that the OEM_TABLE_ID was missing for
hubless systems.  This is used to determine the APIC type (legacy or
extended).  Add the OEM_TABLE_ID to the early hubless processing.

Fixes: 1e61f5a95f191 ("Add and decode Arch Type in UVsystab")

Signed-off-by: Mike Travis <mike.travis@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 714233cee0b5..a5794794ea59 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -366,7 +366,7 @@ static int __init early_get_arch_type(void)
 	return ret;
 }
 
-static int __init uv_set_system_type(char *_oem_id)
+static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 {
 	/* Save OEM_ID passed from ACPI MADT */
 	uv_stringify(sizeof(oem_id), oem_id, _oem_id);
@@ -394,6 +394,9 @@ static int __init uv_set_system_type(char *_oem_id)
 		else
 			uv_hubless_system = 0x9;
 
+		/* Copy APIC type */
+		uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
+
 		pr_info("UV: OEM IDs %s/%s, SystemType %d, HUBLESS ID %x\n",
 			oem_id, oem_table_id, uv_system_type, uv_hubless_system);
 		return 0;
@@ -456,7 +459,7 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 	uv_cpu_info->p_uv_hub_info = &uv_hub_info_node0;
 
 	/* If not UV, return. */
-	if (likely(uv_set_system_type(_oem_id) == 0))
+	if (uv_set_system_type(_oem_id, _oem_table_id) == 0)
 		return 0;
 
 	/* Save and Decode OEM Table ID */
-- 
2.21.0

