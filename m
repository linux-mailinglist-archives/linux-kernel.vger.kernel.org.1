Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD19B216E37
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgGGOBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGGOBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:01:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E07C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:01:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so33972590wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuL/Iy3i9aJ7SLBRjyYkn8G6jFvDgmCt3JP0c6V0JmE=;
        b=KrbNLXwcM8rh7ttMrR97DE+xAoJyroqlKx/hR/xRcE7XSM/PPL+3Y5pbiBajeyuHjs
         iwOG7qmicRXCfX9aM5vTp+l7L0enOJ2k5L9GG2WqKPgF0X/8UFD2zr8hsrCygaQB+5ew
         g6ICyCXsMEe62zk8uaCUHebsDC0ksQJj5YxhAI7fDooRZnuS1aSUzc8Ewr+1UJNvoLnw
         nS3Pw1pCEHpHltVJxgrmzM623dDKzXOJ9U+shmarEjFRGXpWilqb+I42YqXgX13E8CJG
         KFUAi2r8sYjC2qvzSd1/gXekLpbG6wzlgphw0M/6BVGjO3F8xguuvqcj45ujKGcKIzJv
         i+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuL/Iy3i9aJ7SLBRjyYkn8G6jFvDgmCt3JP0c6V0JmE=;
        b=Ck5lRgTwBVDPwrQb1JdH2/WAdWyeK0bxFV6XyFEk70GmVIwQzrss0HC53XWWqJeWcd
         dKuBIvkbbwiUNv7hDZMdPfGm/3HtqEeA05qhD7494ScYvIYXJFrdbDjSDrB05zBgabZT
         sC8IoRDAl+ndiX74iIqFN76WYEvclN+itp2mZo1oxqmKqpuW0MPHZH8BCohQDmyDI+XF
         +2cLasJpi1n1Weyxa/CIkedTn3aUmlkPN9qcEwmnf33dCLWJ0DubT6zx6ePbMFiRSear
         kpcMqWVV4hoITrW1OIU+iVG3iP7b+z45POyByHqWA0J4UHClqGiiAald1bhR+uXQ/yBf
         7Ekg==
X-Gm-Message-State: AOAM531UJMNFxdnwol/D/2kRnV1bl94PtaFsAploHiR7jiuBhSRu05Qy
        e7p7qqCtyPN0o9/uDkbuGWm17A==
X-Google-Smtp-Source: ABdhPJxaRi+woMXn5JnprKx9kBC1w1ggUCROAZwIh9PhadVOAR9gFiaF++i4sJSD9Z6S4KQFuF4TBg==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr54760951wrp.421.1594130467935;
        Tue, 07 Jul 2020 07:01:07 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z25sm1102823wmk.28.2020.07.07.07.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:01:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
Subject: [PATCH 07/10] scsi: pcmcia: nsp_cs: Use new __printf() format notation
Date:   Tue,  7 Jul 2020 15:00:52 +0100
Message-Id: <20200707140055.2956235-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707140055.2956235-1-lee.jones@linaro.org>
References: <20200707140055.2956235-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/pcmcia/nsp_cs.c: In function ‘nsp_cs_message’:
 drivers/scsi/pcmcia/nsp_cs.c:143:2: warning: function ‘nsp_cs_message’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
 drivers/scsi/pcmcia/nsp_cs.c: In function ‘nsp_fifo_count’:
 drivers/scsi/pcmcia/nsp_cs.c:692:24: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]

Cc: YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/pcmcia/nsp_cs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index d79ce97a04bd7..57a78f84f97ab 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -134,6 +134,7 @@ static inline void nsp_inc_resid(struct scsi_cmnd *SCpnt, int residInc)
 	scsi_set_resid(SCpnt, scsi_get_resid(SCpnt) + residInc);
 }
 
+__printf(4, 5)
 static void nsp_cs_message(const char *func, int line, char *type, char *fmt, ...)
 {
 	va_list args;
-- 
2.25.1

