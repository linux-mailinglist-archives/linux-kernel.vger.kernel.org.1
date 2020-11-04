Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247302A6E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgKDTgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731671AbgKDTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:50 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CEFC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:48 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h62so3434900wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xSLrFShdIRGu2Z0l5VTYddY/Kvq8FZAdgHuY+BxUcAw=;
        b=uXVhNdK21Wddb2jNKS1C3MSNolc+cUuO83JkVAMzjCfcEK2rXqEZm/X1pgBv2scGnk
         +zTIi5I0E4UUj/SWhQfmDr4tTemUDgmD+vqMldqbc5VWlLHJw2VznOLL6cQQ2riRvOjG
         Oz3R1W52EjItgciKCtJDyJKyo05tCZUvncTXKz9jxULN2eOCWOXSpg/nn1SsPqc+TKi2
         XZwrXq8AJJjdtvwzfzghNkV7WmH/DZmphK+Ic4G2O2tM2X5o1FnlnsBABertwo8bI23y
         X6giOXaKIJ33PQGAg6tdVHGZfQVQhSn2ryN1HGPgk+bdVsnkAZG+Q6LnLqFwBGp34hPA
         vlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xSLrFShdIRGu2Z0l5VTYddY/Kvq8FZAdgHuY+BxUcAw=;
        b=Wxqt5SUkeL2oZ/b85L1x6HmOSTnEY8MQ/K2QA15cG4Mi9AjxUDtJ8nEAvcwJLs/qtl
         z8Vsr82BOywmWFqqT3DlS8D1um5ElAKevDa2gkxbIpjDjrFIDtcmj4uCCovsk41s1Czd
         YzdxC4OxJcxJ7IV3ae5cCT7fQwJsJIBxypj2awjDGCL9ZH5i8y//UQtkIWS2dfgO+K2v
         zWTzFW8NBzm2XBYntUgFTN1fHsda7MZpfNKNZLxsCMqPinwsv3GU9PeH1D4HPAeF8M1Y
         v6MZwDioaiVzGA/pEV5DzpPGSPwNp193m90LuNA5IbBd7lgk17hflhg0ZiJGj+BLFA9K
         Yp7g==
X-Gm-Message-State: AOAM533VsdnxOK51kyD3JIOBP4RiRz1lTQDuNYIsXzeo8jEky47nm6kl
        FkZWzzur5NB2Oyg5WETe5vDGDg==
X-Google-Smtp-Source: ABdhPJxv4RJjIe6ZQcTMccVOlCyU/O+jKiSTg54znUrsoQWEPdWdSKIPcsjztIYwEOZvLvE96ySv+A==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr6307261wmq.30.1604518607199;
        Wed, 04 Nov 2020 11:36:47 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 33/36] tty: hvc: hvc_opal: Staticify function invoked by reference
Date:   Wed,  4 Nov 2020 19:35:46 +0000
Message-Id: <20201104193549.4026187-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/hvc/hvc_opal.c:106:6: warning: no previous prototype for ‘hvc_opal_hvsi_hangup’ [-Wmissing-prototypes]

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/hvc/hvc_opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index c66412566efce..056ae21a51214 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -103,7 +103,7 @@ static void hvc_opal_hvsi_close(struct hvc_struct *hp, int data)
 	notifier_del_irq(hp, data);
 }
 
-void hvc_opal_hvsi_hangup(struct hvc_struct *hp, int data)
+static void hvc_opal_hvsi_hangup(struct hvc_struct *hp, int data)
 {
 	struct hvc_opal_priv *pv = hvc_opal_privs[hp->vtermno];
 
-- 
2.25.1

