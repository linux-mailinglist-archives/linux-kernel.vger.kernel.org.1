Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8301D607A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgEPLGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 07:06:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:26451 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEPLGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 07:06:15 -0400
IronPort-SDR: HB+sIZYD0Mu+vz1bL8dswvOA5CkggFNoTLEa6o+iWSYR24/zjFpWCBYis1zyuKzWAO+2YTpkw0
 3hKqxO+2yObw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 04:06:14 -0700
IronPort-SDR: vnUpgvWDk7dxh2F+Zmxj/M0trX+nO0mcSN6ZKjKXgSqcHY+QrtJLjfFe+l7U/HWHfcdRxzjWXL
 o6eEgeOy1u1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="263457879"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by orsmga003.jf.intel.com with ESMTP; 16 May 2020 04:06:12 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 0/2] mfd: constify pointers
Date:   Sat, 16 May 2020 14:06:07 +0300
Message-Id: <20200516110609.22013-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify properties and platform_data in mfd cells

Tomas Winkler (2):
  mfd: constify properties in mfd_cell
  mfd: mfd_cell: constify platform_data

 include/linux/mfd/core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.21.3

