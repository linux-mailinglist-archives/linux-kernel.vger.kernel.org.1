Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED75C293CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407303AbgJTNHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406825AbgJTNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603199238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2anAzapiudNNR8XpuCb8etqjbkocHf/cArg3i1fKpjA=;
        b=IfHSCzaczjPDzxsQr/fSGCHJe6b7l1sgRT3CtMjusiJywR4LMvUNuh/+TNz2kw0BiS17bU
        5iIyVzfgPyRbNrNzj6E03/soonZVYrMYk/ccVr9dvazpGEJtXFjkjA3nNbxNxwhMVfKaX+
        RXfMh8ggM7IgISr8k8kvEZX+LFhHVeM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-qv_3k5RiMTy5BoVC12cbVQ-1; Tue, 20 Oct 2020 09:07:16 -0400
X-MC-Unique: qv_3k5RiMTy5BoVC12cbVQ-1
Received: by mail-qv1-f69.google.com with SMTP id h12so1255798qvk.22
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2anAzapiudNNR8XpuCb8etqjbkocHf/cArg3i1fKpjA=;
        b=hEsBz8dWF+pNLDXt9gayjaQRGSj81wXlbTLHvH1iHIJDlkVvGolK3508o1qoFbRIjb
         qLe75FEBvuPkdncDBhe5cGU8O0IjbEvojNJZCUcURRd41kkD1cyd2n6pT0velqvsXzOJ
         izXwLhxXYoZRVN3stzaAaaHlhb/rnPcaRBwpHoM29GrlYbkTGSW2jxwHYy/lQ3uYbV48
         +rqnAEmhD/4JvpUuEhFd/+WZD/IECDqxKD678T4uZM+Qjanu7yyYTr6zYTCfpdniCNxi
         dVXnKcXfM9Apii8muoc+3rCrg8rlfDBtssQZi9oUHBSYiusrmq0/6fJsaA0njv3Mkpi7
         ms0Q==
X-Gm-Message-State: AOAM531fT8wb2LwKYC5CjPFrNkF9+ZLPA2vvToMl58qQQm/Uhsr0vxU3
        OjHbUsF7ywS/byFP/GwJtnlmVGOX0TVXKIa8LT6c9JNKg4+KMKcNTAwomJ/Sw7HI5ttrI1AxnUm
        6wT0pZ9X3C15c51nKEXIGqQET
X-Received: by 2002:aed:216b:: with SMTP id 98mr2299347qtc.233.1603199234956;
        Tue, 20 Oct 2020 06:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqNg7p1DO3AxkYDn6Hv+sy3YgDE6VecvNiBWMxgWFr77Yf6Q7cXLbaArbHxGEA5CBuDcGZyg==
X-Received: by 2002:aed:216b:: with SMTP id 98mr2299314qtc.233.1603199234669;
        Tue, 20 Oct 2020 06:07:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 8sm760540qkm.0.2020.10.20.06.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:07:14 -0700 (PDT)
From:   trix@redhat.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] tty: serial: imx: remove unneeded break
Date:   Tue, 20 Oct 2020 06:07:09 -0700
Message-Id: <20201020130709.28096-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---

v2: improve commit log

---
 drivers/tty/serial/imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1731d9728865..09703079db7b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -320,7 +320,6 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 	switch (offset) {
 	case UCR1:
 		return sport->ucr1;
-		break;
 	case UCR2:
 		/*
 		 * UCR2_SRST is the only bit in the cached registers that might
@@ -331,16 +330,12 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 		if (!(sport->ucr2 & UCR2_SRST))
 			sport->ucr2 = readl(sport->port.membase + offset);
 		return sport->ucr2;
-		break;
 	case UCR3:
 		return sport->ucr3;
-		break;
 	case UCR4:
 		return sport->ucr4;
-		break;
 	case UFCR:
 		return sport->ufcr;
-		break;
 	default:
 		return readl(sport->port.membase + offset);
 	}
-- 
2.18.1

