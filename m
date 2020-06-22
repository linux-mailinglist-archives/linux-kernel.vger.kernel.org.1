Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE4F2032F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 11:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgFVJJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 05:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgFVJJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:09:36 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35611206C1;
        Mon, 22 Jun 2020 09:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592816976;
        bh=wDDMlkh+4teMI1eFK9BzyCTummSg866L5B556UYV8h0=;
        h=From:To:Cc:Subject:Date:From;
        b=nzzUEeHuknhQltm0BhnFEpvYcFAt+Cnpm2tV7pT3BsG57/FrmigBOyqc67baITCZ6
         TIpx6cqL7qiwTWSjOX0yE4y8C2WSLU1bNjjKxfKVMW+vEI4CUPtXCKINbMiMYP3S+L
         LMi2khLzIrYX0DMIi0rctXDUmwmEw0AB8GEK40k8=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: Clean up kernel-doc errors
Date:   Mon, 22 Jun 2020 02:09:35 -0700
Message-Id: <20200622090935.213833-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two things aren't documented causing kernel-doc to fail when checking
the core clk.c file. Fix them so that this file is clean.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 236923b25543..47c0ee9da462 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4135,6 +4135,7 @@ static int devm_clk_hw_match(struct device *dev, void *res, void *data)
 
 /**
  * devm_clk_unregister - resource managed clk_unregister()
+ * @dev: device that is unregistering the clock data
  * @clk: clock to unregister
  *
  * Deallocate a clock allocated with devm_clk_register(). Normally
@@ -4324,6 +4325,8 @@ static void clk_core_reparent_orphans(void)
  * @node: Pointer to device tree node of clock provider
  * @get: Get clock callback.  Returns NULL or a struct clk for the
  *       given clock specifier
+ * @get_hw: Get clk_hw callback.  Returns NULL, ERR_PTR or a
+ *       struct clk_hw for the given clock specifier
  * @data: context pointer to be passed into @get callback
  */
 struct of_clk_provider {

base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
prerequisite-patch-id: ef03ffb3ba4ad414ba2917d05b8804fc14f907c7
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/

