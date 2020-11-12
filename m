Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E5F2B08F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgKLPwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgKLPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:52:15 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E986EC0613D1;
        Thu, 12 Nov 2020 07:52:14 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id m17so6882950oie.4;
        Thu, 12 Nov 2020 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MIVD3ec0pMDUnB/9PHlMhpg4aZF0Cw3HdcfpgHfnm9o=;
        b=e3rEPnCUToZm5Auuc2kEjfMVYhGgtYli/SBoiMGAGsCoAroVu4wW5EZ3o+iG2by1nF
         qr2/wTqIj+Ic/t5+zK2A2LDV/wRKNy+zC0N7zszbmxcrC6R5Dh+nuG0xmfCjU71WIZtg
         AJ0Tanvonq6536yxNEOjKE97UKhAEAE5JsvH8zEo1hbBt9m7PhqQBQcPZZ7VMhPziw9g
         e/GEPChTM9lFlegJVyZpgSTdajf/pwItZeZeqcxD/eZgsIV34g4Wuv9VMK9Dk5EvVeg2
         3rBqSjEq8+uGG3jLyO5MXCUAk8HPhfUJTVQMbRt9aglzZnS97pdkUs2m8OzRWr5ID+nC
         Uqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MIVD3ec0pMDUnB/9PHlMhpg4aZF0Cw3HdcfpgHfnm9o=;
        b=hdPAd7jQBrZOjHvx9sJLV+lGN8b+v4rqJSRpVyWNy3gj5ru5JOcfMKkUoDH8KElGtr
         BLnfKWDnF2itZ9JaFWC6rG245QIs9acprdc1ZNEg82oDGcfbY9otVfn2HnLlDK9lN7ag
         i7v3kq+cxOqZalqfXY3uDpozfgz90mZKWNtHLPFCQsiLf97XPdAbybvo9ZplE15pOmYz
         lva9NZ0GBGdncMGGIyNsGphgjwzhCDxkvo8LmHAFvPJcrCxzwvA6FFOOrbUCfFmbgYQd
         WxEcry2A9CIkL9ab6L6jr8e31KWfS1PEhO1nRNl2V93qRwDiTGJ3JYL4mSYz8H54IAtc
         yxBg==
X-Gm-Message-State: AOAM533eqo10FuksqbqHmmy7bxp7Yf0xvNrWSPLZ11iZ8Hy+Ehme+Rds
        ybMP5DYXDIjU0uwSpwmB43TV6qrJ6xWeZuQrZbf23mR0X8Wyng==
X-Google-Smtp-Source: ABdhPJwaGZvLg3cxotGZ2nYmKL0QSsibauQxy6Q/maqt4lPWs92SRosc9XQushbmxSDrR3grHmDG+8RMVAhIgW2b6rM=
X-Received: by 2002:aca:ad07:: with SMTP id w7mr182696oie.122.1605196334088;
 Thu, 12 Nov 2020 07:52:14 -0800 (PST)
MIME-Version: 1.0
From:   John Boero <boeroboy@gmail.com>
Date:   Thu, 12 Nov 2020 15:52:02 +0000
Message-ID: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
Subject: [PATCH] usb: core: Null deref in kernel with USB webcams.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 54f9886454e9a28e8d943c1cef15df9c11555df7 Mon Sep 17 00:00:00 2001
From: JohnnyB <jboero@users.noreply.github.com>
Date: Thu, 12 Nov 2020 15:28:29 +0000
Subject: [PATCH] usb: core: Null deref in kernel with USB webcams.

Fixes: Ubuntu Launchpad bug 1827452

This is my first attempt at a kernel contribution so sorry if sloppy.

There is some kind of race condition affecting Logitech
webcams that crash USB with a null dereference.
Affects raspberry pi devices as well as x86.
No check on dev before dereference.
Simple fix for issue experienced for months in
both x86 and arm/rpi environments.

Signed-off-by: John Boero <boeroboy@gmail.com>

---
drivers/usb/core/usb.c | 6 +-----
1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index d8756ffe513a..9b4ac4415f1a 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -272,13 +272,9 @@ EXPORT_SYMBOL_GPL(usb_find_alt_setting);
struct usb_interface *usb_ifnum_to_if(const struct usb_device *dev,
                                     unsigned ifnum)
{
-       struct usb_host_config *config = NULL;
+       struct usb_host_config *config = dev->actconfig;
       int i;

-       if (!dev)
-               return NULL;
-
-       config = dev->actconfig;
       if (!config)
               return NULL;
       for (i = 0; i < config->desc.bNumInterfaces; i++)
--
2.26.2
