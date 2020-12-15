Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5492DA4F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725274AbgLOAc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgLOAcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:32:16 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6465AC06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 16:31:36 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so13362791pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 16:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f7OsK3yyie83mFsyxOZLO7U5mEgOhtDjdGrqc4pskdY=;
        b=JnvNAr6HasYZClYsYYu9MLeQeCjXeoPbPpVc46mqEhnAHt3uYnri6YD1gJbaIRgMdh
         gz8XbvbAkQyyapKi24Hp1xZZaMI0FvmEbKBWXi7O/6gO2SNVQ4YIsF67pC83F0Rc4DQq
         lZUEXHhXNi5FxihFuTrxm+EiltW5RkVv651xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f7OsK3yyie83mFsyxOZLO7U5mEgOhtDjdGrqc4pskdY=;
        b=NvxZ6Y0rEMo8aorVlvUmpzMFp9b9bKqb4AvdM8iPMnjC2rEaHRxI9T2y+dx4pdrTmn
         BnMkWwmjleL4GVXZkaRtByqoca16lRr+gA5UY1w9ZvQ//KflOHDtxOE7At+9weQCqfVk
         2Yy0Rj804A+cl1eGzU9P34Wc06tFJHErzvsoJ+Z5uS0916o0RxtaHvlXUXaT36bP5jUG
         nvArVvFTMQ9E7trKOf71KCHdQJLL13rA72VKKsOuYqaPnXqPkQOUjYQVglKKveSq6sQ/
         L+adiuUNNTtjjspBK0NYK14ElWdRKxV4HWF8VGw/lzW3o7t0qnsGuuwu24IYOoTxonbX
         +E+Q==
X-Gm-Message-State: AOAM531kHS15B1Eo0XPA1mCyAtDDpL6wAejJHd0znSKXwaLCLyKF/D1u
        zJg1INNlyXcxCO0drugOYN2w4Q==
X-Google-Smtp-Source: ABdhPJxMxgfSijCu0l6b2bbht2ujt9jAUUdhAg1vdv1oL4+PPMHAhJCCJICFQvVUud5ShcBzteE3xg==
X-Received: by 2002:a62:8895:0:b029:19e:92ec:6886 with SMTP id l143-20020a6288950000b029019e92ec6886mr15472290pfd.12.1607992295840;
        Mon, 14 Dec 2020 16:31:35 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id 77sm20412834pfx.156.2020.12.14.16.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 16:31:35 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     msavaliy@qti.qualcomm.com, akashast@codeaurora.org,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/2] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case
Date:   Mon, 14 Dec 2020 16:30:18 -0800
Message-Id: <20201214162937.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7ba9bdcb91f6 ("spi: spi-geni-qcom: Don't keep a local state
variable") we changed handle_fifo_timeout() so that we set
"mas->cur_xfer" to NULL to make absolutely sure that we don't mess
with the buffers from the previous transfer in the timeout case.

Unfortunately, this caused the IRQ handler to dereference NULL in some
cases.  One case:

 CPU0                           CPU1
 ----                           ----
                                setup_fifo_xfer()
                                 ...
                                 geni_se_setup_m_cmd()
                                 <hardware starts transfer>
 <unrelated interrupt storm>     spin_unlock_irq()
 <continued interrupt storm>    <time passes>
 <continued interrupt storm>    <transfer complets in hardware>
 <continued interrupt storm>    <hardware sets M_RX_FIFO_WATERMARK_EN>
 <continued interrupt storm>    <time passes>
 <continued interrupt storm>    handle_fifo_timeout()
 <continued interrupt storm>     spin_lock_irq()
 <continued interrupt storm>     mas->cur_xfer = NULL
 <continued interrupt storm>     geni_se_cancel_m_cmd()
 <continued interrupt storm>     spin_unlock_irq()
 <continued interrupt storm>     wait_for_completion_timeout() => timeout
 <continued interrupt storm>     spin_lock_irq()
 <continued interrupt storm>     geni_se_abort_m_cmd()
 <continued interrupt storm>     spin_unlock_irq()
 <continued interrupt storm>     wait_for_completion_timeout() => timeout
 <interrupt storm ends>
 geni_spi_isr()
  spin_lock()
  if (m_irq & M_RX_FIFO_WATERMARK_EN)
   geni_spi_handle_rx()
    mas->cur_xfer NULL derefrence

Specifically it should be noted that the RX/TX interrupts are still
shown asserted even when a CANCEL/ABORT interrupt has asserted.

Let's check for the NULL transfer in the TX and RX cases.

NOTE: things still could get confused if we get timeouts all the way
through handle_fifo_timeout(), meaning that interrupts are still
pending.  A future patch will help these corner cases.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 25810a7eef10..6f736e94e9f4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -354,6 +354,12 @@ static bool geni_spi_handle_tx(struct spi_geni_master *mas)
 	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
 	unsigned int i = 0;
 
+	/* Stop the watermark IRQ if nothing to send */
+	if (mas->cur_xfer == NULL) {
+		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+		return false;
+	}
+
 	max_bytes = (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_word;
 	if (mas->tx_rem_bytes < max_bytes)
 		max_bytes = mas->tx_rem_bytes;
@@ -396,6 +402,17 @@ static void geni_spi_handle_rx(struct spi_geni_master *mas)
 		if (rx_last_byte_valid && rx_last_byte_valid < 4)
 			rx_bytes -= bytes_per_fifo_word - rx_last_byte_valid;
 	}
+
+	/* Clear out the FIFO and bail if nowhere to put it */
+	if (mas->cur_xfer == NULL) {
+		unsigned int words = DIV_ROUND_UP(rx_bytes, bytes_per_fifo_word);
+
+		for (i = 0; i < words; i++)
+			readl(se->base + SE_GENI_RX_FIFOn);
+
+		return;
+	}
+
 	if (mas->rx_rem_bytes < rx_bytes)
 		rx_bytes = mas->rx_rem_bytes;
 
-- 
2.29.2.684.gfbc64c5ab5-goog

