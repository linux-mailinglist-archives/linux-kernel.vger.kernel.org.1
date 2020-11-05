Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ADC2A89C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbgKEW2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:28:32 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:63996 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732297AbgKEW2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:28:20 -0500
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MOF4E026764;
        Thu, 5 Nov 2020 22:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=NdX3C45gJcHbe3aslIeJqliC0Xm4KbjC/9nJULV0h3A=;
 b=P90FO2Gmymt1aB7Njis5NMpHf38QyDhKrJ6DCPp8ZGJTQnkeohVoT51paNKFltmp3vaJ
 FrOZVfXBF2KDLRMDq+Bt5kJ/3s2t3ti9LuYVX6yHkiA91VpiBpR43DC8jh1tvPpIlcg6
 kmQh5q/+/H/qNU/LHNF0Xmmwn5JtN5RSKrc2wc2PHp8nXt+CtC7yI5xHgzPC/kPmy4u4
 iKE7TpRGPZotg3am5xpOx6zgWliOoWy20jmwbHNxYtzgL5aR+mLoQzoAnhBtqjB6wnkE
 yLZgu/ccCY2Zwuf/gGmBCIpHcG67xAWNtqOtDMm0XY28YzidTUsvD87uabkwsZEhmS80 Rw== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 34mpfy9ptj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 22:27:58 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 19C4953;
        Thu,  5 Nov 2020 22:27:58 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 66CEB4D;
        Thu,  5 Nov 2020 22:27:57 +0000 (UTC)
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
Subject: [PATCH 2/3] x86/platform/uv: Remove spaces from OEM IDs
Date:   Thu,  5 Nov 2020 16:27:40 -0600
Message-Id: <20201105222741.157029-3-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201105222741.157029-1-mike.travis@hpe.com>
References: <20201105222741.157029-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_16:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=907
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing shows that trailing spaces caused problems with the OEM_ID and
the OEM_TABLE_ID.  One being that the OEM_ID would not string compare
correctly.  Another the OEM_ID and OEM_TABLE_ID would be concatenated
in the printout.  Remove any trailing spaces.

Fixes: 1e61f5a95f191 ("Add and decode Arch Type in UVsystab")

Signed-off-by: Mike Travis <mike.travis@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index a5794794ea59..0f848d6dddc9 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -290,6 +290,9 @@ static void __init uv_stringify(int len, char *to, char *from)
 {
 	/* Relies on 'to' being NULL chars so result will be NULL terminated */
 	strncpy(to, from, len-1);
+
+	/* Trim trailing spaces */
+	(void)strim(to);
 }
 
 /* Find UV arch type entry in UVsystab */
-- 
2.21.0

