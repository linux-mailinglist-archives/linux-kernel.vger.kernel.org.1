Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4852326BBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 07:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIPFlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 01:41:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:31687 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgIPFlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 01:41:31 -0400
IronPort-SDR: VRcb5TeKYvxDnFbow68SVZ8Wg46wXoOEh6u6LgFuPU5UXtTE3Y7tVzorRqXN8sM3gZfBcsR8+C
 JytimR/bpoTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="158686086"
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="158686086"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 22:41:30 -0700
IronPort-SDR: Bi21qIxeMtcEDZzsloKhCsZR+uKQPTqbkVEXP+mBF1XOQETQT+BY3DC6AQaETRfeeIBXtHG24D
 fJY9OPqNppxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="346115038"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga007.jf.intel.com with ESMTP; 15 Sep 2020 22:41:28 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     krzk@kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, mdf@kernel.org
Subject: [PATCH v2] add the FPGA Device Feature List (DFL) EMIF support
Date:   Wed, 16 Sep 2020 13:37:01 +0800
Message-Id: <1600234622-8815-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchsets "Modularization of DFL private feature drivers" & "add dfl 
bus support to MODULE_DEVICE_TABLE()" are all queued to linux-next. So
there is no dependency now.

The driver supports the EMIF controller on Intel Programmable
Acceleration Card (PAC). The controller manages the on-board memory of
the PCIe card.

Xu Yilun (1):
  memory: dfl-emif: add the DFL EMIF private feature driver

 .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
 drivers/memory/Kconfig                             |   9 +
 drivers/memory/Makefile                            |   2 +
 drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
 create mode 100644 drivers/memory/dfl-emif.c

-- 
2.7.4

