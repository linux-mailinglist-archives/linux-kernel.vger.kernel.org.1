Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624B02FCC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbhATIJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbhATIGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:06:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FBFC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:05:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 203so29512622ybz.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=byXc9pQI7vMYVbE49N9U/uHw5G1avW8TqGJiGbgNU14=;
        b=Fwx8k3030gn0USKf9qO1Eh5HsjG3PitR+SvtNXAARBRbqK1dbYZ0E21ItKu+wV8X5P
         10vEPiKx0dm8gtIlaN1XUyqLvN2zLcAJH3e5Xm4a0KHFNHhA2yZ/iUCHtxuEC68nZrJX
         /GgGYZ/6Nxa5Y3LPuuKPKOldR6fMjOTgFFV6KzMMUJAZ+Yt5MGP7OCUoTQbKrHvflmnr
         Aj1odJhDhnm63/c2hdGESokrhaL9VYxu7w4NHMfigxAzW5FLVHsdyfe3Fbfc0fX3UKEk
         5CAkvDF4+AmSUUwBaASJZts9OVrG6WOncmoHn+FelV6F6OgV/51LkSzopYOe3Pb2nlIV
         jLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=byXc9pQI7vMYVbE49N9U/uHw5G1avW8TqGJiGbgNU14=;
        b=QZwrZB8aT3X7BgO3vyF8piz0SGVIgsjlk3b9H0XEURApfZoHo8jJ0uoGtPmpn76qCb
         B7xPjv93ULBlDXXF8xIa0l5JHI/ae069JsSCRl7vIaJXf0cXjAY7nrbV3xxvyHr5IpBv
         bywLkVbR/q5w/JMUl0QpPiPIj0YBAC2ivYcqFAZhXN6vb0TTJ1HjopT9ISgi/R34t2G3
         eAVKACaU2klrdqv0P8CN6VgsNaoU1JbbWsBUtJD0W8SRzudn1Eq6PuaWhGYsbL+PlIkk
         pPR4PuTfJA3lesMZB6c+qcK/aJnl4lDpluk9dAyCFsdQVQMPAg0Wd9uQCxTlNYU2zFIj
         s8qg==
X-Gm-Message-State: AOAM5338u+1b86I0pY50oXW9t8gOSa7kzN4z3flHqYQ1+UwjOTamSMud
        ybmx27rYazg5rBtSBff4WLLUcX4QMCfUfGA=
X-Google-Smtp-Source: ABdhPJyvlDYBk408bidV2X60WKYG8MbXAvvDC1Be7kc6bCfpGeJDmIrGoyIDF0l5x2Hw1S7cMzr+rxE5EWY6LAM=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:45c3:: with SMTP id
 s186mr4746557yba.435.1611129925136; Wed, 20 Jan 2021 00:05:25 -0800 (PST)
Date:   Wed, 20 Jan 2021 00:05:19 -0800
Message-Id: <20210120080522.471120-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v1 0/2] of: property: Add fw_devlink support for more props
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series combines two patches [1] [2] that'd conflict.

Rob/Greg,

I think this should go into driver-core-next since Patch 1/2 fixes
issues caused by a patch in driver-core-next.

Patch 2/2 also touches the same locations. So, combining both into a
series.

Marc,

I'll add support for interrupt-map separately. It'll probably need to be
its own series because it'll need some refactor. I don't want to block
Patch 2/2 on that.

-Saravana

[1] - https://lore.kernel.org/lkml/20210115210159.3090203-1-saravanak@google.com/
[2] - https://lore.kernel.org/lkml/20201218210750.3455872-1-saravanak@google.com/

Individual -> Series:
Patch 1/2: Addressed Geert's gpio-hog problem with gpio[s] property
Patch 2/2: Switched to using of_irq_find_parent()

Saravana Kannan (2):
  of: property: Add fw_devlink support for "gpio" and "gpios" binding
  of: property: Add fw_devlink support for interrupts

 drivers/of/property.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

