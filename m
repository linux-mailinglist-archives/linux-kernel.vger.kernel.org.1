Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41452C79D2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgK2QHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2QHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:07:12 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E3AC0613CF;
        Sun, 29 Nov 2020 08:06:32 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t3so8394513pgi.11;
        Sun, 29 Nov 2020 08:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALXc7Qe3C+ECWCLA5rktXhPD6AeZz9/f+AYmP6J+Vt8=;
        b=sTynAWyUtWwL/d3vDk5zw41PYTBK9FCyUHdlkoYPNtuThJP2wcn+UXaGNH3aXnpzfu
         TvyNCSQLIJ9tWQaNjeTr4dk6wuukzZO6Nc9o/wGh/R2QKLo5ftL74DnSmJUjPhP21QKq
         v4zwI8oS5lnzyhJ65kY+/pameNzrSc9h/Ky8W+hylha6+gl3SB4p28ejhzfNFPdouB+L
         IDk2LbHb8wYfNbKxpJHLJ7zPA6zckQF+Fsssnj+qBijjAtw+sToNv9r1U5u9MFG7vH+R
         J5j6aqNF/fW+j599Y8w1hhq0xw4BxuTnuTERG/fw+6cwpNvUSAe0P96VhsUIckPCDgTp
         yFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALXc7Qe3C+ECWCLA5rktXhPD6AeZz9/f+AYmP6J+Vt8=;
        b=aTxGE2NntcUD7cO9324qaIYGTeDuStgqxzo1GvQQqyh0W9/KM6i/APrB04W5VOkkTm
         I2AHkwWPW6BHMuQMo2vNsoU5T2/HWmM6QjyaMlKBOwSDLypgLHq7PYL1SXssi5o7OWTW
         dnapN/iovsEKSZmYvy35iLLl7eMPBKg6pe1SSWYcpu+hud3pJLS+HmLInlwSTuPwMjnC
         ANiCgBDY4spDEMQNoezYBtXoN3T4aexOyurE1DsqB+MtbnLuww6iRwV5+3PXxeA/0l3E
         OKluOWv8qOUhRrItNo+VNsB3KAiqFj6+i6XXB7maHvyW4VNke92Py9sWSdPnttAysrzM
         h/bQ==
X-Gm-Message-State: AOAM530NP6Nhb7pu4QernO+c434y5ZEamKOP/SXK5Giy/0p3CsddEe1W
        6ihWLPg2OOVERz/IDjJFXgo=
X-Google-Smtp-Source: ABdhPJz5LSVSwgMMUQ4+CLBco7tWDqMUukYtlB/zr1LasR2Q3+m+66oVmJPVr52SzwS3ITOXdjNX6g==
X-Received: by 2002:a63:484d:: with SMTP id x13mr13699870pgk.301.1606665990252;
        Sun, 29 Nov 2020 08:06:30 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:06:29 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 00/15] drivers: usb: misc: update to use usb_control_msg_{send|recv}()
Date:   Sun, 29 Nov 2020 21:35:57 +0530
Message-Id: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
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

 drivers/usb/misc/appledisplay.c    | 46 ++++++++------------
 drivers/usb/misc/cypress_cy7c63.c  | 10 ++---
 drivers/usb/misc/cytherm.c         | 42 +++++++++---------
 drivers/usb/misc/ehset.c           | 70 +++++++++++++-----------------
 drivers/usb/misc/emi26.c           | 14 +-----
 drivers/usb/misc/emi62.c           | 14 +-----
 drivers/usb/misc/ezusb.c           | 16 +------
 drivers/usb/misc/idmouse.c         |  5 ++-
 drivers/usb/misc/iowarrior.c       | 34 +++++++--------
 drivers/usb/misc/isight_firmware.c | 22 +++++-----
 drivers/usb/misc/ldusb.c           |  8 ++--
 drivers/usb/misc/lvstest.c         | 30 ++++++-------
 drivers/usb/misc/trancevibrator.c  |  6 +--
 drivers/usb/misc/usbsevseg.c       | 52 +++++++---------------
 drivers/usb/misc/usbtest.c         | 63 +++++++++++++--------------
 15 files changed, 180 insertions(+), 252 deletions(-)

-- 
2.25.1

