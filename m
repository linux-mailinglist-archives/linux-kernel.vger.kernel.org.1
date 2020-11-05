Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904962A89C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbgKEW2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:28:21 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:52158 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgKEW2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:28:18 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MQZki011714;
        Thu, 5 Nov 2020 22:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=RYdXpgJ4DVpkuo/hpv0r3zo9CyRSgxVIt95OjYxDDow=;
 b=QBO1a4p+OJv2BCtgqpk+uhUaWhLCnG3cx7e5c7GuNTVhya+FftiTC9jdUG6fkwMQBxvC
 YxBV3gn/3ds/MoZMX4vupvRFFyId4SAhHE8ceXg7aum3i0hkVTk3TPWCKfcLC7l2GhDs
 VU04kVAmDTKW9pqZct9Dp4ySUwAsLJ7rVZ4X4JbkudyOXRvPRAlxJmeYti2JJfWQkpzK
 Q3F5NW0QnTdUiwvwwDBmTSekpqYsbwJKgclQHzTLM3u4VH7mYvugGwu6AJUMGVLHhKOI
 790cED1Bnp2pZEeC9Wwa1KuBjnrG0idviJGYMX4a6LB2U/vxBJqFY5FThWua4qLgW4d2 Vg== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 34kdb23xr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 22:28:00 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id CFA29B5;
        Thu,  5 Nov 2020 22:27:58 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 2C2B54B;
        Thu,  5 Nov 2020 22:27:58 +0000 (UTC)
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
Subject: [PATCH 3/3] x86/platform/uv: Recognize UV5 hubless system identifier
Date:   Thu,  5 Nov 2020 16:27:41 -0600
Message-Id: <20201105222741.157029-4-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201105222741.157029-1-mike.travis@hpe.com>
References: <20201105222741.157029-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_16:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=901 adultscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing shows a problem in that UV5 hubless systems were not being
recognized.  Add them to the list of OEM IDs checked.

Fixes: 6c7794423a998 ("Add UV5 direct references")

Signed-off-by: Mike Travis <mike.travis@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 0f848d6dddc9..3115caa7d7d0 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -389,13 +389,20 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 			/* (Not hubless), not a UV */
 			return 0;
 
+		/* Is UV hubless system */
+		uv_hubless_system = 0x01;
+
+		/* UV5 Hubless */
+		if (strncmp(uv_archtype, "NSGI5", 5) == 0)
+			uv_hubless_system |= 0x20;
+
 		/* UV4 Hubless: CH */
-		if (strncmp(uv_archtype, "NSGI4", 5) == 0)
-			uv_hubless_system = 0x11;
+		else if (strncmp(uv_archtype, "NSGI4", 5) == 0)
+			uv_hubless_system |= 0x10;
 
 		/* UV3 Hubless: UV300/MC990X w/o hub */
 		else
-			uv_hubless_system = 0x9;
+			uv_hubless_system |= 0x8;
 
 		/* Copy APIC type */
 		uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
-- 
2.21.0

