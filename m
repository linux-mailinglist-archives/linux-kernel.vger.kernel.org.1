Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500181AAEA1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416234AbgDOQqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 12:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416219AbgDOQqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:46:51 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF7120737;
        Wed, 15 Apr 2020 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586969211;
        bh=Z9iFeNHWUQbmLEpVJTncXd+btqYkvHNdjtz4MDYl1G8=;
        h=From:To:Cc:Subject:Date:From;
        b=i+0ZdBoHK1IJCFwj75kbaqZa4XXaYuyvMzPAYM+2SXIGbUewO+DPSwxulXzCyDUE6
         Eaui+xtenUgO/iEfnjkfyT4I52w7co7sEc0jzrPN/R07uBKNLRErSCxfifWai0fOKd
         tICazg3ghLEgmlKzklPGQlupchcxEVPqf6uCAB6I=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCHv7 0/5] clk: agilex: add clock driver
Date:   Wed, 15 Apr 2020 11:46:37 -0500
Message-Id: <20200415164642.29382-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 7 of the patchset to add a clock driver to the Agilex
platform.

The change from v6 is to correct the dt-bindings document to include the
license header to be "(GPL-2.0-only OR BSD-2-Clause)".

Thanks,

Dinh Nguyen (5):
  clk: socfpga: stratix10: use new parent data scheme
  clk: socfpga: remove clk_ops enable/disable methods
  clk: socfpga: add const to _ops data structures
  dt-bindings: documentation: add clock bindings information for Agilex
  clk: socfpga: agilex: add clock driver for the Agilex platform

 .../bindings/clock/intel,agilex.yaml          |  46 ++
 drivers/clk/Makefile                          |   3 +-
 drivers/clk/socfpga/Makefile                  |   2 +
 drivers/clk/socfpga/clk-agilex.c              | 454 ++++++++++++++++++
 drivers/clk/socfpga/clk-gate-s10.c            |   5 +-
 drivers/clk/socfpga/clk-periph-s10.c          |  10 +-
 drivers/clk/socfpga/clk-pll-a10.c             |   4 +-
 drivers/clk/socfpga/clk-pll-s10.c             |  78 ++-
 drivers/clk/socfpga/clk-pll.c                 |   4 +-
 drivers/clk/socfpga/clk-s10.c                 | 160 ++++--
 drivers/clk/socfpga/stratix10-clk.h           |  10 +-
 include/dt-bindings/clock/agilex-clock.h      |  70 +++
 12 files changed, 794 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
 create mode 100644 drivers/clk/socfpga/clk-agilex.c
 create mode 100644 include/dt-bindings/clock/agilex-clock.h

-- 
2.25.1

