Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD041AFCBB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgDSR2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 13:28:21 -0400
Received: from v6.sk ([167.172.42.174]:44542 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgDSR2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:28:17 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 8E84F610BF;
        Sun, 19 Apr 2020 17:27:46 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 00/10] clk: mmp2: Enable Audio and GPU on MMP2 and MMP3
Date:   Sun, 19 Apr 2020 19:27:32 +0200
Message-Id: <20200419172742.674717-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying this patch set for 5.8.

The goal is to add support for various clocks used by the GPUs and Audio
subsystem MMP2 and MMP3-based machines.

Probably the most significant part is that this adds support for runtime
PM domains which is managed by the same PMU hardware as the clocks.

Tested the GPUs on MMP2 and MMP3 as well as audio on MMP2. (I don't have
an audio codec hooked up on MMP3, nor a camera on a MMP3 machine, so
those remain untested for now).

Thank you
Lubo


