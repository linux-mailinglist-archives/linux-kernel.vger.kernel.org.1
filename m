Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD762C46CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732852AbgKYRaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:30:00 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:30420 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731911AbgKYR37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:29:59 -0500
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APHNm3H000954;
        Wed, 25 Nov 2020 17:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=+oQ5tDT0s75+3qBxLOfxh0HLP+klCcDrGLxiwEJJ1bs=;
 b=Ki9P8BBTIFMwIo/NTZSkgfSf/7nz/sh/HtDxnD/riulbLyzpK9X9yDP1NgN2WZUUGnVn
 oSrjvlMn6kMnfgqriYCIfPqKE3EqGh6nhZie41QJVA5K4Ej6jlvJF7oJSRb71z16bbMB
 5kcmLhIwNJASFvPJOwJPipKUXJM0+7glAim4hekKHeGp2cDbJUwJLiM9VStL+/nJ/ZRf
 dMVxrBjjTRIgvAeXaq4cSYaLMSV0WzCbkIKYL8E+tQuL4xtAoMuJ6pC1NMTNHfNiuf+N
 H2elAA674cwtj+mcR1SgmYZmSz3bw+TXQBrOr6ldBrfT+dw8o+Lt//TATagrEg/PM8Ir YQ== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 3517pqs84m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 17:29:38 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 0958CC7;
        Wed, 25 Nov 2020 17:29:38 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 1718837;
        Wed, 25 Nov 2020 17:29:37 +0000 (UTC)
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
Subject: [PATCH 1/5] x86/platform/uv: Add kernel interfaces for obtaining system info.
Date:   Wed, 25 Nov 2020 11:29:03 -0600
Message-Id: <20201125172907.240996-2-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201125172907.240996-1-mike.travis@hpe.com>
References: <20201125172907.240996-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_10:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=965
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel interfaces used to obtain info for the uv_sysfs driver
to display.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/bios.h     |  2 ++
 arch/x86/kernel/apic/x2apic_uv_x.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 01ba080887b3..1b6455f881f9 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -200,6 +200,8 @@ extern long sn_partition_id;
 extern long sn_coherency_id;
 extern long sn_region_size;
 extern long system_serial_number;
+extern ssize_t uv_get_archtype(char *buf, int len);
+extern int uv_get_hubless_system(void);
 
 extern struct kobject *sgi_uv_kobj;	/* /sys/firmware/sgi_uv */
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1b98f8c12b96..48746031b39a 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -502,6 +502,18 @@ enum uv_system_type get_uv_system_type(void)
 	return uv_system_type;
 }
 
+int uv_get_hubless_system(void)
+{
+	return uv_hubless_system;
+}
+EXPORT_SYMBOL_GPL(uv_get_hubless_system);
+
+ssize_t uv_get_archtype(char *buf, int len)
+{
+	return scnprintf(buf, len, "%s/%s", uv_archtype, oem_table_id);
+}
+EXPORT_SYMBOL_GPL(uv_get_archtype);
+
 int is_uv_system(void)
 {
 	return uv_system_type != UV_NONE;
-- 
2.21.0

