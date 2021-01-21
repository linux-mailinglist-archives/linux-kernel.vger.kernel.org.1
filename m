Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC872FF8AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 00:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbhAUXWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbhAUXWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:22:35 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7A2C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:21:55 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id p8so2725652pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=VVJ18jo9wChTO7xYiVHUOH7AGcTMx8WNIb4MUAmrhNU=;
        b=kUAG9VEXYC1S/8FUYLcyZ1ErjhZkE37BNTiJed1mjrlxgtfSSkObexCkpOM1YHzvPf
         R6H7GgBnPMZYs4/NP3vHjGcaBWlgLRSlXlOP4ZJbJJlEGES1+GOgPie0vcZx/cWa2rtT
         kzLZI/ffEtv2Cq4HYpChR3hf6q8QSMM2fpXKOKFxAaQ99AssRtXNcVtY7T7B9OJszKIX
         8rEdaHRsfTPqAMo4bFxHRa+x1I3vQIA8VjTL1xbtHuRdq0ZFAZczwEMwB0yGoreIxUZi
         M5uurYfv084P1Az0TOUhlJ3kkMRAP+XpPN3RKQsxTW6vt/MLFmPgZcSceIE/TBKmy55S
         nwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=VVJ18jo9wChTO7xYiVHUOH7AGcTMx8WNIb4MUAmrhNU=;
        b=o8COoWOjEGTOTkkSotYP99HSnkOjVIB19CpcEwfdkQgtzhSIWvaKPKT8WvPR/ad4bu
         vPDrniIudsop91mAs0CbDkvKL1Tou8wTrcf846pjpiDsoBzP85trTvMgSs/0y/hJhtTy
         pCl2DFlpRrTCpaiXOde3jtwBjx5qDPFByAJK6f1yqeLZ+gVZadSRUb6CkSsH43yG5vxm
         erHUW29ZdIEpKikttuWGPX0Jx1ONW1HnzGPokFB3UQzdszdE8rB4Z4r4Ltj7/6eLzkg2
         nwwps1732rPMAwUQbdcuUvGFmolwTQb8ep4ZulDFuTMIJxWJ1hMo2IhB600spRcJQijG
         I/pg==
X-Gm-Message-State: AOAM530sRUhb6hKwvHmyKuxVfJgv8cKgj23cqCQRM0KznywyF/sUsz3T
        b+17xlFZi5bgk1aUxVp8kTGmy9aibiKwUw==
X-Google-Smtp-Source: ABdhPJxfyLQMocQPaTk75qAl6HUcaSSq+RJ6eWSQntz8aLR5szNU7Vqcs6APVSzcYDBIv6ZvUcGOaj1r3VWdOg==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a63:f405:: with SMTP id
 g5mr1746475pgi.276.1611271315059; Thu, 21 Jan 2021 15:21:55 -0800 (PST)
Date:   Thu, 21 Jan 2021 23:21:46 +0000
Message-Id: <20210121232147.1849509-1-jbhayana@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [RFC PATCH v3 0/1] Adding support for IIO SCMI based sensors
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

This version of the patch series has been tested using 
version 5.4.21 branch of Android common kernel.

Any feedback welcome,

Thanks,

Jyoti Bhayana

v2 --> v3
- Incorporated the feedback comments from v2 review of the patch

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
 drivers/iio/common/scmi_sensors/scmi_iio.c | 736 +++++++++++++++++++++
 6 files changed, 767 insertions(+)
 create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
 create mode 100644 drivers/iio/common/scmi_sensors/Makefile
 create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c

-- 
2.30.0.280.ga3ce27912f-goog

