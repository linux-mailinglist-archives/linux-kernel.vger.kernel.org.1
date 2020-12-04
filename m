Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9421E2CE96A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgLDIUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgLDIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:20:45 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A670AC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:19:59 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so4440823wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFjKy1JMQGds6QCWv9HgfQo7basi56RFkixKbM89qBQ=;
        b=iLmFK7YliCdlWPtPemg20hSOC9+X0t97zFpxwojlugyjm5Ntx5rhE2aymcQjZFsI7A
         FcAkMDcv4bJ4q7Wv/C9JK60TLmp0sRkQFNE1k8Qk8lt2bSoIoKCak+UH5vbtlcXeBdRz
         m73MSfm60b/c4NPBoAaarCInCaV2yx1Wh1KIbMGbBprjxwQ89iAlXD+IAvlGY4vCFtql
         iMb/7WcIp3bpSXipN7GY2Ex9qkHJ2SXlMY51CpWW61OJbWOa1UcTNcSJ8TvaHl/2f07E
         q+lqbW/z1pxM8yXsNze2PxmqhbgYt/FAaYzbN5JslOIwNF1R+ghXS6L3AxwFYKxsAino
         2smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFjKy1JMQGds6QCWv9HgfQo7basi56RFkixKbM89qBQ=;
        b=pSi4/hKESQJkKR5s/AhRhSWGkWO2QdCXrl8FNXDW0kmk12tOB1tDAPkIMXztc+hZEo
         gdNwKWu1EwBj4xwADnL60xIPX+0SEfyX2tKRb2ENAxWGZR7xA2WFAr5w+fAlak0f9m78
         PwDoIf/j6FOHHWUPCegO5nZZ8guyKaUCBI1GXtjQeZLpYZ0z/a04dELQ8OnYIW63ToVa
         L5iQzKzOO1zKP3vO7A4fN08K7v1FMuhiz53I+caw0x+NrhwFawfu+P+QBNA2UMz8ry9d
         hxN56BwdBMyYP6M2NsH2p1ax3+z22fQjW517Q8OH2Tst3bxJIdeXaRg5YiDqp2VmZ4q9
         s01w==
X-Gm-Message-State: AOAM531vpESx3ICM1uE/KQiLYVp9aMYSHPAmDTPRi8KGG0Rgee4ryHVr
        TCaG7be9Lun1NxyLYNMqtTMe2w==
X-Google-Smtp-Source: ABdhPJykB+eU1y7MuAmsKGB/sLYnbS2V5dqlJBOTpU3F9+1gTVE8TYjBwDFd8NbGB5pAHfOHTslnWA==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr3477924wrw.130.1607069998193;
        Fri, 04 Dec 2020 00:19:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:296a:40d9:d5a0:bbc5])
        by smtp.gmail.com with ESMTPSA id b17sm1691156wrv.10.2020.12.04.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 00:19:57 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/2] drm: panel: add support for the Khadas TS050 panel
Date:   Fri,  4 Dec 2020 09:19:47 +0100
Message-Id: <20201204081949.38418-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add support & bindings for the Khadas TS050 1080x1920 5" LCD DSI panel designed
to work with the Khadas Edge-V, Captain, VIM3 and VIM3L Single Board Computers.
It provides a MIPI DSI interface to the host, a built-in LED backlight
and touch controller.

Changes since v1:
- removed drm_print include
- added reset_gpio to 1 after prepare failure
- now ignore regulator_disable() on prepare failure
- mark prepared=false whatever the result of the unprepare function errors
- also reset_gpio to 1 on unprepare
- do not return on mipi_dsi_dcs_enter_sleep_mode error on unprepare
- mark enabled=true unconditionnally
- use dev_err_probe in probe()

Neil Armstrong (2):
  dt-bindings: panel-simple-dsi: add Khadas TS050 panel bindings
  drm: panel: add Khadas TS050 panel driver

 .../display/panel/panel-simple-dsi.yaml       |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-khadas-ts050.c    | 866 ++++++++++++++++++
 4 files changed, 880 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-khadas-ts050.c

-- 
2.25.1

