Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0AE2C0DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgKWOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgKWOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:34:06 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39192C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:34:04 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p19so35181wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2X6f3r1AMyTvYQnEJG6RFCLQoqcoeXFdGnWiV9Q2OU=;
        b=vHBonhWeMJX1FhFSTdnnEBfkcXDYw8w95Oaan/JooqYoJbfso1Fh/08+/F304VHmWM
         QHlFzAY9nnvB1bfoWBmf+4X+8W5z7vq2e6kPY8eKYC+IhqOnqx3x3j/C19t1W8ZGOWl+
         N4IxOOH+uaNUzon86w96/0mRf0QxuDMShM5wloWRKuZ4O01dOqIMcxbOYWCth5/CNRjD
         x6M4TWL1JhYTtGxsQtI1k2WuUek72lFJ0MKuJ00ciDV4Geo+zqvt9SgFYk5UbtsXcUUL
         lpKJiV5bTv64XCnW4v0q5Xm3gkU+AxbnsjIpp4dO9UD3uuQd2eITPMxTffPf3xCeF/ML
         Q0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2X6f3r1AMyTvYQnEJG6RFCLQoqcoeXFdGnWiV9Q2OU=;
        b=tleobCc66dz/r4dnbjofRrXvSdADj0qh78J4aQV28NfP38CWP4RJW0+XFCZr8/4DXi
         /iB3BfM6dV15kWQb8FIhTmubMloqts3R5BO4AUol7gMhi79Xcjj+g/4Jse+3pOHCkDAr
         +eCuc+JP8z12fSgsf3k5JWmmr0yunBd1ScjTzD4duQy51p9qm5+xf2tXG5dAkOn5pvJM
         z813MH9lXvK7yq1nb/FFUIAehmXIy8F3K8VBVZADXadDSf7onoVbxluZYLoO7ud/Xw9N
         PgsBSPmOmN8qXxeEtc4ysp+auoppm4jdbp3NkJm818fmyEyfYjWZ6HV59L91AyedBECI
         iM5A==
X-Gm-Message-State: AOAM532gI/x2VfTRVgXfWx4eqMxrbNdepmfbVnKn6ZdHHsv7O0+KPfDj
        XyCL1wiCrfFknAGHxZrrNnEyqA==
X-Google-Smtp-Source: ABdhPJyUmHHMKYCP4p/pZ9GX8zG9POVf/kx/9r5H9YZNAat7k4/el+eIzoYqsYebJWQxU1Je/ZZp1Q==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr25595586wma.151.1606142042781;
        Mon, 23 Nov 2020 06:34:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:9541:d2fd:3a68:67ae])
        by smtp.gmail.com with ESMTPSA id h2sm18126723wme.45.2020.11.23.06.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 06:34:02 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] drm: panel: add support for the Khadas TS050 panel
Date:   Mon, 23 Nov 2020 15:33:52 +0100
Message-Id: <20201123143354.295844-1-narmstrong@baylibre.com>
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

Neil Armstrong (2):
  dt-bindings: panel-simple-dsi: add Khadas TS050 panel bindings
  drm: panel: add Khadas TS050 panel driver

 .../display/panel/panel-simple-dsi.yaml       |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-khadas-ts050.c    | 876 ++++++++++++++++++
 4 files changed, 890 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-khadas-ts050.c

-- 
2.25.1

