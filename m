Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9DF2B9720
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgKSPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:43268 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgKSPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:27 -0500
IronPort-SDR: DNVlzu+/4xKKv+PggxX19ejFWMi4VA0dBjMk6ibH9ZFCXmaMs2bHB1p7gJSqi2SbvFmSo8swN1
 RWVq/4NsoauA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159081192"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="159081192"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:26 -0800
IronPort-SDR: IwZO+uvkSxk+iegEMMc4Z4ZDzxi31IxlOGBunP9QNAWZxtd0+TOwW6fjoQ+Y5yNmDRGi/Ky28+
 so6cTXaFdUPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="368812546"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Nov 2020 07:55:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AB8022A7; Thu, 19 Nov 2020 17:55:23 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 00/12] thunderbolt: USB4 NVM upgrade improvements & Maple Ridge support
Date:   Thu, 19 Nov 2020 18:55:11 +0300
Message-Id: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series improves the USB4 router NVM upgrade functionality and adds
support for USB4 router operations proxy implemented by recent Intel
Thunderbolt firmware connection manager. The last patch adds support for
Intel Maple Ridge that is the first discrete Thunderbolt/USB4 controller
from Intel.

This also includes a couple of minor cleanups and improvements around
debug logging.

Mika Westerberg (12):
  thunderbolt: Move max_boot_acl field to correct place in struct icm
  thunderbolt: Log which connection manager implementation is used
  thunderbolt: Log adapter numbers in decimal in path activation/deactivation
  thunderbolt: Keep the parent runtime resumed for a while on device disconnect
  thunderbolt: Return -ENOTCONN when ERR_CONN is received
  thunderbolt: Perform USB4 router NVM upgrade in two phases
  thunderbolt: Pass metadata directly to usb4_switch_op()
  thunderbolt: Pass TX and RX data directly to usb4_switch_op()
  thunderbolt: Add connection manager specific hooks for USB4 router operations
  thunderbolt: Move constants for USB4 router operations to tb_regs.h
  thunderbolt: Add USB4 router operation proxy for firmware connection manager
  thunderbolt: Add support for Intel Maple Ridge

 drivers/thunderbolt/ctl.c     |   3 +
 drivers/thunderbolt/icm.c     | 240 ++++++++++++++++++++++++++++--
 drivers/thunderbolt/nhi.h     |   1 +
 drivers/thunderbolt/path.c    |   4 +-
 drivers/thunderbolt/switch.c  |  20 ++-
 drivers/thunderbolt/tb.c      |   2 +
 drivers/thunderbolt/tb.h      |  14 ++
 drivers/thunderbolt/tb_msgs.h |  28 ++++
 drivers/thunderbolt/tb_regs.h |  14 ++
 drivers/thunderbolt/usb4.c    | 269 ++++++++++++++++++++--------------
 10 files changed, 473 insertions(+), 122 deletions(-)

-- 
2.29.2

