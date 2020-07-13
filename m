Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6026521CF4D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 08:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgGMGJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 02:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgGMGJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:09:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA77AC08C5DB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:09:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so5040021pld.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5SJRhGUMLnGQMUFDntsl5BWZJUWM/0k6ncUijg6biA=;
        b=e9eJSJSiGF6WMtv/BO8xgn4y9lS+3engHpcoQj4ttFSeWSlM7pKNQxEcW/PeneO269
         PHRBri/i+spv6QDrGPYwZgYqJXg9yVXafWGAv+QOUxZzmB3iw39KZ4wiGdPewdO+wSte
         z/gW5kkn0iQxcQGOIGluwcOdvFOcANOep/3TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5SJRhGUMLnGQMUFDntsl5BWZJUWM/0k6ncUijg6biA=;
        b=WDMgP3RENeq8GW975u+pCmAVmji8k6l2dq4cs48LAANUENcspoFVoNVz+WN61m/+Tb
         Izribm/sf9v2yUzdhuemJVzp2ujQ8Of/pYpaazgOnlZ2velw1tGU5EoRpqtAPgledCZz
         rfjOCSZ7ePo3o+nOTdhhj7//QKEY0OGtp0IU1KLA6zdwsTuFfRtIZIYNiSgZwSKWaFwp
         q6qPdI9TxVmC8sKRE1dlKNlRYVa5T8PZaBZeqi0plHtY8vgM1tV829MDP0X4mx0GmkTa
         AVg79qxHm0nsOEovoWtiAADcKKuur10Nb2firU4UOvXm+/qJg6rGHYMj4S5SihK7yjIB
         wySA==
X-Gm-Message-State: AOAM533S7+fP0kvNHhqlOBANORxb7To1yGPMlWsP2eGyKdw4pVPnQDWW
        SNf9nkNjkux99Vap3aWSHOucXw==
X-Google-Smtp-Source: ABdhPJyfrsgnEB025G3HB/bdasCZtlOPEKmabswNGrrw3Z/BVQ8GGnY3KH9KNkNIzG22M+kR6d/lyg==
X-Received: by 2002:a17:90a:e60b:: with SMTP id j11mr18907748pjy.189.1594620575272;
        Sun, 12 Jul 2020 23:09:35 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id c134sm13134934pfc.115.2020.07.12.23.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:09:34 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v3 08/16] dt-bindings: media: document mediatek,mt8183-vcodec-enc
Date:   Mon, 13 Jul 2020 15:08:34 +0900
Message-Id: <20200713060842.471356-9-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713060842.471356-1-acourbot@chromium.org>
References: <20200713060842.471356-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8183's encoder is similar to MT8173's.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 7aef0a4fe207..8093335afecb 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -4,8 +4,9 @@ Mediatek Video Codec is the video codec hw present in Mediatek SoCs which
 supports high resolution encoding and decoding functionalities.
 
 Required properties:
-- compatible : "mediatek,mt8173-vcodec-enc" for encoder
-  "mediatek,mt8173-vcodec-dec" for decoder.
+- compatible : "mediatek,mt8173-vcodec-enc" for MT8173 encoder
+  "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
+  "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
 - reg : Physical base address of the video codec registers and length of
   memory mapped region.
 - interrupts : interrupt number to the cpu.
-- 
2.27.0.383.g050319c2ae-goog

