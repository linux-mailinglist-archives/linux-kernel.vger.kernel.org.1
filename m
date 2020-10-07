Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD41E286239
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgJGPgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:36:08 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41426 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbgJGPgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:36:08 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097FVuqo020404;
        Wed, 7 Oct 2020 17:35:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=qd5+/AbCEM53HLfce4bWxYU4BP8hENng6CU0MTPn/10=;
 b=QEiEP/KU/gXmc696cLJr57K5wtltvdCI/HuHDPhlWieLmRFl0Rv1g7ddwfYroDYmsDGO
 xGYqi7jomW49c0+bxV1WlOcdxj213+v1SkIhM1nN2i2rla2ZP/Jc0OLX/OFsx5VtRSba
 gCT6WvduasmA/i6E2+1BOJ0h2lXYJvBHCnOPRHbzXuDVSSCuu3b9/6hvftQ/SFvcZa73
 lRAgIhzTa6doCmEGSJYz8ifqZGrd71OI4TGiAZEEbYIxUePZSmahVgO0ZsEX77c4VIfB
 26xcjMkKWmiy2uGFibu4FU659OwWChvdR+02oUb5ZUBm/yqVODYms2bp+tN6lfp+4R0Q qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3402tk5pre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 17:35:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DE8810002A;
        Wed,  7 Oct 2020 17:35:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C75692B8A27;
        Wed,  7 Oct 2020 17:35:13 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Oct 2020 17:35:13
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <arnaud.pouliquen@st.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: stm32: dfsdm: change rate limits
Date:   Wed, 7 Oct 2020 17:34:57 +0200
Message-ID: <20201007153459.22155-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_09:2020-10-06,2020-10-07 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Widening of the supported rate range in the STM32 DFSDM driver.
The rates were previously limited to 8kHz, 16kHz and 32kHz.
Allow rate capture in the whole range 8kHz-48kHz as there is no hardware
limitation to support it.
Actual sample resolution is dependent on audio rate and DFSDM configuration. 
Add a trace to allow simple check of sample resolution.

Olivier Moysan (2):
  ASoC: stm32: dfsdm: change rate limits
  ASoC: stm32: dfsdm: add actual resolution trace

 drivers/iio/adc/stm32-dfsdm-adc.c | 4 ++++
 drivers/iio/adc/stm32-dfsdm.h     | 2 ++
 sound/soc/stm/stm32_adfsdm.c      | 8 +++-----
 3 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.17.1

