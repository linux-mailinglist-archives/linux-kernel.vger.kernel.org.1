Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A374627857C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgIYK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:59:54 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:42722 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727201AbgIYK7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:59:53 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08PAtnxL012375;
        Fri, 25 Sep 2020 05:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=e20N2CNvzJLhJBJb0j2rc+3a1k/T7ji10LCuZrTYkq4=;
 b=Z1Vp4tbak8smXSB+gUqIbLV1cWiAhpIsx4J8RALPH4bfdsGIZewU3zHgHzyVYbMT8zvH
 ybGSt2TMnrFOw3JmkfY1eEIp8heOi9sOKuTlUn3Hc18QKY2gdfF7FhYc2ijUyQRp46Ai
 BnVFcZ+bBp+C2JjZ3JLHTQbES1VlBH6SioD1YMU2zvelDfU0DnaJXq0uAROxK0LFfN9D
 oovjspb8tkfnSkFOEwqqoF8rYNyd26xFO1caeLUr4kcM9E9HduJybCSko5hX+OsCVpAV
 pOccchYTddyH17YtVvVPbcm/0AqmxUJqLOdc6y7g2oH7UX1BH35renxQByVVVbPnJqTi sw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 33nedn7xpd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 05:59:43 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 25 Sep
 2020 11:59:41 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 25 Sep 2020 11:59:41 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.158])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A8DD52C6;
        Fri, 25 Sep 2020 10:59:41 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/3] MAINTAINERS: Update Cirrus Logic Codecs maintainers
Date:   Fri, 25 Sep 2020 11:59:08 +0100
Message-ID: <20200925105908.20640-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925105908.20640-1-rf@opensource.cirrus.com>
References: <20200925105908.20640-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250076
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add patches@opensource.cirrus.com to the main group of Cirrus
Logic ASoC codec drivers.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d746519253c3..1d9a57d3992f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4170,6 +4170,7 @@ CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	James Schulman <james.schulman@cirrus.com>
 M:	David Rhodes <david.rhodes@cirrus.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	patches@opensource.cirrus.com
 S:	Maintained
 F:	sound/soc/codecs/cs*
 
-- 
2.20.1

