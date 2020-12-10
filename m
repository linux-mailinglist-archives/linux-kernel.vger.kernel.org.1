Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD502D539D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 07:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbgLJGLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:11:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:21004 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733077AbgLJGLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:11:07 -0500
IronPort-SDR: +25tsBtoYghjX0reePrVzc2p3v5KWGwST92mGB7g3Q/OtDAvReCuvQKXkXeATS8gVWbRIwenqx
 zxhPzJ29fPRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="258920606"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="258920606"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 22:10:26 -0800
IronPort-SDR: OxDrBdRQ6XvRuBqeoVa6LxDUWT8qYCiCnA7SYV2c96vJ4i+dD5rrxrueZiXT5sJ4R/uqmD8Rmu
 d/PZMEIda+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="368644861"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.15])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2020 22:10:26 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        pmalani@chromium.org, bleung@chromium.org
Cc:     heikki.krogerus@linux.intel.com, rajmohan.mani@intel.com,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 0/2] Send acknowledgment to ec from cors_ec_typec
Date:   Wed,  9 Dec 2020 22:09:01 -0800
Message-Id: <20201210060903.2205-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds mechanism of sending mux configuration acknowledgment from kernel
to EC. It also modifies cros_typec_cmds_supported() to support multiple
feature flags.

Utkarsh Patel (2):
  platform/chrome: cros_ec_typec: Parameterize
    cros_typec_cmds_supported()
  platform/chrome: cros_ec_typec: Send mux configuration acknowledgment
    to EC

 drivers/platform/chrome/cros_ec_typec.c       | 28 +++++++++++++++----
 .../linux/platform_data/cros_ec_commands.h    | 17 +++++++++++
 2 files changed, 40 insertions(+), 5 deletions(-)

-- 
2.25.1

