Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96A284197
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgJEUkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:40:40 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:40900 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729334AbgJEUkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:40:32 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095KbwxE017854;
        Mon, 5 Oct 2020 20:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=y7Z/ElFkP6MNCRDJkoZga1Bireej3j8Jo3cWLtIRDt4=;
 b=BC0KQ1LnOr4aXntizTRuH60sTaAnS+YO7bo3LupzxH/ohXwu+6op6ypBVE4yC11LOEh0
 JKNGruP23xiHrwMBhghzt/wGttfguJdrW+yUGLIfZnNqeARoXmgnlpFuyaWWB9v5tuy1
 KwnIbcgtluuMvpgl45LbHRM7i7Q7HKxqYjTNyagV+VN9JX7c+cQ5ZKuxf2V/CORZ78jR
 HUUFFbcLxH9sjG0irPQWd0kJ7ZY9q7bFBEgFF3nD7u6QRDXckqAvMvxBiDZfKDSFmMaf
 3UwB25SoXPGEenSQtrOb4XmjUjbZVeYl9D+y7x4Dc9/FzsvXOsZeQZGMXJ+fKRqhngAy Bg== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 33xg9n3e9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 20:40:06 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 438276A;
        Mon,  5 Oct 2020 20:40:04 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 0A38548;
        Mon,  5 Oct 2020 20:40:02 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mike Travis <mike.travis@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 08/13] x86/platform/uv: Adjust GAM MMR references affected by UV5 updates
Date:   Mon,  5 Oct 2020 15:39:24 -0500
Message-Id: <20201005203929.148656-9-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201005203929.148656-1-mike.travis@hpe.com>
References: <20201005203929.148656-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_15:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make modifications to the GAM MMR mappings to accommodate changes for UV5.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f2c5a03b5cf7..948029576441 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -927,12 +927,32 @@ static __init void map_gru_high(int max_pnode)
 
 static __init void map_mmr_high(int max_pnode)
 {
-	union uvh_rh_gam_mmr_overlay_config_u mmr;
-	int shift = UVH_RH_GAM_MMR_OVERLAY_CONFIG_BASE_SHFT;
+	unsigned long base;
+	int shift;
+	bool enable;
+
+	if (UVH_RH10_GAM_MMR_OVERLAY_CONFIG) {
+		union uvh_rh10_gam_mmr_overlay_config_u mmr;
+
+		mmr.v = uv_read_local_mmr(UVH_RH10_GAM_MMR_OVERLAY_CONFIG);
+		enable = mmr.s.enable;
+		base = mmr.s.base;
+		shift = UVH_RH10_GAM_MMR_OVERLAY_CONFIG_BASE_SHFT;
+	} else if (UVH_RH_GAM_MMR_OVERLAY_CONFIG) {
+		union uvh_rh_gam_mmr_overlay_config_u mmr;
+
+		mmr.v = uv_read_local_mmr(UVH_RH_GAM_MMR_OVERLAY_CONFIG);
+		enable = mmr.s.enable;
+		base = mmr.s.base;
+		shift = UVH_RH_GAM_MMR_OVERLAY_CONFIG_BASE_SHFT;
+	} else {
+		pr_err("UV:%s:RH_GAM_MMR_OVERLAY_CONFIG MMR undefined?\n",
+			__func__);
+		return;
+	}
 
-	mmr.v = uv_read_local_mmr(UVH_RH_GAM_MMR_OVERLAY_CONFIG);
-	if (mmr.s.enable)
-		map_high("MMR", mmr.s.base, shift, shift, max_pnode, map_uc);
+	if (enable)
+		map_high("MMR", base, shift, shift, max_pnode, map_uc);
 	else
 		pr_info("UV: MMR disabled\n");
 }
-- 
2.21.0

