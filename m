Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE7233B97
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 00:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgG3Wzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 18:55:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:45564 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbgG3Wzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:55:41 -0400
IronPort-SDR: OWlRghwkj69rTaEZarkHW4SNqj7SS6Ub+k4Pez2tvGzeVNXz8z4OABZsEfyaodpWOKkMmC5ovu
 zdoLDWM5q5iA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="150902156"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="150902156"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 15:55:41 -0700
IronPort-SDR: XcaNj1JGgmXo0JoQh3/K5HoF5uCjzGFdsq+Ek/2QzHbzXzoN1prL44TwYK7wEAwNQrsPOHbrDy
 YRyi8TRVj9sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="273056527"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2020 15:55:41 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, pmalani@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, azhar.shaikh@intel.com,
        utkarsh.h.patel@intel.com, casey.g.bowman@intel.com,
        rajmohan.mani@intel.com
Subject: [PATCH v2 0/2] TypeC Connector Class driver improvements
Date:   Thu, 30 Jul 2020 15:56:07 -0700
Message-Id: <20200730225609.7395-1-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
* Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
            usb_role_switch_set_role()"
  * Update the commit message to change 'USB_ROLE_HOST in case of
    UFP.'  to 'USB_ROLE_HOST in case of DFP.'

* Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
            during disconnect"
  * New patch added.

Azhar Shaikh (2):
  platform/chrome: cros_ec_typec: Send enum values to
    usb_role_switch_set_role()
  platform/chrome: cros_ec_typec: Avoid setting usb role twice during
    disconnect

 drivers/platform/chrome/cros_ec_typec.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.17.1

