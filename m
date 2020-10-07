Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F24285C65
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgJGKGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgJGKGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:06:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F18C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 03:06:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w5so1444795wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=njbWkdetKP4MxyBSpq/xPTQPrk5CDcrt7ND0CLIln7A=;
        b=TMFJPn4EqOHnkD+TYqxrD4l3/aMVgKQJxuMBZ2/xK+cOx7suIZxnpfZqDS/VPxlNrT
         UBADm87uL6bpvB9LNJzRlxZGfYNqQ5jj5/lHb3NxO3zDmWkZkbESZEkp8Hpi6Y03eKra
         8mrg8EqQd1M07k+DK6eai5QwJoagEu6W2drF+2p1QaujF3Oozp5hfgyPjLohzZSQ4Ncv
         6uYNLFwWlZUqk8HiUfWPJbHSt8gA/Ae42+u1q/40S2v8dK1BgOlse21W0coRCYsZzX9Y
         oB9Z/1QeTQd25DobuYBEdJuIOCweZr6ZnVZ4athoWpOBGQ+GhqrMWE0R9rviam3MXcmk
         o0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=njbWkdetKP4MxyBSpq/xPTQPrk5CDcrt7ND0CLIln7A=;
        b=UjvgcpMqSBNkz0KkgW4V3/Kj2DmqbtlorlC1ssMMBzDWTHSFlYOdJlGTjfiWwkZVcr
         n2Cw3kL5BU6petAJi2kS7NEYJCUVQe90ex3cy87QUSg7VTnjgFqxagn264TAA2KWB2p8
         wkxaec6xNVNwmulN8ENGjSgEohPGp3wg1VC7qsfRFi0Tmoe0dVz6l5aQG1/+M07Wzxga
         PP7YQ3SSCaN41JWBUtjURX+PBuAXu6Ek+8A/D9ZO6opLmKxDsEewD1JNYWtumRaT70CF
         7QbK0Fabn3HfLQsnR36UHQDLGNCcVHmQLpq5x0+uSDB8pYHtfSWo0lmGF1LppdwVOnNR
         1I6Q==
X-Gm-Message-State: AOAM533+z+jD3sSy9XSHRmbpLG8rmZtSbON02EfTgZcv0jQiNHuPTHz/
        z3i4rwkAiQ2qwENO9wU3fB/AOg==
X-Google-Smtp-Source: ABdhPJy1fVxznG2JVnEmKvCX6YPeXlFAy5/rOnU4Kc0Udkn5RJhC4VodgA+iFONbGOIu6nirCEGkBw==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr2852791wrr.57.1602065194303;
        Wed, 07 Oct 2020 03:06:34 -0700 (PDT)
Received: from bojack.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h16sm2214981wre.87.2020.10.07.03.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 03:06:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] arm64: dts: meson-axg-s400: enable PCIe
Date:   Wed,  7 Oct 2020 12:06:29 +0200
Message-Id: <20201007100631.192348-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the nodes for the :
- AXG PCIe PHY, using the shared analog PCIe/MIPI DSI PHY
- 2x AXG PCIe controllers

And enables the PCIe M.2 Key E slots on the S400 board.

Dependencies:
- Patch 1: Analog PCIe/MIPI DSI PHY update [1] MIPI-DSI nodes [2]
- Patch 2: None

[1] https://lkml.kernel.org/r/20200915130339.11079-1-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/20200907083300.14412-3-narmstrong@baylibre.com

Neil Armstrong (2):
  arm64: dts: meson-axg: add PCIe nodes
  arm64: dts: meson-axg-s400: enable PCIe M.2 Key E slots

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 10 +++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 61 +++++++++++++++++++
 2 files changed, 71 insertions(+)

-- 
2.25.1

