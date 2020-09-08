Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9A260AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgIHG0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 02:26:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:26026 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgIHG0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:26:50 -0400
IronPort-SDR: eCDVWCL9kDvUFHjlPhiKJhMvZR125qpSx0tK4zStkCJH+jvJJMTySUOs/FeY0coRZxvwEGgGoP
 GlntqM9NK4QQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="159053539"
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="159053539"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 23:26:48 -0700
IronPort-SDR: fc74VQJEc3y6muJp54WxDSpLpx9WSNv932o3ClKvgBDSvBaU1B18kJ1s/998YT0r5R3D0Rr5gL
 r3gSiUAXqmow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="317081205"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2020 23:26:45 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     linux@roeck-us.net, jdelvare@suse.com, lee.jones@linaro.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, mdf@kernel.org
Subject: [PATCH] add hwmon support for Intel MAX 10 BMC
Date:   Tue,  8 Sep 2020 14:22:19 +0800
Message-Id: <1599546140-18804-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch depends on the patch "add Intel MAX 10 BMC chip support for
Intel FPGA PAC".

https://lore.kernel.org/lkml/1599491813-20819-1-git-send-email-yilun.xu@intel.com/

This patch adds support for the hwmon sub device in Intel MAX 10 BMC

Xu Yilun (1):
  hwmon: intel-m10-bmc-hwmon: add hwmon support for Intel MAX 10 BMC

 drivers/hwmon/Kconfig               |  11 +
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/intel-m10-bmc-hwmon.c | 516 ++++++++++++++++++++++++++++++++++++
 3 files changed, 528 insertions(+)
 create mode 100644 drivers/hwmon/intel-m10-bmc-hwmon.c

-- 
2.7.4

