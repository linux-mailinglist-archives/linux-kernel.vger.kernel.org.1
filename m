Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7443A2E2403
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 04:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgLXDUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 22:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgLXDUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 22:20:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320F9C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 19:19:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h75so1728444ybg.18
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 19:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mk3IEUt06sDvVA1clSFII49sZH3UPqks6XPQtfaaM2A=;
        b=nTV78gIaL2c1ZyNCGPBOg2SWKiC13WVID59PHts0exX7WQ4CGqfP1Xi6lqwipMSskr
         jCdyMtscbgUlWGxR4FhLXEpnYWwNdQYN8hNoq3Ftvz/6eglQ6JEXXLvtRliPENpXl9kx
         bT7qEq8PqKD32mA90xOxPFa6mGYH8lsVYCNyCbMToB3lIqMXGIHqs/4RmGcJ9Flv/V7R
         WbKFbwoL33J4U6NQ5ucZN6dWLpGyi9NTydTFVKihZmn5UIAIG0EncuLP3bUwrdudjNBO
         RR1RL5lttfqXS38dCxSjRXocZFm2JJqlJMGmPWUXtc8jGdENRrMa6ePAvNBNDrEWhyVS
         Ak2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mk3IEUt06sDvVA1clSFII49sZH3UPqks6XPQtfaaM2A=;
        b=AXa2HXoxpvgYUR36VMCpFjDgErEi5fMyG1WqLhVcgjfLjbjAaGUNUnyR73/C1hnUH9
         tOu40O7aLMB7SWe4D6a/duBi7TCI/mpYGpI42+UQWwfdlygwbwYvN2hBO7+5M+2i6LIj
         4WhkvwgZJ2DHMKA8qYSDKC3UK8nJKuQIFlCJdjd2uPU5KOHTFgcZ08R4GrOoRvvPA5/m
         UlQACbqW7yVovODfgyJu5ZVQ8po3kxd8XthhAhcCGpwBh6v6jOx1nzNiZou7dRjiw/TQ
         D06QbwEWPzU4JR7nNQTcA1sLT0v1Phsm80zZukM3UWsJy5EkItHsyIaEZlIwwGAo9sSN
         V6Zw==
X-Gm-Message-State: AOAM530SHCPINPHKeGURDgVubQe7+ifNrwcZM5jHhsVZToL1jnxPzBWr
        XqRFZvtBf5Nu7z+opSDHt/oSi3X0iUAE/A==
X-Google-Smtp-Source: ABdhPJzc+fUOQroVCECGgIesPH+6wCNbIxWTJTywv08eXHy5rY4tG3xwARmFmew944NYTh8NPP76WLRUm3TiLA==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a25:9c07:: with SMTP id
 c7mr41070666ybo.21.1608779964260; Wed, 23 Dec 2020 19:19:24 -0800 (PST)
Date:   Thu, 24 Dec 2020 03:19:20 +0000
Message-Id: <20201224031921.1547519-1-jbhayana@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [RFC PATCH v2 0/1] Adding support for IIO SCMI based sensors
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

commit f83eb664cdb4 ("Merge tag 'scmi-voltage-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-next/scmi")

in Sudeep for-next/scmi branch:

https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/\
linux.git/log/?h=for-next/scmi

This version of the patch series has been tested using 
version 5.4.21 branch of Android common kernel.

Any feedback welcome,

Thanks,

Jyoti Bhayana

v1 --> v2
- Incorporated the feedback comments from v1 review of the patch
- Regarding the new ABI for sensor_power,sensor_max_range,
and sensor_resolution, these are some of the sensor attributes
which Android passes to the apps. If there is any other way of getting
those values, please let us know

Jyoti Bhayana (1):
  iio/scmi: Adding support for IIO SCMI Based Sensors

 MAINTAINERS                                |   6 +
 drivers/iio/common/Kconfig                 |   1 +
 drivers/iio/common/Makefile                |   1 +
 drivers/iio/common/scmi_sensors/Kconfig    |  18 +
 drivers/iio/common/scmi_sensors/Makefile   |   5 +
 drivers/iio/common/scmi_sensors/scmi_iio.c | 693 +++++++++++++++++++++
 6 files changed, 724 insertions(+)
 create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
 create mode 100644 drivers/iio/common/scmi_sensors/Makefile
 create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c

-- 
2.29.2.729.g45daf8777d-goog

