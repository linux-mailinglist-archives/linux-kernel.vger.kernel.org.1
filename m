Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413952AC27A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbgKIRgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbgKIRgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:36:09 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B935C0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:36:08 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id f23so6816028ejk.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L9F3HkMW13rcGTb3bzExEGKic5ytenCIez631dN7HLE=;
        b=PitAaj9RXayVuhqFAVZImb2FJzaptvJrhnw4hRd7qLhtpHZt3/13gByfP2V52MOaUX
         aH5Y7+o8Wug0hJs2gyg/kpATu+uz4xGJqpaA+qMwMJNMx93z7o1RSZbdhe60teDElpma
         MZWjsED9bHeNSqbizQ32mr7FDj01m120ZIF+PLqQ2hWlxXqmbfq7/C7qIMbzCia4vpk0
         wNo+WpH7HTWxUI88xYoFekEvbl+0OmG3mqHshaIormsO/9qngltHSg3J2kMiMZiybVvo
         rnnAax8INabenQwe0yl5nNUwZISmh+wVD3Xw0HE3/3I67qQhxFnAtuHbilgLmxjQDOnA
         wLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L9F3HkMW13rcGTb3bzExEGKic5ytenCIez631dN7HLE=;
        b=JEbvJlTPPr9vk6zdihoEetGKPH1KTfjYDJyfrHFWjdCI6iaYjFgoq7Sj8nEMoAwezj
         apGNWufRHLzI+BpG33qv4eo7DfEmJhxiF3UBwXv7BndKxBaMuSookoNWr4PzCDlABuUE
         elBj4cDjp0wdsl5pKcLmp8UI4AUu3SCeglMknwNcNdl102tuHsUYG27lGWWSXVecVrQ9
         kMxJO/ZtBcMxasBHhHe4L4Z/9J1Mx4730K1AwrXWvy4pEgz3IHXz7mchqWKCv/r019Va
         L3JqFksAuYBtlxU/QrT8kiXWYEYJeCG3822yRH25lW4uxc8UQ+i6X15EaQN2yJl/3EyT
         +WZQ==
X-Gm-Message-State: AOAM531IsSy2ay2v81rb4qYzSRXkzRslzCm3Ibusv8u98CqpK0af9p0I
        r/jgL6+WqMEeun6z+x63W4agUw==
X-Google-Smtp-Source: ABdhPJyPOQ+Ryay5dRFIcvl4AnOiW4HTmIeH+B3sow5u7A2Zn8mHc5EEGOQcqZwKV+qqfynNNsUwQQ==
X-Received: by 2002:a17:906:1381:: with SMTP id f1mr15609974ejc.87.1604943367038;
        Mon, 09 Nov 2020 09:36:07 -0800 (PST)
Received: from localhost.localdomain (hst-221-89.medicom.bg. [84.238.221.89])
        by smtp.gmail.com with ESMTPSA id jw7sm9123981ejb.54.2020.11.09.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:36:06 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 4/4] docs: Deprecate mfc display delay controls
Date:   Mon,  9 Nov 2020 19:35:41 +0200
Message-Id: <20201109173541.10016-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109173541.10016-1-stanimir.varbanov@linaro.org>
References: <20201109173541.10016-1-stanimir.varbanov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate mfc private display delay and display enable controls for
new clients and use the standard controls instead.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../userspace-api/media/v4l/ext-ctrls-codec.rst        | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 82c9cda40270..b8f69c52b2a2 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2771,6 +2771,11 @@ MFC 5.1 Control IDs
     feature can be used for example for generating thumbnails of videos.
     Applicable to the H264 decoder.
 
+    .. note::
+
+       This control is deprecated. Use the standard
+       ``V4L2_CID_MPEG_VIDEO_DECODER_DISPLAY_DELAY_ENABLE`` control instead.
+
 ``V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY (integer)``
     Display delay value for H264 decoder. The decoder is forced to
     return a decoded frame after the set 'display delay' number of
@@ -2778,6 +2783,11 @@ MFC 5.1 Control IDs
     of display order, in addition the hardware may still be using the
     returned buffer as a reference picture for subsequent frames.
 
+    .. note::
+
+       This control is deprecated. Use the standard
+       ``V4L2_CID_MPEG_VIDEO_DECODER_DISPLAY_DELAY`` control instead.
+
 ``V4L2_CID_MPEG_MFC51_VIDEO_H264_NUM_REF_PIC_FOR_P (integer)``
     The number of reference pictures used for encoding a P picture.
     Applicable to the H264 encoder.
-- 
2.17.1

