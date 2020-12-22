Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB782E1079
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 00:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgLVXFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 18:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgLVXFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 18:05:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DB1C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:04:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m5so16619540wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bxxupScKkQylTgnzT1jQfJoerVH6s89+gfUZG72kVPM=;
        b=MVCR6f45O68amRjy6JOuaNJmfDEGVnpIF2mDSapSMTbXpdqXspqepYxxp7vu4y+Smp
         jmQ5nKLR+4nIehdk7+SrYe5ugoypMzJI8rkzjR6zmVjSz4t4VBnNgoAuP6eNKVJOOsnc
         HU8aEtiHyHjERvWzODBiPYWn7h/TzVP9+ux/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bxxupScKkQylTgnzT1jQfJoerVH6s89+gfUZG72kVPM=;
        b=GCLRCmF3yrn0C9UCtJSwVW0oNsqG/L1xVDzqwY7szLkxD8sBvhXgZeaH1uAZKyekGT
         +r7injNRTP5crhehsUHUBQeYF7dN0Py6z1/LkBpgzXS6w//yxkq+nYJzXMq2DLs+g2LF
         HTo9Vd+g5ldXo2qkPA+qDDQI/BSR80wXchkpXf/GCzlxFxubjORpgJAfxNjx1yVYJtGX
         r81PxK+IXIMxyWhepmNEoJNgfZ7cZXoGrwiJ/ZmL/uOuhVgw9oyVMV+Btq6CG9Qv3ejh
         KtEFmLCe0saR6QmGXinwzNCa2yt14k+ieqDcbolH+aQykGyvufHdYoH2El5ZHCgUuumU
         cPOw==
X-Gm-Message-State: AOAM530dgl68PGKT61dV/CdtgrEJgA50X6TenJ8I4AfkFvBn2udyhnH/
        lwcIOkt38e3ky0hmKWWRm2K2IQ==
X-Google-Smtp-Source: ABdhPJzPAAf/t30zcDZA03v+hjXJLfzNdOs2DTGTT2VPaETefMMFTTxqII3if/q2O/QNd9B9/JYaCg==
X-Received: by 2002:adf:f10f:: with SMTP id r15mr26982951wro.302.1608678288761;
        Tue, 22 Dec 2020 15:04:48 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id r16sm34463401wrx.36.2020.12.22.15.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 15:04:48 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 00/11] Show privacy_gpio as a v4l2_ctrl
Date:   Wed, 23 Dec 2020 00:04:35 +0100
Message-Id: <20201222230446.1027916-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
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

The obvious way to show it to userspace is via the V4L2_CID_PRIVACY
control.

This patchset implement this functionality.

v6: Thanks to all the comments from Laurent!
  - Remove multiple async_ctrls from v5, it is not needed
  - Split event handling in two parts, so it can be triggered without wq
  - Save pointer to the privacy entity in the main structure
  - Handle the quirk in a different location to avoid races
  - CodeStyle

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

Ricardo Ribalda (11):
  media: uvcvideo: Move guid to entity
  media: uvcvideo: Allow extra entities
  media: uvcvideo: Allow entities with no pads
  media: uvcvideo: Add uvc_ctrl_status_event_direct
  media: uvcvideo: Allow entity-defined get_info and get_cur
  media: uvcvideo: Implement UVC_EXT_GPIO_UNIT
  media: uvcvideo: Add Privacy control based on EXT_GPIO
  media: uvcvideo: Implement UVC_QUIRK_PRIVACY_DURING_STREAM
  media: uvcvideo: Use dev_ printk aliases
  media: uvcvideo: New macro uvc_trace_cont
  media: uvcvideo: use dev_printk() for uvc_trace()

 drivers/media/usb/uvc/uvc_ctrl.c   | 184 +++++----
 drivers/media/usb/uvc/uvc_driver.c | 603 +++++++++++++++++++----------
 drivers/media/usb/uvc/uvc_entity.c |  11 +-
 drivers/media/usb/uvc/uvc_isight.c |  16 +-
 drivers/media/usb/uvc/uvc_queue.c  |   9 +-
 drivers/media/usb/uvc/uvc_status.c |  32 +-
 drivers/media/usb/uvc/uvc_v4l2.c   |  53 ++-
 drivers/media/usb/uvc/uvc_video.c  | 147 ++++---
 drivers/media/usb/uvc/uvcvideo.h   |  76 +++-
 9 files changed, 727 insertions(+), 404 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

