Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C296320A25A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 17:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404416AbgFYPrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 11:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389551AbgFYPrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:47:08 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D198A2081A;
        Thu, 25 Jun 2020 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593100028;
        bh=L9ED3CmPmrCq6aX9512m6F+JVxfMbMf1Yg5lgmCu1Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBvmjOSiGpHUKSnl9WcOnpYbcnN0Jt2U3/xWMuaG9IbOSiOusHErTQPD0+0SCy10f
         gMO56qo/BsGaIQ0P3597NMz4p9qC+KPD0RAMXEiGWhLcGn+3ZzGDpDXkpNJa0IcGBy
         YuQ+23VJM6VXNy+cY6WR118g8yiYygJcCu6k7ygU=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ALSA: compress: document the compress audio state machine
Date:   Thu, 25 Jun 2020 21:16:49 +0530
Message-Id: <20200625154651.99758-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625154651.99758-1-vkoul@kernel.org>
References: <20200625154651.99758-1-vkoul@kernel.org>
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
 .../sound/designs/compress-offload.rst        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
index ad4bfbdacc83..b6e9025ae105 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -151,6 +151,57 @@ Modifications include:
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
+                                             v
+         compr_free()                   +----------+
+  +------------------------------------|          |
+  |                                    |   SETUP  |
+  |          +------------------------>|          |<-------------------------+
+  |          | compr_drain_notify()    +----------+                          |
+  |          |         or                   |                                |
+  |          |      compr_stop()            |                                |
+  |          |                              | compr_write()                  |
+  |          |                              |                                |
+  |          |                              v                                |
+  |          |                         +----------+                          |
+  |          |                         |          |   compr_free()           |
+  |          |                         |  PREPARE |---------------> A        |
+  |          |                         |          |                          |
+  |          |                         +----------+                          |
+  |          |                              |                                |
+  |          |                              |                                |
+  |          |                              | compr_start()                  |
+  |          |                              |                                |
+  |          |                              v                                |
+  |    +----------+                    +----------+                          |
+  |    |          |    compr_drain()   |          |        compr_stop()      |
+  |    |  DRAIN   |<-------------------|  RUNNING |--------------------------+
+  |    |          |                    |          |                          |
+  |    +----------+                    +----------+                          |
+  |                                       |    ^                             |
+  |          A                            |    |                             |
+  |          |              compr_pause() |    | compr_resume()              |
+  |          |                            |    |                             |
+  |          v                            v    |                             |
+  |    +----------+                   +----------+                           |
+  |    |          |                   |          |         compr_stop()      |
+  +--->|   FREE   |                   |  PAUSE   |---------------------------+
+       |          |                   |          |
+       +----------+                   +----------+
+
 
 Gapless Playback
 ================
-- 
2.26.2

