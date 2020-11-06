Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D542A9349
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgKFJsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFJsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:48:35 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6799AC0613CF;
        Fri,  6 Nov 2020 01:48:35 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 33so625174wrl.7;
        Fri, 06 Nov 2020 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r7YyaJmRIWWPTEfEzl80MC6QW4rF6G5MsBiV1a8/Lpc=;
        b=eQ3+X40TsWePgKwYfv6Y0LrGNy6Si6msdrfWqYRBp5WPTkG0hjNjGm66SiM9HqZ0nk
         KF5HPV6RTb5+1fkntdj+itsd956wskElIvlUkBamTgKjpnplJ4Rk2Ib0ZBg32FcYylp+
         Jfutwen3/Jo8hF5/Y7bL2j/tf2OT/5H9BfIE66I48QofEdVgCsdlHb6TyttKYBIJ9Jy5
         cfSwiMiCX4I7W2zvParOK4si2/Z6C52EoVua/0aWfSgdb9cEX2/ug7fpydGdA+KKEM9J
         R1r/ICUPEoh548L51HgsP7qB63gu7VwTtGnqrF2ukiNlWpoD3+spNOiV3Wf7kfih6Vuu
         4CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r7YyaJmRIWWPTEfEzl80MC6QW4rF6G5MsBiV1a8/Lpc=;
        b=R1XYbL2fVZIQBto8tAFCAr9w77oAsXb4Ygb9ctFyvwkvwHax4kwqda3gSa9srkHNcU
         dbC79coAMDov59yEzpGwXtriS3IndnRkPBOGoOhfh7xSPRd2RV04sVb3mN8qFMaBq+9G
         rVZH2ygcxKsPxsukdDoGGfDWpeX4qPpjyRs1dvmOMPpfo3WLI54FTsFG/62eIZcBC7rX
         6F4L8nkneWUbxM4bZ4Rex0Wl93//RIoi7U6tySjHNHMGhzZFaNP0eg19D39j33kALr3a
         EtQ9npB8+tMepk2888BMrShyJVLo2zoR/gB+5/kV7dwPb0QeFXbMt0oUu/mCV8zVPg58
         Zjqg==
X-Gm-Message-State: AOAM532pOTTqgl1Gx6AgE8k76vasbx9sfYAiLrURDyCnkamApGj4nMZJ
        7ajHOuhOeJSce5PLFerZOj0=
X-Google-Smtp-Source: ABdhPJyVUzxwiL83Bw5+ELbmBhVqWaLCOIfOQ1w3aqx4YdGq1EfkW9niP4Pe3zgVc9WNFsu/OEZyqg==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr1705435wru.356.1604656114107;
        Fri, 06 Nov 2020 01:48:34 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d20:9d00:b87b:b644:61a3:6870])
        by smtp.gmail.com with ESMTPSA id c9sm1187446wrp.65.2020.11.06.01.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 01:48:33 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] clk: remove unneeded dead-store initialization
Date:   Fri,  6 Nov 2020 10:48:20 +0100
Message-Id: <20201106094820.30167-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make clang-analyzer on x86_64 defconfig caught my attention with:

  drivers/clk/clk.c:423:19:
  warning: Value stored to 'parent' during its initialization is never read
  [clang-analyzer-deadcode.DeadStores]
          struct clk_core *parent = ERR_PTR(-ENOENT);
                           ^

Commit fc0c209c147f ("clk: Allow parents to be specified without string
names") introduced clk_core_fill_parent_index() with this unneeded
dead-store initialization.

So, simply remove this unneeded dead-store initialization to make
clang-analyzer happy.

As compilers will detect this unneeded assignment and optimize this anyway,
the resulting object code is identical before and after this change.

No functional change. No change to object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201106

Stephen, Michael, please pick this minor non-urgent clean-up patch.

 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f83dac54ed85..ba35bf35bcd3 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -420,7 +420,7 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 static void clk_core_fill_parent_index(struct clk_core *core, u8 index)
 {
 	struct clk_parent_map *entry = &core->parents[index];
-	struct clk_core *parent = ERR_PTR(-ENOENT);
+	struct clk_core *parent;
 
 	if (entry->hw) {
 		parent = entry->hw->core;
-- 
2.17.1

