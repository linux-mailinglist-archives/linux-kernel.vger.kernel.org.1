Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4D2B7FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgKRPBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:01:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:37906 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKRPBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:01:04 -0500
IronPort-SDR: tG4GU5Q94pVoV1ryrPGBK7rlkQXQ+Jy1hEpM2cF650RqSYfWnSWXrkujChr82Gom0ELxePmkRI
 sfW4aji5T4YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171224092"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="171224092"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:01:02 -0800
IronPort-SDR: rsCU8KYkOh3bKEQ93QeGTpCgE1yrihlALPUw1ZGHY5x+Q6FUbtyYDNzBROyXZ52PaYD+xVUbon
 XNrpE2mQkKLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430881513"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2020 07:01:00 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH 0/3] usb: typec: Product Type time
Date:   Wed, 18 Nov 2020 18:00:56 +0300
Message-Id: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

The original discussion [1].

This proposal is in practice a compromise. I came to the conclusion
that we probable should expose the product type separately after all.
The reason for that is because we may in some cases actually know the
product type even when we don't have access to the Discover Identity
response. UCSI for example in practice gives us at least the cable
product type even though it does not let us know the response to the
Discover Identity command.

So my proposal here is that we add an attribute for the product type
itself, showing the product type as a string. Then we also add the
attribute for the product type specific VDOs which we place under the
identity directory more or less the way you originally proposed.

Note. I have not tested these at all.

[1] https://lore.kernel.org/linux-usb/20201023214328.1262883-2-pmalani@chromium.org/

Heikki Krogerus (2):
  usb: pd: DFP product types
  usb: typec: Add product_type sysfs attribute file for partners and
    cables

Prashant Malani (1):
  usb: typec: Expose Product Type VDOs via sysfs

 Documentation/ABI/testing/sysfs-class-typec |  55 +++++++
 drivers/usb/typec/class.c                   | 173 +++++++++++++++++++-
 include/linux/usb/pd_vdo.h                  |  16 +-
 3 files changed, 234 insertions(+), 10 deletions(-)

-- 
2.29.2

