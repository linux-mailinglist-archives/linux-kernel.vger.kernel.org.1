Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CB124CF20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgHUHWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgHUHRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60140C061350
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so1028730wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePe6weLeORKQn1kjGoGA+hXrLyzhTEFalZVJmLc5XBY=;
        b=GApq0ETO5ZH0/lqVZB+qyfEb/xueGwiJDvz7ILu3q2Fk+VYDnrX5Ro8ZOXabhujwzQ
         P7o6wiNPlc9WW9fzFVz+75rs5Lu9s1hLERwVbh9s9IFfYkZX+EBxZVhEZAIwpYXE3Gi/
         adVSHUfsRhW9pIzkQKhGqoq1EJYchyBbjt0kI5Yqe6X/Xw2KL+vxevPlEo2arezHIiBs
         D3ObLaz9i3MzIqtP7aQ3pEQvAtddrmzjj+mqrgn4TLUX35pKjQ8PToJvskWzWcs/P05k
         CG/jQdiaI2AE/dRDdgPEDxq564aK9j3eQA6hNbV/gfXeH05l70LInADc+Dr00o6gYdwi
         Swag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePe6weLeORKQn1kjGoGA+hXrLyzhTEFalZVJmLc5XBY=;
        b=i7Cm67xyPH2/fr/niy73wOT1qasQ67+4AHsg8x0LHEBkP18smxaWPfm3BTugOF7aF5
         +2kN/UyyMVjGuc244whf4/SvCqB9hKBJkBGHV8ens/FgHKMID35GIFW6gSJEhwYk5iIe
         eEAx7ThZqdeCDJyh6zXA/UTuufgul+yfwBzTEAC0HUTYoChYEsutYgWk2bKoKZXxLxUM
         3CmgzTlEFiPfxEEYgKBWcfVY01KlT5KajXyF/Mq5wXGMmJKtdRax+nb1Xf1H3pv//ryF
         w+L4mbSOPAVzKqk91vQApQZ07f73mQQhx+jrLH3oEej7K6BCGs9egLpA87jgLvDrjTDu
         37bw==
X-Gm-Message-State: AOAM530FMyVLf4cUIROh5A0osOmrQ9pAf7LWFw1ybRbMD8Ir7k68lS9Y
        O8n9YYWoZZEg0p2JubWVQxA7jA==
X-Google-Smtp-Source: ABdhPJxoFebcmcu4cK83ANrkpCcLdWEdbrXuuGl+2NTHdEzpvzoiiO6Qd5WRSwT/+N7tZ6OHsMbjDg==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr1375083wrm.113.1597994221040;
        Fri, 21 Aug 2020 00:17:01 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Subject: [PATCH 10/32] wireless: rsi: rsi_91x_ps: Source file headers do not make good kernel-doc candidates
Date:   Fri, 21 Aug 2020 08:16:22 +0100
Message-Id: <20200821071644.109970-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_ps.c:26: warning: Function parameter or member 'state' not described in 'str_psstate'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_ps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_ps.c b/drivers/net/wireless/rsi/rsi_91x_ps.c
index 01472fac8b9ae..fdaa5a7260dd8 100644
--- a/drivers/net/wireless/rsi/rsi_91x_ps.c
+++ b/drivers/net/wireless/rsi/rsi_91x_ps.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2014 Redpine Signals Inc.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
-- 
2.25.1

