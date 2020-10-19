Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97C292F89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbgJSUf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:35:59 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:56518 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731714AbgJSUf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:35:58 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09JKUmxH027004;
        Mon, 19 Oct 2020 20:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pps0720;
 bh=2LS0LsGZahfJhbJjbIE39ei2BmedNdC5yuafNBCSBVU=;
 b=Y2cqiUj2Vynp/6Li0FurCdSJMUa9a90xij1ZfgWE6X8l00VuCbvwuPMTPH6/GpPx0zNW
 zb0ILkL4oUFbl753XL9iOV3fcyj3BP9gewsFBbPq//9CgoIPioPG85RstrYBdvG9BuPC
 n4UzznymEoLQNIZRcw6JsBXtzYEriQUd6ZRkx53HiAOcAVR+epktmK0pyaX1Z0v5WL/F
 LMQs3s8BLvhlCix79nzfLDT/U+DB1LUvL6xatPq7bP+v7VYrsw55nvnz3+FEkQFM0l5L
 mjygVAyJVevK8I4Vv17AlOEtWBGSDFSzyH5jQ0hy/LW10KQIs+Kcbkee6o7yNQjz6v8i kg== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 347swnusbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 20:35:36 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 38BF882;
        Mon, 19 Oct 2020 20:35:35 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.129.62])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id DCE233D;
        Mon, 19 Oct 2020 20:35:33 +0000 (UTC)
Date:   Mon, 19 Oct 2020 15:35:33 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Robin Holt <robinmholt@gmail.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [PATCH] MAINTAINERS: Some SGI-related cleanup
Message-ID: <20201019203533.GA1203217@swahl-home.5wahls.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.26.2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_10:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UV platforms are the only ones who currently use the XP/XPC/XPNET
Driver, so it seems fair HPE should take some responsibility as
maintainers of it; so add Mike Travis and Steve Wahl.  Cliff
Whickman's email address is no longer valid, so remove it. Robin Holt
was contacted and wishes to remain as a maintainer.

Update Dimitri Sivanich's email address for the SGI GRU driver.

Add Mike Travis to HPE Superdome Flex (UV) platform.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Acked-By: Robin Holt <robinmholt@gmail.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---

Third sending: increase distribution list.  Someday I may get this
right the first time.  (My appologies if you've seen this thrice.)

Second sending was due to a Return-Path: problem with my email config. My
apologies if you've seen this twice.
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9350506a1127..3a18b48a5221 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15671,13 +15671,14 @@ F:	include/linux/sfp.h
 K:	phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)
 
 SGI GRU DRIVER
-M:	Dimitri Sivanich <sivanich@sgi.com>
+M:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
 S:	Maintained
 F:	drivers/misc/sgi-gru/
 
 SGI XP/XPC/XPNET DRIVER
-M:	Cliff Whickman <cpw@sgi.com>
 M:	Robin Holt <robinmholt@gmail.com>
+M:	Steve Wahl <steve.wahl@hpe.com>
+R:	Mike Travis <mike.travis@hpe.com>
 S:	Maintained
 F:	drivers/misc/sgi-xp/
 
@@ -18905,6 +18906,7 @@ F:	arch/x86/platform
 
 X86 PLATFORM UV HPE SUPERDOME FLEX
 M:	Steve Wahl <steve.wahl@hpe.com>
+R:	Mike Travis <mike.travis@hpe.com>
 R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
 R:	Russ Anderson <russ.anderson@hpe.com>
 S:	Supported
-- 
2.26.2

