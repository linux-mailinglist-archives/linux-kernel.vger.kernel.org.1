Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230CB29A6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895083AbgJ0IwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895068AbgJ0IwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:52:08 -0400
Received: from localhost.localdomain (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94ECD22282;
        Tue, 27 Oct 2020 08:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603788727;
        bh=pFcgzOxL9tC0NlBunrULVucAR0yi3s4tm515Q8gGEfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WH1OMv4S5i3cOT96BG9u7c3+bhIIh3OQz7yt5pg5ugEzmwkE795Uc0BcGjshjzJCf
         UQQEtZ8KdostSKbt2xcGvtt6D4kI5kG5OIvNTgQmYfCHCw+OMr5JxzlLUp5wh82W5g
         2gpftqPSyWfECNr3hmeWhK2oNVl/xBEfHZJpB8E4=
From:   balbi@kernel.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 1/2] hwtracing: coresight: add missing MODULE_LICENSE()
Date:   Tue, 27 Oct 2020 10:51:56 +0200
Message-Id: <20201027085157.1964906-2-balbi@kernel.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027085157.1964906-1-balbi@kernel.org>
References: <20201027085157.1964906-1-balbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <balbi@kernel.org>

Fix the following build warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/hwtracing/coresight/coresight.o

Signed-off-by: Felipe Balbi <balbi@kernel.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 6994c1309b2b..7936fca8436c 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1692,3 +1692,4 @@ module_exit(coresight_exit);
 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
 MODULE_DESCRIPTION("Arm CoreSight tracer driver");
+MODULE_LICENSE("GPL");
-- 
2.29.1

