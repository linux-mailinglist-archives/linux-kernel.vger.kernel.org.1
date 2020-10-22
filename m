Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D1729601D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900204AbgJVNh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgJVNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:37:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F840C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:37:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i1so2471648wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VK4FgjtpkHHYUN2/U6FSltdeDbo7aonVsHt4FDf3Llc=;
        b=ird/YN9lH1BtBZ8Hed7YgeAeT5tU18FYvjLagm5kFiAIzqkS7YnirxsmUHHEnhQLhb
         6hWmyaetMck/VZVm7Jy3Ckp9huRBvTs4e1bCst7zuc/OuPwBLPy0OJu0vyS0350wy1bJ
         0y+ou/mHS7B1rzft7O+VzXHDXyuVcnIKLHaHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VK4FgjtpkHHYUN2/U6FSltdeDbo7aonVsHt4FDf3Llc=;
        b=YR6EJ1wjC3ZShaVrkgzd3j8+MBX03cWjjYQOLg21C7yPcvahCWGBI1ZByfJnPBuSdz
         y1+bPWamHv+EJd6JZtGw91gKC7v+c6JMpmMsPNa1yQe8O/6u92x3/bzYQ9wKfyh4Fc7F
         5cR3fGH8s2go8wN4rybFHFHwpDRW4N9ryAQFgpb5BFfjDTlvOH9GhhbJLqx+X5jBestR
         hPjfW6vyFMNd0US53heEtbndHR//S3bQAaZnL2hgVQHKNe3kgy6tezoxjMLNIsGvrQZ2
         6sBjYjgtOERybOBmkdkUpAUrTb20dySqEIpk13xXCOPOfav9j8OObuzllFFcE6at/C8L
         AYpQ==
X-Gm-Message-State: AOAM532/+jsY7uM7zaCu2rCEHJFm61fJPvzr74YHWXAu+dPItHZ7PVIG
        Yxre75Yk5Rz0BoeS5we/1oUBIt9/LLmhu5AO
X-Google-Smtp-Source: ABdhPJzwijLPW+SG7YfBNlKDFj8QOg+9H2CDvF1LuekVvASb0hAlxfQ0fAqaiAtQCAFFbzbOYLvIfA==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr2813167wro.339.1603373876297;
        Thu, 22 Oct 2020 06:37:56 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id q10sm4094031wrp.83.2020.10.22.06.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 06:37:55 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tfiga@chromium.org, Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/6] Show privacy_gpio as a v4l2_ctrl
Date:   Thu, 22 Oct 2020 15:37:47 +0200
Message-Id: <20201022133753.310506-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
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

Ricardo Ribalda (6):
  media: uvcvideo: Add UVC_CTRL_FLAG_ENTITY_GET_INFO
  media: uvcvideo: Add UVC_CTRL_FLAG_ENTITY_GET_CUR
  media: uvcvideo: Add UVC_GUID_EXT_GPIO_CONTROLLER
  media: uvcvideo: Add Privacy control based on EXT_GPIO
  media: uvcvideo: Implement UVC_GPIO_UNIT
  media: uvcvideo: Handle IRQs from the privacy_pin

 drivers/media/usb/uvc/uvc_ctrl.c   |  56 ++++++++++++++--
 drivers/media/usb/uvc/uvc_driver.c | 102 +++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  14 ++++
 include/uapi/linux/uvcvideo.h      |   3 +
 4 files changed, 169 insertions(+), 6 deletions(-)

-- 
2.29.0.rc1.297.gfa9743e501-goog

