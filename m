Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF76286236
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgJGPfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:35:39 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:42216 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727414AbgJGPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:35:39 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097FWDIn023606;
        Wed, 7 Oct 2020 17:35:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=LPmTNBs4XJT9cCBJcxCmDFKkYPrNIrwRIBlSBsDz2R0=;
 b=lm1iWgIpw3IRxl+qksHroByVOItjRbOuuvxvijzveW7+Y9ICpeptdf6WIc5pIZiTqKAp
 jpWvLuQrdzZx4Fd7EJm3glQXfQnoBVYovukBy4jRmLDNCMyeOprguLv8mXyUM+vKE/+J
 mco1YAzJVY4FPvUGYMhspQW42Cua6au0cmdKHeciHHmcQOSulhJaC/uhZQCMf95m8RX2
 K6p6JN7wGf4Gx9lXCmjeK5FKt59HOP/M74padGli3II1RjJELU4s0f8837tiRtY4K32I
 hNyUq67nTSegexag0oatupc6Cjf0biUnc6b7DZiQPuwGOICW+6puyb5o4vieBaP4dXac xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3402tjwfh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 17:35:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7628D10002A;
        Wed,  7 Oct 2020 17:35:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 690F82B8A27;
        Wed,  7 Oct 2020 17:35:15 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Oct 2020 17:35:15
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <arnaud.pouliquen@st.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: stm32: dfsdm: add actual resolution trace
Date:   Wed, 7 Oct 2020 17:34:59 +0200
Message-ID: <20201007153459.22155-3-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007153459.22155-1-olivier.moysan@st.com>
References: <20201007153459.22155-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_09:2020-10-06,2020-10-07 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a trace to report actual resolution of audio samples.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 4 ++++
 drivers/iio/adc/stm32-dfsdm.h     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 5e10fb4f3704..b7e9ef1a6eec 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -293,6 +293,7 @@ static int stm32_dfsdm_compute_osrs(struct stm32_dfsdm_filter *fl,
 					max >>= flo->rshift;
 				}
 				flo->max = (s32)max;
+				flo->bits = bits;
 
 				pr_debug("%s: fast %d, fosr %d, iosr %d, res 0x%llx/%d bits, rshift %d, lshift %d\n",
 					 __func__, fast, flo->fosr, flo->iosr,
@@ -476,6 +477,9 @@ static int stm32_dfsdm_channels_configure(struct iio_dev *indio_dev,
 	if (!flo->res)
 		return -EINVAL;
 
+	dev_dbg(&indio_dev->dev, "Samples actual resolution: %d bits",
+		min(flo->bits, (u32)DFSDM_DATA_RES - 1));
+
 	for_each_set_bit(bit, &adc->smask,
 			 sizeof(adc->smask) * BITS_PER_BYTE) {
 		chan = indio_dev->channels + bit;
diff --git a/drivers/iio/adc/stm32-dfsdm.h b/drivers/iio/adc/stm32-dfsdm.h
index 5dbdae4ed881..4afc1f528b78 100644
--- a/drivers/iio/adc/stm32-dfsdm.h
+++ b/drivers/iio/adc/stm32-dfsdm.h
@@ -249,6 +249,7 @@ enum stm32_dfsdm_sinc_order {
  * @rshift: output sample right shift (hardware shift)
  * @lshift: output sample left shift (software shift)
  * @res: output sample resolution
+ * @bits: output sample resolution in bits
  * @max: output sample maximum positive value
  */
 struct stm32_dfsdm_filter_osr {
@@ -257,6 +258,7 @@ struct stm32_dfsdm_filter_osr {
 	unsigned int rshift;
 	unsigned int lshift;
 	u64 res;
+	u32 bits;
 	s32 max;
 };
 
-- 
2.17.1

