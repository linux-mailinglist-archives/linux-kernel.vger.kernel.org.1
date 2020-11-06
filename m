Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83512A980F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 16:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgKFPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 10:09:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgKFPJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:09:37 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590DF22227;
        Fri,  6 Nov 2020 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604675376;
        bh=s/FYo72I6lt9+QYesQbFcIAoPzgpDRs/37yRXdQqM5k=;
        h=From:To:Cc:Subject:Date:From;
        b=niY8WqBV/LQP5/Zv6YXKlYmfDYoKB+adBBoqmX19s/VeJv9+OlmHmVH7t43qQIkq0
         cZ47uoBSseKF7a6ZT9EF/MbPgsOYZ15XgLFVz1zcxlxrtwuJ9uXjcjIqnMYkMYJ3yh
         zIEr1PwU2DX7lEktrKS9ejhSXnyyvXq0O8CjSY3c=
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Mentz <danielmentz@google.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH RFC] driver core: Ensure DT devices always have fwnode set
Date:   Fri,  6 Nov 2020 15:07:47 +0000
Message-Id: <20201106150747.31273-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the fwnode API and things that rely on it like fw_devlink will
not reliably work for devices created from DT since each subsystem that
creates devices must individually set dev->fwnode in addition to setting
dev->of_node, currently a number of subsystems don't do so. Ensure that
this can't get missed by setting fwnode from of_node if it's not
previously been set by the subsystem.

Reported-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---

*Very* minimally tested.

 drivers/base/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d661ada1518f..658626bafd76 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2864,6 +2864,10 @@ int device_add(struct device *dev)
 	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
 		set_dev_node(dev, dev_to_node(parent));
 
+	/* ensure that fwnode is set up */
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node && !dev->fwnode)
+		dev->fwnode = of_fwnode_handle(dev->of_node);
+
 	/* first, register with generic layer. */
 	/* we require the name to be set before, and pass NULL */
 	error = kobject_add(&dev->kobj, dev->kobj.parent, NULL);
-- 
2.20.1

