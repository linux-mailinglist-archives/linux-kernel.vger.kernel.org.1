Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4822C6305
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgK0KZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgK0KZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:25:12 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E106FC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:11 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g25so2133144wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrxeOOjDCIprrnDpDsRoG4Zke9Q0VN/X0WIR5/LQh/o=;
        b=BaVPoe3XTAR1940YgwoOaek33VCoGTVt0+cQEejxUjnYglXOcOeAPaKjPn3wzG30mC
         Qtmr+wbFHvw8ByZMmu0mdLHqcorA+nNnteSdWTJ4iVzJf7XgnrHSAlIauKFPOBv3UaDh
         5r7EBpCCnpNMNGH8DPQ8iNZz11xEURpvvontNFIYDmTs3+dfC8D8blEbUcwlm1olHxKv
         f/QrW8BClTSO5ro+jhTL3aqM/iqqpRCokS40ycuPielk+Nz5OQkJZgZ9nRmzu1jj+oc2
         2EjPgZ3QUqCUR6ZHerdw4zZBiNGmLIVrFPDfhUj14F05QgiBfqsD2vxHV/7+BMo+el8z
         8A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrxeOOjDCIprrnDpDsRoG4Zke9Q0VN/X0WIR5/LQh/o=;
        b=uCw2F/RskXp6u3D08ncvgX7D+e89T7Q0lyrrxd0blTqUhT0zlkCOwHBXWwU6g0K7ny
         6rVel/AfNwv8eJQd3+r5muV20hhiA4ZBVKpqsR0xDPePMfh7AFwXBY8bZTpLVOq9ASaR
         ihtRCIXO+rbxxTIBUjR8fWB8zYSMVAQE4nPIHAh55HUnLLwCyEmJRrhM5zuULOSrcZfV
         L1iYULiCDQAnWz+vDVwy0JanyROZlt+doo9CxWr6Qqy0o1FaWiP5IN733YTvDEHg4pjC
         AaCE5Li73mlnSICJWAzhQzSaaG4954bGz4tpV6mQ2gIhs9zvCGb/q+8vbL6A3S0pP2OM
         FIxA==
X-Gm-Message-State: AOAM532rkdtb3zl55FlxQsIg5SKWiP84LTZXeLm1DryU0lZe51Ai51US
        VXswjL4Swj/JktRuCTTMmk2c5w==
X-Google-Smtp-Source: ABdhPJwLSw/MtEGshVoF6YcGyZW4o/WiuQpZWvZy9wLslgTzthmoYpeI4ALOu9WilJe1y6zYbs0Xbw==
X-Received: by 2002:a1c:2c2:: with SMTP id 185mr8201087wmc.103.1606472710601;
        Fri, 27 Nov 2020 02:25:10 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x4sm13942024wrv.81.2020.11.27.02.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:25:09 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/7] slimbus: fix a kernel-doc markup
Date:   Fri, 27 Nov 2020 10:24:45 +0000
Message-Id: <20201127102451.17114-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
References: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Fix the name of the enum on its kernel-doc markup:
	enum slim_ch_aux_fmt -> enum slim_ch_aux_bit_fmt

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/slimbus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index c73035915f1d..00a7f112574b 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -244,7 +244,7 @@ enum slim_ch_data_fmt {
 };
 
 /**
- * enum slim_ch_aux_fmt: SLIMbus channel Aux Field format IDs according to
+ * enum slim_ch_aux_bit_fmt: SLIMbus channel Aux Field format IDs according to
  *	Table 63 of SLIMbus Spec 2.0
  * @SLIM_CH_AUX_FMT_NOT_APPLICABLE: Undefined
  * @SLIM_CH_AUX_FMT_ZCUV_TUNNEL_IEC60958: ZCUV for tunneling IEC60958
-- 
2.21.0

