Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FCE233B98
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 00:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgG3Wzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 18:55:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:45564 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730054AbgG3Wzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:55:42 -0400
IronPort-SDR: kawTkFQP55VEULzcGrGYrAP1LvoSpHBmY9J3Jy9FGQsGyzuuaCItL3ut4xAUdrm5s1Ml41P1Hx
 Z2Bra0+VP9AQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="150902158"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="150902158"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 15:55:41 -0700
IronPort-SDR: 9Sz416oK0urEKke1GBsMDwoA2rmKwkYr09Od2H6/HF51d8D+uzTtjBucDvK1JOWd2F4UKuKBpJ
 Kkvf3cKXKrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="273056530"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2020 15:55:41 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, pmalani@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, azhar.shaikh@intel.com,
        utkarsh.h.patel@intel.com, casey.g.bowman@intel.com,
        rajmohan.mani@intel.com
Subject: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum values to usb_role_switch_set_role()
Date:   Thu, 30 Jul 2020 15:56:08 -0700
Message-Id: <20200730225609.7395-2-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200730225609.7395-1-azhar.shaikh@intel.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_role_switch_set_role() has the second argument as enum for usb_role.
Currently depending upon the data role i.e. UFP(0) or DFP(1) is sent.
This eventually translates to USB_ROLE_NONE in case of UFP and
USB_ROLE_DEVICE in case of DFP. Correct this by sending correct enum
values as USB_ROLE_DEVICE in case of UFP and USB_ROLE_HOST in case of
DFP.

Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")

Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
Cc: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 3eae01f4c9f7..eb4713b7ae14 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -590,7 +590,8 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
 
 	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
-					!!(resp.role & PD_CTRL_RESP_ROLE_DATA));
+				       resp.role & PD_CTRL_RESP_ROLE_DATA
+				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
 }
 
 static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
-- 
2.17.1

