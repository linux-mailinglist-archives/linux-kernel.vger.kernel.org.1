Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A48F28D178
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgJMPrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:47:51 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:2106 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731228AbgJMPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:47:50 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09DFkshV018125;
        Tue, 13 Oct 2020 15:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=TqTvTpJ/4FrLzIjc58f5bSHCXa5YAfsXATheYZQFDnE=;
 b=lqKOQOyMRXdzo2kJBIVnNIFOEaUxmuVNAJQeg/N2BtiZ74ujEYOJYsNMb1sbp7gGbNUp
 4/ywt4JH3PfBIcBQ6TI6GGLpQnBlW20AqyFMXqZOVlkvH8EBURuNiAKy8BSYfEqwiDv5
 qgo23ljZCPF2TJAUplj7mf86/h7bskmIU5DS2UVhv5HmuR6u8DSUNFZPCDllqsANRZI6
 o5tPFBzIue1jgYhpWiPOAiuWNs9o1zAMCgVgUpsRL+ChkJ4N8zcUxqwr45QRAaNa8A4S
 DWMTX8F8FmT/t8bzNey3shiOWDq20uT0ROR1vcwXZUcRYUzmrwGXp7kUZQmo+KG4l5Wy jA== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 344e3c0buh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 15:47:44 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 150FD62;
        Tue, 13 Oct 2020 15:47:42 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 700074A;
        Tue, 13 Oct 2020 15:47:42 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/platform/uv: Remove unused variable in UV5 NMI handler
Date:   Tue, 13 Oct 2020 10:47:31 -0500
Message-Id: <20201013154731.132565-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-13_08:2020-10-13,2020-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unused variable.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
---
 arch/x86/platform/uv/uv_nmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 0f5cbcf0da63..eafc530c8767 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -59,7 +59,6 @@ DEFINE_PER_CPU(struct uv_cpu_nmi_s, uv_cpu_nmi);
 static unsigned long uvh_nmi_mmrx;		/* UVH_EVENT_OCCURRED0/1 */
 static unsigned long uvh_nmi_mmrx_clear;	/* UVH_EVENT_OCCURRED0/1_ALIAS */
 static int uvh_nmi_mmrx_shift;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_SHFT */
-static int uvh_nmi_mmrx_mask;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
 static char *uvh_nmi_mmrx_type;			/* "EXTIO_INT0" */
 
 /* Non-zero indicates newer SMM NMI handler present */
@@ -247,7 +246,6 @@ static void uv_nmi_setup_mmrs(void)
 		uvh_nmi_mmrx = UVH_EVENT_OCCURRED0;
 		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED0_ALIAS;
 		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT;
-		uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK;
 		uvh_nmi_mmrx_type = "OCRD0-EXTIO_INT0";
 
 		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
@@ -258,7 +256,6 @@ static void uv_nmi_setup_mmrs(void)
 		uvh_nmi_mmrx = UVH_EVENT_OCCURRED1;
 		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED1_ALIAS;
 		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED1_EXTIO_INT0_SHFT;
-		uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK;
 		uvh_nmi_mmrx_type = "OCRD1-EXTIO_INT0";
 
 		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
-- 
2.21.0

