Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EE5215899
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgGFNfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 09:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbgGFNeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C408C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so39372154wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fFhBoF9F+cplYOt0drBYrKvo/NCkeTyoUMk2XPNxJS4=;
        b=OmZFfKsZE3nw2Rx7QazBJNlNeA+U8z1Z2PcNhcqjoK68z1sVetkUL2vJdCbMgfCx+z
         GQ5OdTbXa+xGGweQRAIjQY+yIMbO16Ik2oUI+cRDjkln/G96vTY+Sv3Hmg9wjeMj9Moe
         wjup2WRBceFy+RvHDn6sGC88K+miXgtBtFdiQiKW7ax7JwncaSGkDlPgFdll46+6/YiB
         c2Hvox1thv7IHBF2cFtkUXRSO0tVbQdaKgKzefw5AxbQcMOI86AnSy5xCXNu/8SdAEfj
         tMQN++j0iRkOEy/9hGk3KCKGViLlrFbGp+lhcUlgAE3JBu5bqpBfe9atSyQizMIJsTA+
         txEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fFhBoF9F+cplYOt0drBYrKvo/NCkeTyoUMk2XPNxJS4=;
        b=pXNzFbTM73od0U8JDOiCI2JVUq4DGDyWg/bEq0iNQER9J7cE7zYsRlBpvU3N0HBi0z
         /ZBqcLIwcyONlRorEaDSOoPaPe5ZCXB1cwWdL9k48+eKNTrEdcU7UdmpPqE1gq9MQEb2
         XV9wBNnORpPSMW21F69XvS9r446nXCCb5BuxUp3g5qobQ7Ugm+e6JDTWsJfLMv2N8goJ
         5Ltcn6nbCO+BFHGo6BF3OJG6Yx1IpJaOlazSa+XdysQhZySgOlK7uLVqEtw+vbnBKeq4
         +nIFp7slfDOmcXexzSfztCe9TO1KfCkR2lzZrcFo2+rgaoea0rG/3Oo9C19XuklHE0yA
         Crpg==
X-Gm-Message-State: AOAM531zeQf/5gCVAfsRs5ChyJfPeHj4BO/S946PeM3Su0lpUEbhKRt1
        zit5n1P+ekWs4vXqUdKrMj2qIw==
X-Google-Smtp-Source: ABdhPJzHeQs23/qyFcnX4TERiDrg/KCZCBqe16Wspkyc46J1cIxb5+c8wXVxLRMwjJxdzWxMdM1HWA==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr2416268wmh.121.1594042440115;
        Mon, 06 Jul 2020 06:34:00 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 13/32] usb: host: r8a66597-hcd: Remove set, then over-written, but never used variable 'tmp'
Date:   Mon,  6 Jul 2020 14:33:22 +0100
Message-Id: <20200706133341.476881-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like it's been this way since the driver's inception in 2007.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/r8a66597-hcd.c: In function ‘clear_all_buffer’:
 drivers/usb/host/r8a66597-hcd.c:478:6: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]
 478 | u16 tmp;
 | ^~~

Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/r8a66597-hcd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 0c03ac6b02137..63719cdf6a4e6 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -475,16 +475,14 @@ static void pipe_stop(struct r8a66597 *r8a66597, struct r8a66597_pipe *pipe)
 static void clear_all_buffer(struct r8a66597 *r8a66597,
 			     struct r8a66597_pipe *pipe)
 {
-	u16 tmp;
-
 	if (!pipe || pipe->info.pipenum == 0)
 		return;
 
 	pipe_stop(r8a66597, pipe);
 	r8a66597_bset(r8a66597, ACLRM, pipe->pipectr);
-	tmp = r8a66597_read(r8a66597, pipe->pipectr);
-	tmp = r8a66597_read(r8a66597, pipe->pipectr);
-	tmp = r8a66597_read(r8a66597, pipe->pipectr);
+	r8a66597_read(r8a66597, pipe->pipectr);
+	r8a66597_read(r8a66597, pipe->pipectr);
+	r8a66597_read(r8a66597, pipe->pipectr);
 	r8a66597_bclr(r8a66597, ACLRM, pipe->pipectr);
 }
 
-- 
2.25.1

