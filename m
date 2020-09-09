Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C8726275E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 08:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgIIGwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 02:52:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:49965 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIIGwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:52:13 -0400
IronPort-SDR: DAOBKHJX+Dib/wCrDoH0wCpq5TnlvC48W3lu8zqpzz/FgFFguDyAPxoxMxwBBIokUwivseK0Hj
 fl0sM/jBoF+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="145996079"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="145996079"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 23:52:12 -0700
IronPort-SDR: c5Tjb/R/oOW8P0FFhVqa4mmRiz0VXxXVK2EAFFFpJKuKcTO5sHvOGpYEVtJbhLp5xklKKMLVmT
 WT6Hs3nNj1mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="328796179"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2020 23:52:08 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 0/2] Add driver for Moortec PVT controller
Date:   Wed,  9 Sep 2020 14:52:03 +0800
Message-Id: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 adds DT bindings schema in YAML format.
Patch 2 adds driver for MR75203 PVT controller.

Rahul Tanwar (2):
  Add DT bindings schema for PVT controller
  Add driver for Moortec MR75203 PVT controller

 .../devicetree/bindings/hwmon/moortec,mr75203.yaml |  70 +++
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/mr75203.c                            | 617 +++++++++++++++++++++
 4 files changed, 698 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
 create mode 100644 drivers/hwmon/mr75203.c

-- 
2.11.0

