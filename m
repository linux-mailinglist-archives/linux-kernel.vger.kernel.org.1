Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44252A9C8C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgKFSlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgKFSlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:41:15 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1DBC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:41:15 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f38so1619734pgm.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDCAM3XXJ/HqS+XVohaVZpsIAUFDZRh6b3WrbFuDG9U=;
        b=fFFla20VJR/kGP9WOCjXrl2YTtaAKL0pypx0TCbvLLuwisjKD7azcqfEP6esytHrPT
         ZhIi+A/5Tl+B755MlTRP9B6xUmAaybjazvH20Eaib1iOIGiRAJUh8LNjd7wWsXT8R1SG
         somhWUx6M/pq/EbjlMdx3JUkCk3neMgJDotC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDCAM3XXJ/HqS+XVohaVZpsIAUFDZRh6b3WrbFuDG9U=;
        b=K9fCTzon5uwOCj8b/uBwN9zjzuNj6bzv+3Iye3Rvs8kxug9rpVjNlN6DIBYIm/qe5t
         jjZErCv8QDJ9IGzbf1bFScCctK6dXFBTND00PyqnwOiSR+YG5cAriKTxwdz7W0rh9X8r
         gSNZ/QYshftS63MsVF3OxauuYqSThT7YDWDZlI7izfw7hhub1f8yD8OpJgndo0z2ru7I
         URFcXkTCjc9Y6QeNfQPjcOhvGeFxJtp3P5hCV98lK5yJcCy8CjiDt+gS4qysSu4+y/1b
         bEl9fgSuPaUU6hxYRbVssUWxsVOnoD0WaXZE27QQJfHlLfXf8zpYhegP+HrbWMcaFrot
         JHJA==
X-Gm-Message-State: AOAM530/OdMcrzDPgVhDl5SAXRoGIOQ9TkN8F65I8UTO7BJNK4or+asm
        heiYWCs8NVZRqU/UNq44jBIzx6YmtvV/2w==
X-Google-Smtp-Source: ABdhPJy4TU6PlLg261yhikfs03Bl03a33QLqBDzlxcnuY3UDTN4lEkK0ah72fLRDjXly1XBAW49Dvw==
X-Received: by 2002:a17:90b:316:: with SMTP id ay22mr1001591pjb.8.1604688074447;
        Fri, 06 Nov 2020 10:41:14 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id b6sm3246143pjq.42.2020.11.06.10.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:41:13 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 0/6] platform/chrome: cros_ec_typec: Add cable
Date:   Fri,  6 Nov 2020 10:40:57 -0800
Message-Id: <20201106184104.939284-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series adds Type C cable registration to the cros-ec-typec
port driver using the Type C connector class framework. The first few
patches perform a few minor re-organizations to prepare for the cable
registration patch.

The last couple of CLs update the USB PD VDO header file to add a
captive cable connector for the Type C cable plug field, and then use
the added macro to add the corresponding field of the Type C cable
descriptor in the cros-ec-typec driver.

v1:
https://lore.kernel.org/lkml/20201106012758.525472-1-pmalani@chromium.org/

Changes since v2:
- Changed local variable uint32_t to u32 in patch 6/6.

Prashant Malani (6):
  platform/chrome: cros_ec_typec: Make disc_done flag partner-only
  platform/chrome: cros_ec_typec: Factor out PD identity parsing
  platform/chrome: cros_ec_typec: Rename discovery struct
  platform/chrome: cros_ec_typec: Register cable
  usb: pd: Add captive Type C cable type
  platform/chrome: cros_ec_typec: Store cable plug type

 drivers/platform/chrome/cros_ec_typec.c | 148 +++++++++++++++++++-----
 include/linux/usb/pd_vdo.h              |   4 +-
 2 files changed, 123 insertions(+), 29 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

