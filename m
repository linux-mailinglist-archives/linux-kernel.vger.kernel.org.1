Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9221D254964
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 17:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgH0P2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 11:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgH0P2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:28:34 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA47C061264;
        Thu, 27 Aug 2020 08:28:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d11so8161502ejt.13;
        Thu, 27 Aug 2020 08:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xka1xJCkBzX+fo5h4+QXGe8/233LKJ14V0jyRndSzNc=;
        b=hp8auHCAxhQofF46+/rfvZCfBQxMxa9yfLpeumNP5dkb5BmFli8QnVvTzp5iqDmwkN
         OFZnje5f8iIGZUOmFSQRAKQ/o/0e4BpcOeVTY70dOj66t6E39GQQPeySVwuZChQqjMDR
         TOYYhgrp4gVGMJdurH1WsElWn3U9smnf59cLNiKN4D+eH2DGS4NpDhgT5X7/wZBx6+eX
         8Jv0AIFL6cPtNuCiZbZWZHnvNs8FGhqmfuGA/igqZWrkUZRju2sfTbqqnky0wf4TMsqZ
         vi/ab9n39AugeXgYinWJ98iYlNXglDHNn9DX3pJM/GzvHcfrce3Mx377YFPy2BX7rfXs
         cA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xka1xJCkBzX+fo5h4+QXGe8/233LKJ14V0jyRndSzNc=;
        b=DMbMMFMq1hK7l1hKpML8xtIxCjObqIFTeePEPGj+x1Lee4/6EJu+BjB98ZGCqxVMf+
         idwXVSbUl7PcHKvAJIwrxG/Cl3rtjdH3BZYCv+ohrnkk4CNcHm5iu5vq7EeWjPrCIZlR
         +ObElUO7lpp71zy93xoNUiKklPYeJmhqoqKEa/RdVBdwWKR1p37uY1HDv25Rq70De7R9
         FJvAaXVL/93fKoB9QW1QRcneUZDpBNbW2lN3wIXxOkbARdb+63RnvvsyEKqMhlz94+Pv
         CBr8lN9TBpMkBszmzPC8SJE6GI2C0kzBVLVrCkSEEBbg21iTlknckUbHJXZ3lQrr/zIw
         32ug==
X-Gm-Message-State: AOAM533Fl/YM3N0sgHvjlgqRl/rEiXjCAttOy+bbb0iQr9/H+I+cDcff
        GEHeEYIDbKACSLn3CeYzwBM=
X-Google-Smtp-Source: ABdhPJxLch9UreAcwRDiLekEgeE+NbAhBr9zxAevKnxFyrbn01pD3UPpu0iRMBhDYkp6T5ioVUCw2A==
X-Received: by 2002:a17:906:5796:: with SMTP id k22mr22645745ejq.77.1598542112392;
        Thu, 27 Aug 2020 08:28:32 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r18sm2147119eju.25.2020.08.27.08.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:28:31 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: Make kerneldoc consistent
Date:   Thu, 27 Aug 2020 17:28:27 +0200
Message-Id: <20200827152827.1661050-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The kerneldoc comment for of_parse_clkspec() mentions in one place that
the value of the index parameter dictates how name is used, whereas in
reality it's the name parameter that dictates whether or not the index
parameter is used.

In a later paragraph the kerneldoc comment does mention that the index
will be ignored if the name is non-NULL, so make the parameter
description consistent.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0a9261a099bd..cf6774abebb0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4600,7 +4600,7 @@ EXPORT_SYMBOL(devm_of_clk_del_provider);
 /**
  * of_parse_clkspec() - Parse a DT clock specifier for a given device node
  * @np: device node to parse clock specifier from
- * @index: index of phandle to parse clock out of. If index < 0, @name is used
+ * @index: index of phandle to parse clock out of; ignored if @name is non-NULL
  * @name: clock name to find and parse. If name is NULL, the index is used
  * @out_args: Result of parsing the clock specifier
  *
-- 
2.28.0

