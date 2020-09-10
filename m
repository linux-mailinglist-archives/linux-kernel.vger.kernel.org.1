Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBBC2643FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 12:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgIJK06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 06:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730326AbgIJKYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:14 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A36D21D81;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=jHUZV+cWgEQl2mMFgX4G1V6AIILSty3RFc5SKiifj4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiHYqo0JV/FEXoK8b12o4CiGCE0f+6FizPXP9zirhyGpH5sieh90V9BpS2ixv0cKH
         zeo47WxNHAyavtknV/f8ieOlAbzmKymNk08qNB6MtOIKyRA2HlrwsBJ1H75vLY+wD2
         4BLcPID8GQ1BGn4HJB6TXpJyJnjWzMn9ognhq0yk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EIO9-NP; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] drm: kernel-doc: document drm_dp_set_subconnector_property() params
Date:   Thu, 10 Sep 2020 12:24:05 +0200
Message-Id: <3e0a0530be29111426da2b41e06fed4fb90612ab.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
index ad7c03dac467..e0ca8f19164b 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -599,7 +599,8 @@ EXPORT_SYMBOL(drm_dp_downstream_debug);
 
 /**
  * drm_dp_subconnector_type() - get DP branch device type
- *
+ * @dpcd: DisplayPort configuration data
+ * @port_cap: port capabilities
  */
 enum drm_mode_subconnector
 drm_dp_subconnector_type(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
@@ -650,6 +651,10 @@ EXPORT_SYMBOL(drm_dp_subconnector_type);
 
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

