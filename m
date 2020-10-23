Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C3E297088
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464871AbgJWNbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374545AbgJWNbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:31:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB3C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:31:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k21so1126700wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0g5y25aamnJmaPgpvLpUPjcowdDVx0DC7LsyytrI5g=;
        b=MlR6wK4kuxU+Ax9dRf4/DR9QDEr/ma6S6Y2sM20AWbwA7RfrDwTOOLYdZaax7G0v1y
         zsFqOdkKJfXeOi3Yyhs6Zhol6iJX6NsnuMRaRnAoCfQxi4JEXtn5GNKWELkTTWb8WdHn
         ajtN6cIlBo/KjFgAgqvJLHPTaCSxPtg6NuFnBiti0+aY7y+Wnahua1t8VjnSDG5TyTLx
         L1xGw/h7u5Qp+D2SR2Y9/0TmbwOwUPdOkLI6ydPX2T/GrZA/QQDjLoEen9L6CFXZVUxy
         /N8Bwq19JrKxMCxvNX6YwY8+cSYhFxAnjWHLzaBIJHX31b0Ppkepn0BNjIrPH6qfGGsh
         CqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0g5y25aamnJmaPgpvLpUPjcowdDVx0DC7LsyytrI5g=;
        b=lPFOmqonxcB3PXDQY1OEguax5RwGQLai8RuyZMKm1xgDwZzHSKaAjELqpW6B4dn567
         EaO+EpKT9VLWV2W37tbudeSdLAvGtoOJyq9IvWHRK3qPT0DHt6sniLK6JfJdNCZ5Gx0F
         np4O7fKQSV/usSBipv6KBGaB9CEaD3ORkoqiL8mEQgBqGH6GptYWS37FvnsiyyKayci7
         MxmddDVMjBV7XcwWquHnPpM4qsZ9wUSjHOZJcA6/dFHIWZP1ZF6ZyuwxFfHgHrzkun0D
         fZdNLHNjiRcy7atShrAeZrVU5Tb9qxFAFwhRR/3CJUALmX36lJNjOmQaQRQksmhHnE8+
         LW1Q==
X-Gm-Message-State: AOAM530Pvn+lgjO/3uHNeFDpHuC2FCCuVsbI7ILsIdQiRS2+jKo2jTe3
        v5BmOJgcZFfLlHJ+nKlTIYcjpg==
X-Google-Smtp-Source: ABdhPJx3KXkKjPhuP5F8RgAsbrby6ayVAwe3PQJpsJ7APdCh/zspU8uMjMlSQ4RwHHypPHprj6j/XA==
X-Received: by 2002:a1c:bb84:: with SMTP id l126mr2267365wmf.141.1603459894574;
        Fri, 23 Oct 2020 06:31:34 -0700 (PDT)
Received: from localhost.localdomain (211.160.185.81.rev.sfr.net. [81.185.160.211])
        by smtp.gmail.com with ESMTPSA id f6sm3146107wru.50.2020.10.23.06.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:31:33 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 0/5] Add DRM/DSI support for MT8167 SoC
Date:   Fri, 23 Oct 2020 15:31:25 +0200
Message-Id: <20201023133130.194140-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for DSI on the MT8167 SoC. HDMI is not yet supported
as secondary display path.

mmsys is not supported by this series and will be sent in a seperate series
based on [0].

[0] https://patchwork.kernel.org/project/linux-mediatek/list/?series=360447

Changelog:
	V2: removed 3 patches

Fabien Parent (5):
  dt-bindings: display: mediatek: disp: add documentation for MT8167 SoC
  dt-bindings: display: mediatek: dsi: add documentation for MT8167 SoC
  drm/mediatek: add disp-color MT8167 support
  drm/mediatek: add DDP support for MT8167
  drm/mediatek: Add support for main DDP path on MT8167

 .../display/mediatek/mediatek,disp.txt        |  4 +-
 .../display/mediatek/mediatek,dsi.txt         |  4 +-
 drivers/gpu/drm/mediatek/mtk_disp_color.c     |  7 +++
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c        | 47 +++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 38 +++++++++++++++
 5 files changed, 96 insertions(+), 4 deletions(-)

-- 
2.28.0

