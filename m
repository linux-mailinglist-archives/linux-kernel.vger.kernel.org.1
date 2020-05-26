Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A871A8C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 22:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633158AbgDNUbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 16:31:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:19887 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633141AbgDNUbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:31:32 -0400
IronPort-SDR: 0E/i2S/t/SrGBvpo7MlJKg5g/xw43VoYFVcSO8BtoW8VtL8LfocJWjibk/V9KYcxFgxLP4f8In
 vKixC4Z9XYZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:31:31 -0700
IronPort-SDR: bOko6i7G2Cvd+l+59nK1HE1zgsFtO5KioBUHSU3TkP8t5A7Djd07uHhW+tdoyByVnO8+C51j8+
 pkifmWB4u+Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="453669027"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 14 Apr 2020 13:31:30 -0700
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [RESEND PATCHv1 0/1] firmware: fpga: replace the error codes with the standard one 
Date:   Tue, 14 Apr 2020 15:47:53 -0500
Message-Id: <1586897274-307-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

The Intel service layer driver has defined error codes for the
specific services, which started from FPGA configuration then RSU
(Remote Status Update).

Intel service layer driver should define the standard error codes
rather than keep adding more error codes for the new services.

The standard error codes will be used by all the clients of Intel service
layer driver.

Replace FPGA and RSU specific error codes with Intel service layer’s
Common error codes.

Richard Gong (1):
  firmware: fpga: replace the error codes with the standard ones

 drivers/firmware/stratix10-rsu.c                   | 10 +--
 drivers/firmware/stratix10-svc.c                   | 62 ++++++-------------
 drivers/fpga/stratix10-soc.c                       | 25 +++-----
 include/linux/firmware/intel/stratix10-smc.h       | 49 +++++++--------
 .../linux/firmware/intel/stratix10-svc-client.h    | 71 +++++++++-------------
 5 files changed, 84 insertions(+), 133 deletions(-)

-- 
2.7.4

