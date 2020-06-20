Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0B920213D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 06:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgFTEQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 00:16:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:21181 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFTEQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 00:16:41 -0400
IronPort-SDR: Q5aO9nSTl/Hh59mmSGf4JsF2H0wyuqsBPUE3c2tlogcsG58R5ZyKzzQG3cXVmLcdAPx2Yy5NZV
 SJN16Tcoh+4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="208428254"
X-IronPort-AV: E=Sophos;i="5.75,257,1589266800"; 
   d="scan'208";a="208428254"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 21:16:41 -0700
IronPort-SDR: +ZbB+HOkXUxi20T35I/EWUD9LHbV50lt/Q96BNYfBQOrw34EDqIsHSTxJV0w59HsNc2iI8mOwn
 /qVWy6UDE64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,257,1589266800"; 
   d="scan'208";a="352917595"
Received: from lkp-server02.sh.intel.com (HELO 3aa54c81372e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2020 21:16:38 -0700
Received: from kbuild by 3aa54c81372e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jmUvm-00010v-6o; Sat, 20 Jun 2020 04:16:38 +0000
Date:   Sat, 20 Jun 2020 12:16:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vinay Simha BN <simhavcs@gmail.com>
Cc:     kbuild-all@lists.01.org, Vinay Simha BN <simhavcs@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: [RFC PATCH] display/drm/bridge: tc358775_parse_dt() can be static
Message-ID: <20200620041627.GA26592@14d5058516e7>
References: <20200618121902.16841-2-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618121902.16841-2-simhavcs@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 tc358775.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 87af3271b63521..88a45e86eae334 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -502,7 +502,7 @@ static int tc_mode_valid(struct drm_bridge *bridge,
 	return MODE_OK;
 }
 
-int tc358775_parse_dt(struct device_node *np, struct tc_data *tc)
+static int tc358775_parse_dt(struct device_node *np, struct tc_data *tc)
 {
 	struct device_node *endpoint;
 	struct device_node *parent;
