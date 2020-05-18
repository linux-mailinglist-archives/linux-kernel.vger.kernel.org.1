Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E935E1D6EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 04:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgERCeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 22:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgERCeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:34:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88419C061A0C;
        Sun, 17 May 2020 19:34:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d22so6634594lfm.11;
        Sun, 17 May 2020 19:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RJIP0CQmzhZgZi7curoUhxtyDwhM7Gccf5L+02fqCt4=;
        b=GPMfBxuBBwkDGH07WQUV82WfnOHnZ1riGASfaG56/QtFxTjZboeHxdQTIpFFNNl5bg
         Bs9wi618SiRwIYBdYr73+8qX7GmNiBUOrnCO3+ztB6N40KxeuGSJ4OtAjjDPTuy5OOOY
         pxp9+6gFBhJoyNcPjU3LS/yzAJav+7T8I8uDeiLDzv7P3H6Ova7R58Y0Hej5aGUxJ6JZ
         JN7yCGVvt4Cy+vuzGcWXF3BBObINI3YQULKfGF19/KFvXDtxTmUwgM1ertv2ijh0hkFK
         7FKBjtEa78Y9VCJ5/HT6KSrZF83dwl2i+5IzD4c48f0MbtwxoxTDFJFZzyCVNzDTczuJ
         0nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RJIP0CQmzhZgZi7curoUhxtyDwhM7Gccf5L+02fqCt4=;
        b=ar2k010v6FdFI6v+aUhaLG0R/Yu1YTIxcSinKUUiOXA1LG+IZd0eQwTH1+zL6j1FgS
         c7MXaj+jhJyiW5Sex1CoNDJSfjpIFr4khrVFqDCKIg/CBU/hai7Im/l99TvKSdYug1qc
         /KKjeSM2wHNfyTqZKwTWf3VA9UbjAfSJ2VCeKo3VLQcv/E1G+U18/PAI2Hpdqs5Gpu/G
         F0o8AjrS81ZFZJNUA+MGp55f2Hu0Wj6I+tNef4JWXB768naGhtc7ujvFoYadUQd5L2HA
         Q5/idhzGvvtRP1OmdbA70RJkjCquHGvocwrOLkF5g5Oar/CxvuQbmI5/5HfjkMS45Hja
         xycQ==
X-Gm-Message-State: AOAM5327Cv1Sk6cDpzYsBNOkGu9K+Ln757nQfj+GmA5+2ICn/NjZntVc
        CGAt6b/JaKaIm49kn/mcgD4=
X-Google-Smtp-Source: ABdhPJyC+tzEUGGGFXi/i85Sz9gsnT2zFVj63FdZWioYtju4fNMBf7vye7YPay2X6xjyITXnMzZ6Sw==
X-Received: by 2002:ac2:4145:: with SMTP id c5mr10067638lfi.91.1589769248843;
        Sun, 17 May 2020 19:34:08 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id l25sm5937498lfh.71.2020.05.17.19.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 19:34:08 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 0/5] arm64: dts: meson: add W400 dtsi and GT-King/Pro devices
Date:   Mon, 18 May 2020 02:33:59 +0000
Message-Id: <20200518023404.15166-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series combines patch 2 from [1] which converts the existing Ugoos
AM6 device-tree to a common W400 dtsi and dts, and then reworks the
Beelink GT-King/GT-King Pro serries from [2] to use the dtsi, but this
time without the offending common audio dtsi approach. I've carried
forwards acks on bindings from Rob as these did not change.

v3 - amend author full-name on bindings patch

[1] https://patchwork.kernel.org/patch/11497105/
[2] https://patchwork.kernel.org/project/linux-amlogic/list/?series=273483

Christian Hewitt (5):
  arm64: dts: meson: convert ugoos-am6 to common w400 dtsi
  dt-bindings: arm: amlogic: add support for the Beelink GT-King
  arm64: dts: meson-g12b-gtking: add initial device-tree
  dt-bindings: arm: amlogic: add support for the Beelink GT-King Pro
  arm64: dts: meson-g12b-gtking-pro: add initial device-tree

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../dts/amlogic/meson-g12b-gtking-pro.dts     | 125 ++++++
 .../boot/dts/amlogic/meson-g12b-gtking.dts    | 145 ++++++
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts | 410 +----------------
 .../boot/dts/amlogic/meson-g12b-w400.dtsi     | 423 ++++++++++++++++++
 6 files changed, 698 insertions(+), 409 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi

-- 
2.17.1

