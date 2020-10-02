Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0831280B9C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 02:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgJBAYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 20:24:44 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:6900 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbgJBAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 20:24:44 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092054ZC005626;
        Fri, 2 Oct 2020 00:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=4wSX3Q07/QzZpnEqGMY61fdXNEMXIjXkb9tZJKr7TVI=;
 b=mXpXJkdz8itqYy4r1pp3U2yodGje542tzub+JuXJ1HARKSPcWn7ZWFxIMyHQKLYn7vFI
 GjZ0Lx5gLcHFfLwc+2oNzUl5R17yvEVfRTEm0zWb3bwVOl6QhWk/0fz/kQQu0FLVnPGh
 GMHPLmzSOv05ty0TXTnnfHZsPIc90irmAX1QqzudBaS8nAJuNJxvCq1HdmhR5IfTJOqL
 ndsPCcz3HVVOGcsBKRUHoKXsIyBKeuUvRQSOFpCSKKuF1PIG10S0LGzNRZLaHlTnnGNt
 t1DvDvrSV1pMeOEWznp7Wb4uGbdgWL2KqA7zSC/2z4w8g1JY0YRHkkZCZP7RYFmNB1RR rw== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 33vb2rnh8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 00:06:28 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 5779D85;
        Fri,  2 Oct 2020 00:06:28 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 3F8323A;
        Fri,  2 Oct 2020 00:06:27 +0000 (UTC)
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
Subject: [PATCH v3 08/13] x86/platform/uv: Adjust GAM MMR references affected by UV5 updates
Date:   Thu,  1 Oct 2020 19:05:33 -0500
Message-Id: <20201002000538.94424-9-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201002000538.94424-1-mike.travis@hpe.com>
References: <20201002000538.94424-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_10:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=961 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010195
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
index 746a56466066..9f89c1e82df0 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -931,12 +931,32 @@ static __init void map_gru_high(int max_pnode)
 
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

