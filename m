Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36E42DA507
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgLOApl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgLOApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:45:13 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440B0C061793;
        Mon, 14 Dec 2020 16:44:33 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u5so4621941qkf.0;
        Mon, 14 Dec 2020 16:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCxy4tLMQWYC9VVh3cCItDfMQ9M7vpTOjNyRTb5usTg=;
        b=ai3bipDiioymIZzmPss6ujwy0oGpxSpDsREQ1Abe+DwpIYjbPZCAdSciukQ38MvpW5
         G3Vf54WEEqnnmo5Z6++5lJ/UVvhV4CT4+HXDvCxjVIv4yk+OBbQcUpLJpzg3avNYMJRA
         ps1mwVu2nfW7DN/faWPWHbzKaSWdhthDh/CyTFrvtWcZPgbNbu4HMYj90ZVwih6deJK5
         jT2QQlQu0jkZCeEJaSKXMV3bOb+ccjEEMnkgEgXahMVZQXtW42+eiNLNiwhBRIvazVjH
         TZO4xSQIFfvv6bPGZEa9VHgCVlN7sfLnJrK75JyV7CF2WfsHpqpo81GAIixNAe2IBQwS
         YWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCxy4tLMQWYC9VVh3cCItDfMQ9M7vpTOjNyRTb5usTg=;
        b=NshXzcZJexW4BaqCDbNOu4Gmzzkgsh4G5aepOU6h38Fr6Gq916HjaPARUMk5rSz4DX
         gyhSInSdWnQSb65OSxAZcN7g9DI5fttsnxQwHNCJHJ7M5Pc0h+ttrcyj7ddkg9n6fYdM
         ObaK1dl0PSjzhKpnOE7mtmpmL+T8xnXOc8Qtx32+zpvj3GtbYcQMU4wl0nbaelMgXobA
         nscFNVWagoR/CA/4yK60cVOrdjDJ9MZNHmPYa0gu6Gp4MKCsdQP2nYvGSURfDvdnut6B
         dY+zO3TysRI+4tIys7k6oja5wPDUCZReLa+5AdXnEoV3D8olS87nrrjKFKJ+opfjrbgD
         GCDw==
X-Gm-Message-State: AOAM532M/oDZe/4IkBisMOZDR7j4K/AQgLmh9PG53w26wYgo/Bgh8FcW
        2BBqZ75Q20ZF9X3gB8IBYo4=
X-Google-Smtp-Source: ABdhPJzcSVAaBVu6JxUqc2+HquOtYsClaOF/npMB4CyHEtMTSeSExW7qVXZ1k9xJurFB7rzId3E9jg==
X-Received: by 2002:a05:620a:66d:: with SMTP id a13mr10028610qkh.5.1607993072363;
        Mon, 14 Dec 2020 16:44:32 -0800 (PST)
Received: from atris.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id e10sm14923039qte.48.2020.12.14.16.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 16:44:31 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/1] add support for the LMK04832
Date:   Mon, 14 Dec 2020 19:44:19 -0500
Message-Id: <20201215004420.11342-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Hi,

The LMK04832 is an ultra-high performance clock conditioner with JEDEC
JESD204B support and is also pin compatible with the LMK0482x family of
devices.

This driver adds minimal support to configure the LMK04832 clocks using
the clock framework.

At the moment, this doesn't fully support JESD204B subclass 1.
I'm working on adding proper SYSREF support and will update this series
as soon as it's ready.

At this stage, I was hoping for some general feedback on the work done
so far and advice on a few points:

 - Currently, nothing sets the VCO frequency. In a local version,
   I used a devicetree property and clk_set_rate(lmk->vco.clk, vco_rate).
   Should this be set using the parent_rate from inside the
   lmk04832_sclk_round_rate() and lmk04832_dclk_round_rate() functions.
   How would this affect VCO sub clocks?

 - Should round_rate error out when the calculated rate is too far from
   the desired rate? Other drivers don't seem to do that.

 - Since this is device is compatible with the LMK0482x family, should
   the driver be renamed to lmk048xx?

Thanks for your time,
Liam

Liam Beguin (1):
  clk: add initial support for the lmk04832

 .../devicetree/bindings/clock/ti,lmk04832.txt |   90 ++
 drivers/clk/Kconfig                           |    7 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-lmk04832.c                    | 1357 +++++++++++++++++
 4 files changed, 1455 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.txt
 create mode 100644 drivers/clk/clk-lmk04832.c


base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
-- 
2.27.0

