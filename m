Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0943A1B2CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 18:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgDUQg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 12:36:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:41402 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDUQg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:36:28 -0400
IronPort-SDR: mmupEVOgE4pb0iQPggfjXSzkfrcYNJ9Hs43OlSrhUjeksi6QKTZOcfvhGghf9yZvoT+2a5BwCy
 /VE3ZALGSD9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 09:36:26 -0700
IronPort-SDR: HvIJwZk1MLJIzXs3XyzrNOWtCXf2oDnfOrV7a2PZKwpN01yMVf/cCI3H0aPJIu1ZMc2hjGTXij
 nahNXmtAfXiw==
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="429584494"
Received: from dalessan-mobl1.ir.intel.com ([10.252.22.134])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 09:36:24 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Paul J Murphy <paul.j.murphy@intel.com>
Subject: [PATCH 0/1] Add IMR driver for Keem Bay
Date:   Tue, 21 Apr 2020 17:36:17 +0100
Message-Id: <cover.1587485099.git.daniele.alessandrelli@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a patch for a new Intel Movidius SoC, code-named Keem
Bay.

Keem Bay needs a driver to disable the Isolated Memory Region (IMR)
set up by the SoC bootloader during early boot.

If such an IMR is not disabled and some device tries to access it,
the system will reboot.

Since this driver is SoC-specific and Keem Bay is a new SoC, I was
unsure of where to put this driver. In the end I decided to create a
new 'keembay' directory in 'drivers/soc'. I hope that's reasonable, if
not, just let me know.


Daniele Alessandrelli (1):
  soc: keembay: Add Keem Bay IMR driver

 MAINTAINERS                       |  5 ++++
 drivers/soc/Kconfig               |  1 +
 drivers/soc/Makefile              |  1 +
 drivers/soc/keembay/Kconfig       | 22 +++++++++++++++++
 drivers/soc/keembay/Makefile      |  5 ++++
 drivers/soc/keembay/keembay-imr.c | 40 +++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+)
 create mode 100644 drivers/soc/keembay/Kconfig
 create mode 100644 drivers/soc/keembay/Makefile
 create mode 100644 drivers/soc/keembay/keembay-imr.c

-- 
2.21.1

