Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416212AE545
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbgKKBFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:05:01 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:34296 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731982AbgKKBFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:05:01 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AB0wJIF008620;
        Wed, 11 Nov 2020 01:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=gj4FGYPPEFu5y5//Sn6dcPRQx9fXFoM5v85DlCNQGHk=;
 b=ZbNwdIHhcOLLmpF/SqzMuOYiVsAu4h/2+1AlvdazhBovEgclDgMc6CHlmgzd2hCO5pqb
 i17awatACudMYQeE+CH5LYgnsPpK91+gDS8vT9b4yrxDZvhCteX8TsgmCYcR9XISDTBc
 mKsAXgzOaduTaHw2PT0KU7qdUnoQIcmuPW5uqkTYvgWEZAti1VxkTQi8R0AAYfe6mtfL
 WQVVaUWXUtT6wbl6EmSdGRuunFlZyyJyQ15AgDz9+faTDInYw4ZEPlSoVYuRyuoUh7f2
 BeKZuY3CvCH/lcMm/kH7g9ckFPNHVIv7qETDAc1EGMwymi06HJkU8CmG1rl45oFiM41n sQ== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 34nmh6w17n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 01:04:28 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 3A98AA1;
        Wed, 11 Nov 2020 01:04:28 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 4D9B14C;
        Wed, 11 Nov 2020 01:04:27 +0000 (UTC)
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
Subject: [PATCH] x86/platform/uv: UV5 Fix copied output archtype
Date:   Tue, 10 Nov 2020 19:04:18 -0600
Message-Id: <20201111010418.82133-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_09:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test shows that the output contains a space:
    # cat /proc/sgi_uv/archtype
    NSGI4 U/UVX
Remove that embedded space by copying the "trimmed" buffer instead of the
untrimmed input character list.  Use sizeof to remove size dependency
on copy out length.  Increase output buffer size by one character just
in case BIOS sends an 8 character string for archtype.

Fixes: 1e61f5a95f191 (Add and decode Arch Type in UVsystab)

Signed-off-by: Mike Travis <mike.travis@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 3115caa7d7d0..1b98f8c12b96 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -33,7 +33,7 @@ static union uvh_apicid		uvh_apicid;
 static int			uv_node_id;
 
 /* Unpack AT/OEM/TABLE ID's to be NULL terminated strings */
-static u8 uv_archtype[UV_AT_SIZE];
+static u8 uv_archtype[UV_AT_SIZE + 1];
 static u8 oem_id[ACPI_OEM_ID_SIZE + 1];
 static u8 oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 
@@ -320,7 +320,7 @@ static int __init decode_arch_type(unsigned long ptr)
 
 	if (n > 0 && n < sizeof(uv_ate->archtype)) {
 		pr_info("UV: UVarchtype received from BIOS\n");
-		uv_stringify(UV_AT_SIZE, uv_archtype, uv_ate->archtype);
+		uv_stringify(sizeof(uv_archtype), uv_archtype, uv_ate->archtype);
 		return 1;
 	}
 	return 0;
@@ -378,7 +378,7 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 	if (!early_get_arch_type())
 
 		/* If not use OEM ID for UVarchtype */
-		uv_stringify(UV_AT_SIZE, uv_archtype, _oem_id);
+		uv_stringify(sizeof(uv_archtype), uv_archtype, oem_id);
 
 	/* Check if not hubbed */
 	if (strncmp(uv_archtype, "SGI", 3) != 0) {
-- 
2.21.0

