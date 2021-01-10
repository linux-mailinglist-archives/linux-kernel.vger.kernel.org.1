Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24C22F06C0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 12:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbhAJLyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 06:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbhAJLyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 06:54:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2884C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 03:54:05 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p12so6089451pju.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 03:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VrQQUPI56TTkrQd0HB4Qa4KAsPZx7AHK+GwBGWgvesk=;
        b=fzgc8Ut2i//vG1wPgWUWhTlkVqOf6sMPDaplhnO79PmzwL41jsSKSHH2n77yGoFaIK
         HMy1aVSXQ3EM2zqa+ESyXnflvabYfHfTfu76SN+gzFlrvUxU1fwfrf5GUZv7OqqAg5O0
         8vFfM/D67m9+9OE5gdTlkg1axyScBiNRYs9PyGObGwkl9DkTpznwN9QdKQO34eMs+u+6
         pR+cQLdglriBWlKYFvtwcyowHTGBNPY3ZouLxkY/HHIl/AGWY2mKyKSnknp1Q4xIhumb
         Lifl9Wt/D+h85DnYQU9L5EMpRoTDbCrRkCcaAs9BaUpypvJKXf4ueYGacj5BUrvm4qoA
         rSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VrQQUPI56TTkrQd0HB4Qa4KAsPZx7AHK+GwBGWgvesk=;
        b=UPh4zKfrxhBhNRLpLSmL9SWojj07wOaetC0erzMJroVHBF6oqhl+jm5NrJ8fxPD/4g
         63u9NZ4o7x9EaPfk4IuJ2kGtyM+c9cYt2G8Y1MG7uRvtatl4rnfuwRK+tGOGcb+r+csX
         lMYWiLCLakUZHwTcv2XKhEJJqlDqSZ3QOQfKxra8Q+FI/fPq7ZQckGdiYfl/dUgusjV0
         k60O6FaTYai2D4qQoB6jLlvZ4NeQuaJT4ik0aHgOSbkwxRy3UJ2kqrQ6NITSoFOQCiIS
         O1NIYBLpnLoJpzPAX13NQ/NWGsW3MUXICBfGQvBRjIUPMFn4GWTOBHaZfURAZ22/5Cdz
         UVyQ==
X-Gm-Message-State: AOAM533p41vtdIeNNLXIxGWJyJDHFVetnMgcIPWiyBeQDmodUnLGli55
        Yu03QiiPTFkoDccHAjM0T2gHzw==
X-Google-Smtp-Source: ABdhPJwL6nVy7+Pcy+4C2dqM0lgsiHbO7tJRmB7Tq2ToRvCdHG7Jm+eOZlDduAmKz6Cj+flOaZmCQw==
X-Received: by 2002:a17:902:7007:b029:dc:e89:50f1 with SMTP id y7-20020a1709027007b02900dc0e8950f1mr12102454plk.72.1610279644969;
        Sun, 10 Jan 2021 03:54:04 -0800 (PST)
Received: from always-libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id x1sm15613906pfj.95.2021.01.10.03.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 03:54:04 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v5 0/2] misc: pvpanic: introduce capability & event attribute
Date:   Sun, 10 Jan 2021 19:53:56 +0800
Message-Id: <20210110115358.79100-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 -> v5:
Use sysfs_emit to export attribute value.
Only allow subset of capability to set on events.
Add more detailed infomation in document.

v3 -> v4:
Use event sysfs attribute instead of module parameter.
Use driver dev_groups instead of creating files by sysfs_* API.

v2 -> v3:
Seperate the function to 2 parts:
    1, use sysfs to expose device capability.
    2, add a module parameter to set limitation by user.

v1 -> v2:
Remove device info log, use module parameter to expose capability.

v1:
The guest sides determines pvpanic capability by RDPT, before kicking
host side, check the event is supported or not.

zhenwei pi (2):
  misc: pvpanic: introduce device capability
  misc: pvpanic: introduce module parameter 'events'

 .../ABI/testing/sysfs-bus-pci-devices-pvpanic | 14 +++++
 drivers/misc/pvpanic.c                        | 58 +++++++++++++++++--
 2 files changed, 67 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic

-- 
2.25.1

