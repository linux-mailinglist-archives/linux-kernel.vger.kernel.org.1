Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467471E6E82
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 00:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436948AbgE1WTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 18:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436902AbgE1WTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:19:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B3DC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:19:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z64so148601pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xRqzS5lxFaKDdGCCXOJrFWYOqXqiEcAWVVaJIo0Jl50=;
        b=UilgVzE9ZezWKY0kXWB2q+H7dCWUW03PUc17aswnj1HPCVlY2v3gx57GpJ+CeIuzi1
         Z5d0Nl/fxgKP8F61EAbwoCr7VHMTvII4Rf32C6jrjyn0DKBL3bvvjjfp9/YKjOZLLcX7
         IlnTTNK8ckDhC7+WElyX/zLCPKUlxW4dOEjFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xRqzS5lxFaKDdGCCXOJrFWYOqXqiEcAWVVaJIo0Jl50=;
        b=frSzQ+uemrgaFsB7kTM2QZojVLfV7DYXo8lOV/xmCbKcengSABEmPHCcvEuJzcvtFq
         U9ri9rfjXoR337RaUa1FLBpYIKCteRSOHOQP5ml41Yd91QYlR9t6DjDve787I7IobkLl
         5HUTTxIrRz0PLtvnqUYGEvkIh+LeartXpKJYBYdY5w12/nfVXU5u9uGgeQH1ssPUD6VT
         sAQ4PiwapAvXB9P4nblvoCipYinhU4dHcbAoWqdKeqvbRnIrFj1g5MJKJwoqqpUGz5Ho
         Hl2KupXXuq8JZ8a3nsLMhGlWDEpio+7+aSYeI97Xv3W5oLrAy9ELNg54fEYzcud1XG77
         FYgw==
X-Gm-Message-State: AOAM531vM1tdE7i6qbzkNffjbaNEi8gIUbQ0GtGIousTtt93fzMmdHgb
        Ae66GW9q4vT7rHX4n6KfkLMSwA==
X-Google-Smtp-Source: ABdhPJw0aZ7PN9WkqkwNrHB2k+9F8JoZ/MIUXuARtR77z0m1Bs0DwKFDd7/AJ5T5zmuaAa4kDPVNrg==
X-Received: by 2002:a63:d148:: with SMTP id c8mr5093834pgj.51.1590704382905;
        Thu, 28 May 2020 15:19:42 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b23sm5143337pgs.33.2020.05.28.15.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:19:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm_tis_spi: Don't send anything during flow control
Date:   Thu, 28 May 2020 15:19:30 -0700
Message-Id: <20200528151912.1.Id689a39ce8d1ec6f29f4287277ad977ff4f57d7d@changeid>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During flow control we are just reading from the TPM, yet our spi_xfer
has the tx_buf and rx_buf both non-NULL which means we're requesting a
full duplex transfer.

SPI is always somewhat of a full duplex protocol anyway and in theory
the other side shouldn't really be looking at what we're sending it
during flow control, but it's still a bit ugly to be sending some
"random" data when we shouldn't.

The default tpm_tis_spi_flow_control() tries to address this by
setting 'phy->iobuf[0] = 0'.  This partially avoids the problem of
sending "random" data, but since our tx_buf and rx_buf both point to
the same place I believe there is the potential of us sending the
TPM's previous byte back to it if we hit the retry loop.

Another flow control implementation, cr50_spi_flow_control(), doesn't
address this at all.

Let's clean this up and just make the tx_buf NULL before we call
flow_control().  Not only does this ensure that we're not sending any
"random" bytes but it also possibly could make the SPI controller
behave in a slightly more optimal way.

NOTE: no actual observed problems are fixed by this patch--it's was
just made based on code inspection.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/char/tpm/tpm_tis_spi_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index d96755935529..8d2c581a93c6 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -53,8 +53,6 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 
 	if ((phy->iobuf[3] & 0x01) == 0) {
 		// handle SPI wait states
-		phy->iobuf[0] = 0;
-
 		for (i = 0; i < TPM_RETRY; i++) {
 			spi_xfer->len = 1;
 			spi_message_init(&m);
@@ -104,6 +102,8 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 		if (ret < 0)
 			goto exit;
 
+		/* Flow control transfers are receive only */
+		spi_xfer.tx_buf = NULL;
 		ret = phy->flow_control(phy, &spi_xfer);
 		if (ret < 0)
 			goto exit;
@@ -113,9 +113,8 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 		spi_xfer.delay.value = 5;
 		spi_xfer.delay.unit = SPI_DELAY_UNIT_USECS;
 
-		if (in) {
-			spi_xfer.tx_buf = NULL;
-		} else if (out) {
+		if (out) {
+			spi_xfer.tx_buf = phy->iobuf;
 			spi_xfer.rx_buf = NULL;
 			memcpy(phy->iobuf, out, transfer_len);
 			out += transfer_len;
-- 
2.27.0.rc0.183.gde8f92d652-goog

