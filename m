Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06620A25B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406058AbgFYPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 11:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405858AbgFYPrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:47:11 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14C1720706;
        Thu, 25 Jun 2020 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593100031;
        bh=hx7r4O1r7ywjtPb9iFcLRAnuQzWlpCbea5qfWNcioug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZm/TjUbqbsyhFwi+vO160VREwyB/Ptj+AzI/dHKIQyBzKF8PDtkXXUgI6FdSpUTP
         3hO4cs/IFrU5uZsTp/vKf/BiqWFMw7XmmC89ONWDzic9aPDHvhh2hKoFgKuSzSSeoQ
         3m/VOfmebBHThJe1IdGZmNBbdV+jdU+w9WW6FESk=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] ALSA: compress: document the compress gapless audio state machine
Date:   Thu, 25 Jun 2020 21:16:50 +0530
Message-Id: <20200625154651.99758-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625154651.99758-1-vkoul@kernel.org>
References: <20200625154651.99758-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also documented the galpess transitions. Please note that these are not
really stream states, but show how the stream steps in gapless mode

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../sound/designs/compress-offload.rst        | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
index b6e9025ae105..82950dbbc4a9 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -250,6 +250,38 @@ Sequence flow for gapless would be:
 
 (note: order for partial_drain and write for next track can be reversed as well)
 
+Gapless Playback SM
+===================
+
+For Gapless, we move from running state to partial drain and back, along
+with setting of meta_data and signalling for next track ::
+
+
+                                        +----------+
+                compr_drain_notify()    |          |
+              +------------------------>|  RUNNING |
+              |                         |          |
+              |                         +----------+
+              |                              |
+              |                              |
+              |                              | compr_next_track()
+              |                              |
+              |                              v
+              |                         +----------+
+              |                         |          |
+              |                         |NEXT_TRACK|
+              |                         |          |
+              |                         +----------+
+              |                              |
+              |                              |
+              |                              | compr_partial_drain()
+              |                              |
+              |                              v
+              |                         +----------+
+              |                         |          |
+              +------------------------ | PARTIAL_ |
+                                        |  DRAIN   |
+                                        +----------+
 
 Not supported
 =============
-- 
2.26.2

