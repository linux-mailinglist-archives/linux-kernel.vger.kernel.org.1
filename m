Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F6C2C6EBE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 05:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgK1ECR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 23:02:17 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:43890 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730991AbgK1Dnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 22:43:50 -0500
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AS3cpFT011940;
        Sat, 28 Nov 2020 03:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=24akV8Ya8RoKe3CU3rPNfvY3ectYNJNlA27cMRIlZKw=;
 b=Ve3MwMhFi+0IRIWU7HJo7wg9e7J7Qj412TGMoC8zQZPH53IiphYDziwMX7Jabu5AEyiz
 vzZ4WbOy/Lrrlz5OdNkup+VPg/fH+2EbhW4q2K2lfuW6KR1KK1r7gtlRYi+eKkmDyaXL
 h7La55UmPRovWoCFrLgNsKADEUygRHYE/98J6i22rKk6VN3yNOF6xLtoJ7n7hvGUKwym
 3mAyXoUaC9flpEwy7X6yinjtFaNftMTu+167ITmXMDwvd4ze/QJ7afPh4iLh0i0f3pke
 1sfJbVl/UVuv4aEFOXoqDLdbthARkoVU0wNhLQCt2rcjfdWQR/E4CNfmCKHRdz0K5bUq ZQ== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 3532m2m0dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Nov 2020 03:42:57 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 1950766;
        Sat, 28 Nov 2020 03:42:57 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 1BCA84A;
        Sat, 28 Nov 2020 03:42:56 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 4/5] x86/platform/uv: Add deprecated messages to /proc info leaves
Date:   Fri, 27 Nov 2020 21:42:26 -0600
Message-Id: <20201128034227.120869-5-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201128034227.120869-1-mike.travis@hpe.com>
References: <20201128034227.120869-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_02:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011280025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "deprecated" message to any access to old /proc/sgi_uv/* leaves.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 48746031b39a..4248579825fb 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1615,21 +1615,33 @@ static void check_efi_reboot(void)
 		reboot_type = BOOT_ACPI;
 }
 
-/* Setup user proc fs files */
+/*
+ * User proc fs file handling now deprecated.
+ * Recommend using /sys/firmware/sgi_uv/... instead.
+ */
 static int __maybe_unused proc_hubbed_show(struct seq_file *file, void *data)
 {
+	pr_notice_once(
+		"%s: using deprecated /proc/sgi_uv/hubbed, use /sys/firmware/sgi_uv/hub_type\n",
+		current->comm);
 	seq_printf(file, "0x%x\n", uv_hubbed_system);
 	return 0;
 }
 
 static int __maybe_unused proc_hubless_show(struct seq_file *file, void *data)
 {
+	pr_notice_once(
+		"%s: using deprecated /proc/sgi_uv/hubless, use /sys/firmware/sgi_uv/hubless\n",
+		current->comm);
 	seq_printf(file, "0x%x\n", uv_hubless_system);
 	return 0;
 }
 
 static int __maybe_unused proc_archtype_show(struct seq_file *file, void *data)
 {
+	pr_notice_once(
+		"%s: using deprecated /proc/sgi_uv/archtype, use /sys/firmware/sgi_uv/archtype\n",
+		current->comm);
 	seq_printf(file, "%s/%s\n", uv_archtype, oem_table_id);
 	return 0;
 }
-- 
2.21.0

