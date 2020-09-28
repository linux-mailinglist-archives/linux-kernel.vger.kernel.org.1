Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEDA27A961
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgI1IRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:17:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:49004 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgI1IRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:17:33 -0400
IronPort-SDR: mTT2JbMv+XdqZBm8kh5hsjRammkfrGbnbD43BYhMDQI0LCuXEI3i2qklW7ewgxXlSgbwmcBCBw
 qYfuvoRI4Lwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="149731270"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="149731270"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 01:17:32 -0700
IronPort-SDR: kYVQuW7GLVYq8nQNU0100Q5LUSITzTOIv2n1EBlMuB0tCSFs9CJsSedOtPseZB7nTnMeSmfqbo
 WBfRdvrTHKrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="414908891"
Received: from tejas-system-product-name.iind.intel.com ([10.145.162.130])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2020 01:17:28 -0700
From:   Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
To:     rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, james.ausmus@intel.com,
        matthew.d.roper@intel.com, jose.souza@intel.com,
        ville.syrjala@linux.intel.com, lucas.demarchi@intel.com,
        hariom.pandey@intel.com
Subject: [PATCH 0/2] drm/i915/jsl: Update JasperLake Voltage swing table
Date:   Mon, 28 Sep 2020 13:39:29 +0530
Message-Id: <20200928080931.246347-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series covers following things:

1. Split and differentiate between EhlkhartLake and
   JasperLake platfrom
2. Update voltage swing table for eDP on JasperLake platform
BSpec: 21257

Tejas Upadhyay (2):
  drm/i915/jsl: Split EHL/JSL platform info and PCI ids
  drm/i915/edp/jsl: Update vswing table for HBR and HBR2

 drivers/gpu/drm/i915/display/intel_ddi.c | 67 ++++++++++++++++++++++--
 drivers/gpu/drm/i915/i915_drv.h          |  4 +-
 drivers/gpu/drm/i915/i915_pci.c          |  9 ++++
 drivers/gpu/drm/i915/intel_device_info.c |  1 +
 drivers/gpu/drm/i915/intel_device_info.h |  1 +
 include/drm/i915_pciids.h                |  9 ++--
 6 files changed, 84 insertions(+), 7 deletions(-)

-- 
2.25.1

