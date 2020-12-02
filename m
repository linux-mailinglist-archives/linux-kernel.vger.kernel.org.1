Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84A32CBE12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgLBNR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgLBNR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:17:28 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5082C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 05:16:41 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id f23so4254052ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 05:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YFuryNq+yiJ8h6eDBZHjVfvzohLImj8dR6NtOH9iUac=;
        b=NZSWOxK5OUukxA2dIEAUSf1X7dtSajYgAfv2g5wvGXQVYekjzrn3BS0M/z5IxCrabL
         evreeX3+1IkKQQ1w+3WNl63UwSOkzwN3NqCMemtB7M6rmQ0RRmksel4vdye0E/cD7BLI
         gkOoilJ1MhlEtuzQx9EGBTpfAYENT5gDpPX2V3nWjNJXvjvaAUQYTii+nPoKmx4gnWns
         IDxnp4FrgHEdVs8V8IjX/SXJBx0NnetHaxoOF0q/5ndv1ezdklqFCPH50dgGSLs4nsvM
         DulI4KxMAipBZv9VBxZcPVjDRQW90Va35hImCBYJ1Fxx+3U3eqElF+Qtd4DBAcedQ/nu
         +bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=YFuryNq+yiJ8h6eDBZHjVfvzohLImj8dR6NtOH9iUac=;
        b=fXy9IuyQcn1xgYXGm3vOSLv6xtQJVxB2/TYB9liJ7LxWn20upDAn6j+w2UzrFOItqA
         SvSMqb9UyJVj5DPDD0CssgyWopqXaoy1mVg26MndLW3Hpa/GvkZkSGXwBPJ+DkUI43WU
         /1xtKluYK2bBrsX1ZUrwWn0MsN+Cs8USYpjquMWO6Kgts8uoypSfx3UUckQVSbW9noI5
         JC6ExVg3WI7S+zFP1waaSyVLGVLRXNlIYSnRhKvfAl9svTV+OaQZCkdfAj0QLDOEDObY
         NgI0l439sF3OlnW255Nr0ciXr2MT23FMMgj+xq0/dh7X/C1W57GIrwlAz+lTyuzNxLFW
         e78w==
X-Gm-Message-State: AOAM533j+075Olmm31Xv0AQvcuSvldP97PVScNNE6wfqo5rWSdTnoXi3
        mhhhat7J/kmhLMMx2i5Gj5qdS4MLjCasHGKr
X-Google-Smtp-Source: ABdhPJwE+atf1tpH4BTLQ+cRxpcWVgmERHoNhVDJ5MZkiLBvIJY1ZNQYZH2JNR5h/8hKr40P2/biQA==
X-Received: by 2002:a17:906:cc84:: with SMTP id oq4mr2239188ejb.513.1606915000192;
        Wed, 02 Dec 2020 05:16:40 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a20sm1376061edj.81.2020.12.02.05.16.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 05:16:39 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Fix xlnx,mio-bank property values for arasan driver
Date:   Wed,  2 Dec 2020 14:16:31 +0100
Message-Id: <5fa17dfe4b42abefd84b4cbb7b8bcd4d31398f40.1606914986.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP has 3 mio banks and all of them are valid. That's why also
list the first one which is missing. Property is enumeration not range.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 58fe9d02a781..8958e54e522d 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -147,7 +147,7 @@ properties:
 
   xlnx,mio-bank:
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [0, 2]
+    enum: [0, 1, 2]
     default: 0
     description:
       The MIO bank number in which the command and data lines are configured.
-- 
2.29.2

