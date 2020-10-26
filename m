Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39622299729
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793307AbgJZTjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1786239AbgJZTjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603741191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lCWigmNkQYdFYX02ynyqvoR8Vn8yvpoh4XRQOBQT06E=;
        b=aG7bhzWdQ0t7DYabcFq0HhBegsbo9SIlVEmHpzKzzJgkHGZ1RL2jCKrJ8hS4SrM8bYb5FS
        Vf3t0JFnv0+NSZAPjgG7VO5G1hLcuoGghFp5i8YHjGieiSe1tUG6EF6aScb88IzKprEna1
        wE9idhKosV/j+QOcyYbavRDZ/f3bNws=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-Ni8hQSynOMObMpMDTyoKEQ-1; Mon, 26 Oct 2020 15:39:49 -0400
X-MC-Unique: Ni8hQSynOMObMpMDTyoKEQ-1
Received: by mail-oo1-f69.google.com with SMTP id r25so6134308oop.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lCWigmNkQYdFYX02ynyqvoR8Vn8yvpoh4XRQOBQT06E=;
        b=f3xa3Q3ONjw5gjpuZxYxb7zCQy/+2vVRsgurD5MnSuDE9KDpsvBUJEs6IpgYBa0tv5
         nKGY8vmx2y4e5eLaErMSoBHQWQ+zSy1Ap343BC2LJH8a+PT0uo3ekCReT/MNuxE/6Oem
         hEDuufxmJZ04mpJq2jFip4GgO5XH+smSq27WeowLyNG6yTMmrT1uWgGmGu+SgFwG1qCx
         2R7EwEQs9DdERhYLw8S0QhDUu7xLMnqV3YMCl8DaSTOrV56kYWhZfkQNummHq54HV8r0
         d+OQ9t0ICzCMShgLcWKZDvVZ2RvmUzNjDuiEeOtH2elLnLhCEYnygrcxf4x6AhC2yRkg
         ON8A==
X-Gm-Message-State: AOAM532KSjXBTwBXdTRFqV4/i8SfZHxOBsfF4Wh5w1AbPniGoVhhPAPo
        CEtp9SiJUbNjzmMopgGr5hayVGbYqmQ9qqwUqLVbHxGUwVokf92FtmScU1Q5WTj8hp8dUL3q4mb
        dNWjbWlUZ6uJghcrphvJ23PIk
X-Received: by 2002:a9d:2a88:: with SMTP id e8mr12231285otb.122.1603741188410;
        Mon, 26 Oct 2020 12:39:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsyhAyUP2n2wv1fWsYURWnBm/cPB7m0J6DqoavC6i6FD6IAtB7NM8dGRZmoMdpumanQCoxXA==
X-Received: by 2002:a9d:2a88:: with SMTP id e8mr12231270otb.122.1603741188215;
        Mon, 26 Oct 2020 12:39:48 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t29sm4230509otd.51.2020.10.26.12.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:39:47 -0700 (PDT)
From:   trix@redhat.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] usb: gadget: f_hid: remove unneeded break
Date:   Mon, 26 Oct 2020 12:39:33 -0700
Message-Id: <20201026193933.1434490-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a goto.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: split from larger patch
---
 drivers/usb/gadget/function/f_hid.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 1125f4715830..5204769834d1 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -511,9 +511,7 @@ static int hidg_setup(struct usb_function *f,
 		/* send an empty report */
 		length = min_t(unsigned, length, hidg->report_length);
 		memset(req->buf, 0x0, length);
-
 		goto respond;
-		break;
 
 	case ((USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
 		  | HID_REQ_GET_PROTOCOL):
@@ -521,13 +519,11 @@ static int hidg_setup(struct usb_function *f,
 		length = min_t(unsigned int, length, 1);
 		((u8 *) req->buf)[0] = hidg->protocol;
 		goto respond;
-		break;
 
 	case ((USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
 		  | HID_REQ_SET_REPORT):
 		VDBG(cdev, "set_report | wLength=%d\n", ctrl->wLength);
 		goto stall;
-		break;
 
 	case ((USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
 		  | HID_REQ_SET_PROTOCOL):
@@ -544,7 +540,6 @@ static int hidg_setup(struct usb_function *f,
 			goto respond;
 		}
 		goto stall;
-		break;
 
 	case ((USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_INTERFACE) << 8
 		  | USB_REQ_GET_DESCRIPTOR):
@@ -562,7 +557,6 @@ static int hidg_setup(struct usb_function *f,
 						   hidg_desc_copy.bLength);
 			memcpy(req->buf, &hidg_desc_copy, length);
 			goto respond;
-			break;
 		}
 		case HID_DT_REPORT:
 			VDBG(cdev, "USB_REQ_GET_DESCRIPTOR: REPORT\n");
@@ -570,13 +564,11 @@ static int hidg_setup(struct usb_function *f,
 						   hidg->report_desc_length);
 			memcpy(req->buf, hidg->report_desc, length);
 			goto respond;
-			break;
 
 		default:
 			VDBG(cdev, "Unknown descriptor request 0x%x\n",
 				 value >> 8);
 			goto stall;
-			break;
 		}
 		break;
 
@@ -584,7 +576,6 @@ static int hidg_setup(struct usb_function *f,
 		VDBG(cdev, "Unknown request 0x%x\n",
 			 ctrl->bRequest);
 		goto stall;
-		break;
 	}
 
 stall:
-- 
2.18.1

