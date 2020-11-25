Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FC22C46CD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbgKYRaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:30:02 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:37626 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732839AbgKYRaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:30:00 -0500
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APHS3vE005417;
        Wed, 25 Nov 2020 17:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=YigZqEC/I0cyKmhNEyT4SOhl7g9ARpOKi+XCmmQh28I=;
 b=lzJq54GC4HvGUbTKIBCgm3S6wjYUQZZv28RzuYPTcVMbWYhlw1WEmwPYZ3OzKUxBnc/B
 yFn4HgYyfVi0YLCmxBeAOQnySZ/Z2fq+SFsCx6f6OcTkL0lLrUHFZ+Tw9WIUy0OsglMb
 YqoeYmFKX1klECnuBlFWGIg5JCExe9VY9MfjVnwMRw1wv9Is9tZy62ekcJCz3YB7pnQz
 3aeDKDdkgpe35BTkEGVV27MldgfTcU3JYrZdjsCoAXZmr8UGwOYxwqPNq8By+u7bvlz2
 pwYt4o+BIGb8aJcP48WM6IFgKShHgGJnH0gZy+NTcrXcF+bu3AFoiUBY2mWArNJhHD1P Nw== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 351gycdfdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 17:29:41 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 03F0390;
        Wed, 25 Nov 2020 17:29:41 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 143DF39;
        Wed, 25 Nov 2020 17:29:40 +0000 (UTC)
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
Subject: [PATCH 4/5] x86/platform/uv: Add deprecated messages to /proc info leaves
Date:   Wed, 25 Nov 2020 11:29:06 -0600
Message-Id: <20201125172907.240996-5-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201125172907.240996-1-mike.travis@hpe.com>
References: <20201125172907.240996-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_10:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "deprecated" message to any access to old /proc/sgi_uv/* leaves.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 48746031b39a..bfd77a00c2a1 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1615,21 +1615,45 @@ static void check_efi_reboot(void)
 		reboot_type = BOOT_ACPI;
 }
 
-/* Setup user proc fs files */
+/*
+ * User proc fs file handling now deprecated.
+ * Recommend using /sys/firmware/sgi_uv/... instead.
+ */
+static void proc_print_msg(int *flag, char *what, char *which)
+{
+	if (*flag)
+		return;
+
+	pr_notice(
+		"%s: using deprecated /proc/sgi_uv/%s, use /sys/firmware/sgi_uv/%s\n",
+		current->comm, what, which ? which : what);
+
+	*flag = 1;
+}
+
 static int __maybe_unused proc_hubbed_show(struct seq_file *file, void *data)
 {
+	static int flag;
+
+	proc_print_msg(&flag, "hubbed", "hub_type");
 	seq_printf(file, "0x%x\n", uv_hubbed_system);
 	return 0;
 }
 
 static int __maybe_unused proc_hubless_show(struct seq_file *file, void *data)
 {
+	static int flag;
+
+	proc_print_msg(&flag, "hubless", NULL);
 	seq_printf(file, "0x%x\n", uv_hubless_system);
 	return 0;
 }
 
 static int __maybe_unused proc_archtype_show(struct seq_file *file, void *data)
 {
+	static int flag;
+
+	proc_print_msg(&flag, "archtype", NULL);
 	seq_printf(file, "%s/%s\n", uv_archtype, oem_table_id);
 	return 0;
 }
-- 
2.21.0

