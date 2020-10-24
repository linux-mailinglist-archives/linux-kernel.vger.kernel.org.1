Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E6A297D4F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762052AbgJXQVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759673AbgJXQVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:21:05 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA48C0613CE;
        Sat, 24 Oct 2020 09:21:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u19so5633321ion.3;
        Sat, 24 Oct 2020 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wWyoxZmi/FlddChHaymi/wsISdG3xKHaSJYRVIR+21M=;
        b=OOgIiGspFu3YlBbS5yWxJliGdHnmhk8lftt7KiwgBzj7G9muXYCrBKAKCu62y2wqsC
         51b91HC/e87lVcs4RxkShomCG01WboHsSbKEON04tE27o8Ba1vaISbuZhq0+II2K5bpD
         hW9wyLhc145LEcTtCujCf2qmKFJkXJ0T8pWGIUtfipTjcGY+ByZLNjl1uWc4do72eWKw
         QJ4/9wi70kYSqqvxtKxwuro+kl9ZFnXrW8n9gQNbauX3+BWJC0RePQS7CxJ9E27FLKun
         EzYtEDlo3jwvrWiLtbxRH10qVsvGhB/YYUKbN7npjnXnIfbZoMAsQyfxBZDthTquus5a
         rebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wWyoxZmi/FlddChHaymi/wsISdG3xKHaSJYRVIR+21M=;
        b=m5Ny2bYGKiJJT1zWW25sNoybx7MkyYpGJtSEUrkMfFYpflGf6V9vTU17BuWu3uxSXv
         n+L5FvBK7m9RKqEEzqGz9Q5BtPxmF2UrgCEvoyVBC8MjoO85Lm612rlRZMd232V9oFqb
         HAlNL+m4dWFf4elAGYZ2NF+1Sozzv9ujBJxcTQAhb5rCi08/Al1wmez5gWyuwW83xZ5A
         f1i+7GSgBwdUYj8cmYI3TNMWMQywu2Gsa1+HaWyacyOKIRjrjyjsGHbl/1bb/MVUTEb+
         EJr2aftjQxgvsIMpdqthiSQJ2vGR6olOj79R6yd9I2p4JUx5HpWKLRXPvu4wDZpM5k23
         dnDA==
X-Gm-Message-State: AOAM533OBtEPQJ13MRG7LIPEHLsLGSC7r9Ld9JyqIBrlyFDjT2ygwDzH
        dsejKsukcbsOPInQOl1lGg5R0/n0ALRsGw==
X-Google-Smtp-Source: ABdhPJy5vSVk245QpNXf7RaLmv6F5K7Kl+sAaWeAiizjOhoV1VZNhzyZ6ax/2ciA7WWEmw6FfK7GzA==
X-Received: by 2002:a5d:904d:: with SMTP id v13mr5362225ioq.116.1603556464730;
        Sat, 24 Oct 2020 09:21:04 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:527:767:b750:2d3c])
        by smtp.gmail.com with ESMTPSA id m86sm3028587ilb.44.2020.10.24.09.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 09:21:03 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     abel.vesa@nxp.com, marex@denx.de, Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [RFC 0/3] clk: imx: Implement blk-ctl driver for i.MX8MN
Date:   Sat, 24 Oct 2020 11:20:12 -0500
Message-Id: <20201024162016.1003041-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some less-documented registers which control clocks and 
resets for the multimedia block which controls the LCDIF, ISI, MIPI 
CSI, and MIPI DSI.

The i.Mx8M Nano appears to have a subset of the i.MX8MP registers with
a couple shared registers with the i.MX8MM.  This series builds on the
series that have been submitted for both of those other two platforms.

This is an RFC because when enabling the corresponding DTS node, the 
system freezes on power on.  There are a couple of clocks that don't
correspond to either the imx8mp nor the imx8mm, so I might have something
wrong, and I was hoping for some constructive feedback in order to get
the imx8m Nano to a similar point of the Mini and Plus.

Adam Ford (3):
  dt-bindings: clock: imx8mn: Add media blk_ctl clock IDs
  dt-bindings: reset: imx8mn: Add media blk_ctl reset IDs
  clk: imx: Add blk-ctl driver for i.MX8MN

 drivers/clk/imx/clk-blk-ctl-imx8mn.c     | 80 ++++++++++++++++++++++++
 include/dt-bindings/clock/imx8mn-clock.h | 11 ++++
 include/dt-bindings/reset/imx8mn-reset.h | 22 +++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/clk/imx/clk-blk-ctl-imx8mn.c
 create mode 100644 include/dt-bindings/reset/imx8mn-reset.h

-- 
2.25.1

