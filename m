Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0B2950A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444549AbgJUQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444530AbgJUQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:21:56 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46481C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:21:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ce10so4107409ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UI2P/yyao6EznjeZr1h9V5wwTm/lr2jsyR7CYvPpJn8=;
        b=sGEe0ZSsBq2hxXtN4AppUO1Zi4qpE8rjaTwX9Wi5YMoUpfkKpWDeC8/ptxqAH7PVfT
         W2Wm/iYiW8Gy1hphh3YxpoKfkJS4qpIFENQQtiX5j6O5Lu/vCGSyezztx/pWVwrbOR7y
         FEsYm1MaFmx0ioASrEdPyTgGZ8i49rzkz3JDUnjItBHliozJJrO7da0ibDypAqBVKKik
         fObm9XdOL1ZOsJRzednQvcOqJw1q34CsvIsayRX3amK+jvKt/S9StRra6V+I0s5WbUcj
         9LJORutEbazY+hbuHPmEtbhKBdvVkBNksZgc9QFUMkpkc3O6XisHdQ3W0kl0fKWKi+4M
         Wp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UI2P/yyao6EznjeZr1h9V5wwTm/lr2jsyR7CYvPpJn8=;
        b=pb76NKGXgiF8pUcZ0DYvCsrAwFJSSUCI4JxKsFfWCR4J2VthPMxAN2JKQ/VMZ0BAC4
         FYiTWWX7u2EoUrgh4/n5WbG7Xh4923ubqwlWY619WsOAUBRSvdc3q5T6ZawrNOdf5pco
         ckCruftyXHnDhrBGa+hUoVKwsPzYr//Q71bfPUvAzpygyXOr8Off3ymh0j0MhDs2Gili
         gpUfzK8c8BVC9VvlPNPMjr62AYQ6A/vGJLTLfbAYLNn4c1dVdV+NzlxS6K3G3SD8NtYY
         PCVWLZ3wHOWM7qknktJn/sav61xnnYvpYk1yMsDxK2uSuvfHDlbtqCN1FooBnPcHc1Lk
         fUMA==
X-Gm-Message-State: AOAM531UbLD76d3JUrNIVujwPWoyqOC3iDXMBPqL1/g2FOWbdTqMWivM
        EmrvmkRzfLHn8g9rwEtcU4TjRg==
X-Google-Smtp-Source: ABdhPJz01d9oIMCTPrSm5ZUKeD22XQbYSH9b+dNijavQFdQQWBxIif4CrZRFLBUmfLd4R+zYnk+Azg==
X-Received: by 2002:a17:907:2089:: with SMTP id pv9mr4460227ejb.427.1603297312942;
        Wed, 21 Oct 2020 09:21:52 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id 11sm2566667ejy.19.2020.10.21.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:21:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 0/3] clk: add api to get clk consumer from clk_hw
Date:   Wed, 21 Oct 2020 18:21:44 +0200
Message-Id: <20201021162147.563655-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset a call in CCF to get "struct clk*" from "struct clk_hw*"

Changes since v1: [0]
* Add a con_id string to help keep track of the consumer
* Add devm variant:
 - Following our discussion on V1, I choose to have the dev as
   argument as most devm function do. However, as Stephen pointed out
   we don't expect this to differ from the one linked to clk_hw. In
   this case a warning is thrown.
* Add a first usage of this in the amlogic clock driver.

[0]: https://lore.kernel.org/r/20200519170440.294601-1-jbrunet@baylibre.com

Jerome Brunet (3):
  clk: avoid devm_clk_release name clash
  clk: add api to get clk consumer from clk_hw
  clk: meson: g12: drop use of __clk_lookup()

 drivers/clk/clk.c            | 73 +++++++++++++++++++++++++++++++++---
 drivers/clk/meson/g12a.c     | 68 ++++++++++++++++-----------------
 include/linux/clk-provider.h |  5 +++
 3 files changed, 104 insertions(+), 42 deletions(-)

-- 
2.25.4

