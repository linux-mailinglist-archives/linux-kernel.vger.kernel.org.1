Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33CD2F85DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbhAOUBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:01:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:25626 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbhAOUBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:01:16 -0500
IronPort-SDR: MyIVHaCCxsMKQOr2OA4FvHKtApRkLEdqum8dWOPIWVkNWuTsLIm1hvs55cARlF0MY0quQFEeve
 A2wlLIZlIDxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="175096282"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="175096282"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 11:59:30 -0800
IronPort-SDR: BlOKC1SOZ6dwZxeGIsGOmOmOIhcb5t0K6ktqssDamiG31ZVxN8RfQz7hYhX6E4dYpGDgHX8KYw
 eKZAC9TkUvcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="465686856"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2021 11:59:29 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/2] stm class/intel_th: Fixes for v5.11
Date:   Fri, 15 Jan 2021 22:59:15 +0300
Message-Id: <20210115195917.3184-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are updates that I have for v5.11. These are: one minor bugfix and
a new PCI ID.

Alexander Shishkin (1):
  intel_th: pci: Add Alder Lake-P support

Wang Hui (1):
  stm class: Fix module init return on allocation failure

 drivers/hwtracing/intel_th/pci.c  | 5 +++++
 drivers/hwtracing/stm/heartbeat.c | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.29.2

