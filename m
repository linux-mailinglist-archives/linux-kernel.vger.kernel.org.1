Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A58F2CAD81
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbgLAUhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:37:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:61686 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbgLAUhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:37:31 -0500
IronPort-SDR: 6oXfcAaYD3TQGgB2I6dPaC4/wDHDZZgyqu3ui1r5esYfcet4EadBnWp+soBLlnn0SMtTEgRNGx
 q669tY0YZbWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="234508953"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="234508953"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 12:36:49 -0800
IronPort-SDR: rCQ6f4mX/UveoPTJru+BFcyNnjaNPPiBEx7VpbAHeiN8NBJYwtrcum01WtPKf6AmtExzuMSZGW
 aiEah0AnI8og==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="481254566"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.174.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 12:36:49 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 0/1] mfd: intel-m10-bmc: add sysfs files for mac_address
Date:   Tue,  1 Dec 2020 12:36:45 -0800
Message-Id: <20201201203646.200907-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two sysfs nodes to the Intel MAX10 BMC driver: mac_address
and mac_count. The mac_address provides the first of a series
of sequential MAC addresses assigned to the FPGA card. The
mac_count indicates how many MAC addresses are assigned to the
card.

Russ Weight (1):
  mfd: intel-m10-bmc: expose mac address and count

 .../ABI/testing/sysfs-driver-intel-m10-bmc    | 20 +++++++++
 drivers/mfd/intel-m10-bmc.c                   | 43 +++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |  9 ++++
 3 files changed, 72 insertions(+)

-- 
2.25.1

