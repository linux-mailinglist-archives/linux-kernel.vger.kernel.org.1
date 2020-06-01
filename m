Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB481EA6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgFAPPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 11:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgFAPPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:15:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115AEC05BD43;
        Mon,  1 Jun 2020 08:15:08 -0700 (PDT)
Received: from ni.home (unknown [IPv6:2a01:cb19:8092:cf00:aaa1:59ff:fe08:91d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: myjosserand)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E6E0E2A2000;
        Mon,  1 Jun 2020 16:15:05 +0100 (BST)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@collabora.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mylene.josserand@collabora.com, kever.yang@rock-chips.com,
        geert@linux-m68k.org, kernel@collabora.com
Subject: [PATCH v3 0/1] ARM: Add Rockchip rk3288w support
Date:   Mon,  1 Jun 2020 17:14:41 +0200
Message-Id: <20200601151442.156184-1-mylene.josserand@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Context
-------

Here is my V3 of my patches that add the support for the Rockchip
RK3288w which is a revision of the RK3288. It is mostly the same SOC
except for, at least, one clock tree which is different.
This difference is only known by looking at the BSP kernel [1].

Currently, the mainline kernel will not hang on rk3288w but it is
probably by "chance" because we got an issue on a lower kernel version.

According to Rockchip's U-Boot [2], the rk3288w can be detected using
the HDMI revision number (= 0x1A) in this version of the SOC.

Changelog
---------

In this V3, the revision's detection is not done in the kernel anymore.
This patch will handle the rk3288w clock tree according to a new
compatible "rockchip,rk3288w-cru" that must be provided by bootloaders.

Changes since v2:
   - Remove all codes about revision detection, let's handle that by
   Bootloaders

Best regards,
Mylène Josserand

[1] https://github.com/rockchip-linux/kernel/blob/develop-4.4/drivers/clk/rockchip/clk-rk3288.c#L960..L964
[2] https://github.com/rockchip-linux/u-boot/blob/next-dev/arch/arm/mach-rockchip/rk3288/rk3288.c#L378..L388

Mylène Josserand (1):
  clk: rockchip: rk3288: Handle clock tree for rk3288w

 drivers/clk/rockchip/clk-rk3288.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.26.2

