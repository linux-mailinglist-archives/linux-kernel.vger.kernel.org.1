Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D494620D157
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgF2SlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbgF2Sk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:58 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 045EC23D69;
        Mon, 29 Jun 2020 13:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593438473;
        bh=ExLjXgZWw/0zjrLIbDaeGd7JgcoFGq7lfg4yUAVlg6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bz0r7R1nDnMuHaPhVhn84xesH7NHGDr7OTDK1nygMTqPm+4oSIQCWfSS6aXABp2kB
         rraIaPu9JEvGAjS6ZGHIx/lpDsbMBstg45zxtfonC+8bPV2vzix6rqoplDZQUPlTLS
         eU6DuYRwKG6MeU/1TWk5QBrDZmaVc5IbI09dXOsw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] ALSA: compress: document the compress audio state machine
Date:   Mon, 29 Jun 2020 19:17:35 +0530
Message-Id: <20200629134737.105993-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629134737.105993-1-vkoul@kernel.org>
References: <20200629134737.105993-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we had some discussions of the stream states, so I thought it is a
good idea to document the state transitions, so add it documentation

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../sound/designs/compress-offload.rst        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
index ad4bfbdacc83..ad89af9b31c9 100644
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
+         compr_free()                  +----------+
+  +------------------------------------|          |
+  |                                    |   SETUP  |
+  |          +-------------------------|          |<-------------------------+
+  |          |       compr_write()     +----------+                          |
+  |          |                              ^                                |
+  |          |                              | compr_drain_notify()           |
+  |          |                              |        or                      |
+  |          |                              |     compr_stop()               |
+  |          |                              |                                |
+  |          |                         +----------+                          |
+  |          |                         |          |                          |
+  |          |                         |   DRAIN  |                          |
+  |          |                         |          |                          |
+  |          |                         +----------+                          |
+  |          |                              ^                                |
+  |          |                              |                                |
+  |          |                              | compr_drain()                  |
+  |          |                              |                                |
+  |          v                              |                                |
+  |    +----------+                    +----------+                          |
+  |    |          |    compr_start()   |          |        compr_stop()      |
+  |    | PREPARE  |------------------->|  RUNNING |--------------------------+
+  |    |          |                    |          |                          |
+  |    +----------+                    +----------+                          |
+  |          |                            |    ^                             |
+  |          |compr_free()                |    |                             |
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

