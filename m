Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABFB2C7C66
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgK3Bbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgK3Bbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:31:39 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D59C0613CF;
        Sun, 29 Nov 2020 17:30:53 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id r9so290299pjl.5;
        Sun, 29 Nov 2020 17:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDOpWxXfNZ312yhyl51Y7bEUu6zDTfPu30AJ2VVW3j8=;
        b=GRMO7geaH7OIC3CKw4jkUk882KiGCKpXeYYxwK8nqNyEZpKh1nKhxQynS76lMSxBAu
         epu4fqCwvyeoxDRs3bpQqQztQhryoB7ve/sdf6BTaj0+bfRUGML42xZ/bzQkHWGUpe+s
         tUhQ1W7YBHuChFyRE8UuVA7nZN44dXDVl39TMpNDByQpK7kEAEy7H0wLlB7iZLtTsdOO
         rfRebXJx7ha0RMQ9c33ymAwVMbJV33r48MHfXk+OXoVjDPMWDJ8zAo+8shAdpReIULzx
         RZTgk/cb1VtSBty9c5SQ2sF3kO4EgPED5g/FzBYMnl2EDhhrazjSNMgyxAQny4PxYdyk
         C6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDOpWxXfNZ312yhyl51Y7bEUu6zDTfPu30AJ2VVW3j8=;
        b=UleiSXk3Zvbrxt0Z1B4MdNnthbTR+rhMLt/yUJuxPRVjvmdt7Ag5AcYPoqc1g0UmwQ
         dvzQB5Ypt/gcsjOQpcdfXHdmhdTFgxL3MCZXRRaI+fvfr9VTGpfEnnqOjpv3qllrCQkG
         KlloS1qa612brWxNUad5z6+GyDLf+M6f9i01s7blEoKeWinV58LO1vJfKLb/03PgW5At
         DJtVKET0rcCYkDDkJgJhXHObfcwUGkwMfwADbQuv5NOg3PEM1C9C21yTcWKKppMoD83W
         +H5xqcKI0Ga7oHFy1YLDEUZS3JbfflbMZ+LBJ2cRhs1J9TLBBUEKXXcVITTDW7u/CeI1
         d6FQ==
X-Gm-Message-State: AOAM531xg8bEaj6Ko4aCjSJ/k2jMp5Rkd02t/TQIpJr7XTCJEUH36qmw
        CHbGrVHOJVCPaMchX57YWyw=
X-Google-Smtp-Source: ABdhPJwOqYJKKyq4DzeiIKNVhiim6y247J1ugLfLyWq4kjGuEzuxguenIXn8MCnrtKQtIi+wegz2vg==
X-Received: by 2002:a17:90b:33d1:: with SMTP id lk17mr23709423pjb.174.1606699852617;
        Sun, 29 Nov 2020 17:30:52 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id a3sm14565211pfo.46.2020.11.29.17.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:30:51 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/15] usb: misc: idmouse: update to use usb_control_msg_send()
Date:   Mon, 30 Nov 2020 07:00:31 +0530
Message-Id: <20201130013031.2580265-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
References: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer usb_control_msg_{send|recv}() API are an improvement on the
existing usb_control_msg() as it ensures that a short read/write is treated
as an error, data can be used off the stack, and raw usb pipes need not be
created in the calling functions.
For this reason, the instance of usb_control_msg() has been replaced with
usb_control_msg_send() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/idmouse.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/idmouse.c b/drivers/usb/misc/idmouse.c
index e9437a176518..52126441a633 100644
--- a/drivers/usb/misc/idmouse.c
+++ b/drivers/usb/misc/idmouse.c
@@ -56,8 +56,9 @@ static const struct usb_device_id idmouse_table[] = {
 #define FTIP_SCROLL  0x24
 
 #define ftip_command(dev, command, value, index) \
-	usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0), command, \
-	USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT, value, index, NULL, 0, 1000)
+	usb_control_msg_send(dev->udev, 0, command, \
+	USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT, \
+	value, index, NULL, 0, 1000, GFP_KERNEL)
 
 MODULE_DEVICE_TABLE(usb, idmouse_table);
 
-- 
2.25.1

