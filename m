Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706332EF3CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbhAHOOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:14:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbhAHOOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:14:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3BBD22A99;
        Fri,  8 Jan 2021 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610115244;
        bh=LP4iqShCCmApBox7uX87r8DgJVKp3NJlHINQVEMmtGA=;
        h=From:To:Cc:Subject:Date:From;
        b=eaSB6OG+8xAN9ZgU7y0quuTFTsQ/ngFahBFMNvhptoDZvyXHPIiNM3HcvzxdeGJSm
         tMYWgHEul0hUM4yHGMHScZ6DxJLD41md9aj86wFm6mzHVjY4sG297je9wtXZOoxlec
         ZjuCmcx/4OSw8nYuC1lNpGCkQ6C5BvhfkwbRDUnVTOcPBVvZMe4s8ub1BNej/T8tgb
         e2QdXPAQFTPT4YrrXLFMJwL25ogplfk1aSVEEgP71xOSJ2X3OpFlL8ELlmpTF2zqGG
         4dHxBG7hdU9IJJzimxBv/rFtWyE5LrKqEquhO1Lj0Bw56BAs2qPBTq5l6tJgWoUnSI
         +WPDN6mdvdZTQ==
Received: by wens.tw (Postfix, from userid 1000)
        id A46105FB8B; Fri,  8 Jan 2021 22:14:02 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH] staging: rtl8723bs: wifi_regd.c: Fix incorrect number of regulatory rules
Date:   Fri,  8 Jan 2021 22:14:01 +0800
Message-Id: <20210108141401.31741-1-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The custom regulatory ruleset in the rtl8723bs driver lists an incorrect
number of rules: one too many. This results in an out-of-bounds access,
as detected by KASAN. This was possible thanks to the newly added support
for KASAN on ARMv7.

Fix this by filling in the correct number of rules given.

KASAN report:

==================================================================
BUG: KASAN: global-out-of-bounds in cfg80211_does_bw_fit_range+0x14/0x4c [cfg80211]
Read of size 4 at addr bf20c254 by task ip/971

CPU: 2 PID: 971 Comm: ip Tainted: G         C        5.11.0-rc2-00020-gf7fe528a7ebe #1
Hardware name: Allwinner sun8i Family
[<c0113338>] (unwind_backtrace) from [<c010e8a4>] (show_stack+0x10/0x14)
[<c010e8a4>] (show_stack) from [<c0e0f868>] (dump_stack+0x9c/0xb4)
[<c0e0f868>] (dump_stack) from [<c0388284>] (print_address_description.constprop.2+0x1dc/0x2dc)
[<c0388284>] (print_address_description.constprop.2) from [<c03885cc>] (kasan_report+0x1a8/0x1c4)
[<c03885cc>] (kasan_report) from [<bf00a354>] (cfg80211_does_bw_fit_range+0x14/0x4c [cfg80211])
[<bf00a354>] (cfg80211_does_bw_fit_range [cfg80211]) from [<bf00b41c>] (freq_reg_info_regd.part.6+0x108/0x124 [>
[<bf00b41c>] (freq_reg_info_regd.part.6 [cfg80211]) from [<bf00df00>] (handle_channel_custom.constprop.12+0x48/>
[<bf00df00>] (handle_channel_custom.constprop.12 [cfg80211]) from [<bf00e150>] (wiphy_apply_custom_regulatory+0>
[<bf00e150>] (wiphy_apply_custom_regulatory [cfg80211]) from [<bf1fb9e8>] (rtw_regd_init+0x60/0x70 [r8723bs])
[<bf1fb9e8>] (rtw_regd_init [r8723bs]) from [<bf1ee5a8>] (rtw_cfg80211_init_wiphy+0x164/0x1e8 [r8723bs])
[<bf1ee5a8>] (rtw_cfg80211_init_wiphy [r8723bs]) from [<bf1f8d50>] (_netdev_open+0xe4/0x28c [r8723bs])
[<bf1f8d50>] (_netdev_open [r8723bs]) from [<bf1f8f58>] (netdev_open+0x60/0x88 [r8723bs])
[<bf1f8f58>] (netdev_open [r8723bs]) from [<c0bb3730>] (__dev_open+0x178/0x220)
[<c0bb3730>] (__dev_open) from [<c0bb3cdc>] (__dev_change_flags+0x258/0x2c4)
[<c0bb3cdc>] (__dev_change_flags) from [<c0bb3d88>] (dev_change_flags+0x40/0x80)
[<c0bb3d88>] (dev_change_flags) from [<c0bc86fc>] (do_setlink+0x538/0x1160)
[<c0bc86fc>] (do_setlink) from [<c0bcf9e8>] (__rtnl_newlink+0x65c/0xad8)
[<c0bcf9e8>] (__rtnl_newlink) from [<c0bcfeb0>] (rtnl_newlink+0x4c/0x6c)
[<c0bcfeb0>] (rtnl_newlink) from [<c0bc67c8>] (rtnetlink_rcv_msg+0x1f8/0x454)
[<c0bc67c8>] (rtnetlink_rcv_msg) from [<c0c330e4>] (netlink_rcv_skb+0xc4/0x1e0)
[<c0c330e4>] (netlink_rcv_skb) from [<c0c32478>] (netlink_unicast+0x2c8/0x3c4)
[<c0c32478>] (netlink_unicast) from [<c0c32894>] (netlink_sendmsg+0x320/0x5f0)
[<c0c32894>] (netlink_sendmsg) from [<c0b75eb0>] (____sys_sendmsg+0x320/0x3e0)
[<c0b75eb0>] (____sys_sendmsg) from [<c0b78394>] (___sys_sendmsg+0xe8/0x12c)
[<c0b78394>] (___sys_sendmsg) from [<c0b78a50>] (__sys_sendmsg+0xc0/0x120)
[<c0b78a50>] (__sys_sendmsg) from [<c0100060>] (ret_fast_syscall+0x0/0x58)
Exception stack(0xc5693fa8 to 0xc5693ff0)
3fa0:                   00000074 c7a39800 00000003 b6cee648 00000000 00000000
3fc0: 00000074 c7a39800 00000001 00000128 78d18349 00000000 b6ceeda0 004f7cb0
3fe0: 00000128 b6cee5e8 aeca151f aec1d746

The buggy address belongs to the variable:
 rtw_drv_halt+0xf908/0x6b4 [r8723bs]

Memory state around the buggy address:
 bf20c100: 00 00 00 00 00 00 00 00 00 00 04 f9 f9 f9 f9 f9
 bf20c180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>bf20c200: 00 00 00 00 00 00 00 00 00 00 04 f9 f9 f9 f9 f9
                                         ^
 bf20c280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 bf20c300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
index 578b9f734231..65592bf84f38 100644
--- a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
+++ b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
@@ -34,7 +34,7 @@
 	NL80211_RRF_PASSIVE_SCAN)
 
 static const struct ieee80211_regdomain rtw_regdom_rd = {
-	.n_reg_rules = 3,
+	.n_reg_rules = 2,
 	.alpha2 = "99",
 	.reg_rules = {
 		RTW_2GHZ_CH01_11,
-- 
2.29.2

