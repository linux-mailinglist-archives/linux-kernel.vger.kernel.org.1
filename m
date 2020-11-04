Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582D52A6C63
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgKDSHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgKDSHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:07:48 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAB3C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:07:47 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s9so23054156wro.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00yDIMllqd/dhlfJcoib8aA1apSovUKmF4tHSgYMrU8=;
        b=HBRINmi/Jg/JTIsA9nTzVg3Q+PTWcEsRjort86K7ZnvxWx3WUXeGH53Rp4B8aXhYtN
         AzuVRYx4JuoAMwnsIAru6Hu247vjLabfUYayOZQJP9dRj9mJS20pDIglPVf0elbwMvdn
         yww+HW9Y7LlTxEM62LWul7GoiAS75LNmFsJak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00yDIMllqd/dhlfJcoib8aA1apSovUKmF4tHSgYMrU8=;
        b=jQ6qoiIA0O5H30LLiMwyCWVOO7ja1oTiFhhTuR9RQRrtj1WB8TW6YYIGxkVpJpWZBA
         7R+i0XJGcRXPFhoBvtAEFH5OQKxyYLdChd0NLhWJ8HD+coiyncxpNYdXS4fG5sw9hxWI
         wvS3KXZS4E7B/RWYh4RN+b4tLGXK4U6Bc1BXn8w7nf9bGNcgHEwHUIdkh5U4993cx2Y/
         UZ7t1cRA379LTGfnSOefWantwTtE0ZBKDhTPUkhhlgBYtfGEmQafLeSwm9LAuuQisAMy
         XYcNLGdRTBAR/7fElw9w9uaqkR8rtXh1T5CpptJMD4VhGak/JH1x0jG4m+SCXQdpAF+q
         ji+A==
X-Gm-Message-State: AOAM5315tBekzJIi0eUeA/WxBfZwYnLte9Q12KLJeDItiyIepfS1p5Wc
        jLqdYnFo5hfvC9ZCiqOHI30voA==
X-Google-Smtp-Source: ABdhPJzkDuUYL/UU4eilQX7p0NAwDH5Dir5eZJxRYuT8aYI214lUtpeykKI466JmBbJP8ve5pcIqQg==
X-Received: by 2002:a5d:4d4b:: with SMTP id a11mr33143405wru.199.1604513266119;
        Wed, 04 Nov 2020 10:07:46 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id y10sm3801841wru.94.2020.11.04.10.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:07:45 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/7] Show privacy_gpio as a v4l2_ctrl
Date:   Wed,  4 Nov 2020 19:07:27 +0100
Message-Id: <20201104180734.286789-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
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

v2: Thanks to all the comments from Laurent!

- move guid to unit
- support entities with no pads
- CodeStyle
- Irq handling
- pr_cont
- new ids

Ricardo Ribalda (7):
  media: uvcvideo: Use pr_cont() macro
  media: uvcvideo: Move guid to entity
  media: uvcvideo: Allow external entities
  media: uvcvideo: Allow entities with no pads
  media: uvcvideo: Entity defined get_info and get_cur
  media: uvcvideo: Implement UVC_EXT_GPIO_UNIT
  media: uvcvideo: Add Privacy control based on EXT_GPIO

 drivers/media/usb/uvc/uvc_ctrl.c   |  73 ++++++++-----
 drivers/media/usb/uvc/uvc_driver.c | 166 +++++++++++++++++++++++++----
 drivers/media/usb/uvc/uvcvideo.h   |  19 +++-
 3 files changed, 207 insertions(+), 51 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

