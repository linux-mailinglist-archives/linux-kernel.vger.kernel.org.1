Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5867D2B989D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgKSQud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgKSQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:50:32 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B98C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:50:32 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a16so8890536ejj.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnYOafAhGIR02+MUCgtMxCZXgMyaOid7ab2rHWcYBHg=;
        b=DSYvqMMlbwsKkjFozlJiml8agxccgAQ4votPqfWGHXRQpOyFVLTKvBj5LXvaKc1FPC
         vZk0CXc3u0SSlFozE9VMymXiQZNMypShrFb+ofUVgoISjz7xDZkT8qL2ryKh3wCl1125
         h5IIhRiEF/qMcY2WG2P9e1xg8uUX5SRthyq9mQLPUvPHRJrP3irf+E18MzGMuHK7ebpl
         XfRrqyPe8qgLyUN1Y52JmuNttO8CfCYKxb4n0lFWfUUMd5AJ9Y2FiGg1SZjYrApUl+BD
         tRQI2eX1ifyKdpqN+KVi2pQK7UECqEVPoiEHl5ev3cPCqhya4+qKG3z7Mhgtjd/WNy8n
         xCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnYOafAhGIR02+MUCgtMxCZXgMyaOid7ab2rHWcYBHg=;
        b=LVmrhbZvIpnQsmXZgmdf8RF2TExz573EmAgph0c5Sy6LIX5cv1DZO+junvmxzYKck1
         OvUfGc0GbKVG1zi+ohhtP1WE6a1eR4O7NlnHYfWjDX3RiD4O/e1WFMiEjuPE5Bka8ldQ
         4kn3ozQUzvH7S1nmnXpKREptQYvCJc+HRwAoPyKfThNYWcNvb3qxiamEzR4BGztDP6BT
         P91WN3h/0NjiGrcrkdo+q7yHFJPAYgRXi9xmX8ZaudF5ETjY4jPnKnCVzF2HyJxWGbRV
         myoGeI7DfUd5tmfIVemoQgOv17S+t3Yt06QyuzuxR3+DTKHVuX36rJz82JSEFPeUhdGw
         dbow==
X-Gm-Message-State: AOAM532pCR0zsIeJrL/NS3L5qZElAQTHgk1qkRAULSScdxrHmRnonPZO
        8c4I86oQgitpR+WAswUWg1c=
X-Google-Smtp-Source: ABdhPJwGsFyv5ZTeF8O6UdQpJ9IjacTJD4OTJ50oO+t1BWYx+gqlRHPHrkum4oGtBvqp6KByzsULog==
X-Received: by 2002:a17:906:3641:: with SMTP id r1mr28022638ejb.405.1605804631067;
        Thu, 19 Nov 2020 08:50:31 -0800 (PST)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id s15sm2176edj.75.2020.11.19.08.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 08:50:30 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/3] staging: dpaa2-switch: make sure that the VLAN is not already configured
Date:   Thu, 19 Nov 2020 18:50:16 +0200
Message-Id: <20201119165017.806696-3-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119165017.806696-1-ciorneiioana@gmail.com>
References: <20201119165017.806696-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

When in the PREPARE state of a switchdev transaction, check if the
requested VLAN is not already configured on the switch port. This keeps
us from getting into a WARNING as below.

[ 1389.683296] dpaa2_ethsw dpsw.0 eth0: VLAN 2 already configured
[ 1389.689125] ------------[ cut here ]------------
[ 1389.694084] eth0: Commit of object (id=1) failed.
[ 1389.698863] WARNING: CPU: 0 PID: 613 at net/switchdev/switchdev.c:277 switchdev_port_obj_add_now+0xcc/0x110
[ 1389.708589] Modules linked in:
[ 1389.711634] CPU: 0 PID: 613 Comm: bridge Not tainted 5.9.0-rc2-next-20200828-00112-g7172078477c5 #59
[ 1389.720753] Hardware name: NXP Layerscape LX2160ARDB (DT)
[ 1389.726139] pstate: 40000005 (nZcv daif -PAN -UAO BTYPE=--)
[ 1389.731698] pc : switchdev_port_obj_add_now+0xcc/0x110
[ 1389.736824] lr : switchdev_port_obj_add_now+0xcc/0x110

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 20c6326e5dee..d524e92051a3 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -984,10 +984,17 @@ static int dpaa2_switch_port_vlans_add(struct net_device *netdev,
 	int vid, err = 0, new_vlans = 0;
 
 	if (switchdev_trans_ph_prepare(trans)) {
-		for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++)
+		for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
 			if (!port_priv->ethsw_data->vlans[vid])
 				new_vlans++;
 
+			/* Make sure that the VLAN is not already configured
+			 * on the switch port
+			 */
+			if (port_priv->vlans[vid] & ETHSW_VLAN_MEMBER)
+				return -EEXIST;
+		}
+
 		/* Check if there is space for a new VLAN */
 		err = dpsw_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
 					  &ethsw->sw_attr);
-- 
2.28.0

