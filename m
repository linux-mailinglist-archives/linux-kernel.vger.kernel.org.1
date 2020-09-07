Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B788325FF02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgIGOdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 10:33:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:38051 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbgIGO2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:28:25 -0400
IronPort-SDR: 9i4PpFstBA+GSZ3Ig6HjujZGulonX8u5sZEPYgskb6ZOEZ3/umJRV1e9zyf86eQjFomFKVOoFH
 KwnIGwbsmNlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="137525039"
X-IronPort-AV: E=Sophos;i="5.76,402,1592895600"; 
   d="scan'208";a="137525039"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 07:27:17 -0700
IronPort-SDR: dBeBuHtNm44/5v8V1yPwJtYmTovXJotpsKTASoxtPFzjjIOwL6pD4ik6nwK5BbBR4pM7PhxK7Z
 QHbdP6wx3zXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,402,1592895600"; 
   d="scan'208";a="299459691"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2020 07:27:15 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v8 0/2] Modularization of DFL private feature drivers
Date:   Mon,  7 Sep 2020 22:23:01 +0800
Message-Id: <1599488581-16386-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset makes it possible to develop independent driver modules
for DFL private features. It also helps to leverage existing kernel
drivers to enable some IP blocks in DFL.


Patch #1: Introduce the dfl bus, then dfl devices could be supported by
          independent dfl drivers.
Patch #2: An example of the dfl driver for N3000 nios private feature.


Main changes from v7:
- remove the dfl_info_attr macro in dfl framework.
- add sysfs interfaces for retimer mode in dfl-n3000-nios, also doc update.
- delete duplicated sysfs interfaces description in dfl-n3000-nios doc.
- minor fixes.


Xu Yilun (2):
  fpga: dfl: create a dfl bus type to support DFL devices
  fpga: dfl: add support for N3000 Nios private feature

 Documentation/ABI/testing/sysfs-bus-dfl            |  15 +
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  49 ++
 Documentation/fpga/dfl-n3000-nios.rst              |  73 +++
 Documentation/fpga/index.rst                       |   1 +
 drivers/fpga/Kconfig                               |  11 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-n3000-nios.c                      | 574 +++++++++++++++++++++
 drivers/fpga/dfl.c                                 | 265 +++++++++-
 drivers/fpga/dfl.h                                 |  86 +++
 9 files changed, 1068 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
 create mode 100644 drivers/fpga/dfl-n3000-nios.c

-- 
2.7.4

