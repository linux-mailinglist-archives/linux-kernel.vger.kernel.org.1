Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B926A5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgIOMz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgIOMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:46:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16AEC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:45:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so3151193wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUcUK8YA7xOYjNtjzxXPOPtmn9lpMNim28eyU9a7Hf4=;
        b=vnq12OZ8h+snAbmU97iIZz1Xs6BZApGeIO+pwz8ITYX8upAHSJfhj4ZI+YsVyDfd3t
         78y7H0Qi1P0lHHPn/CMTUbHSCT1uascuXBTiCv+E1xPSeRrOLgGltLj1G9V2aCXe8soZ
         /rNy2cpnLf6NjM5HZfoEp54Ra+pSLk/xaQvI6aGFFTpiwoBX3WiFVcw7b/AAwE78Xsjh
         JseJEkm65hME+gZKqdhLAeKhGN8A+PinC+RGE6WtYds9wZvUIt8Z9LHJf5VBdPGC6Wrm
         hxRF54lld9/K/YjwTC6ECTGJvis46Zk8sfS9pyyTNUJPFZFwIrgex+ljhrkhshLnEjKB
         6OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUcUK8YA7xOYjNtjzxXPOPtmn9lpMNim28eyU9a7Hf4=;
        b=t/r3YB6VpFkfOjvCKPEoTGs4Ll8up+2Yx6h8usXgEYfxZmNSZQbREfzw5OmruPr7Eb
         Xzyyrvuvy4NMz6RVYKbFar5HZ3ulBOIW1leK2OP6VzJBjmN3vTKgm782Wm+gcSZhU9ca
         xFzbQ9aXSYieRMcP6CDKeA1+Ci1I4MlwPAF6/kciJMGHkKnrSsrOpKqmXfRALcn2Ypno
         3+aRTwkztA5ZvHljbw9TD9s3I49Bv0AwBj0kAmLzavPdN4kh1HP8bBTIau8+v85GR7lX
         o4E0fwVTkEY8b2gQ/DV90P9EK2P7Zimwf938g7wk3LO/8bem++X8DXj1Wbc0pzJTRjFp
         eY3g==
X-Gm-Message-State: AOAM531Oza/ipe/U8rgYJfKdubclVHAB/EL6lg86YxqOAMYx+297S/5I
        UhbsoomHvDd3KUT99W5eL/ueyrmnytLxd40N
X-Google-Smtp-Source: ABdhPJxwMlDEHZh9fctKaT98W85S9FRLO1xXWLr+E4hFyfBsptLyDwy8SoxnjHKzdeZGkqN83g5/CA==
X-Received: by 2002:a5d:40c7:: with SMTP id b7mr21519638wrq.300.1600173956444;
        Tue, 15 Sep 2020 05:45:56 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id q8sm26548589wrx.79.2020.09.15.05.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 05:45:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/4] clk: meson: axg: add clocks for MIPI-DSI support
Date:   Tue, 15 Sep 2020 14:45:49 +0200
Message-Id: <20200915124553.8056-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the VPU & VAPB clocks along the MIPI DSI Host clock.

The clock scheme is based on the GXBB & G12A VPU clocks, with a different CTS
clock output used for MIPI-DSI.

Changes since v1 at [1]:
- update patch 3 commit message to reflect drm driver state
- added comments in patch 3 for clock specificities
- removed useless parents comments in patch 2
- fixed bad flags in patch 4
- removed holes in axg_vdin_meas_parent_data in patch 4

[1] https://lkml.kernel.org/r/20200907093810.6585-1-narmstrong@baylibre.com

Neil Armstrong (4):
  dt-bindings: clk: axg-clkc: add Video Clocks
  dt-bindings: clk: axg-clkc: add MIPI DSI Host clock binding
  clk: meson: axg: add Video Clocks
  clk: meson: axg: add MIPI DSI Host clock

 drivers/clk/meson/axg.c              | 819 +++++++++++++++++++++++++++
 drivers/clk/meson/axg.h              |  23 +-
 include/dt-bindings/clock/axg-clkc.h |  25 +
 3 files changed, 866 insertions(+), 1 deletion(-)

-- 
2.22.0

