Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8884F2AA604
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgKGOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 09:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgKGOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 09:48:26 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E7FC0613CF;
        Sat,  7 Nov 2020 06:48:26 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id u21so5093203iol.12;
        Sat, 07 Nov 2020 06:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HiXXbu7YjLPRmH2y2VHpSQxvCKwLmys8FY/M3vmv+vg=;
        b=iYbNy//j1QUS+E7guB/UJtcAyP41Bt7gVZZys6lzUtXdo+J3XmEdYbvISe0kKJ5U9j
         qo0tb3UIqmFMcMdonzlodZhEJ+dMMXmi6DbzUbpzVt0Zb/cTn0QzxrK3rehfkwdRe61d
         kkHVY37gwfP1TjLGfyklMZOLD4mAxk+rheR9zPRIXO0f130bxgwcvet+moAPJ/H0iZSQ
         zCCZ/ExM5bs37Ck5uBBlQARGK+I0HetMHCxYWVuTAEZofcJqW34m0LoaaCRF4xoVnqOD
         gSamnmYR4ja6cdJm/7KAspTGzorregVM8vB1KGyjvpAfYVdSFMS9g+d8Oy2vZGc+omVr
         cTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HiXXbu7YjLPRmH2y2VHpSQxvCKwLmys8FY/M3vmv+vg=;
        b=NqblYh5ZCdRIdnj7079vj7AHHkDwjve2ZEUXXhMpXzBhtumS4av3X2WuRf56cRFEfT
         C9i1sUrdQHxOc8VDqEw6FNQm/O3xN59CmIlBxRLcIfPPb4UsxyFn9FIGh01ilZGtjkjD
         yxryx7D0e5igauEDVUNSDxwZUNoMI7mWjX6RuX68ghPeIr3a6zrEwS7D15t3ae1356X4
         XxD8PMdaAyfaoNC1uGQWQMXNf8GdVxe1nhgsbrnr041wX1QwY0uzKKAMKN0Qj4dlCh31
         3ozTLXBIMOp6eWO5dJpvBTSvYiyq4/d2sfyZzdrEIQ4Q11gwwjlLvj0fJiXkFh+N/icH
         qP5w==
X-Gm-Message-State: AOAM533aFIGeiuZPxiOT1VZGoogxIHEOaSsTo5+vwQ8JI36ykH4w3JrT
        MQCP7O1DRZRPrvESKPEQPHg=
X-Google-Smtp-Source: ABdhPJwFcAF6+Hsj19mlUBsnOzbY7B601teON6zNd0PLzCHZMrnEp7uXbEFLmP/B/NdkwtFLC2uxjg==
X-Received: by 2002:a5d:9602:: with SMTP id w2mr4995815iol.120.1604760505854;
        Sat, 07 Nov 2020 06:48:25 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id t2sm2737892iob.5.2020.11.07.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 06:48:24 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, krzk@kernel.org,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/3] dt-bindings: arm: fsl: Add beacon,imx8mn-beacon-kit
Date:   Sat,  7 Nov 2020 08:48:08 -0600
Message-Id: <20201107144811.1977108-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add beacon,imx8mn-beacon-kit to list of compatible options.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
V4:  Add RB note
V3:  Correct Typo and move to Nano section
V2:  New to series
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 85fb24da4a02..5a2608e6bc30 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -680,6 +680,7 @@ properties:
       - description: i.MX8MN based Boards
         items:
           - enum:
+              - beacon,imx8mn-beacon-kit  # i.MX8MN Beacon Development Kit
               - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
           - const: fsl,imx8mn
-- 
2.25.1

