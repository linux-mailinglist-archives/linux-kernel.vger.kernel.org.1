Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8C92D815A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393200AbgLKVzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393178AbgLKVzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:55:16 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35174C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:54:36 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p19so5441964plr.22
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=hYQLpIQAE5/Axip10es018C6XUh3MhNHtJpTlD1WAo0=;
        b=Yq2V2+0S/HCmoRwuPzTrXXqUv25lxJFRuUv5r7ayLhb8FnOfnEARyaJkpBzfJL5h0W
         SLjC9hGEOX/MTmi+SY3koZs/ZkE2dfUWqywpj+e1ZUDVELZetvYSTt+BE/LNk11UIo6C
         KQ/9GhxMIaLFSlmA9li80DJZ53+biNSYNjJEUMHpA9JUh2X+P75thAjpPw24cEEU0xwv
         KegG221gNp94gxhUAiIJ1saLt1E7YAzulaySc4XMmZrWNa2tt+yRTj4/FFhlp0DCppUB
         OCptSkHJLUlehIwV0kzeXp6z/+Ezpt40k8gtYS2O28oe82tJ72ofv1DRUMphPfKsIVVk
         no6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=hYQLpIQAE5/Axip10es018C6XUh3MhNHtJpTlD1WAo0=;
        b=ecJ9QFW/ShKGUkRLxXB1x+SeHkn0RyH71oLPvzP4jQqIGQTDyBHvbyhO+NTSOmdaWq
         2V61AOpuJWS99MAY2wAw34HdauxM9EyJ3yB6wvx4ws7cWA1Z2laFnkLNuYGBfGQYHEpi
         wyIO4xUqhVOpiPCajUkah9JMzhZ6jQYRYxHQpKDJSIk2c7fNBNdeq3qClegS420/lz+a
         xH7vAq3WoouA60LT6ZJsf5Xp465OA8qPc5m6+t+EBKGfYoPDoDJ+UkolvbK7UwB4l5pr
         /GT//PvGQfZMP7G6eHltMChPzlf9031KnJas4H9jb1N/RCuGhXoXDYJKMD4E1gRFW+yH
         4N+g==
X-Gm-Message-State: AOAM5313bk5Iob9JfOoZfK/wkdwHhAvtkrq61NYmvwWyNZC6HjPWfLFo
        xXMMw6sBeedZCRxNL3TxxtHq7kIUrA==
X-Google-Smtp-Source: ABdhPJxtfdrdKRpRKa4d5PNa0dLBVDAHtyXSihMPO14aQqpZ26aPmkyBpZu6VDejyrLbK+HND/kTNhUhag==
Sender: "kunyi via sendgmr" <kunyi@kunyi0.svl.corp.google.com>
X-Received: from kunyi0.svl.corp.google.com ([2620:15c:2c5:3:9657:a5ff:fef2:53bd])
 (user=kunyi job=sendgmr) by 2002:a17:90a:17a4:: with SMTP id
 q33mr1446850pja.0.1607723674991; Fri, 11 Dec 2020 13:54:34 -0800 (PST)
Date:   Fri, 11 Dec 2020 13:54:24 -0800
Message-Id: <20201211215427.3281681-1-kunyi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH linux hwmon-next v5 0/3] SB-TSI hwmon driver v5
From:   Kun Yi <kunyi@google.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, supreeth.venkatesh@amd.com
Cc:     Kun Yi <kunyi@google.com>, openbmc@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5: addressed comments in v4
v4: addressed comments in v3; converted DT binding to required schema
v3: addressed comment in v2 and improved documentation
v2: rewrote using devm_hwmon_device_register_with_info() API and addressed
    comments received in v1
v1: first version

Kun Yi (3):
  hwmon: (sbtsi) Add basic support for SB-TSI sensors
  hwmon: (sbtsi) Add documentation
  dt-bindings: (hwmon/sbtsi_tmep) Add SB-TSI hwmon driver bindings

 .../devicetree/bindings/hwmon/amd,sbtsi.yaml  |  54 ++++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/sbtsi_temp.rst            |  40 +++
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sbtsi_temp.c                    | 250 ++++++++++++++++++
 6 files changed, 356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
 create mode 100644 Documentation/hwmon/sbtsi_temp.rst
 create mode 100644 drivers/hwmon/sbtsi_temp.c

-- 
2.29.2.684.gfbc64c5ab5-goog

