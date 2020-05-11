Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CCA1CE442
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 21:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgEKTZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 15:25:29 -0400
Received: from v6.sk ([167.172.42.174]:52316 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbgEKTZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:25:29 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 9E3DC610A9;
        Mon, 11 May 2020 19:25:27 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 00/10] clk: mmp2: Enable Audio and GPU on MMP2 and MMP3
Date:   Mon, 11 May 2020 21:25:07 +0200
Message-Id: <20200511192517.1206442-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
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

Compared to v1 this just adds a couple of ack tags for the DT bindings.

Thank you
Lubo


