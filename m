Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8EE2D6B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbgLJW7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 17:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731469AbgLJW7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:59:24 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DD9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 14:58:44 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id bj5so3590839plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 14:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OPHWOK5WAgwd+yrAYdQC/rR2GLSlVzPXGosqBcdq/4=;
        b=h2xeoXNt7wtbkMacHS4as8YKxrtSBe3DrCz+Xu+0lPMXNtCPTclId3JVhMZDwgOItT
         kCZkL0LyTkHoNRXihiopanIijhbduiOGTCTCRVAvNbMlZeRjOwBIMkJmeozlVH4STE4p
         JBz0xc36zpxXa1ioOGykM0m1ao8yonzfYACCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OPHWOK5WAgwd+yrAYdQC/rR2GLSlVzPXGosqBcdq/4=;
        b=YmNOWQy8QlLtm1tNTDOk6O3kZpJ5tK3X0wJNETLVXZiwCFHW6LF0uBSd/hdlBZ//gq
         N00Eh3fpZ1mnuP7whQZU145GXmBt0R0JFsD17m4XzToxZs7AlIN1IJ9wquIZCydO0W1P
         nhkdJHjQXarXbRTQl+6CYAEgDvgCQlnPbDXYmSFT4OiUdqx5XvLhiB6AsPT2NAyBYyjn
         HAXsFAP/qFdQY3pK1EaHBiwybip4Fik4rWIOShvlgvyVTL0vS7UbUqqz1aO7ifLcjVbr
         vC39P+IpAc48N9SW8qq+uENcdBMJCb+xe8h4iQbD8P8xBHfluZVqKDTDlc+QBlKuFap/
         +WWg==
X-Gm-Message-State: AOAM530TK/V2wJgNr5wmT1NCTJUXLPciqpfw3QzYgI9ouSU91aeWvNhb
        xf1xq/LKJ4Fx8kRLUpsMM2xPWQ==
X-Google-Smtp-Source: ABdhPJzeALKEO27XgdOtrXGiYotJyJRdtIKe9a3aceFlFDbSGaGB/Zwkf+gRozrESWuyZBenPgn0YQ==
X-Received: by 2002:a17:902:8341:b029:d8:d123:2297 with SMTP id z1-20020a1709028341b02900d8d1232297mr8319123pln.65.1607641124011;
        Thu, 10 Dec 2020 14:58:44 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id k9sm7554157pjj.8.2020.12.10.14.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 14:58:43 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/2] platform: chrome: Simplify interrupt path
Date:   Thu, 10 Dec 2020 14:58:37 -0800
Message-Id: <20201210225839.1212462-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Irrespective of the transport (i2c, spi, ish, rpmsg), have all cros ec
interrupt stack call the threaded part (bottom half) of the interrupt
handler.
Fix an issue where EC could be stuck if it sends a message while the AP
is not powered on.

Gwendal Grignou (2):
  platform: cros_ec: Call interrupt bottom half in ISH or RPMSG mode
  platform: cros_ec: Call interrupt bottom half at probe time

 drivers/platform/chrome/cros_ec.c           | 33 +++++++++++++++++----
 drivers/platform/chrome/cros_ec_ishtp.c     |  6 +---
 drivers/platform/chrome/cros_ec_rpmsg.c     |  6 +---
 include/linux/platform_data/cros_ec_proto.h |  3 +-
 4 files changed, 31 insertions(+), 17 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

