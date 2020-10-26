Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E052996CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793006AbgJZT2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1784689AbgJZT2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603740487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=FPGZin7hGiL0S83YGvD7bl4y6jo+RRVwdp7xyLYn+vo=;
        b=FSzSt8kio8kv1/lQqEMh3YbDfiRb7FiVaQKfDGkN3Mzg2baKvy/AI6q9OQ8g6DTLXwljzz
        kTprz1mSFHgkW8cWDrTU1pKt2v02jAK6OZ7AZZAmfo+coo/T43RZ2HEU68+uSkl+XsF4pg
        69HP+ps7r0+MQjrW+CDJonjkB9vSGSQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-zXgbDZXuN-iYHLPE41_MeA-1; Mon, 26 Oct 2020 15:28:05 -0400
X-MC-Unique: zXgbDZXuN-iYHLPE41_MeA-1
Received: by mail-ot1-f71.google.com with SMTP id x12so3993765otq.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FPGZin7hGiL0S83YGvD7bl4y6jo+RRVwdp7xyLYn+vo=;
        b=MZzFu1v98RYanRXUCTTgEsmYCqEKimL0I8V0ImMU6CmBZAKxxeuk4avAove/U1yEBu
         bQE0tJ5h/GPx7AC9oiRuOc4gJn1Mzp3VJeOKPWuGIK4VuAoBjWkMewdNK+4You6hjIOm
         Vr/PRYxaIgTY11DjFjxFjxMolC71wA7sGJZiVOE0uNKHrU48c/IGYmWQplbMUn2Bvuw1
         G1e7qyBJef5g7pTwBueGV2vxbf1HtsdDES80Cz1lOWvoN6LXixaIp/RVVzwEnqv4wNZ6
         PSCZxnNEASMWepQACfjVWxMy0Q3wDw9qEzfv5aSmr3szm37h5F2dXdKbydBT9Fyh94WC
         GAFA==
X-Gm-Message-State: AOAM532yvamhbVyGQKtuRIteU6zNVUJS5AVUA1ChpI8gyL+TN2N5V2lD
        tomhbJSCo/Ijn/7UuqT0GkuwEAlIMEFq6VO6lnXB+p/FbmlQ7cQU8J0okuIvc8AkZDG3pnse7pc
        bSDAe3Ha082Zfl6au+iS5UFEq
X-Received: by 2002:a05:6830:1e34:: with SMTP id t20mr15194094otr.287.1603740485039;
        Mon, 26 Oct 2020 12:28:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+uWy1gyFBJcF88tBJdS44nzHs70xmAwlCO4fBguLAt1yBtaehqdBxW0o9IPEE/f7UbbnymQ==
X-Received: by 2002:a05:6830:1e34:: with SMTP id t20mr15194075otr.287.1603740484841;
        Mon, 26 Oct 2020 12:28:04 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h7sm3340103oop.40.2020.10.26.12.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:28:04 -0700 (PDT)
From:   trix@redhat.com
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] usb: misc: iowarrior: remove unneeded break
Date:   Mon, 26 Oct 2020 12:28:00 -0700
Message-Id: <20201026192800.1431547-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a goto.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: split from original larger patch
---
 drivers/usb/misc/iowarrior.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 70ec29681526..efbd317f2f25 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -384,7 +384,6 @@ static ssize_t iowarrior_write(struct file *file,
 		retval = usb_set_report(dev->interface, 2, 0, buf, count);
 		kfree(buf);
 		goto exit;
-		break;
 	case USB_DEVICE_ID_CODEMERCS_IOW56:
 	case USB_DEVICE_ID_CODEMERCS_IOW56AM:
 	case USB_DEVICE_ID_CODEMERCS_IOW28:
@@ -454,14 +453,12 @@ static ssize_t iowarrior_write(struct file *file,
 		retval = count;
 		usb_free_urb(int_out_urb);
 		goto exit;
-		break;
 	default:
 		/* what do we have here ? An unsupported Product-ID ? */
 		dev_err(&dev->interface->dev, "%s - not supported for product=0x%x\n",
 			__func__, dev->product_id);
 		retval = -EFAULT;
 		goto exit;
-		break;
 	}
 error:
 	usb_free_coherent(dev->udev, dev->report_size, buf,
-- 
2.18.1

