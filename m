Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80252F50B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbhAMRLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:11:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbhAMRLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:11:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D05B2339F;
        Wed, 13 Jan 2021 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610557864;
        bh=8xJJDd/LVtplXoIwuRfT36wIVGuC/ZK1fPhF+6QXzW0=;
        h=From:To:Cc:Subject:Date:From;
        b=CGUOWvg3Brm8rQPUtEPyrDMonhbTPlYZ4huVEAS8VpS+/zHVHfZZ2pyw0Xil1zFgV
         HxPvqD8sx6scXQMVRxKXhAKaanrgsPzMYV+QaRVe4cFXBYHx063zY0JtSL9WyPgyQT
         Omrsq5i+strnCIE++V7xROjpExy36QOf9SEuKkLr4CMNHLB0hooyXNk8ow/yeJnfQf
         e0MHz+Iv06/qcM9OKavKBNGvr2up/6kE1/6YxXpkq5ssMaUgpl+JDAZNLa9FTn7o9H
         9ApMSsBzPCAzBkJK4yzJ6u3EVlORIRKyVvTULN2C/4CE7k+0O2S10v6jIYdkbryq4W
         N1eokmNFG6bsw==
From:   Mark Brown <broonie@kernel.org>
To:     tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] random: Document add_hwgenerator_randomness() with other input functions
Date:   Wed, 13 Jan 2021 17:10:14 +0000
Message-Id: <20210113171014.2830-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section at the top of random.c which documents the input functions
available does not document add_hwgenerator_randomness() which might lead
a reader to overlook it. Add a brief note about it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

This patch is almost a year old at this point...

 drivers/char/random.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5f3b8ac9d97b..3e17e04c3cef 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -228,6 +228,14 @@
  * particular randomness source.  They do this by keeping track of the
  * first and second order deltas of the event timings.
  *
+ * There is also an interface for true hardware RNGs:
+ *
+ *	void add_hwgenerator_randomness(const char *buffer, size_t count,
+ *				size_t entropy);
+ *
+ * This will credit entropy as specified by the caller, if the entropy
+ * pool is full it will block until more entropy is needed.
+ *
  * Ensuring unpredictability at system startup
  * ============================================
  *
-- 
2.20.1

