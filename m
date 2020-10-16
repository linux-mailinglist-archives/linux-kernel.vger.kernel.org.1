Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2050F290DAC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391541AbgJPWZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390264AbgJPWZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:25:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5E2C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:25:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p11so2007114pld.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4eqbUws5OBh+zSDmGIZGynXeE/GCKmhJYh2f9F/2s8=;
        b=mr2aRkQ7R0v0EkIi2XrrSQ0gbLANCLdkIL0QK3vPOvbnnI/MOHnvr1tdUqfWi51/Ap
         2FvYtH6EZyB0SnEV78PJp7ij10yoYf6ovtlU+ijVeeVmTxaDtza0F3WqMQ34DsSbxezx
         2U8PEpiH9RvQJu+V/Wgi4GquMla0kntl4RLZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4eqbUws5OBh+zSDmGIZGynXeE/GCKmhJYh2f9F/2s8=;
        b=Wn6Fft3bpVX0FToU34oZTYVhaawa9Eo2ls1NQbAYmTDxV9vXw2t2GqTpS/f6D0Qk/E
         2+ngujqX2cdwrrXpFxkHtkQMeQatTxEmLUg5PCp09fbtUQq6eiiFSAj+nj51VEAqsNKq
         Topw3WR2aWoGi+fhB6o2iP8iHR5+0Uz2FsECxsCGwVEFrV8uYg+4BKgVJ2EHbjipl7An
         tO/CHaks4C9jUroy6BSj8vQWOjiMmTuoBR1KfmxwhxoXKK8qZ2NVNLlVNOSVlXzzoelF
         LlE74WOi2ZQmu+2UrkUXDuQn1IFUzOn3FfWsTHxKicLvYYV7SubiQcZ6iLu0+u+oz8OE
         D90Q==
X-Gm-Message-State: AOAM532s7EmGx3DyPpphdhnFyQJhG67TLaGLp+E3nEZEqc/97Aoh/8Q/
        q18m4Fc9egpeedWorCL7IA09bw==
X-Google-Smtp-Source: ABdhPJxAKtghLb3UyyudbSNcwHrz2ZMGGBl+4IjwkyNwhpexwbID8QZbyf3tMdH6HyUVJMdZKodKRg==
X-Received: by 2002:a17:902:930c:b029:d3:b362:7939 with SMTP id bc12-20020a170902930cb02900d3b3627939mr6414396plb.54.1602887127549;
        Fri, 16 Oct 2020 15:25:27 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:a2ce:c8ff:fec4:54a3])
        by smtp.gmail.com with ESMTPSA id t10sm4099304pjr.37.2020.10.16.15.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Oct 2020 15:25:27 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Evan Green <evgreen@chromium.org>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] i2c: i2c-mux-gpio: Enable this driver in ACPI land
Date:   Fri, 16 Oct 2020 15:25:21 -0700
Message-Id: <20201016222523.364218-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-mux-gpio driver is a handy driver to have in your bag of tricks,
but it currently only works with DT-based firmware. Enable this driver
on ACPI platforms as well.

The first patch is a little dinky. Peter, if it turns out you'd rather
just take this all as a single patch, feel free to squash the first
patch into the second. Or I can resend a squashed patch if needed.

Changes in v3:
 - Introduced minor &pdev->dev to dev refactor (Peter)
 - Update commit message again (Peter)
 - Added missing \n (Peter)
 - adr64 overflow check (Peter)
 - Don't initialize child (Peter)
 - Limit scope of dev_handle (Peter)

Changes in v2:
 - Make it compile properly when !CONFIG_ACPI (Randy)
 - Update commit message regarding i2c-parent (Peter)

Evan Green (2):
  i2c: i2c-mux-gpio: Factor out pdev->dev in _probe_dt()
  i2c: i2c-mux-gpio: Enable this driver in ACPI land

 drivers/i2c/muxes/i2c-mux-gpio.c | 112 ++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 30 deletions(-)

-- 
2.26.2

