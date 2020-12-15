Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA32DB0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgLOQKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgLOPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:45:35 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FE0C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:44:51 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id y23so18967713wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HR5GScKaiUW2x/d4MD32i6GDQyLCkJOmbObRCwkENAo=;
        b=CaKFmsj5/lz9xGMXw8/PJvHrbzL1UY5UtZaLLSbXB33haTJZ4AnQa8JEmZ2LK+b9K3
         JjUHcoAbPcNtN5ivG6IFnEazOlh40IS1/Puq40blWChh2S2A96k51YjvP6V+m5KuQjqb
         Sp9KmePJ7OMXMwErm2zhXKMuRmL2X9vvPcDAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HR5GScKaiUW2x/d4MD32i6GDQyLCkJOmbObRCwkENAo=;
        b=eLjMxeZLwregDy2iBgkIbyS/82VDkHcsz6q+lXikN1Y6eS0HFPL9faddsrtAWKAcVM
         uyCgldpDlBp5l9/8dsZB/s89/Xtcn0nYlbjInU78wIv5+LC8zjK4OibyhYZOkjlSuFeh
         swOPZ3AkPn12NDmGfoEQVE3Z4vwU70bc4/IslJnkQDt1yaytOub1C/L5t/YPalD8XPpG
         Rb8JZDjECQx3nFvpxmmAYBQBVXzyvhiRMJ5MXksYUJqO6L+HcPrrwfgj7Abo9wttSnZ/
         OoyQ+yPrdg/xkxq3QaUJUuivdXKHMRlzgygWjQI724losrXMfooDCLtVNSBx5mbomBA8
         mlWw==
X-Gm-Message-State: AOAM533e8v/eQLUmrnUO0bVF7fh9JJrp5qdgduZbEwg/lIq87c1d8o54
        Z80fT5UdzT/Gjcmt00ueXTWQWQ==
X-Google-Smtp-Source: ABdhPJyK6/64D2Y1cYIWy8fyfkT9RQD9Z/5hK0muDrkBcRYcnAroDcmqwxEqmf2Hkl4ozs+L8TiXuQ==
X-Received: by 2002:a05:600c:224b:: with SMTP id a11mr33331066wmm.97.1608047089901;
        Tue, 15 Dec 2020 07:44:49 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id 125sm38204141wmc.27.2020.12.15.07.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 07:44:49 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/9] Show privacy_gpio as a v4l2_ctrl
Date:   Tue, 15 Dec 2020 16:44:30 +0100
Message-Id: <20201215154439.69062-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices can implement a physical switch to disable the input of the
camera on demand. Think of it like an elegant privacy sticker.

The system can read the status of the privacy switch via a GPIO.

The ACPI table maps this GPIO to the USB device via _CRS and _DSD
descriptors, so the kernel can find it.

The userspace applications need to know if the privacy pin is enabled
or not.

The obvious way to show it to userspace is via the V4L2_CID_PRIVACY control.

This patchset implement this functionality.

v4: Implement UVC_QUIRK_PRIVACY_DURING_STREAM

v3: Thanks to all the comments from Joe Perches
- Rework of printk macros

v2: Thanks to all the comments from Laurent!

- move guid to unit
- support entities with no pads
- CodeStyle
- Irq handling
- pr_cont
- new ids

Ricardo Ribalda (9):
  media: uvcvideo: Move guid to entity
  media: uvcvideo: Allow external entities
  media: uvcvideo: Allow entities with no pads
  media: uvcvideo: Entity defined get_info and get_cur
  media: uvcvideo: Implement UVC_EXT_GPIO_UNIT
  media: uvcvideo: Add Privacy control based on EXT_GPIO
  media: uvcvideo: Use dev_ printk aliases
  media: uvcvideo: New macro uvc_trace_cont
  media: uvcvideo: Implement UVC_QUIRK_PRIVACY_DURING_STREAM

 drivers/media/usb/uvc/uvc_ctrl.c   |  80 ++++---
 drivers/media/usb/uvc/uvc_driver.c | 322 +++++++++++++++++++++++------
 drivers/media/usb/uvc/uvc_entity.c |  10 +-
 drivers/media/usb/uvc/uvc_queue.c  |   3 +
 drivers/media/usb/uvc/uvc_status.c |  13 +-
 drivers/media/usb/uvc/uvc_video.c  |  51 ++---
 drivers/media/usb/uvc/uvcvideo.h   |  54 +++--
 7 files changed, 389 insertions(+), 144 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog

