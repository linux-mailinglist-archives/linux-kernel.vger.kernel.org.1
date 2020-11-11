Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BC52AE648
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 03:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbgKKCSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 21:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732112AbgKKCSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 21:18:02 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A43C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:18:01 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 3so225213wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=ytnceseKstAkbTY6hqRw1K2IUsH5s6eyRpuBlxMNr7E=;
        b=bIHeqXCjBg9KBCdMR1zWDl6CFWFcA1jwTMpdjeCeLoPP88uZXsSSFPrxQH2gU7/nl6
         pW5Pef923VxB62smWyXe//me2yzR9bkW8ZVlcVY0OVvm2+itLvtNwi4nAi7T5VT2TSxf
         KT2ovmvtuWkhXWtgpNr3FizmQXg5H0L6KDvI7pJsJv0Z9JVQKq2NRm6z/cd8dE+1LRqc
         heS6HxxyVtwVQJxk5xkpOZAoDFg+K0h/JRuXfmy2iI2moLAhDubhCQCgySiJH+37fOZR
         bvRKIRYJzPWgC3WiCjlIjW5t3fjeEuSMExu8mB14w6Igz3xnJGHcTdK0GbRg7Z9+ykhe
         UgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=ytnceseKstAkbTY6hqRw1K2IUsH5s6eyRpuBlxMNr7E=;
        b=ngqL+xuWPWRaNGrvlBFmuOCJqGBbN/h6N718pDg7F88bAG9+PBOFKINsMzhY3l5LcN
         CXZC1Im+aBCxUkUup1vx8/3VLNcpxtuE4o56UlO5krHJJQtsFqgxOoVAeL5lC4l7MXO8
         dmQBjsXSeSXJKYSL1TokK1d5ybfDPOMUAh1BkI1fuPoxRtK1hcxna5lrURdLvQb1T4os
         B9BnYKpz1PNyxp0OEkj10WpxtdhUCDt/B5sMwIosforFkwIo4dAuJT2OTHbT8zT4oAZk
         ThwgxRhb8YcH9PyjJswkDCLMVb9oiNKF0KF2Q/de3EnX+XPRg5a/wJAlCRwfxq0n7Jwm
         P/eA==
X-Gm-Message-State: AOAM530+aprWi0vFVfcbr6hATZrV+jiuN1K9s0yzjN8wvqCwo88sD9BF
        ed/RcQE2kz3JG3iFmfgMj12d8nAn+7ckkc10
X-Google-Smtp-Source: ABdhPJzuuDXDSY0PgO7PMSKSHaXAnCza28TgavAUOfVt3lTBjteVZ5QDJPOeCX6Ohk6PzjQ0RxW5pzGi92qT8zkQ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:e4d4:: with SMTP id
 b203mr91996wmh.141.1605061080014; Tue, 10 Nov 2020 18:18:00 -0800 (PST)
Date:   Wed, 11 Nov 2020 03:17:55 +0100
Message-Id: <245047b3fffaf5c0b791ed226d1ea272b2aef031.1605060950.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] MAINTAINERS: add usb raw gadget entry
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself (using the personal email address) as a reviewer for the
USB Raw Gadget driver.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94ac10a153c7..f68835aaaddc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18176,6 +18176,14 @@ L:	linux-usb@vger.kernel.org
 S:	Supported
 F:	drivers/usb/class/usblp.c
=20
+USB RAW GADGET DRIVER
+R:	Andrey Konovalov <andreyknvl@gmail.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	Documentation/usb/raw-gadget.rst
+F:	drivers/usb/gadget/legacy/raw_gadget.c
+F:	include/uapi/linux/usb/raw_gadget.h
+
 USB QMI WWAN NETWORK DRIVER
 M:	Bj=C3=B8rn Mork <bjorn@mork.no>
 L:	netdev@vger.kernel.org
--=20
2.29.2.222.g5d2a92d10f8-goog

