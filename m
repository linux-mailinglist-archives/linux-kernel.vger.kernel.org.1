Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC7D285622
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgJGBRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 21:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgJGBRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:17:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203CC0613D3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 18:17:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d6so368527pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X3yYB0EHwEWrP2fjO5tTxpwU3iz+XBA/J7IzQ9l34LE=;
        b=Cc/RyzcfY7N1uH0NrbyKcMJoNSDvgRmLb4ILDISwzb64iioQGhMAbv8YatwVFE5zTe
         YSPAEHwvKxwVGjzBtJwLpnk6FONK/g/XmKF9PFUQQzbEHTmxaYOvg/NUdmlUp22HkPaN
         UXh07oheL9NP+kgJGHxFmdJOE1fxhxkm1R10o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X3yYB0EHwEWrP2fjO5tTxpwU3iz+XBA/J7IzQ9l34LE=;
        b=bbCKzDk6GcZ96C5eFxSgWFh8aCl4tt/rnlCl3cVnfNeW2iu03FIW9Yqlrh9+My7xBx
         z9ri/jeLUz0Zz+uuE7KFC/m8TGEe0G80Q6SioNhjj5eslAmsYwiu0Ax8qQC7GEfonz2Y
         pcWcj6wRqQ7F5hn/01Qh3D3mxRLdjRaB36h+pEt+4hWd4AkK1V9Ez7URys42wKqDvDth
         CT7bt9FPJfbl2AIEWvIBnugKKe6yGsh/phmgazlDb6QaWF2LugT7QNV6fa+ZXjQKg7bJ
         KNnOqEMcWvxEhiOnLn0wUX9pqnL2Gm5UFQbp0DDbTdtQpnzqYIiSU7bFkCWda/m9RBht
         8PLA==
X-Gm-Message-State: AOAM530VCsVry2+PLMIoAFmlOuCaGVF24asIddrq738gWiescBfJfKw8
        uBHYzveJwfTpE/G+AWs+Jt9l3g==
X-Google-Smtp-Source: ABdhPJyvkMM+fdSw7224IGBytnYwurIh8nkJhXgkqu8xpRZgB6wh8w67m8cQWGmwY99Y4NZoYt97QQ==
X-Received: by 2002:a65:5a0d:: with SMTP id y13mr824246pgs.436.1602033457282;
        Tue, 06 Oct 2020 18:17:37 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z190sm482654pfc.89.2020.10.06.18.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 18:17:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 0/6] iio: sx9310: Support setting various settings
Date:   Tue,  6 Oct 2020 18:17:29 -0700
Message-Id: <20201007011735.1346994-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I need to configure various settings such as thresholds, gain factors,
etc. on this device. Some settings matter at boot, while others can wait
for userspace to configure things. This patch series adds support to
set these various bits in the registers of this device.

Changes from v2 (https://lore.kernel.org/r/20200930075728.2410327-1-swboyd@chromium.org)
 - Rolled in a fix from Gwendal on last patch to simplify if-else logic
 - Fixed binding and picked up Rob's reviewed-by tag

Changes from v1 (https://lore.kernel.org/r/20200903221828.3657250-1-swboyd@chromium.org)
 - A bunch more patches for userspace settings
 - Removed body thresholds as they're probably not used
 - Removed compensate common as it probably doesn't matter
 - Moved thresholds, gain factor, hysteresis, debounce to userspace

Stephen Boyd (6):
  iio: sx9310: Support hardware gain factor
  iio: sx9310: Support setting proximity thresholds
  iio: sx9310: Support setting hysteresis values
  iio: sx9310: Support setting debounce values
  dt-bindings: iio: sx9310: Add various settings as DT properties
  iio: sx9310: Set various settings from DT

 .../iio/proximity/semtech,sx9310.yaml         |  63 +++
 drivers/iio/proximity/sx9310.c                | 508 +++++++++++++++++-
 2 files changed, 565 insertions(+), 6 deletions(-)

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>

base-commit: 1bebdcb928eba880f3a119bacb8149216206958a
-- 
Sent by a computer, using git, on the internet

