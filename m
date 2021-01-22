Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6592FFC57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbhAVFrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbhAVFr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:47:29 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08DEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:46:49 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i7so2954283pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVDNBKzWbPYiMsCNbvCHJ2UjAPDB55l9YQZXJthpoYY=;
        b=LhVWIKFljefuM8VG9uaIucwjYZmU6JRglTw4huFU7/L0t/iRU+WtGCa4G0CrARFWoX
         g6PNRrZLWD4JzLQmGEAvFdmJwQSNCu3IU7ZD5gssI5c1YQOw/gIjWTVYS/KPDR8ev9wX
         6fZE4Bzez+wNADB5UU6J4G/PxURJzyV2ZV9Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVDNBKzWbPYiMsCNbvCHJ2UjAPDB55l9YQZXJthpoYY=;
        b=b0wxJMGeZwPgwvr+Rep79Mvrg65cktYB/sZ9uS/Di+aNcSmVHrkK+c9ilrW7EM330C
         eBQ0FVNLLDiKV3YAq1PCtP6LvAUl6qAcG+qb7oaZGqyafrAOb2kxoGyM4Gl6M5hWZbMc
         ZvxbncKXsrkSVTpIctZVyBqJKzE0JEXL9VlWvGFEhog9e1NbKVzS4aa6F3u0H/lgj82P
         6UXiCr/QU2rlubW9wwTX3v5kzz6xqLb4Cfk5VZ+RcaOsmu4N8farZy1yNSms7ZKD9cdB
         YRJFR7vCQg0p/tsNkAgoQ+PkAkZgWDoCpPF62lEwdIK1XdbekBGyxU5sLwMI936iW6X+
         +M3A==
X-Gm-Message-State: AOAM531xHSJNmPCHTm3hKSSBHj2ydH+Tkb+opvwLcZUPUwsEhc1YkEUE
        mglw1o3dsfnMA+4kpSFhqrvaGw==
X-Google-Smtp-Source: ABdhPJwmsuyg6/1bTKB/B0N2B21Yu33lg828MZMh/ET+rUM+/rE96IFJlV2oz6LvhsOMM614Pqf4RQ==
X-Received: by 2002:a62:37c2:0:b029:1bd:59ad:c4e5 with SMTP id e185-20020a6237c20000b02901bd59adc4e5mr2048423pfa.66.1611294409206;
        Thu, 21 Jan 2021 21:46:49 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id o1sm7241124pgq.1.2021.01.21.21.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 21:46:48 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     rdunlap@infradead.org, groeck@chromium.org,
        enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 0/2] platform: chrome: Simplify interrupt path
Date:   Thu, 21 Jan 2021 21:46:35 -0800
Message-Id: <20210122054637.1422289-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rrespective of the transport (i2c, spi, ish, rpmsg), have all cros ec
interrupt stack call the threaded part (bottom half) of the interrupt
handler.
Fix an issue where EC could be stuck if it sends a message while the AP
is not powered on.

Changes since v1:
- fix merging issue and function comments syntax.

Gwendal Grignou (2):
  platform: cros_ec: Call interrupt bottom half in ISH or RPMSG mode
  platform: cros_ec: Call interrupt bottom half at probe time

 drivers/platform/chrome/cros_ec.c       | 33 ++++++++++++++++++++-----
 drivers/platform/chrome/cros_ec.h       |  4 ++-
 drivers/platform/chrome/cros_ec_ishtp.c |  6 +----
 drivers/platform/chrome/cros_ec_rpmsg.c |  6 +----
 4 files changed, 32 insertions(+), 17 deletions(-)

-- 
2.30.0.280.ga3ce27912f-goog

