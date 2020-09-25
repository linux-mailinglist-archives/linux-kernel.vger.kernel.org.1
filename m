Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E4B2780EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgIYGyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYGyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:54:31 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B080C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 23:54:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g29so1742967pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 23:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HdE7nLvEFj18RV9A2g392hZIV3ihv+vkUnf6hZyZUiI=;
        b=LOOOW3X3ilRxghcGS6kesPqVSpVDVzHB+wJ/pOrMNeujL2vcH/fbrSTfaTjDw5vAjT
         VK5mCz6OUBRPj+obsf9HzaQt7++4c8INP61tk0DmPbOf3C3CuwsYaSz+myXOuf7KlyaE
         ynLNjxG1dydzIlg3SUspITMegtmEZA8OjMIOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HdE7nLvEFj18RV9A2g392hZIV3ihv+vkUnf6hZyZUiI=;
        b=oateVH0NFvDZbP56wzlrVJTDG13xZmq4gGwhfjpTDRKFZnLXdRDO2dd1/IX2X2m5h0
         jaSZU24CO+8jwtVPHH0zm/5L6zVhC61nB9lCNIoauAx97rb5tkR6zQ+6KZFNgZSnwvPa
         4sgjKKfgUxjPwlBwZEGXTjoht4KFhjhl6JaKf4xw/fCJJN7lxVgVBuBsdxwr5G6nno4b
         F9sYeX5pdZ+t/yW9H/uAHPaLGpue6WUoPixmMuy3etuC7IquaglqQHO653SQiKvargM0
         vn+o6lKkBfsFZ06PEpyC+6KRVB091RZULhlZcaXcZ1Exqbcg5v1rELcSpEzHszv4byEf
         IGTA==
X-Gm-Message-State: AOAM533oQERqk4Hk3l6gLR5M+g5+1YOAqeikX4X8jTV2E2/JbiUyN8fc
        YIIa8MvsAx6KJNqRCcMiBxD/NQ==
X-Google-Smtp-Source: ABdhPJxeXe/jApGVyUA65xnQpVIAMUd3AY9UUwRBr8ghMbWnb5Si2clEbVRamnuUhqstE+vlnH9yEQ==
X-Received: by 2002:aa7:97a8:0:b029:13e:d13d:a105 with SMTP id d8-20020aa797a80000b029013ed13da105mr2777875pfq.33.1601016870507;
        Thu, 24 Sep 2020 23:54:30 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id x27sm1549612pfp.128.2020.09.24.23.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 23:54:30 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>, Rob Herring <robh@kernel.org>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/6] dt-bindings: spi: add mt8192-nor compatible string
Date:   Fri, 25 Sep 2020 14:54:12 +0800
Message-Id: <20200925145255.v3.1.I4cd089ef1fe576535c6b6e4f1778eaab1c4441cf@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200925065418.1077472-1-ikjn@chromium.org>
References: <20200925065418.1077472-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8192 spi-nor controller support.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index 42c9205ac991..55c239446a5b 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt7622-nor
               - mediatek,mt7623-nor
               - mediatek,mt7629-nor
+              - mediatek,mt8192-nor
           - enum:
               - mediatek,mt8173-nor
       - items:
-- 
2.28.0.681.g6f77f65b4e-goog

