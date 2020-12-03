Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36EB2CDA16
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgLCPYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:24:54 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:18798 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726751AbgLCPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:24:54 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3F821Q010480;
        Thu, 3 Dec 2020 15:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=5VtHZKKZ25YZXJfM+LeO3yfzrQRS17P/tGLiFL7aoHI=;
 b=Abt5gpdpSdWUcuWHnsgZT6zgv86OkDksQ3tqjKszxMMrhjYfc9uw3a7XyTXpje16vIUo
 f8Z1hzHLdmI4+7qYa0Bs5w1BvnQfEctAiGEPT4jrAWMrkLx46F1IMA9uHZNcPqqBdSrP
 XnDUCANAg9S85teycFyLj9IIkh6WVa9maHGZuO+uTEnr1pX5MFVE+RRUApdc/Aq7AXxj
 YsbP0Q88HnNY8YNRQrT4M0/Ums+ixb5otVGqgxWT+3vGWHdYNkeF69LSvvRwkVVqfinZ
 EzHKa10suwcUp9xj8akiUfG0Vu2Q9ay7TgHMaOcsgTlYQ+xK7KK97vtHvCoWpIcwE8Rp 1A== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 35714tgsn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 15:23:48 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 2DD2166;
        Thu,  3 Dec 2020 15:23:47 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 17EB548;
        Thu,  3 Dec 2020 15:23:45 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix UV4 Hub Revision adjustment
Date:   Thu,  3 Dec 2020 09:22:52 -0600
Message-Id: <20201203152252.371199-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_08:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix UV4 Hub Revision adjustment as Hub chip starts with revision 1.
Incorrectly identifies UV4 as UV4A and UV4A as UV5.

Fixes 647128f1536ef: x86/platform/uv: Update UV MMRs for UV5

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Acked-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1b98f8c12b96..235f5cde06fc 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -161,7 +161,7 @@ static int __init early_set_hub_type(void)
 	/* UV4/4A only have a revision difference */
 	case UV4_HUB_PART_NUMBER:
 		uv_min_hub_revision_id = node_id.s.revision
-					 + UV4_HUB_REVISION_BASE;
+					 + UV4_HUB_REVISION_BASE - 1;
 		uv_hub_type_set(UV4);
 		if (uv_min_hub_revision_id == UV4A_HUB_REVISION_BASE)
 			uv_hub_type_set(UV4|UV4A);
-- 
2.21.0

