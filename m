Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906B92F1565
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 14:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbhAKNj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 08:39:27 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39754 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730855AbhAKNjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:39:18 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10BDaN87021911;
        Mon, 11 Jan 2021 07:38:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=dj/afU35e9If0LpEXtndT0z7ZC1EFJEfmUbXASkboj8=;
 b=MHVILp821vdOdbtDE/WQP0PUo2Yu/mlmr/7Ea83MmNBb1RO2rZgF8kqymhdSw75KM5gs
 BXlHSlb7KEVjDp9NXux/deoyW6+OuL6FqB+3Ur40dtrtnIK+DlADEt0WknQ1JgxlbyWh
 4R4CSn2A9gmBFv/RIvIEPz9dSze+IY+4WJYBTzQmziXO1a3eZ+zXPrixeZsndtdjgce2
 w+cRxxrclMTB+MdKyA85/FLH7nABozfMfyzNg9njdKHUYOhZwmXYBvUo4VOBfzMFCknp
 iZU32+eV8jWV07fSKi4kn18VE8HcHuGTY/I9/mqJZisQXyYzf2tW1dPw3g+WS07tDC2B 1w== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35y9srt3v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Jan 2021 07:38:31 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 11 Jan
 2021 13:38:29 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 11 Jan 2021 13:38:29 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.3])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E3F0F45;
        Mon, 11 Jan 2021 13:38:28 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Fix uninitialized variable warnings
Date:   Mon, 11 Jan 2021 13:38:25 +0000
Message-ID: <20210111133825.8758-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wm_adsp_read_data_word() used if (ret) to check for an error from
wm_adsp_read_raw_data_block(). While this is perfectly valid,
wm_adsp_read_raw_data_block() itself uses if (ret < 0) and three
calls to wm_adsp_read_data_word() also use if (ret < 0).

This creates an error check chain like this:

  1st) if (ret < 0) return ret;
  2nd) if (ret) return ret;
  3rd) if (ret < 0) ...

This can confuse the compiler into thinking that there are possible
returns > 0 from the middle if() that are not handled by the final
if(). If this was true it would lead to using uninitialized variables
later in the outer function.

Fix this by changing the test in wm_adsp_read_data_word() to be
if (ret < 0).

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f8ad768364c2..1fc7bc1970ea 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3694,7 +3694,7 @@ static inline int wm_adsp_read_data_word(struct wm_adsp *dsp, int mem_type,
 	int ret;
 
 	ret = wm_adsp_read_raw_data_block(dsp, mem_type, mem_addr, 1, &raw);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	*data = be32_to_cpu(raw) & 0x00ffffffu;
-- 
2.20.1

