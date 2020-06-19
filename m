Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2038D20016E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 06:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgFSEzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 00:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgFSEzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:55:06 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9B720DD4;
        Fri, 19 Jun 2020 04:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592542505;
        bh=aaWRkkykSSnCYuAvPKup4agERzD5kDIAX5iNHAHydtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zulubkkTMOWfLNC6gumYk9dHzgNwNj6/lG03GT93JzxbEux14idZVIMS7Ylwenm/1
         SpQstxJtCf5JGNud6GNwSoDf2PS3KtF5Jv2F6pn3haKeZXOApSQA/lWiGq8w7IeP6h
         flduAyEktEGBW1lCH6EzhlTht/hz6Kue0O9ABzA0=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ALSA: compress: document the compress audio state machine
Date:   Fri, 19 Jun 2020 10:24:46 +0530
Message-Id: <20200619045449.3966868-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619045449.3966868-1-vkoul@kernel.org>
References: <20200619045449.3966868-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we had some discussions of the stream states, so I thought it is a
good idea to document the state transitions, so add it documentation

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../sound/designs/compress-offload.rst        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
index ad4bfbdacc83..7292717c43bf 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -151,6 +151,58 @@ Modifications include:
 - Addition of encoding options when required (derived from OpenMAX IL)
 - Addition of rateControlSupported (missing in OpenMAX AL)
 
+State Machine
+=============
+
+The compressed audio stream state machine is described below ::
+
+                                        +----------+
+                                        |          |
+                                        |   OPEN   |
+                                        |          |
+                                        +----------+
+                                             |
+                                             |
+                                             | compr_set_params()
+                                             |
+                                             V
+                                        +----------+
+                compr_drain_notify()    |          |
+              +------------------------>|   SETUP  |
+              |                         |          |
+              |                         +----------+
+              |                              |
+              |                              |
+              |                              | compr_write()
+              |                              |
+              |                              V
+              |                         +----------+
+              |                         |          |
+              |                         |  PREPARE |
+              |                         |          |
+              |                         +----------+
+              |                              |
+              |                              |
+              |                              | compr_start()
+              |                              |
+              |                              V
+        +----------+                    +----------+     compr_pause()      +----------+
+        |          |                    |          |----------------------->|          |
+        |  DRAIN   |<-------------------|  RUNNING |                        |  PAUSE   |
+        |          |                    |          |<-----------------------|          |
+        +----------+                    +----------+     compr_resume()     +----------+
+              |                              |
+              |                              |
+              |                              | compr_free()
+              |                              |
+              |                              V
+              |                         +----------+
+              |     compr_free()        |          |
+              +------------------------>|          |
+                                        |   STOP   |
+                                        |          |
+                                        +----------+
+
 
 Gapless Playback
 ================
-- 
2.26.2

