Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81A2B217F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMRGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKMRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:06:17 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1A8C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:06:15 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id w16so6443655ply.15
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=dj0jv6XXUDKICvtLjODWA/Yz9MrznwTlv4Lm1G6nAlI=;
        b=JHKXAEK1eudje5I7yL3R44oqiAFIfxWMjFzNJyAVSLvG7nPAxdQXAM9/nvBFe6VgSp
         6TrEcLpfE3oFnvYxgV6jAqCJQwyKxfDoLYzZiYAGxaQKMRfQpiZJ1qW62udOxkcodIWL
         mkvKd3HJ/UlfcdLMo6CoYtOATPQnT9h2xPb9x5zf5VR0ninRwUk4LG2tcV3H+KMfufzo
         ku2fx8H4hgx0o324OARg6i3otBJmfg9Zcdbe7Gl4FrhZom3XpTjOmDzz1L7PNyGi/2Hr
         43NdPWFDOBCqmY+jWxCBtlFzeUL32V2dDDVIM97W4j4Rq3KjasZndZxnb8eMbrffiMuO
         IEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=dj0jv6XXUDKICvtLjODWA/Yz9MrznwTlv4Lm1G6nAlI=;
        b=uLUQfwcqALG3/2WS9jSTi7cC61ndsrSP7POG83kjZYjf/wMrpnlDGA6UEfIMO+h68k
         e1laYYPDN5qyLBYfoDKtfMryP9bzDhoUMpSOjGYsrFNOAiEddecY5S+qteECd2q+iOHx
         0qUTUCB71qMzrAC/mmdp8eU/V8qpWzX6Y8EKKDrvYVWNbpbOKx8CbD37UUGpJC15akxP
         o1QL73TqKcdATqGor68ML7yJvYDb6EhL/gWI9K7kzzpmRxaVhOKJ/O2Tri1mLBliJ3Bc
         zDxDZRC5pbr66D+CXySp9o5TghxoWV4lJ6S0yFhfndC6AYs2sFjwbEHaeQQMyIPM8TAB
         c3uA==
X-Gm-Message-State: AOAM530ROmeWbanDZRYDKCvMnsUejHxp1bGppIWgb5qTA4NnCpXwhxi0
        6fTqP5BAwWoSrEZGHGSYJPxb2gB6a2DRBA==
X-Google-Smtp-Source: ABdhPJzF7xYbHCu+ksjPx54Cod29NEjLlNMO11OIFrFrkXXVrv4alG0tupojocqKb7LnnfcIxmggd4L0on9StA==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a17:90a:fe0a:: with SMTP id
 ck10mr1861259pjb.233.1605287175249; Fri, 13 Nov 2020 09:06:15 -0800 (PST)
Date:   Fri, 13 Nov 2020 17:06:10 +0000
Message-Id: <20201113170611.378887-1-jbhayana@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 0/1] Adding support for IIO SCMI based sensors
From:   Jyoti Bhayana <jbhayana@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jyoti Bhayana <jbhayana@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        egranata@google.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, Peter.hilber@opensynergy.com,
        ankitarora@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for ARM SCMI Protocol based IIO Device.
This driver provides support for Accelerometer and Gyroscope sensor
using new SCMI Sensor Protocol defined by the upcoming SCMIv3.0 ARM
specification, which is available at 

https://developer.arm.com/documentation/den0056/c/

The series is currently based on top of:

commit b9ceca6be432 ("firmware: arm_scmi: Fix duplicate workqueue name")

in Sudeep for-next/scmi branch:

https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/\
linux.git/log/?h=for-next/scmi

Also, apply latest patches on the SCMI V3.0 Sensors extensions series
found at:

https://lore.kernel.org/linux-arm-kernel/\
20201026201007.23591-1-cristian.marussi@arm.com/

The purpose of this RFC patch series is to get the initial level of
feedback. This version of the patch series is not fully tested.
Only the older verion of this patch series based on linux kernel 
version 5.4.21 has been tested using branch of Android common kernel.

Any feedback welcome,

Thanks,

Jyoti Bhayana

Jyoti Bhayana (1):
  iio/scmi: Adding support for IIO SCMI Based Sensors

 MAINTAINERS                 |   6 +
 drivers/iio/Kconfig         |   1 +
 drivers/iio/Makefile        |   1 +
 drivers/iio/scmi/Kconfig    |  16 +
 drivers/iio/scmi/Makefile   |   5 +
 drivers/iio/scmi/scmi_iio.c | 780 ++++++++++++++++++++++++++++++++++++
 6 files changed, 809 insertions(+)
 create mode 100644 drivers/iio/scmi/Kconfig
 create mode 100644 drivers/iio/scmi/Makefile
 create mode 100644 drivers/iio/scmi/scmi_iio.c

-- 
2.29.2.222.g5d2a92d10f8-goog

