Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A840A2B9D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKSVu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgKSVu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:50:28 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92C4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:50:27 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so7973456wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXd2Y9BPUP+hnJL/FOxqeTmdTbabxcES+pTsOfva6bA=;
        b=VF20oNx/2JEUfQe3W+Z9FLA2x69adkZZxcFDA7pBJMscwFRiD7DNKNe0aFbgPB1oT6
         AR9bNah2BycGf2EoAjvNU6k2JBntrcNjgfAtG+vjCVpl66U6ajj7Q4EInG2q3yJZ/IxK
         LsrubevvB9+OuBXh43LzPI9PlKwBfHxV1b7lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXd2Y9BPUP+hnJL/FOxqeTmdTbabxcES+pTsOfva6bA=;
        b=rVHINrWqbTUKBtDlDyvLnAWpCzAXh9ZIg758S8CIltTEAFiclQaE8V6O97WL313Xh4
         VTy70BX95w5dj6dTiT6iZNI3v7njXuegeX1zPsPbuj70HYvcsQiGPGSlg+mrKuytR9kw
         bx/ttXQx8X9OPYhXWXspg5nix74KZ25kCblAmw2XMPABVg7HA0V4n8TmWhMthKflcPaB
         Fn8u+Iqft6hfZ6ur2+EEyp2MqJjisBzuZO99jJwffic9o0NuYAv6S/oWJfnuirs/JCV/
         pEu6ajM/2YREG6+IinCylxPB4QY4W4/QRXcwo1ze1I330ce0usToJ5XaU3sAmUmrQXY2
         NwKQ==
X-Gm-Message-State: AOAM531TK1/UdRB4BwobN9DMLl+RsDr5UOr0KXykzQb8vebwwtRtAK8z
        DLlwqC88S2/vnm23t5gh1k/YIQ==
X-Google-Smtp-Source: ABdhPJw/Aj3QSpqIe3URcPUvwq+c+BXysYVzdBCtGucQ4oLXGKvkWnFHk3HVMEvqILfVMldo1VPshg==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr12025399wrp.383.1605822626578;
        Thu, 19 Nov 2020 13:50:26 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t136sm1818859wmt.18.2020.11.19.13.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 13:50:26 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/8] Show privacy_gpio as a v4l2_ctrl
Date:   Thu, 19 Nov 2020 22:50:12 +0100
Message-Id: <20201119215020.508487-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
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

v2: Thanks to all the comments from Joe Perches
- Rework of printk macros

v2: Thanks to all the comments from Laurent!

- move guid to unit
- support entities with no pads
- CodeStyle
- Irq handling
- pr_cont
- new ids

Ricardo Ribalda (8):
  media: uvcvideo: Move guid to entity
  media: uvcvideo: Allow external entities
  media: uvcvideo: Allow entities with no pads
  media: uvcvideo: Entity defined get_info and get_cur
  media: uvcvideo: Implement UVC_EXT_GPIO_UNIT
  media: uvcvideo: Add Privacy control based on EXT_GPIO
  media: uvcvideo: Use dev_ printk aliases
  media: uvcvideo: New macro uvc_trace_cont

 drivers/media/usb/uvc/uvc_ctrl.c   |  80 +++++----
 drivers/media/usb/uvc/uvc_driver.c | 249 +++++++++++++++++++++--------
 drivers/media/usb/uvc/uvc_entity.c |  10 +-
 drivers/media/usb/uvc/uvc_status.c |  13 +-
 drivers/media/usb/uvc/uvc_video.c  |  51 +++---
 drivers/media/usb/uvc/uvcvideo.h   |  52 ++++--
 6 files changed, 309 insertions(+), 146 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

