Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6AE269AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgIOApR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgIOApO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:45:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA441212CC;
        Tue, 15 Sep 2020 00:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600130713;
        bh=pKdQVJjnWdHPks2U7fV5zrwIH3JNHsSVYFB3BBYhmLc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Uzamz8KnA4jUuOvHuRW4DNtTFoAFkGIgDB1dijjt4w7BuITnoGME8UDWm8nr0rYdy
         JwQcMq7kMpEFoZ2lu7YPYCcyeVJbp1tDKU8V9DXgjQ0zaaDegMc7SFKcYIknlZqX8i
         75z43TNjN7LSl07uaYX33tH/STjkYNI/GXz6ljvc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200831161436.134186-1-jagan@amarulasolutions.com>
References: <20200831161436.134186-1-jagan@amarulasolutions.com>
Subject: Re: [PATCH] clk: rockchip: Fix overflow rate during fractional approximation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 14 Sep 2020 17:45:11 -0700
Message-ID: <160013071168.4188128.10518912964578839607@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jagan Teki (2020-08-31 09:14:36)
> The current rockchip fractional approximation overflow the desired
> rate if parent rate is lower than the (rate * 20) for few clocks like
> dclk_vopb_frac.
>=20
> The overflow condition has observed in px30 for dclk_vopb_frac
> clock with an input rate of 71.1MHz and parent rate of 24MHz is,
>=20
> [    2.543280] rockchip-drm display-subsystem: bound ff460000.vop (ops vo=
p_component_ops)

Can you remove timestamps?

> [    2.557313] rockchip-drm display-subsystem: bound ff470000.vop (ops vo=
p_component_ops)
> [    2.566356] rockchip-drm display-subsystem: bound ff140000.syscon:lvds=
 (ops rockchip_lvds_component_ops)
> [    2.576999] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    2.592177] Unexpected kernel BRK exception at EL1
> [    2.597551] Internal error: ptrace BRK handler: f20003e8 [#1] PREEMPT =
SMP
> [    2.605143] Modules linked in:
> [    2.608566] CPU: 1 PID: 31 Comm: kworker/1:1 Tainted: G     U         =
   5.8.0-rc1-15632-g97edd822b844 #30
> [    2.619363] Hardware name: Engicam PX30.Core C.TOUCH 2.0 10.1" Open Fr=
ame (DT)
> [    2.627460] Workqueue: events deferred_probe_work_func
> [    2.633209] pstate: 20000005 (nzCv daif -PAN -UAO BTYPE=3D--)
> [    2.639445] pc : rational_best_approximation+0xc4/0xd0
> [    2.645194] lr : rockchip_fractional_approximation+0xa8/0xe0
> [    2.651520] sp : ffff800011ea31c0
> [    2.655222] x29: ffff800011ea31c0 x28: ffff00007a4ecd50
> [    2.661162] x27: ffff00007d042600 x26: 000000000439fca3
> [    2.667102] x25: 0000000000000000 x24: ffff800011ac9948
> [    2.673033] x23: ffff800011ea3308 x22: ffff00007d042418
> [    2.678973] x21: ffff800011ea3240 x20: ffff800011ea3238
> [    2.684904] x19: ea47000000000000 x18: 0000000000000000
> [    2.690836] x17: 0000000000000500 x16: 0000000000000001
> [    2.696775] x15: ffffffffffffffff x14: 0000000000000000
> [    2.702707] x13: 0000000000000000 x12: 0000003c00000000
> [    2.708647] x11: 0000000000000030 x10: 0101010101010101
> [    2.714586] x9 : 0000032000000320 x8 : 7f7f7f7f7f7f7f7f
> [    2.720517] x7 : 000000a3c59050d3 x6 : 0000000000000030
> [    2.726457] x5 : ffff800011ea3240 x4 : ffff800011ea3238
> [    2.732397] x3 : 000000000000ffff x2 : 000000000000ffff
> [    2.738329] x1 : 00000000016e3600 x0 : 0000000001497e00
> [    2.744269] Call trace:
> [    2.747005]  rational_best_approximation+0xc4/0xd0
> [    2.752365]  clk_fd_round_rate+0x8c/0x110
> [    2.756846]  clk_composite_round_rate+0x30/0x40
> [    2.761917]  clk_core_determine_round_nolock.part.30+0x44/0x80
> [    2.768442]  clk_core_round_rate_nolock+0x78/0x80
> [    2.773701]  clk_mux_determine_rate_flags+0xd8/0x200
> [    2.779253]  clk_mux_determine_rate+0x10/0x20
> [    2.784124]  clk_core_determine_round_nolock.part.30+0x1c/0x80
> [    2.790639]  clk_core_round_rate_nolock+0x78/0x80
> [    2.795900]  clk_core_round_rate_nolock+0x5c/0x80
> [    2.801159]  clk_round_rate+0x64/0xf0
> [    2.805254]  vop_crtc_mode_fixup+0x2c/0x60
> [    2.809828]  drm_atomic_helper_check_modeset+0x95c/0xae0
> [    2.815767]  drm_atomic_helper_check+0x1c/0xa0
> [    2.820738]  drm_atomic_check_only+0x43c/0x760
> [    2.825705]  drm_atomic_commit+0x18/0x60
> [    2.830095]  drm_client_modeset_commit_atomic.isra.16+0x17c/0x250
> [    2.836911]  drm_client_modeset_commit_locked+0x58/0x1a0
> [    2.842851]  drm_client_modeset_commit+0x2c/0x50
> [    2.848014]  drm_fb_helper_restore_fbdev_mode_unlocked+0x70/0xd0
> [    2.854730]  drm_fb_helper_set_par+0x2c/0x60
> [    2.859497]  fbcon_init+0x3c0/0x540
> [    2.863400]  visual_init+0xac/0x100
> [    2.867298]  do_bind_con_driver+0x1e4/0x3a0
> [    2.871973]  do_take_over_console+0x140/0x200
> [    2.876843]  do_fbcon_takeover+0x6c/0xe0
> [    2.881228]  fbcon_fb_registered+0x10c/0x120
> [    2.886005]  register_framebuffer+0x1f0/0x340
> [    2.890878]  __drm_fb_helper_initial_config_and_unlock+0x318/0x4a0
> [    2.897790]  drm_fb_helper_initial_config+0x3c/0x50
> [    2.903244]  rockchip_drm_fbdev_init+0x5c/0xf0
> [    2.908202]  rockchip_drm_bind+0x194/0x1e0
> [    2.912785]  try_to_bring_up_master+0x164/0x1d0
> [    2.917851]  component_master_add_with_match+0xac/0xf0
> [    2.923597]  rockchip_drm_platform_probe+0x238/0x2e0
> [    2.929150]  platform_drv_probe+0x50/0xa0
> [    2.933631]  really_probe+0xd4/0x330
> [    2.937628]  driver_probe_device+0x54/0xb0
> [    2.942207]  __device_attach_driver+0x80/0xc0
> [    2.947078]  bus_for_each_drv+0x78/0xd0
> [    2.951365]  __device_attach+0xd4/0x130
> [    2.955652]  device_initial_probe+0x10/0x20
> [    2.960328]  bus_probe_device+0x90/0xa0
> [    2.964616]  deferred_probe_work_func+0x6c/0xa0
> [    2.969685]  process_one_work+0x1e4/0x360
> [    2.974166]  worker_thread+0x208/0x480
> [    2.978358]  kthread+0x150/0x160
> [    2.981968]  ret_from_fork+0x10/0x18

Wow this stack is huge.

> [    2.985970] Code: d65f03c0 d2800008 d2800027 17ffffe8 (d4207d00)
>=20
> This happened because the fractional divider does not apply if parent_rate
> is lower than (rate * 20).
>=20
> So, this patch is trying to fix that overflow clock and switch to half-div
> instead computing fractioanl approximation.
>=20
> Some part of the patch is referenced from below BSP commit:
>=20
> commit <88a5404a2277> ("clk: rockchip: fix up the
> rockchip_fractional_approximation")
>=20
> commit <4186a0e4239b> ("clk: rockchip: Add supprot to limit input rate
> for fractional divider")

Not sure what these are. Do we need random commit hashes in the log that
reference not-upstream patches? Seems like it could be left below the
triple dash and anyone can reference the mailing list if they really
care.

>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---

Any Fixes tag?

>  drivers/clk/rockchip/clk-px30.c | 12 ++++++------
>  drivers/clk/rockchip/clk.c      |  9 +++++++++
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
