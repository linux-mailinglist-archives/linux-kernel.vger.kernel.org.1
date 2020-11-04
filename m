Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A852A6E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgKDThZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731548AbgKDTgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:43 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18979C040201
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:42 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c16so3419737wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fgb1IEzfMnPc6nqs8QP0jEqoyFf5EkN3W0LREp5eok=;
        b=dUki5RoAgEUXeV68RfVBsjZNTcSI5/Puy7ll183zFMy88MFmsFDu++Lc+6nX6nS1AC
         f6R+u9/0cYkz9bE0iRfGya8+/e0t/t2FEmXyplh3cPVhWClmNbJpgnBPsGpWvSuWsKlb
         9Yjo3MWCHUzlFjclnW2Ag4ZTN/eP2MEPGJsQzi/Rmk6b89US8uJYtsMHbpNTdNur/rAP
         +xugpeZt1Bzs2DaMfrknk/bKiy6as07x7eJzKM9o7RHXNN6rROFE0jYf/ylkFx6iPDa4
         v2Sk+Vi/vHzMQHT2B8Xe+lbVvu8fbvl5bBn2n8yakmZw6QAO8IY8177O8vpbx9rtvWtk
         SEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fgb1IEzfMnPc6nqs8QP0jEqoyFf5EkN3W0LREp5eok=;
        b=TsuUodAKILcCwPfSwXz0wUmokf3oIqdc2EoTb4gfMhghKch6OEZ5hrkELkjC4Pey0z
         Iq/kZXmMkMzCkr2IcRY03ZhoZOdzXUl6CnRukuKlM+n4jpF5u8Sjp0PW91E5BjXtNXok
         /vNuC/eVUCDh9mDrZ8yAsMCViw/lkXmW0eGOAHblvXy3rptWIAwYTyQVrOVwbXNqZg2P
         ibb+Dnrk7RSe/HgETBb25F39CPFrPVP1GJuDIpKGz2M+q6gakJJQQ0uorZ9a3o2QMFww
         zFsTs3M1F59Q7OaJzngJtXM7ZuBcbb39fMyJWu4PQ/Z5jmKPWosFDcw4UqQEwM8Y12iG
         FhsQ==
X-Gm-Message-State: AOAM531QCBhbVH55rcjHZkYDX7ye+66DUrWkfpwAaZbx9CdNTEZaSuP1
        iWIuia+9n6QFIiF+UEr6vLJJYQ==
X-Google-Smtp-Source: ABdhPJzZSKL8589f8RPwDs7HELd7TAx5FicWl/OW2kST8shLGYY49ni5v34zHDMZovFwCv5U+2lCfA==
X-Received: by 2002:a1c:1d51:: with SMTP id d78mr6192642wmd.60.1604518600809;
        Wed, 04 Nov 2020 11:36:40 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 28/36] tty: serial: stm32-usart: Remove set but unused 'cookie' variables
Date:   Wed,  4 Nov 2020 19:35:41 +0000
Message-Id: <20201104193549.4026187-29-lee.jones@linaro.org>
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

 drivers/tty/serial/stm32-usart.c: In function ‘stm32_transmit_chars_dma’:
 drivers/tty/serial/stm32-usart.c:353:15: warning: variable ‘cookie’ set but not used [-Wunused-but-set-variable]
 drivers/tty/serial/stm32-usart.c: In function ‘stm32_of_dma_rx_probe’:
 drivers/tty/serial/stm32-usart.c:1090:15: warning: variable ‘cookie’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Gerald Baeza <gerald.baeza@st.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/stm32-usart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ee6c7762d3559..f4de32d3f2afe 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -350,7 +350,6 @@ static void stm32_transmit_chars_dma(struct uart_port *port)
 	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 	struct dma_async_tx_descriptor *desc = NULL;
-	dma_cookie_t cookie;
 	unsigned int count, i;
 
 	if (stm32port->tx_dma_busy)
@@ -394,7 +393,7 @@ static void stm32_transmit_chars_dma(struct uart_port *port)
 	desc->callback_param = port;
 
 	/* Push current DMA TX transaction in the pending queue */
-	cookie = dmaengine_submit(desc);
+	dmaengine_submit(desc);
 
 	/* Issue pending DMA TX requests */
 	dma_async_issue_pending(stm32port->tx_ch);
@@ -1087,7 +1086,6 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 	struct device *dev = &pdev->dev;
 	struct dma_slave_config config;
 	struct dma_async_tx_descriptor *desc = NULL;
-	dma_cookie_t cookie;
 	int ret;
 
 	/* Request DMA RX channel */
@@ -1132,7 +1130,7 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 	desc->callback_param = NULL;
 
 	/* Push current DMA transaction in the pending queue */
-	cookie = dmaengine_submit(desc);
+	dmaengine_submit(desc);
 
 	/* Issue pending DMA requests */
 	dma_async_issue_pending(stm32port->rx_ch);
-- 
2.25.1

