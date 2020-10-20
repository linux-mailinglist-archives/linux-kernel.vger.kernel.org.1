Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70A629400A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436985AbgJTP5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:57:35 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60390 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436958AbgJTP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:57:35 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09KFfsqH008231;
        Tue, 20 Oct 2020 17:57:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=vxVcS0wL2dmaUGtZbYgULMDICAzdzq2c+2XOgarz2W8=;
 b=tSwotTfTGzp0UfKKaB1HYz9zhyFIEMvXk0/ssAnHzRK+LOHI19fiimx69WyRWlMICUAy
 Wo/P3c1f+2gcH1cH8RY4Q/DQXDqInf17gTxzmFToN4alTF2f9oVsf8NHy8EVb9f3apvz
 rWEAn3mKh4y/ZWU2sGc4CRv4h/9xJkO58xI0wfaCRBhBvimJlhhY8B5KF0p+kE9ISYR9
 IXIsI+hxUy1hX0QuNS7/dnnSJqYNz5LpoxAZoys1cKVQLHSPFO044Ol6n+Pk8tfK+2NC
 x2ULDjdMqr5yEYnbJ2xw+KEATp0kc3Eq0cMKnu8yHxLVxWAGItQlU51t1T3pdBOakj0b YA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 347pcwuuw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 17:57:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3188410002A;
        Tue, 20 Oct 2020 17:57:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD477206290;
        Tue, 20 Oct 2020 17:57:13 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct 2020 17:57:13
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <olivier.moysan@st.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH v2 0/2] dt-bindings: stm32: convert audio dfsdm to json-schema
Date:   Tue, 20 Oct 2020 17:57:07 +0200
Message-ID: <20201020155709.2621-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-20_08:2020-10-20,2020-10-20 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some audio properties documented in st,stm32-adfsdm.txt are already documented
in Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml bindings.
Move remaining properties from st,stm32-adfsdm.txt to st,stm32-dfsdm-adc.yaml,
and remove st,stm32-adfsdm.txt.

Changes in v2:
- Complete st,stm32-dfsdm-adc.yaml rather than converting st,stm32-adfsdm.txt

Olivier Moysan (2):
  dt-bindings: stm32: dfsdm: update audio properties
  dt-bindings: stm32: dfsdm: remove stm32-adfsdm.txt binding

 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  |  7 ++-
 .../bindings/sound/st,stm32-adfsdm.txt        | 63 -------------------
 2 files changed, 5 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt

-- 
2.17.1

