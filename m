Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6820224E78
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 02:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGSAdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 20:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSAdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:33:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB2AC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4xgT1e/c0uMcREKxhGXpwMFM0lJQ7iVJdWBf7wUK0V8=; b=NqkxN9fJa9piz3C0cgOg4s7Crz
        zV91vMRc5OlrJWiZg0THAn2hzB6UNdSdGk/hx7YfQ9RKvbswIbAMt1ysur8CacdDU6v374hnGFs/v
        Dc+uARTwgFWA1sOJXOjdZG6zc3+urHApufEJtvg4SVrC1c6rjjqOSTVWQI2L+InKkgnr/eyNAqARj
        mfygoOIsJNB0FyuQF0mv0he2uByZHHy++VtzW32p0XiUClzfQNsL38ctv6D7MIZ/6imiRnHuZTZou
        dX3tnTcKMRqU9rEjHtDIwFEhUU+sqUqH+9tSbuFDE4+SMPobcI4PQhrhgPeyHkt+6t1ahRuQ1XXIU
        HDAIe75A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxGR-0003A7-6q; Sun, 19 Jul 2020 00:33:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: soc-dai.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:33:07 -0700
Message-Id: <20200719003307.21403-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "be" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 include/sound/soc-dai.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/sound/soc-dai.h
+++ linux-next-20200717/include/sound/soc-dai.h
@@ -39,7 +39,7 @@ struct snd_compr_stream;
 /*
  * DAI Clock gating.
  *
- * DAI bit clocks can be be gated (disabled) when the DAI is not
+ * DAI bit clocks can be gated (disabled) when the DAI is not
  * sending or receiving PCM data in a frame. This can be used to save power.
  */
 #define SND_SOC_DAIFMT_CONT		(1 << 4) /* continuous clock */
