Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D3C2C10D0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbgKWQiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732563AbgKWQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:38:17 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58213C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:38:17 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so19242987wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWoVY3ymzk4cWTn4v1bXh+Sdx2khkGvdmAYTQ5FaBbQ=;
        b=SxLSwWWikSEHrkcswd89DLnmpGU0XvkZ4As0oJ6nDX4yXVtzmohXimFSlhYvIZx6eT
         DdkRfxY0QSpesU+aedtenhi7zp7OZlNYlrxVYvEEnonOqfwBtgUwHvdWvDZu5yJ6lJYU
         5OcKgqup/6Ci+DmbTdcO8VnzLF5zRy9Onrn48R7O0/jNBpQzpEidn2KTdwvnxOlIuo4R
         aLG89aQtiKToEimH91cAjypIMKgHZnREw7OESaJJUkjVKWgt07nVybKpRu2tZ9RPAqbv
         QgczmFlfg/AFkryP0aQJk5FgggPsQveYH6uzZkTkt6Kq0+1P1oYMd99nImv7gBdZUlFx
         8PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWoVY3ymzk4cWTn4v1bXh+Sdx2khkGvdmAYTQ5FaBbQ=;
        b=TDL1N9HbVqfk8EBqdezmGm8hQecTHcxsvLIi21+XxcXIxE27Q7PdHA6XPLsNlqBuSu
         XqhomgHUMGa/Z/e552TcASfKdBzr7uFM1/iQ7KSBih7ar0JdRnEUG/eJsulhbNb5ZBy8
         Yyh+nv6x0dJJbq5lM2cP5vhPqNvLRwulr5Ail5fbt3f8l2vt98aqo7vApp0hQzLElBKV
         NOcrn0VDFb/rZcd+CP6AUdlj4nmy3D15NMu4kLZswpZ9eVNT+/RZqfTI1CH2e5AuVtoV
         iIqWtMoDqfcAZpgLk/3ZPC8wEo2NfF8fWT0O5hfu3TFI4OJhYSk3MzhEreZOwfY+ht8B
         wIjw==
X-Gm-Message-State: AOAM5304vMvjliZUv6gFlEU6GadxyvVVFVLO2U3c5ScI+7s6znl9jukr
        Uo3Fu7qcH+9S4PbMno/ChYlayg==
X-Google-Smtp-Source: ABdhPJwPUVxyobNEfXOdvktyz0fszKkrJa0DxbBhWMphOi5LtCs4uDIpZ6d6t6TRxess5meOoBwYOw==
X-Received: by 2002:adf:c147:: with SMTP id w7mr611048wre.60.1606149495821;
        Mon, 23 Nov 2020 08:38:15 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:9541:d2fd:3a68:67ae])
        by smtp.gmail.com with ESMTPSA id l3sm19566386wmf.0.2020.11.23.08.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:38:15 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] clk: meson: g12a: add MIPI DSI Host Pixel Clock
Date:   Mon, 23 Nov 2020 17:38:09 +0100
Message-Id: <20201123163811.353444-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adss the MIPI DSI Host Pixel Clock used to feed the DSI pixel
clock to the DSI Host controller.

Unlike the AXG SoC, the DSI Pixel Clock has a supplementary mux, divider and gate
stage before feeding the pixel clock to the MIPI DSI Host controller.

Neil Armstrong (2):
  dt-bindings: clk: g12a-clkc: add DSI Pixel clock bindings
  clk: meson: g12a: add MIPI DSI Host Pixel Clock

 drivers/clk/meson/g12a.c              | 72 +++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |  3 +-
 include/dt-bindings/clock/g12a-clkc.h |  2 +
 3 files changed, 76 insertions(+), 1 deletion(-)

-- 
2.25.1

