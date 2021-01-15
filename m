Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305BE2F838E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733234AbhAOSOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbhAOSOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9022C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 91so10212088wrj.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAAEuD3RlEr/SK+ua/zk+cZbQLwjXz0Jv5gG/pDSRFI=;
        b=RNlz61U66+BUG1s+nfI5teKJXRzuhAMcV/qAFVRXV+wo32MjqVdz82qZ+lAO7fU6y1
         6AeYS8NZOV1XOpHbW/l8uDFRm91lwC39apk+K9velV1B1eYzstpRzlMpCDA8KTHqXr9w
         UKqvIVaChpMvb5Xu2BYeV67rF7W62o/haTbVgcfVDoNHWaS2uYXSsrYQuwtsaA7cFUD0
         1d4o9RxUprSwq8f+2rKLEt1HiQFe3SzaQ+tFDP7FSt6o6cK8dxAjmEmaTxYFQuKq5WbD
         s1Im/XIHYHvruuyaGxAt3cLHIhdXy44KcuI/A0h5AKziCv8119TfPyA8Cbu5/MZhOwBg
         4szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAAEuD3RlEr/SK+ua/zk+cZbQLwjXz0Jv5gG/pDSRFI=;
        b=ZSEqbxtQvHbNo93dxHEzuB8Bs2z6tQoe8FracPucd1lkDmAJiSIl2cNoPFPc2pdZo7
         RFvHhFbH656LvBL5xnanZWOfS4JsiY19gVBr7L8I9egZB8u+ntFGwghzZjvSqY93xPhL
         wj2g2s9FzyXSMZXMWlVffhP8C83p4968Jq3TJt8O1JdsxtwVjykdepEzEeQKx+JNCaHn
         LvX2WS1PEH9IPcS6TPzbkmMpdlBxlNiReAcSKB7NXfJMOYUk/VZ5nhnQ+cPUGm5a6ibU
         yMW74gaAWrRb96yh/jurY46nkVDPxmfAhBNRe1VkD4rqNANvOLY7Ty4qz8YxBe4J+S1k
         XWdw==
X-Gm-Message-State: AOAM531o9QaGP9YOHpZFOlMNTDSVqsZCpZwBkefnRTrWnOhERzLPe0Rr
        7q0aERsICo+4FWGZ46uofRi+nw==
X-Google-Smtp-Source: ABdhPJzlmSdMVzlgQMNkUxNs186KSUwDnAnO4SsNgnPYTbXf9gsWuDYH8x8BWmMJW6fVGztzH9DU9A==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr14777366wrt.396.1610734413540;
        Fri, 15 Jan 2021 10:13:33 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/40] drm/vmwgfx/vmwgfx_fifo: Demote non-conformant kernel-doc header
Date:   Fri, 15 Jan 2021 18:12:45 +0000
Message-Id: <20210115181313.3431493-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c:299: warning: Function parameter or member 'dev_priv' not described in 'vmw_local_fifo_reserve'
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c:299: warning: Function parameter or member 'bytes' not described in 'vmw_local_fifo_reserve'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
index 7400d617ae3cc..20246a7c97c9d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
@@ -276,7 +276,7 @@ static int vmw_fifo_wait(struct vmw_private *dev_priv,
 	return ret;
 }
 
-/**
+/*
  * Reserve @bytes number of bytes in the fifo.
  *
  * This function will return NULL (error) on two conditions:
-- 
2.25.1

