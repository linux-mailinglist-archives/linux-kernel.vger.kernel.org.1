Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C546F1A63D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 09:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgDMHxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 03:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgDMHxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:53:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E97C008651;
        Mon, 13 Apr 2020 00:53:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k11so8657169wrp.5;
        Mon, 13 Apr 2020 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=spiyZxT4E+JmLBsDsV1seik/2tk8bWL3YTlzlnavzgI=;
        b=f7pV8rfFH7lOGO3h5/nULD5HFllQxOEL05FTUF2SiEU7MAF1JJPc8mKH7k/3mp1dKC
         FdUtjdGVIhPaaHxiz+2ZaWsvZCsBdBLkUc0vwbtipe+jfJJ55AY7x9j9o7z3iU3ftoEb
         Bv3Ej6Xplpkv9hOYt6QwjKJzP4A3G62gst9hKhD5eBAYTvgF9Wr4JygtFDUu1AyZxBEn
         wNjlO5+VD0sorsLos6LHRByHb8qvslGj1FTporIbvRQfVEods0O9oLMrmXmySRNdjWmj
         QcA6UC/bsomklfXgRa3zN0/xG2DhA+CKHljfC40QOQW0cpHOsm/s4JnXCNvoy3PfS2Za
         3XdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=spiyZxT4E+JmLBsDsV1seik/2tk8bWL3YTlzlnavzgI=;
        b=DIMJWxM4zBkKNwQ6oMnScO2gTlJCd+r3SgpUlLO4gpNWyo9Ie+BZt3Mj85LlYmkR9Z
         B3hfhU9kTwcwk1ULP0xNNblvPOYaFEHsoJCxbSvNnGuXJFMMXwKX4/NgMAvCAqpwFZYW
         Gfob1fCSvP1XWaG8ZG7H9IUZRzCD1cl9MwkxOPAtM8fhVa03yhH7xM1MeCgOa6yIz5Cn
         K5uAui3L2y/CccFwe16om9VvBG3ociv8fmrFE0EZh90JhaC1Y4pD0suG97iCfgEG38nL
         nzDUusyGIiUvMViJBLPFIRfyDwmVbCLV5IddqVIZD3AKQJGpfUosDlwjtG0pJ8gPUgeF
         DPYQ==
X-Gm-Message-State: AGi0Pua9lwaUaflpYSub3eCaYGYNoiLQb1lojdsk2ZS86JgSvjxtDu1X
        xF/s4nrl/90CiV0vg3kG3aU=
X-Google-Smtp-Source: APiQypI3ADIddYujUXFFd3J7qJbmarkuNkmp+vZH8NiU3NHgBxky845LmO+SMRcLmZhfAGYfIIblKg==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr3023648wru.376.1586764421177;
        Mon, 13 Apr 2020 00:53:41 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2da9:2f00:c0be:812e:7fb0:ebe0])
        by smtp.gmail.com with ESMTPSA id s14sm14009619wme.33.2020.04.13.00.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 00:53:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>, Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: point to display schemas in DRM DRIVERS FOR ALLWINNER A10
Date:   Mon, 13 Apr 2020 09:53:29 +0200
Message-Id: <20200413075329.10717-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f5a98bfe7b37 ("dt-bindings: display: Convert Allwinner display
pipeline to schemas") replaced sunxi/sun4i-drm.txt with
allwinner,sun*.yaml files in Documentation/devicetree/bindings/display/,
but did not adjust DRM DRIVERS FOR ALLWINNER A10.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches \
  F: Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt

Point to allwinner display schemas in DRM DRIVERS FOR ALLWINNER A10.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Maxime, please ack.
Rob, please pick this non-urgent minor clean-up patch.


 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..1f6c9bec872a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5552,7 +5552,7 @@ M:	Chen-Yu Tsai <wens@csie.org>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+F:	Documentation/devicetree/bindings/display/allwinner,sun*.yaml
 F:	drivers/gpu/drm/sun4i/
 
 DRM DRIVERS FOR AMLOGIC SOCS
-- 
2.17.1

