Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4953329382F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405768AbgJTJg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405753AbgJTJgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:36:54 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37B9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:52 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id m11so849299qvt.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=r3JzWUNRrjq682a06yIScf4/krvhqrY6PtINhDvgCTc=;
        b=jNnueWZgP0hwxnWozjesm/JVD1/uoPvY7/+6OPyoWzNYfPM2OBr5L3e30WeWbYkX7i
         g5KaYozep/eGB8kn6FkGQgfhEW1ZVoBhePHvWgCyNz9S641EGAWvL6FWQcDHO3VowqJ2
         LztVnUlhG0N0EQvHQiu+K0mcFAqGDVfxJse0W3+Ie/bLP069GRglRfNS19znRj2pTKlC
         Uc0mn+mB3SVOOyNlm9mTCEwXTZtnEonhU0qh3QCbDXo5+uLbAxE2o/10xVhv+0zZ6LKb
         jl2K0KS+F8FYFA3TnRneZ1106cyvXXZawhde9BG2sKrq8xrl1WRZcUPKd90SPV3C/Viz
         1QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r3JzWUNRrjq682a06yIScf4/krvhqrY6PtINhDvgCTc=;
        b=eKAEObLHgkaslNnIENt7bREmrqeiyZz/1ygAXQJCrtJVpABWJyr3RyC1hsu1dcSi84
         fzgpbz9IisVQXHQHFaVu2Z5W625FdbvVCfwiSvsERCXZfZRTaiXvoFj6V8WURzxzcBsW
         IyBYBGVsfG84JPMkCPgyIj8NZrCOV1wnKohI6mokBLGI90DNJOWMCbDeI5r1ht3dZSj2
         RVAIKWWxcT1mQKCfsZcxCl2WRIWdAbmCtZAsJK2ZRj8v6Ne3BN3c3dk33iKrp81xO2f+
         1h6e9ASaACDG5MI/cjCRHM8QT9tL1mcpciYrxgbqqnDc09l2angrYP97NbswT+5hYFED
         r5Jw==
X-Gm-Message-State: AOAM532Tal+NtA3tn50cqgoJqV6gvRFLjzqvBF8UsFcIe/CCR3KuN7ph
        alZZfXubmOJscoVd/3SwljJlNBCKVYM=
X-Google-Smtp-Source: ABdhPJyTHPscP95/S9HiCZTpVZgRDFJES7WtA9XrSALnIO/5o9I/qTrCxXOEpoAq5Oq4K6Kv8thbg73zAqE=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:ad4:44a8:: with SMTP id n8mr2393037qvt.29.1603186612161;
 Tue, 20 Oct 2020 02:36:52 -0700 (PDT)
Date:   Tue, 20 Oct 2020 02:36:27 -0700
In-Reply-To: <20201020093627.256885-1-badhri@google.com>
Message-Id: <20201020093627.256885-11-badhri@google.com>
Mime-Version: 1.0
References: <20201020093627.256885-1-badhri@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v11 10/10] usb: typec: tcpci_maxim: Enable auto discharge disconnect
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable auto discharge disconnect for Maxim TCPC.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- Rebase on usb-next.

Changes since v7:
- Heikki's suggestion:
Moved the actual write of TCPC_VBUS_SINK_DISCONNECT_THRES
register to tcpci code.

Changes since v8:
- Moved the logic to program the default values of
  TCPC_VBUS_SINK_DISCONNECT_THRESH into the tcpci code.

Changes since v9:
- none.

Changes since v10:
-Added Reviewed-by: Heikki Krogerus
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index aa54b0cf7a64..3c6812daec3c 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -441,6 +441,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	chip->data.TX_BUF_BYTE_x_hidden = true;
 	chip->data.init = tcpci_init;
 	chip->data.frs_sourcing_vbus = max_tcpci_frs_sourcing_vbus;
+	chip->data.auto_discharge_disconnect = true;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-- 
2.29.0.rc1.297.gfa9743e501-goog

