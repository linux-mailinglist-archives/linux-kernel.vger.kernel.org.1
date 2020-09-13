Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56321267ED8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgIMImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgIMIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:41:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5916C061573
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a22so15937724ljp.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UgXVvnxYc25DMg5eUeNGWMrOx6zm4No8JCi8XAUNxYg=;
        b=lx0mFy4n2rEpoVob9pkrgYPp75olJ93BxlZg3tL2E+ce+daz/PeTcLnXtvwAK/zNMQ
         OyM15CBcmoEhsg5wNYOcvVT68gWbhR43mfiAoCvbhadYe0VHrG/FuVXZ9lZpDM+Gmqxg
         HU+jAyQJ8A+djQoaRifGIrVfwBfs/2fz+ZgCdOwNixotB7TT0gACzuDn++XOx4BG/l21
         4iyNwxMTDJIafJc1PYkcZ80Lfxe/93wLogNMapZEfeJLU2P85XzfnbGvw4DnGyaLrmi9
         YMp/cXPIBpoKN46tQFIjvPN2no/i5z2ObHJ3yLMeysvgio+oo4B8aLrq05LNWcuNo3C5
         ItgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UgXVvnxYc25DMg5eUeNGWMrOx6zm4No8JCi8XAUNxYg=;
        b=Pmj5R0MtPIXeZwNtqt/L/xTGxhI+7Js7PwA8VmDiK3crJgF2TyzL/nPl9K4Jcpm2dD
         xOuIg+iXNp4ekIV2fOwHuMkqxlmUglAcx17Fl5twWkRzmHjyIUB8HyJzyMZ8UHjNJAM5
         L8BEpiRHtSvNXFQMNzX7QlG9RLyU0yWHqps54TfBQuP+Q5few3QBW3s0+JgZdElrdVOy
         udhh/zPUznTqzF4lHy04f1w97g2beRwragpA8J2rns30p21XNABMbTcBAnmXZm5aqqlj
         E7CtA6NQMeDesrCU+zTUbOiz4Lasn93h3Hn1O8SaL6icyNEgBZ8bFYFLHBFrK6sW/kI1
         o9VA==
X-Gm-Message-State: AOAM533MfVUh21MXC1U6iqWycLvYyeXVV5fl5QTCbY329ncj8VOWulYi
        NFAqIGTi6bKG5UjXFQOBFoQ=
X-Google-Smtp-Source: ABdhPJyfqZIUpR/9/Dz6NCyyBUPMiLV7gF+r4bg828OrnWFSzV/fWAPa5EtYB7BQpOuL+CiBF98kMw==
X-Received: by 2002:a2e:8e71:: with SMTP id t17mr3155349ljk.413.1599986505463;
        Sun, 13 Sep 2020 01:41:45 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id n9sm2081099lfd.215.2020.09.13.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 01:41:44 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/5] drivers/regulator: Constify static variables
Date:   Sun, 13 Sep 2020 10:41:09 +0200
Message-Id: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a couple of static variables, most importantly regulator_ops to
allow the compiler to put them in read-only memory.

Rikard Falkeborn (5):
  regulator: dummy: Constify dummy_initdata and dummy_ops
  regulator: fixed: Constify static regulator_ops
  regulator: stw481x-vmmc: Constify static structs
  regulator: pca9450: Constify static regulator_ops
  regulator: ti-abb: Constify ti_abb_reg_ops

 drivers/regulator/dummy.c             | 4 ++--
 drivers/regulator/fixed.c             | 4 ++--
 drivers/regulator/pca9450-regulator.c | 6 +++---
 drivers/regulator/stw481x-vmmc.c      | 4 ++--
 drivers/regulator/ti-abb-regulator.c  | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.28.0

