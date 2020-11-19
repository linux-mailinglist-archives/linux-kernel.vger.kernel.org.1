Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECEC2B9EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgKSX4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgKSX4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:41 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D94FC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 15:56:41 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f20so10408032ejz.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 15:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pEpws+SKMwPOzOPdKBgnzH8PkBoXgcO6KMe2V6Jcg8=;
        b=fbSzTjH+Qqa5FxL6NyjtgiaDorQ26HeYcZCwU+diTfNcZwc6McI9NShBULEsp41xa3
         WolluAlKGD5D0zO5fp/y6w8b1xXZVWyE2/H+pysurZJ7RGO3PKf7hj35p7e2ZHZy5GRE
         jlxO5Esl8Jd/6HKaotgIWBX3JNQRv9Nbrqqd14eBanO5+TwYBEIkB7yDARiZdlqgSj0w
         ISLKGj0iFqPYuLV98GOIc0KiOXZmEDKtgU4uJPrLZyR/Xr+CQfzSPY/+W/Y53VjS/rS3
         uEEC89ha+IN8ZSgRQ79407bKg+5+2PQwCVH9zGpVDDqjnaQFWMEcr0Sr0Y3/uioFxRLR
         4IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pEpws+SKMwPOzOPdKBgnzH8PkBoXgcO6KMe2V6Jcg8=;
        b=ATQpw1lE/jU7b8aXHDPzBxALEm0g7PVhkYDls5brjt/L0nPrTn3rcgqq0k1YAxMEZj
         YJfzjMFgh3u/4Iec0SfefR0PiESz6hHhHXNTNQxO6+sqq4bI4K/CkVD0z2CEnRvCcJD2
         TbF+4xyMorWMkGr6r83Wr0QRIkjooPOYrtAEUB/nlCDtA9v5EXgV0DN4zpUnYZVBqzHF
         peJXbAhG9SsLfSl9OvXUX+Gf2jg8x45KqOmgcOSpazA69y/qsrXm/KAbMHa65bl4CE79
         S2MtTVIsG+dTl1UQgBU5dIs5Pyj+AXbVGq0L/yLEtLpvMqRdxEisx7Ge0C+BDnCIUeVR
         uSEg==
X-Gm-Message-State: AOAM5314VC2r7+ccTbgTHUt334n/+Dzj0MGKEWhy2qcphFlOqYqEEzqd
        Ja6NgMIXYjcAdSGQGIGUV3I=
X-Google-Smtp-Source: ABdhPJzChNF/BgMaRCq5EHyok6vqktvmtENed1wYA8cBCRDqaVyOwDPx+bYLaAHR5iHtelOOrgropQ==
X-Received: by 2002:a17:906:5a8b:: with SMTP id l11mr23422456ejq.99.1605830199950;
        Thu, 19 Nov 2020 15:56:39 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:39 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/18] MAINTAINERS: Add linux-actions ML for Actions Semi Arch
Date:   Fri, 20 Nov 2020 01:56:12 +0200
Message-Id: <5845b7a323c65adaa1566c3bee68b5ca1f1bb17e.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the linux-actions mailing list for the Actions Semi architecture.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a85c1881cf07..8428aba52581 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1497,6 +1497,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
 M:	Andreas Färber <afaerber@suse.de>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
-- 
2.29.2

