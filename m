Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE12E77C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgL3KiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL3KiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:38:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD8CC061799;
        Wed, 30 Dec 2020 02:37:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r7so17065907wrc.5;
        Wed, 30 Dec 2020 02:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lB2jyYvwAFJqgVsiDcs5q586quNuRit4RsqbIhvpDwc=;
        b=t8D2NXMib2OLbtiEq5l5ecValyii3h7bqMz+EpQVrCxtRdc+mKf4ZdiWmkUYabnrfq
         QDfC60lxCZ+4sUmp2K4b1waHjxiDnq+CJCjV929wEbbDLkrbQ/K3JnRW9ZTUmzvaX1Yx
         0Eh80JlyEikRcwuo0kk7EaHMp4pvjNx4W4mDjts3rDu5OBy62WCYDStcM/rqHy45fwuR
         8DokrqVFRH4IPlCdjNdnnAvlAhfHwIzBe/ict0mXJuJ3Zq3s5Ezg8UlmFl86okqGtVMB
         b50Zjlvsv1RrlMLZe0kJ6J2BzT2iudLqIOPwkVXyTWZziRltj11Lf7QNAIRwnAdQBJOV
         zTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lB2jyYvwAFJqgVsiDcs5q586quNuRit4RsqbIhvpDwc=;
        b=F1yQWIAcIKkdgr4Wp0kMap3+z/BB6cN8Wzgs2gYmzTbjVvHrPpo9M8vfW70zM4/wYc
         2SmLsmhukHoZMZKgRYdEGQ5vivGcVWuehG4kzL7cSXVHV4QSWaN63KpXK/8BDgjZrVz/
         EXl9Eyam/iZD+QPlJoly1h0RizAAuXuMEyBXHFY+10nh2qBNfMUGjOGeWTnNFffCI2AQ
         6zaOnH3rnSnnO0z6yDaf66F8wXuU/xyAR/iSTgSHNpXJPYz44aV/m2NnvKKMyKK8ZYpv
         xFECDA26b4mCyJd/MWeg7Xi6TWIL5uWDQKTHyBMKqUCNqHOgWP7LqumpUtixhPXUP3SI
         MO9g==
X-Gm-Message-State: AOAM530xE/j48NkivNDGNGrXXlokTbUEkPRn86oZIdKxx4lKjWzxLAEd
        RtyfRpp+dEuvflwaKm7EpBI=
X-Google-Smtp-Source: ABdhPJzLX1NguQsuiZgg15MM5WznDUrE9WmYBn+8YF63U9dYWpUYEV9el75+TDC2/A3CUHqLMEqmsg==
X-Received: by 2002:adf:f6c9:: with SMTP id y9mr60289027wrp.121.1609324653781;
        Wed, 30 Dec 2020 02:37:33 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j15sm66672156wrr.85.2020.12.30.02.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 02:37:32 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/2] arm64: dts: meson: add support for Beelink GS-King-X
Date:   Wed, 30 Dec 2020 10:37:27 +0000
Message-Id: <20201230103729.2272-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds bindings and device-tree for the Beelink (AZW) GS-King-X,
which like GT-King and GT-King Pro is based on the W400 reference design.

Changes since v1:
- move audio from TDM_B to TDM_A
- drop S/PDIF content
- add Rob's bindings ack

Christian Hewitt (2):
  dt-bindings: arm: amlogic: add support for the Beelink GS-King-X
  arm64: dts: meson: add initial Beelink GS-King-X device-tree

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-g12b-gsking-x.dts  | 133 ++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts

-- 
2.17.1

