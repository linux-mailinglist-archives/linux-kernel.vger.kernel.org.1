Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F440290F64
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411793AbgJQFhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411472AbgJQFhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:37:21 -0400
Received: from mail.kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D205207BC;
        Sat, 17 Oct 2020 02:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602900098;
        bh=wpHHkpSSM4GJrfAVokKmd5/Sksc+zajepbEU8E6FKKw=;
        h=From:To:Cc:Subject:Date:From;
        b=RRxUJMkGM/FWKah4086J64u71LxphKynJzZrkX/5UlfClBO1pt0VPETpfzmV/iWCX
         MM7f54KEepOPQuvVxbwGRbqEY5mrNs5CPdISa5GM1jn4Pyjmk1GNsd3ym9Li0DqY+j
         KlVYSJ6DMQHhg14/0nRg/f1DfbvksiUTUte9Pgbk=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] clk: qcom: gdsc: Keep RETAIN_FF bit set if gdsc is already on
Date:   Fri, 16 Oct 2020 19:01:37 -0700
Message-Id: <20201017020137.1251319-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the GDSC is enabled out of boot but doesn't have the retain ff bit
set we will get confusing results where the registers that are powered
by the GDSC lose their contents on the first power off of the GDSC but
thereafter they retain their contents. This is because gdsc_init() fails
to make sure the RETAIN_FF bit is set when it probes the GDSC the first
time and thus powering off the GDSC causes the register contents to be
reset. We do set the RETAIN_FF bit the next time we power on the GDSC,
see gdsc_enable(), so that subsequent GDSC power off's don't lose
register contents state.

Forcibly set the bit at device probe time so that the kernel's assumed
view of the GDSC is consistent with the state of the hardware. This
fixes a problem where the audio PLL doesn't work on sc7180 when the
bootloader leaves the lpass_core_hm GDSC enabled at boot (e.g. to make a
noise) but critically doesn't set the RETAIN_FF bit.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Taniya Das <tdas@codeaurora.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Fixes: 173722995cdb ("clk: qcom: gdsc: Add support to enable retention of GSDCR")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/gdsc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index bfc4ac02f9ea..af26e0695b86 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -358,6 +358,14 @@ static int gdsc_init(struct gdsc *sc)
 	if ((sc->flags & VOTABLE) && on)
 		gdsc_enable(&sc->pd);
 
+	/*
+	 * Make sure the retain bit is set if the GDSC is already on, otherwise
+	 * we end up turning off the GDSC and destroying all the register
+	 * contents that we thought we were saving.
+	 */
+	if ((sc->flags & RETAIN_FF_ENABLE) && on)
+		gdsc_retain_ff_on(sc);
+
 	/* If ALWAYS_ON GDSCs are not ON, turn them ON */
 	if (sc->flags & ALWAYS_ON) {
 		if (!on)

base-commit: 9ff9b0d392ea08090cd1780fb196f36dbb586529
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/

