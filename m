Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AA522534B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 20:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGSSJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 14:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGSSJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:09:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5A8C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iPaO1K0bu25pKqHZF+1ghwNegEI493yaKvwjy1Nvz34=; b=Ohp3Gz9OWNM5lu4juCjHWk7mQV
        wohMQnY5qMf9gLilT3+O1ya1aJ0LN6N+vQaiFLSlmdFWbs6aEtbwgvrOTq4fL+cAS3WR3Rnt//T26
        ybnQIontyas3pSlQrPpm2qg9PlMcFnLGnblCXQZdC42THweTmoMs0areLFnqF8Dhsb00CHnPMPCvn
        aXpEUpioD9Zwxq/C8IBMqK5PSihOgIAq8CnXlijcDNZUU53HPeVoygkk34FLRfBq6fycAl8S9W2ux
        8rceBVKvmv74KV9WGKk+fHlO8UNeEw704iF7cl7fpO+Wy5Va8TpvCLToIKDnwxtDbt57queUfoSLz
        x3ihyPzA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxDkF-0006Dj-QY; Sun, 19 Jul 2020 18:09:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: wcd9335.h: fix duplicated word
Date:   Sun, 19 Jul 2020 11:09:01 -0700
Message-Id: <20200719180901.30720-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the doubled word "in" in a comment by adding punctuation
in 3 places and capitalization.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/wcd9335.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200717.orig/sound/soc/codecs/wcd9335.h
+++ linux-next-20200717/sound/soc/codecs/wcd9335.h
@@ -4,9 +4,9 @@
 #define __WCD9335_H__
 
 /*
- * WCD9335 register base can change according to the mode it works in
- * in slimbus mode the reg base starts from 0x800
- * in i2s/i2c mode the reg base is 0x0
+ * WCD9335 register base can change according to the mode it works in.
+ * In slimbus mode the reg base starts from 0x800.
+ * In i2s/i2c mode the reg base is 0x0.
  */
 #define WCD9335_REG(pg, r)	((pg << 8) | (r))
 #define WCD9335_REG_OFFSET(r)	(r & 0xFF)
