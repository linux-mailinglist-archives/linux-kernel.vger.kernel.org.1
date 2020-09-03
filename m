Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE18025B9DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 06:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgICEnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 00:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgICEnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 00:43:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8BAC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 21:43:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so1092908pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 21:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujAveOaaBdyq96Z9dyNuykpAuBn9CZjmoC9iNupYh6s=;
        b=HxyIm4L5zMFVFnsyDYvn3sqwdawBG4xlyQ9mc2VcvPEEzD+aPLCyxc8yS9SLibp30G
         CgfLUocFzE3AvHEUbRSh+dY73taKKlTF3IgZq/93F5USgv1PVL4mgZcnJ+RaGlt1Mw57
         NCdqdIJmw772VeH03O1dmCEB6IX8qnU5urVhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujAveOaaBdyq96Z9dyNuykpAuBn9CZjmoC9iNupYh6s=;
        b=B+5TI0XyQZaA9XgZWqB0DjIK1V+rz616QIg73ZmOQBG8fjTMIrsSj++QOWEyNFCYjV
         Yg8mNEfjeIc62SQDKuxNdThqmGBu5QR8wL1Ui80Wm7SFW+mtJsjsG1j+znYwhTN0utIt
         zWQcHDBB7JYuUpikjCMVRFyQJYMSi12v0cq0ID/6w5L2ibHWUoGLb7uYrvs9J6gHRLXp
         Nk22Y9yadpl8iS8kl8WQTCeOcHG1Q8ZEipVYtYxuIyB0ntk0P3t5x6SDcY0XRZFfeAHL
         02ftV0kjP0SMgsdh1yb7vy5pRPks/35OjHkbqU6vxcpjzqOoQzHIZdply6O0GCxNMs6x
         q2UQ==
X-Gm-Message-State: AOAM532ar70QSrBRoDFgFMFPT9Q39rihaOTGXMonbuWBlwBhhi+Xwxl2
        rhbT5+1z9oVNaPZR21UPMX39aA==
X-Google-Smtp-Source: ABdhPJzPDJi+mUaZKseRY+d6FfXdEB6IDIHsARy6IMBCmGx44gf2A4Nf4vZaOTrRIHiNU/jVPUugog==
X-Received: by 2002:a63:e347:: with SMTP id o7mr1288507pgj.143.1599108190812;
        Wed, 02 Sep 2020 21:43:10 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q190sm1236687pfc.176.2020.09.02.21.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 21:43:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andrea Borgia <andrea@borgia.bo.it>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        Pavel Balan <admin@kryma.net>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: i2c-hid: Prefer asynchronous probe
Date:   Wed,  2 Sep 2020 21:43:02 -0700
Message-Id: <20200902214250.1.I63d3f1c93f88cb0cda5161c42e97decb4a63a571@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding printouts to the i2c_hid_probe() function shows that it takes
quite some time.  It used to take about 70 ms, but after commit
eef4016243e9 ("HID: i2c-hid: Always sleep 60ms after I2C_HID_PWR_ON
commands") it takes about 190 ms.  This is not tons of time but it's
not trivial.  Because we haven't yet specified that we'd prefer
asynchronous probe for this driver then, if the driver is builtin to
the kernel, we'll wait for this driver to finish before we start
probes for more drivers.  Let's set the flag to enable asynchronous
for this driver so that other drivers aren't blocked from probing
until we finish.

Since this driver can be configured as a module and modules are
always asynchronously probed this is quite a safe change and will
benefit anyone who has a reason to build this driver into the kernel
instead of using it as a module.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 87ff93bf76ba..c898bd8617f9 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1280,8 +1280,10 @@ static struct i2c_driver i2c_hid_driver = {
 	.driver = {
 		.name	= "i2c_hid",
 		.pm	= &i2c_hid_pm,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.acpi_match_table = ACPI_PTR(i2c_hid_acpi_match),
 		.of_match_table = of_match_ptr(i2c_hid_of_match),
+
 	},
 
 	.probe		= i2c_hid_probe,
-- 
2.28.0.402.g5ffc5be6b7-goog

