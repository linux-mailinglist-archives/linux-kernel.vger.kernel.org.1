Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E55304686
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbhAZRX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:23:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:55396 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbhAZGzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:55:49 -0500
IronPort-SDR: JWRUjXGYoZMklII1094Hx2Xpzef7JGQ4CjvCTZs1fFXuc/d0frU5uvWvcPm3wDHG/THsP9aaMI
 lvtmPyi+ctUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177289709"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="177289709"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 22:55:02 -0800
IronPort-SDR: yiQ5gPPJ8tloCzC6jl+sbyUQ6LA1OSLwkAnyx9exbcsuNZznpCYrXfIOwYHjbbUMfg3k2YDgTZ
 nRN2tQKGl3oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="387712986"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2021 22:54:57 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v2 0/4] Some improvement for Intel MAX 10 MFD drivers
Date:   Tue, 26 Jan 2021 14:50:32 +0800
Message-Id: <1611643836-7183-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is some improvements for intel-m10-bmc and its subdevs.

Main changes from v1:
- Add a patch (#2) to simplify the definition of the legacy version reg.
- Add a patch (#4), add entry in MAINTAINERS for intel-m10-bmc mfd driver
  and the subdev drivers.

Matthew Gerlach (1):
  mfd: intel-m10-bmc: Add access table configuration to the regmap

Xu Yilun (3):
  mfd: intel-m10-bmc: Fix the register access range
  mfd: intel-m10-bmc: Simplify the legacy version reg definition
  MAINTAINERS: Add entry for Intel MAX 10 mfd driver

 MAINTAINERS                       |  9 +++++++++
 drivers/mfd/intel-m10-bmc.c       | 25 ++++++++++++++++++-------
 include/linux/mfd/intel-m10-bmc.h |  7 +++++--
 3 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.7.4

