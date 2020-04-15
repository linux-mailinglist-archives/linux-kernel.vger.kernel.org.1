Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5AD1A9284
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 07:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393312AbgDOF37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 01:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393297AbgDOF3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:29:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49367C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:29:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d24so838808pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bCc4iQ4ygRBodRsuGfneSy5bdVh5uMBWmu99paXEno=;
        b=Owej7V6OMCrpnkVdNDH45+VRMCzggv9PZDNxoxyfd0vzd/FWpLRMmiMKhdL5Kp939E
         WJKBDOXAp7ALWNeF4i2q83sKdAGlbG4m1Tv4PYkc68w/0C25nki2cbdVT2BOuBwA7i52
         daknjaEWNAB5lmzrP3E3QkFnDMB4SEPP2jH5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bCc4iQ4ygRBodRsuGfneSy5bdVh5uMBWmu99paXEno=;
        b=PjRX3+Jpb8P5xFUed85VC4CiFOWVMwOZkBqdS5gGMqycef5ihbZyyvzPdRxROJqQ7t
         j42PV8khhumXdspG2kTjp5JBCrO6tTcw7sPGXZn3EZV0obVpRocQIcx1Zq7J2wZzUWrw
         HRFqZAokG+YRFfOENurDscwEICt5QYqzK3seSNWCSopEKbBsVn0LP57f8Ez/ckmfWgAT
         l//yIEd4fh+b+u1wpcQrw7THKslRfckYO+R47YNx3g5SgWVuXNvzDElNXSLQ/5U8L22F
         pwFtH/fdOVDgBRuOeg6gmSkFnJhdgupAU339Ovx4EFu4dPCkWK/uC1XgFQO/0/scGSwv
         sAvA==
X-Gm-Message-State: AGi0PuZEx9pFjpEtWLVc9gkF7wst0JljWKLl/OUROvyaM4aMM/tU5tkB
        obGZ7jA0eZMnXTJ5pQP69mRboiReIjA=
X-Google-Smtp-Source: APiQypL7Cjvm4TwUw1nrSMgkAQIjoA8Z4kY+4SsYt6oJZBxQT+GKCsxwrPd/Qqcj45W6PPh8eIytyw==
X-Received: by 2002:a17:90a:a602:: with SMTP id c2mr4149088pjq.135.1586928591174;
        Tue, 14 Apr 2020 22:29:51 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id p1sm13314213pjr.40.2020.04.14.22.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 22:29:50 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v4 0/3] platform/chrome: typec: Add port partner registration
Date:   Tue, 14 Apr 2020 22:29:40 -0700
Message-Id: <20200415052943.93009-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series adds port-partner registration when
connects/disconnects are detected. In order to do that, we also register
a listener for the cros-usbpd-notifier, which will inform the driver of
EC PD events. While we are here, separate out the Type C port data
objects into a separate struct.

v3: https://lkml.org/lkml/2020/4/9/868
v2: https://lkml.org/lkml/2020/4/9/861
v1: https://lkml.org/lkml/2020/4/6/1155

Changes in v4:
- Modified typec_register_partner() error check.

Prashant Malani (3):
  platform/chrome: typec: Use notifier for updates
  platform/chrome: typec: Add struct for port data
  platform/chrome: typec: Register port partner

 drivers/platform/chrome/Kconfig         |   1 +
 drivers/platform/chrome/cros_ec_typec.c | 119 ++++++++++++++++++++----
 2 files changed, 103 insertions(+), 17 deletions(-)

-- 
2.26.0.110.g2183baf09c-goog

