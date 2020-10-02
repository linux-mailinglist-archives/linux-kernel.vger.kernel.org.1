Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3928169E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbgJBPaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:30:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11928 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387984AbgJBPaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:30:08 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092FGmtG025137;
        Fri, 2 Oct 2020 17:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=rH5DRDsh0Q+Pmb7n88LdQ/t1cLnzwZVBzxVpYfSXUEM=;
 b=ZzjSrmrul4W3cETzEbXmFH9DTGZprBTe7Axt5fLkFo93oKDdTeg5xhjLsV+ZtffYPcrC
 rSAmqdhpV9yfTTHZQ9f6vpCeifvD1Nd04mK7Z863fS4YWDrp/60rx7e8zJ3duZTCuOpb
 +nw8xZM3+YqizZGMs1/Te8qLDu/69Ix8VPWQnamtV6D1DWVml7HaCfCJ/2wyxtPEwuIy
 h7K8VQVR6bRHE7ntHgxpRDp60H/iRAGuCc2V7OfddUenYkmsnhTXW9sVIU0DEPk72W8Y
 YUIDsPHUBBnnWQ4QDGHnVRLy9D6LT/sFIspU/Kf1oeYlJd9tnl4fgMMvFlzAUrfC/3zZ ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33sts8chy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 17:29:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E371010002A;
        Fri,  2 Oct 2020 17:29:07 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B69812A562F;
        Fri,  2 Oct 2020 17:29:07 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct 2020 17:29:07
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <arnaud.patard@rtp-net.org>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] ASoC: cs42l51: add soft dependency declaration
Date:   Fri, 2 Oct 2020 17:29:04 +0200
Message-ID: <20201002152904.16448-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_10:2020-10-02,2020-10-02 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When configured as module, CS42L51 codec driver uses two modules
snd-soc-cs42l51 and snd-soc-cs42l51-i2c.
Add soft dependency on snd-soc-cs42l51-i2c in snd-soc-cs42l51,
to allow smart module dependency solving.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 097c4e8d9950..1630baad42e2 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -814,4 +814,5 @@ EXPORT_SYMBOL_GPL(cs42l51_of_match);
 
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Cirrus Logic CS42L51 ALSA SoC Codec Driver");
+MODULE_SOFTDEP("pre: snd-soc-cs42l51-i2c");
 MODULE_LICENSE("GPL");
-- 
2.17.1

