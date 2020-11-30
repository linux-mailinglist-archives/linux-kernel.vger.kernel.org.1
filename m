Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C902C7C53
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgK3BVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgK3BVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:21:12 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23761C0613CF;
        Sun, 29 Nov 2020 17:20:27 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id bj5so5560667plb.4;
        Sun, 29 Nov 2020 17:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9neIC2nP4AkQG8eY+IlQyOgSSMBX6Quf44ZMyRQcc0=;
        b=sP8kFzR69H9wb2BgjF9BVHIprW940obj2C3GgnE5KiSsX26HBnzEte+yBu2/xs7nF7
         NxupZizj41Df2KVAP5epghac0sLnIf7LavS+NbHqe+FL+QFaBn7Vju807Efy/ok7gVUX
         nuF1iWP1zWKzNdiOEID78J8vIvzwl+P3+puPkRITotCQf2iDU60datuh+gjF4GA52+Pg
         zt3zEcrhy4VuB/y6cuXINykKyw7eNvlSqQ7fJoYpvW6UBAeRn7z5nlWHsye2gYlmQL6J
         MvxkDVnS1o8zMn+vNK+DLn/8udePoShPcOGn6ZHQAJG8o9rM0tiNggs4FafYaCYmEbRf
         JDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9neIC2nP4AkQG8eY+IlQyOgSSMBX6Quf44ZMyRQcc0=;
        b=X6+RUEhQiPqbmWtka0uQsuCAcAc1EONLS75ec5mqKFTWFeMjgnSLSmApiJAIxcISZx
         sizEz5d6+qm3qSu1UPNFqTYuGvIxzHUNKsjYel/eqy4QAQ1hmCPaeMZ5DGAPGN9rn0Cj
         2hAzU70kg8P3+zDH9DzGs8FQIcWf/FvH1WghD2DvH7md9oYJYQPtMGpG1XPFGLkhaePE
         kEeRbx1aimNcEfjIjJVQ6RGykXxQj0GTrB8fTL/8Qnwr7Flgq2vp+xyl9uFZAv9eLEVz
         92vEu7sb4zPH3Q1FwfaQtG7Blzt7XLwcwLd+C4KTiFpyJcDOtSenpUYRCH2IlazZo8FF
         1alg==
X-Gm-Message-State: AOAM530+cJQ+r7tQt5gTBuyyh7FAq4Dw4RBpmE3eLHbsigC7WSSGquzt
        8Pyw8LhrVH70XbQTUklmdf0dR4pGSAwV3S6ogaE=
X-Google-Smtp-Source: ABdhPJywNIp8bBDK+nxoBIkEXPB7hi3yXNEqpvBhNXKu3OFZe7JfHWZbeDitlY1UswE1xADVZpOxVA==
X-Received: by 2002:a17:90a:b782:: with SMTP id m2mr10256163pjr.185.1606699226333;
        Sun, 29 Nov 2020 17:20:26 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id l10sm20002567pjg.3.2020.11.29.17.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:20:25 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 00/15] drivers: usb: misc: update to use usb_control_msg_{send|recv}()
Date:   Mon, 30 Nov 2020 06:48:04 +0530
Message-Id: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new usb_control_msg_{send|recv}() API provides an improved way of 
using usb_control_msg(). Using this, short reads/writes are considered
as errors, data can be used off the stack, and the need for the calling
function to create a raw usb pipe is eliminated.
This patch series aims to update existing instances of usb_control_msg() 
in drivers/usb/misc to usb_control_msg_{send|recv}() appropriately, and
also update the return value checking mechanisms in place (if any), as
necessary so nothing breaks.

I was however unable to update one instance of usb_control_msg() in 
drivers/usb/misc/apple-mfi-fastcharge.c.

The return value checking mechanism present here, is as follows.
	if (retval) {
		dev_dbg(&mfi->udev->dev, "retval = %d\n", retval);
		return retval;
	}

	mfi->charge_type = val->intval;

	return 0;

This implies that mfi->charge_type = val->intval only when number of
bytes transferred = 0, and the return value is directly returned 
otherwise. Since the new API doesn't return the number of bytes 
transferred, I wasn't quite sure how this instance could be updated.
In case this check is logically incorrect, a patch with a fix 
can be sent in as well.

Changes in v2:

  * Buffer variables that were previously dynamically allocated are no
    longer dynamically allocated unless they have a variable length
    (since that threw a warning).
    

Anant Thazhemadam (15):
  usb: misc: appledisplay: update to use the
    usb_control_msg_{send|recv}() API
  usb: misc: cypress_cy7c63: update to use usb_control_msg_recv()
  usb: misc: cytherm: update to use usb_control_msg_recv()
  usb: misc: ehset: update to use the usb_control_msg_{send|recv}() API
  usb: misc: emi26: update to use usb_control_msg_send()
  usb: misc: emi62: update to use usb_control_msg_send()
  usb: misc: ezusb: update to use usb_control_msg_send()
  usb: misc: idmouse: update to use usb_control_msg_send()
  usb: misc: iowarrior: update to use the usb_control_msg_{send|recv}()
    API
  usb: misc: isight_firmware: update to use usb_control_msg_send()
  usb: misc: ldusb: update to use usb_control_msg_send()
  usb: misc: lvstest: update to use the usb_control_msg_{send|recv}()
    API
  usb: misc: trancevibrator: update to use usb_control_msg_send()
  usb: misc: usbsevseg: update to use usb_control_msg_send()
  usb: misc: usbtest: update to use the usb_control_msg_{send|recv}()
    API

 drivers/usb/misc/appledisplay.c    |  46 +++++------
 drivers/usb/misc/cypress_cy7c63.c  |  21 ++---
 drivers/usb/misc/cytherm.c         | 128 ++++++++++-------------------
 drivers/usb/misc/ehset.c           |  76 ++++++++---------
 drivers/usb/misc/emi26.c           |  31 ++-----
 drivers/usb/misc/emi62.c           |  30 ++-----
 drivers/usb/misc/ezusb.c           |  16 +---
 drivers/usb/misc/idmouse.c         |   5 +-
 drivers/usb/misc/iowarrior.c       |  34 ++++----
 drivers/usb/misc/isight_firmware.c |  30 +++----
 drivers/usb/misc/ldusb.c           |   8 +-
 drivers/usb/misc/lvstest.c         |  38 ++++-----
 drivers/usb/misc/trancevibrator.c  |   4 +-
 drivers/usb/misc/usbsevseg.c       |  60 ++++----------
 drivers/usb/misc/usbtest.c         |  69 +++++++---------
 15 files changed, 216 insertions(+), 380 deletions(-)

-- 
2.25.1

