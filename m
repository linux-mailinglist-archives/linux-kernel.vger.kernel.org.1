Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE38D2552F3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 04:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgH1CUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 22:20:03 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57288 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgH1CUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 22:20:02 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kBTzk-00CDlN-DK; Fri, 28 Aug 2020 04:20:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] of: of_match_node: Make stub an inline function to avoid W=1 warnings
Date:   Fri, 28 Aug 2020 04:19:39 +0200
Message-Id: <20200828021939.2912798-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building without CONFIG_OF and W=1, errors are given about unused
arrays of match data, because of_match_node is stubbed as a macro. The
compile does not see it takes parameters when not astub, so it
generates warnings about unused variables. Replace the stub with an
inline function to avoid these false warnings.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/linux/of.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 5cf7ae0465d1..e9838387e7d9 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -991,7 +991,12 @@ static inline int of_map_id(struct device_node *np, u32 id,
 }
 
 #define of_match_ptr(_ptr)	NULL
-#define of_match_node(_matches, _node)	NULL
+
+static inline const struct of_device_id *of_match_node(
+	const struct of_device_id *matches, const struct device_node *node)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF */
 
 /* Default string compare functions, Allow arch asm/prom.h to override */
-- 
2.28.0

