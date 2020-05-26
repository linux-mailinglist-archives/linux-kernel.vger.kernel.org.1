Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0907F19E196
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 01:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgDCXyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 19:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgDCXyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 19:54:11 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DE4A2072B;
        Fri,  3 Apr 2020 23:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585958051;
        bh=IZmDyvmJOLUbLBV5JuNMND47WpiNR7jak95jQCtF9UQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ujPOS2djBdNndNotY3DHLXkaA7ITJ2+FEHyc7otjt7Fc4XDcP73S/q8/KQ88aiBAj
         kqZeRnH1SDiGJVm+k4mPoGUJnLC+tk4MDap9ay+tlQkF7Vc0J2KKSMA10yXu/BelbQ
         ELRcBLJz7YcUbVHhPlVD1BwBoqYFixcn0bsmaFa0=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCHv5 0/5] clk: agilex: add clock driver
Date:   Fri,  3 Apr 2020 18:53:58 -0500
Message-Id: <20200403235403.13990-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 5 of the patchset to add a clock driver to the Agilex
platform.

The change from v4 is address comments from Rob Herring on the dt-bindings
file.

Thanks,


Dinh Nguyen (5):
  clk: socfpga: stratix10: use new parent data scheme
  clk: socfpga: remove clk_ops enable/disable methods
  clk: socfpga: add const to _ops data structures
  dt-bindings: documentation: add clock bindings information for Agilex
  clk: socfpga: agilex: add clock driver for the Agilex platform

 .../bindings/clock/intel,agilex.yaml          |  40 ++
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
 12 files changed, 788 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
 create mode 100644 drivers/clk/socfpga/clk-agilex.c
 create mode 100644 include/dt-bindings/clock/agilex-clock.h

-- 
2.25.1

