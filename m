Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1315A29C7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371307AbgJ0S6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S371299AbgJ0S6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603825085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/w7n3wo/ogMNJSBrl9q8TgkOqP0Cfiwxz1gfe/57UsA=;
        b=WymB0rXzUiXBR+OG2luMf5g0CDve48dfDjLaGNEaX0o1TPZT9V+RItECqIIXNTjpAjrstr
        jLIz4c6LNPzurW1AGlaqvKj4A8q6MlNH7Qig2hlPE9TFDZmw8r8GP2gHM3+hMbe5fIoPmt
        IKtGQR+0vB2Kw63ms6/n2M8iSnWLGnw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-JwF5X0JeOleBYKHWvTCJyg-1; Tue, 27 Oct 2020 14:58:03 -0400
X-MC-Unique: JwF5X0JeOleBYKHWvTCJyg-1
Received: by mail-oi1-f200.google.com with SMTP id c198so1114262oig.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/w7n3wo/ogMNJSBrl9q8TgkOqP0Cfiwxz1gfe/57UsA=;
        b=gMvGFMRJEA2whO7fnZX/eotP+DAnD0LUeSXXowziewnuPPJ/KvU1qIigcrXgimA2B2
         YyZGy20rH4E/CstqWuvfAYPkSIDQOnRWC3AWEnDycbjF+LIRFhvwgZ06j7xOss6Wyuru
         zItP8R3N+52DHIdDYGoqLp611wOXn4GNd4RDH+AV8ltWGxkXkMKhrCQTwF4WH+oH9jwV
         8/jBI5Nc0IotISZXllMOJIlPvCmGW+2GhEOge7+5Dx5h0ViWkBzCey/c6a0aNhcZBmiL
         u9Voet/FQb3rVx+z3HQ2lc9AQlizn2Hjz2cZUcqAHpuBQKUIFJL9v5xIHAuxys4gzqcs
         RlBQ==
X-Gm-Message-State: AOAM530m6pIhueZKw6XmAR+WAd5KlDZF/nljrjV5QXX+aMyluwJmkRdf
        Ko6NJJ2Sl/Y6WTHp3m7Hj8ekrdOCljgUF7JqiAeW0rn/r0fiRkO9G3nF6e3hY+cukXcvjQiAW5q
        RxwP5E5A7F/ppseRvneIraX3z
X-Received: by 2002:a05:6830:10d2:: with SMTP id z18mr2320848oto.41.1603825082557;
        Tue, 27 Oct 2020 11:58:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYGhvIxX/WWpgZFdD22OWQEZoC9GCiKRCLyoHJyIbNVn7keqIqMsFXtqbWyOFnR+FdTTxhYA==
X-Received: by 2002:a05:6830:10d2:: with SMTP id z18mr2320838oto.41.1603825082332;
        Tue, 27 Oct 2020 11:58:02 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j97sm1433795otj.37.2020.10.27.11.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:58:01 -0700 (PDT)
From:   trix@redhat.com
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, abel.vesa@nxp.com,
        peng.fan@nxp.com, leonard.crestez@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] clk: imx: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 11:57:56 -0700
Message-Id: <20201027185756.1586607-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/clk/imx/clk-pll14xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index aba36e4217d2..2b5ed86b9dbb 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -416,7 +416,7 @@ struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 		       __func__, name);
 		kfree(pll);
 		return ERR_PTR(-EINVAL);
-	};
+	}
 
 	pll->base = base;
 	pll->hw.init = &init;
-- 
2.18.1

