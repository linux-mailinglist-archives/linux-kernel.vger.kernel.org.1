Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66CE28CE26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgJMMQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgJMMO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:56 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F19E02224A;
        Tue, 13 Oct 2020 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591295;
        bh=4Bu6akfKjaahqyWEGXpzqa8kviAzcp1lUCJxl8zFrWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2iGqVC1fOha+iGz8JFU7cdkGEU5OoGqj/YHIfj9cSSwx7NoAlAo3j5BZ3dcmeH9NA
         nV40NJUVyy592zk//xW5Y8s8+5F4tTcqOjj+IyBCezscgfuLxjGXYNLQ5QW84vqliE
         aOv4FYczeFA+p6ri5EUYEUavDvh93i6oKdwB9BKI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSJCe-006Co6-TJ; Tue, 13 Oct 2020 14:14:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>,
        Jeevan B <jeevan.b@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Oleg Vasilev <oleg.vasilev@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/24] drm: kernel-doc: document drm_dp_set_subconnector_property() params
Date:   Tue, 13 Oct 2020 14:14:35 +0200
Message-Id: <1d8b7e4aa3b5a3feedf11407b1b7437d2c680443.1602590106.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602590106.git.mchehab+huawei@kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset e5b92773287c ("drm: report dp downstream port type as a subconnector property")
added a new function to the kAPI, but didn't add any documentation
for the parameters for drm_dp_set_subconnector_property().

Fixes: e5b92773287c ("drm: report dp downstream port type as a subconnector property")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/drm_dp_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 90807a6b415c..b1c71af88579 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1028,7 +1028,8 @@ EXPORT_SYMBOL(drm_dp_downstream_debug);
 
 /**
  * drm_dp_subconnector_type() - get DP branch device type
- *
+ * @dpcd: DisplayPort configuration data
+ * @port_cap: port capabilities
  */
 enum drm_mode_subconnector
 drm_dp_subconnector_type(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
@@ -1079,6 +1080,10 @@ EXPORT_SYMBOL(drm_dp_subconnector_type);
 
 /**
  * drm_mode_set_dp_subconnector_property - set subconnector for DP connector
+ * @connector: connector to set property on
+ * @status: connector status
+ * @dpcd: DisplayPort configuration data
+ * @port_cap: port capabilities
  *
  * Called by a driver on every detect event.
  */
-- 
2.26.2

