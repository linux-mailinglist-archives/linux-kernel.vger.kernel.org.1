Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F9E286386
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgJGQTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:19:31 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:4408 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbgJGQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:19:31 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097FuTNA003915;
        Wed, 7 Oct 2020 16:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=7tQCY0Wr9+/NZHFcaRpeFKsfOHAUf5dEI8TQ+uqumXQ=;
 b=nI6Rf9bI7j9j5jYGsuMgH3MI7w1G/Q5bw88BII1EkS1ww91zWuf5lrUrCrn6b/Iv/Zmh
 Df6bKY0dTE7gBXfGkEm4MEu7hcrNz89P1saA4p7ROGBks8yYK6moRxrhRZMMqaP0BtMc
 90gTxZDw9lxlWaCTjcQOBVxIoMFYMbDIE2xHvXDyQFz3jQpo7WL23tafWNy5f4MZnbve
 94LyNZpB+fq9O8AQKGbqgdMf4tEwsslv2aKSX4jOvEIsBlU44n2JaLcdkVoeMHmBdEkk
 ds+UPzDzwFYqHTgQBz0Y0aHvJuAfh/Lq24q2mn7RX8X9OMF1Gq+7DzzrzJ05MUhOoQd7 /Q== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 340ndrwqy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 16:19:29 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 008CF8C;
        Wed,  7 Oct 2020 16:19:28 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id D0BDF3A;
        Wed,  7 Oct 2020 16:19:28 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 89CC730000CA2; Wed,  7 Oct 2020 11:19:28 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Robin Holt <robinmholt@gmail.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Subject: [PATCH] MAINTAINERS: Some SGI-related cleanup
Date:   Wed,  7 Oct 2020 11:19:12 -0500
Message-Id: <20201007161912.28399-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_10:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070100
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
CC: Robin Holt <robinmholt@gmail.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---

Second sending due to a Return-Path: problem with my email config. My
apologies if you've seen this twice.

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

