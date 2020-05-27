Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777BD1E384D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 07:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgE0Fg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 01:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgE0Fgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:36:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0A2C061A0F;
        Tue, 26 May 2020 22:36:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v63so11338553pfb.10;
        Tue, 26 May 2020 22:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e1I6YF+VJ57pEb1USvw1okp6yWunIg/IfHp9i2omTR0=;
        b=F0a8r1jZcLSsqVhoGtMU61xccI5tarnT5nhRMAICnfjsL9bASyXrz43UyQu0EWXlLz
         sno2Oo9jK1ypU2ZvQ3qFXqvp7EiVmqEwPGSeN3DRp4AGsbFitXFigM0rrCmVIZ0L45yg
         PVHtYchZ1Mukrux08wrh1QF/CXst5ayVSlTC7fchD0pXKxe+DLj3hEwuuAtz350u2ahU
         V8OOsBMuB+J6Rf5vlHZMkeBBj1L4EibLk9NnlpLsy1T0PA7NG+fF+ephdSRw45Ir0s0W
         /gBGl7TsRNriBmQc6UlYdz02TqZNKv0Lc8TwM1sUQbBnaALhYcb4BgqZQKqNcN8CRNqL
         S4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e1I6YF+VJ57pEb1USvw1okp6yWunIg/IfHp9i2omTR0=;
        b=ClAUsy3FZTw5gt6eTTDsUIwdtv+EpqlWzcMJocuE6aS9PkfbVR+BCLkiEnvsIlKafF
         1vcyRx95n8VUQ5uVG43fS04T5uOH9mWBTguN/nwpyD3N+jfsr/ClDWX2XI0WSxOWKyly
         pMNrH0+B93eGaTLIfXj19AqklTeHmGeYjJ2wrxg5MHdpjCpEkV5xl3+4wkMnix102HTQ
         2MsDQsNJTgwM8lSukfpJE+264tm6lSVFMKtXPXe/BGwN/5PRIBDyJ/PRZabyVogDRaBL
         /Y6EXLT4PANulu+6crR8craztl7uoub7sPx2oFMN3tOXfvj5GgiEXMqFfo9Ds2u0lT5V
         kWSw==
X-Gm-Message-State: AOAM532cJiWcqCHamc/fKj4AFz+hryr5pU0Uyl2yX67OIJicwxmmenHr
        z8MApigC6yZgAGZWyBMzCgU=
X-Google-Smtp-Source: ABdhPJzoMBCx1CJhWyfTUVqZ/X+/E5f1uED5yGsoIj9ZGhO45fOqKyN0oUFquW+/Aeyxuq5vfTwkIw==
X-Received: by 2002:a63:24a:: with SMTP id 71mr2475497pgc.184.1590557815341;
        Tue, 26 May 2020 22:36:55 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r34sm1092406pgl.38.2020.05.26.22.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 22:36:54 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH v2 0/4] add mipi_csi_xx gate clocks for SC9863A
Date:   Wed, 27 May 2020 13:36:34 +0800
Message-Id: <20200527053638.31439-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

mipi_csi_xx clocks are used by camera sensors. These clocks cannot be
accessed (even read) if their parent gate clock is disabled. So this
patchset also add a check to parent clocks when reading these gate
clocks which marked with the specific flag (SPRD_GATE_NON_AON).

changes from v1:
* added Rob's acked-by;

Chunyan Zhang (4):
  clk: sprd: check its parent status before reading gate clock
  dt-bindings: clk: sprd: add mipi_csi_xx clocks for SC9863A
  clk: sprd: add dt-bindings include for mipi_csi_xx clocks
  clk: sprd: add mipi_csi_xx gate clocks

 .../bindings/clock/sprd,sc9863a-clk.yaml      |  1 +
 drivers/clk/sprd/gate.c                       |  7 ++++
 drivers/clk/sprd/gate.h                       |  9 ++++++
 drivers/clk/sprd/sc9863a-clk.c                | 32 +++++++++++++++++++
 include/dt-bindings/clock/sprd,sc9863a-clk.h  |  5 +++
 5 files changed, 54 insertions(+)

-- 
2.20.1

