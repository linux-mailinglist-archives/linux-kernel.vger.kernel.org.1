Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF602E2E21
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 13:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgLZMUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 07:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLZMUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 07:20:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE34C061757;
        Sat, 26 Dec 2020 04:19:34 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d17so8602919ejy.9;
        Sat, 26 Dec 2020 04:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm5T9vuPoWIU6xCRU+PgPla6hEE0eBziHw6J7ZqdXys=;
        b=bqq1We105hP+TtOg3qX8jecGZUr9MXbSQ2RvjDz0u77TDGY1DWtFO0BY7DtyJmpIvL
         9X0Ot0AnsXAqG9djHwSY2TOepTf7YTpue4aq3ykqTz+js9XKep9MG34+eDPagjCvutw7
         Thv4/PeacvvNUZ+VspXqdRfZUfZtZkXfth+Roe+g/g41B+G5XOwTAJsVw6agoj+3Guvs
         s0y90ow09kbb8Dn/SC87QRUh02Jx50vNvp9j18P4eCNy/CcgHbiqMZIBoFU2/jBylhz5
         aN0jMZ+VLHhLALXoB/hdeAIq2N67joqKigulW2ebO3IvpUvAmruyvxgpndweIzh5jvbH
         3/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm5T9vuPoWIU6xCRU+PgPla6hEE0eBziHw6J7ZqdXys=;
        b=EOM4Ds/ozkHKpmFAMYbyyt2gixalzs1Fsmy/ZzuSmj4V2CxDIhCv5FUoihbDl9y3yr
         4Inj4iphqaLMTLA4Qr/i3ZAJCuk1v4/fVKzB/SPF58SeMjyqzFIxyTSjEZJXazqKcZGk
         b8aovQxPxCpe5r9DK0zLujdTquIXt84LQjMfoQjN5QNpSo3wq5euPp2AKjZGuLycfMcB
         iw/otjLy3zEmsY5EQIq7Og1Mu7yw1STw+YVac4cIY8ZcmQDb0aKqrZntkFD/WrL9H3z8
         UNqZIAbjYFd5UdsQ+CGrE90UHE10fBWVXjhpUkIWrGqCmunEvwf5/w625M+ohPHPWnf1
         SY6g==
X-Gm-Message-State: AOAM5314lFK7+ewhr7Z1XrvVDwPrpEYSC21UX0ljBphzNme0P+5dFH5f
        +3fCWH/2L3VGyWXC/sNxBSpdGnZZ62Q=
X-Google-Smtp-Source: ABdhPJwaTJ/wSSQc8uzjHVrEb0CVZyzc5uCwBEghsv+4BwXwE5ZQ9YRadAodvW6Ne6zlWO6VWINCsA==
X-Received: by 2002:a17:907:2d0f:: with SMTP id gs15mr34046687ejc.455.1608985173213;
        Sat, 26 Dec 2020 04:19:33 -0800 (PST)
Received: from localhost.localdomain (p200300f137218200428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3721:8200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j9sm33842662eds.66.2020.12.26.04.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 04:19:32 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] clk: meson: three small clk-pll fixes
Date:   Sat, 26 Dec 2020 13:15:53 +0100
Message-Id: <20201226121556.975418-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

while working on some changes for the 32-bit SoCs I hit a corner-case
in the HDMI PLL: there's some rate doubling going. The PLL only locks
in a specific rate range but the M/N table is not aware of that. This
means for now (I am planning to fix that) that we can end up in a 
ituation where the PLL doesn't lock and meson_clk_pll_set_rate() is
supposed to still behave in this case. So here's three small patches
for that.

For me it's fine to queue these patches for -next. I am not aware of
any breakage upstream, only some of my pending patches prefer to have
these fixes.

Slightly unrelated: if you know anything about that clock doubling then
please let me know!


Best regards,
Martin


Martin Blumenstingl (3):
  clk: meson: clk-pll: fix initializing the old rate (fallback) for a
    PLL
  clk: meson: clk-pll: make "ret" a signed integer
  clk: meson: clk-pll: propagate the error from meson_clk_pll_set_rate()

 drivers/clk/meson/clk-pll.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.29.2

