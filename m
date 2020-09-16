Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08B626BA93
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgIPDTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:19:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:2941 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIPDTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:19:12 -0400
IronPort-SDR: p7EBlkSor1is14SjR8rdggrKhIwXmPeU59MLOadnR1KxMrVKobzArh8ah8Xmb0mXZupLdYDnRk
 mzhsyQIhqegA==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="156781076"
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="156781076"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 20:19:12 -0700
IronPort-SDR: Wc46e8Y1VUnMmy70pqa2KzWZEGHUL3eAbJxLO5/5nOQthbixxIpRmSWzpKm4oV6emulsrAmCBE
 JlECbt4NBm+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="507842351"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2020 20:19:09 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     linux@roeck-us.net, jdelvare@suse.com, lee.jones@linaro.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, mdf@kernel.org
Subject: [PATCH v2] add hwmon support for Intel MAX 10 BMC
Date:   Wed, 16 Sep 2020 11:14:21 +0800
Message-Id: <1600226062-25755-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch depends on the patch "add Intel MAX 10 BMC chip support for
Intel FPGA PAC".

https://lore.kernel.org/lkml/1599491813-20819-1-git-send-email-yilun.xu@intel.com/

This patch adds support for the hwmon sub device in Intel MAX 10 BMC

Main changes from v1:
- add the Documentation
- refactor the code, provide static hwmon_channel_info

Xu Yilun (1):
  hwmon: intel-m10-bmc-hwmon: add hwmon support for Intel MAX 10 BMC

 Documentation/hwmon/index.rst               |   1 +
 Documentation/hwmon/intel-m10-bmc-hwmon.rst |  78 ++++++
 drivers/hwmon/Kconfig                       |  11 +
 drivers/hwmon/Makefile                      |   1 +
 drivers/hwmon/intel-m10-bmc-hwmon.c         | 355 ++++++++++++++++++++++++++++
 5 files changed, 446 insertions(+)
 create mode 100644 Documentation/hwmon/intel-m10-bmc-hwmon.rst
 create mode 100644 drivers/hwmon/intel-m10-bmc-hwmon.c

-- 
2.7.4

