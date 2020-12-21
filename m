Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8298F2DFFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgLUS2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgLUS2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:28:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B2CC061793
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:27:40 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g185so11858650wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJuLPvN2RTSNyr6LApzw+/OhfeYw5gbFBvw/kpJgHjI=;
        b=DQyB82We6HV18Ka32uGMj6H2J+bJdM7Y3zVVCfkuJOaodSSJNWB/8GqFOdELB7k+KS
         DUxjF69Dfb8bXn4RpaOvWr6M3LUO5KWekB+4gvw9cu3biW6KB/9jwvbyX3HSRGsyN/+G
         z1Y83YcMUDAVWO6uoxRYfbM7FagtC2CYHd8L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJuLPvN2RTSNyr6LApzw+/OhfeYw5gbFBvw/kpJgHjI=;
        b=M15676QYe41oJy2aMSHqXs4wAGFGj2KhjHvdzBdtcZ+cewvdDSLL18qYYo4sD8Ffrg
         Rka1mz4lxZ+e+Txu3yzptfdCX/Ci4j83WISNFmeBMIpLPShCxMU02kEiV2ag+bfC0Qgl
         PWqinPwAKzrGHBWYBcMvZSMavIMOo3ZZn1LQRn79cHOZCMhGhyZwq+EliIoEI7z4u8Y7
         ClzRIVEiab5MX3u7Qq3TgyE9ncNg/gTdS5Cwp3szNVaXRCChhfdqT19jx7fU3nCmK+DY
         pLL/jVlEblWbENCfgszY4z6EtcstWmyDISdi2GcmNBFJHSiyS9fCEGDFZudZnK9z2xeu
         qkkw==
X-Gm-Message-State: AOAM533phFRuBnAyojofJCMDjIkwH4XrsI8+H687YaZi8bCriOxq11y4
        3T1ag3w/eAWRLiIWkihMBtL/duuY0aAzSAG04yc=
X-Google-Smtp-Source: ABdhPJwL72OqtKMahlwApirIUX+DUcjXJsr/D1CeeqHILBPP03aucCZhCea9miDoTCBiJ9an+V6J2A==
X-Received: by 2002:a05:600c:2306:: with SMTP id 6mr17698261wmo.53.1608569302238;
        Mon, 21 Dec 2020 08:48:22 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o125sm24581109wmo.30.2020.12.21.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:48:21 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 00/12]Show privacy_gpio as a v4l2_ctrl
Date:   Mon, 21 Dec 2020 17:48:07 +0100
Message-Id: <20201221164819.792019-1-ribalda@chromium.org>
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

v5: Thanks to all the comments from Laurent!
  - Allow multiple async_ctrls
  - Use dev_dbg() for uvc_trace
  - Major redesing of "Implement UVC_EXT_GPIO_UNIT"
  - Major redesing of "Implement UVC_QUIRK_PRIVACY_DURING_STREAM"

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

Ricardo Ribalda (12):
  media: uvcvideo: Fix race condition handling events
  media: uvcvideo: Allow more that one asyc_ctrl
  media: uvcvideo: Move guid to entity
  media: uvcvideo: Allow extra entities
  media: uvcvideo: Allow entities with no pads
  media: uvcvideo: Allow entity-defined get_info and get_cur
  media: uvcvideo: Implement UVC_EXT_GPIO_UNIT
  media: uvcvideo: Add Privacy control based on EXT_GPIO
  media: uvcvideo: Implement UVC_QUIRK_PRIVACY_DURING_STREAM
  media: uvcvideo: Use dev_ printk aliases
  media: uvcvideo: New macro uvc_trace_cont
  media: uvcvideo: use dev_dbg() for uvc_trace()

 drivers/media/usb/uvc/uvc_ctrl.c   | 204 +++++----
 drivers/media/usb/uvc/uvc_driver.c | 644 +++++++++++++++++++----------
 drivers/media/usb/uvc/uvc_entity.c |  11 +-
 drivers/media/usb/uvc/uvc_isight.c |  16 +-
 drivers/media/usb/uvc/uvc_queue.c  |  12 +-
 drivers/media/usb/uvc/uvc_status.c |  32 +-
 drivers/media/usb/uvc/uvc_v4l2.c   |  53 ++-
 drivers/media/usb/uvc/uvc_video.c  | 120 +++---
 drivers/media/usb/uvc/uvcvideo.h   |  91 ++--
 9 files changed, 767 insertions(+), 416 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog

