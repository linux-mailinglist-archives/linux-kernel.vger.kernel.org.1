Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7890F1DA4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 00:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgESWm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 18:42:29 -0400
Received: from v6.sk ([167.172.42.174]:58624 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgESWm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:42:26 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 1BDF9610B0;
        Tue, 19 May 2020 22:41:55 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 00/13] MMP2 Clock Updates (GPU, Audio, Power Islands)
Date:   Wed, 20 May 2020 00:41:38 +0200
Message-Id: <20200519224151.2074597-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying this patch set. It contains patches that were
previously sent in two separate series ("clk: mmp2: Enable Audio and GPU
on MMP2 and MMP3" and "MMP2 Audio clock controller driver") but given
there are some dependencies, it seems more practical to merge them into
one.

The ultimate goal it so make GPU and Audio clocks work on MMP2 and
MMP3-based machines.

This patch set aims to address issues pointed out in review of v1 of the
clock controller set.

Ther first few patches add the clocks for the audio block, setting a few
things beforehands:

  [01/13] clk: mmp: frac: Do not lose last 4 digits of precision
  [02/13] clk: mmp: frac: Allow setting bits other than the
  [03/13] dt-bindings: marvell,mmp2: Add clock id for the I2S
  [04/13] dt-bindings: marvell,mmp2: Add clock id for the Audio
  [05/13] clk: mmp2: Move thermal register defines up a bit
  [06/13] clk: mmp2: Rename mmp2_pll_init() to
  [07/13] clk: mmp2: Add the I2S clocks
  [08/13] clk: mmp2: Add the audio clock

Then the support for controlling the power to Audio, GPU and (on a MMP3)
Camera blocks is added. The power is controlled by the same hardware
(the PMUs) as one that drives the clocks:

  [09/13] dt-bindings: clock: Make marvell,mmp2-clock a power
  [10/13] dt-bindings: marvell,mmp2: Add ids for the power
  [11/13] clk: mmp2: Add support for power islands

Finally a driver for the clocks used by I2S is added. The controller is
separate from a PMUs and lives in the audio block along with a pair of
I2S controllers:

  [12/13] dt-bindings: clock: Add Marvell MMP Audio Clock
  [13/13] clk: mmp2: Add audio clock controller driver

Tested the GPU and Audio on an OLPC XO-1.75 laptop (MMP2).

Thanks,
Lubo


