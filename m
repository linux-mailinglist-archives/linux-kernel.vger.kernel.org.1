Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AAB2C966B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 05:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgLAEXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 23:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgLAEXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 23:23:22 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F587C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 20:22:42 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id m20so477102pls.21
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 20:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=N92L65vs0hZN6sbhv8nMQq5Z7xcM5ZZapP+dkcKSuqU=;
        b=btWG3ONsCv6PeV3rp4vVFHmjusgTjmABN+C30bO1SGVHFSe6C36HvYYA8ndJREdbxs
         FdRSol/vyFkUDbPfE0BGjqgIfP37sh8D79rUvGOjEJxaSCEo/lJ5WbKrojuDYEkil0N+
         1Z/MKpcDZ3RoBNQpKReNzbAidMoH0Iw1fCPmVGzMh98X1F6RkR5NUawp4sWtcw9dOfvB
         zITNk/XOaHGym+CMM3ICvOROcfCqzjA1azMME4Yhi6SCpQvXs6B+j0WtIi8VNfEYg3qY
         gy61pPYTEdsQJ9IkJftP19SqoDustePtMHzucxxnYGok0ncgMcv0+65nuxpgMfao1Q1Q
         rGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=N92L65vs0hZN6sbhv8nMQq5Z7xcM5ZZapP+dkcKSuqU=;
        b=NGTaRwalOoM38XF3ZnyfhzmCABN4tmBEm1MXsVHNQI0IzjD0QWt4GePxN03vEBMgf+
         J67YTiIEJ7v/maXuTr8dlSxqFj7DJ4vf3lYOViZ6GKxFFiaDUPIYXpTx6nj2hypG4HC3
         uh+v22RIYIYwdzRUngNfRTvxIRmwTA10o7it1yEKMfqnop9Kitvv/4oFzda21vuEcOdF
         PWvESS+WrqRrUg3t1+OyFI2DE62wjCBYSCCKzTn5nWqXFPsD0X1hACsNZr1r0oDNlyLY
         9xSDkAaJHXx/qFsxmflnoU7PR5GEQ/kmGqiTpmcxyQz11t+MSGx0kXB2fhApa0D91y66
         MtlQ==
X-Gm-Message-State: AOAM533kdXb65+0Z23+xJvjSzBaoLOJE7OoKgGX0h7SFBJTxt/5K55B0
        h2A0GV2cNozkkrEwcVTDj+0pPMdPMlk=
X-Google-Smtp-Source: ABdhPJxhNSfzVMCAuC/49qFFxX8y+9/ZZDYhsrntdi227pnDJ6CxFEJDZzTM3YSri7VOtC1aCo1lP0v350Q=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:90a:460a:: with SMTP id
 w10mr121176pjg.1.1606796561660; Mon, 30 Nov 2020 20:22:41 -0800 (PST)
Date:   Mon, 30 Nov 2020 20:22:34 -0800
Message-Id: <20201201042237.414235-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v1 1/4] usb: typec: tcpm: Pass down negotiated rev to update
 retry count
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nRetryCount was updated from 3 to 2 between PD2.0 and PD3.0 spec.
nRetryCount in "Table 6-34 Counter parameters" of the PD 2.0
spec is set to 3, whereas, nRetryCount in "Table 6-59 Counter
parameters" is set to 2.

Pass down negotiated rev in pd_transmit so that low level chip
drivers can update the retry count accordingly before attempting
packet transmission.

This helps in passing "TEST.PD.PORT.ALL.02" of the
"Power Delivery Merged" test suite which was initially failing
with "The UUT did not retransmit the message nReryCount times"

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 include/linux/usb/tcpm.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3bbc1f10af49..c73bc3a8356a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -667,7 +667,7 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
 		tcpm_log(port, "PD TX, type: %#x", type);
 
 	reinit_completion(&port->tx_complete);
-	ret = port->tcpc->pd_transmit(port->tcpc, type, msg);
+	ret = port->tcpc->pd_transmit(port->tcpc, type, msg, port->negotiated_rev);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index e68aaa12886f..efaedd7e8a18 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -121,7 +121,7 @@ struct tcpc_dev {
 			      enum typec_cc_status cc);
 	int (*try_role)(struct tcpc_dev *dev, int role);
 	int (*pd_transmit)(struct tcpc_dev *dev, enum tcpm_transmit_type type,
-			   const struct pd_message *msg);
+			   const struct pd_message *msg, unsigned int negotiated_rev);
 	int (*set_bist_data)(struct tcpc_dev *dev, bool on);
 	int (*enable_frs)(struct tcpc_dev *dev, bool enable);
 	void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
-- 
2.29.2.454.gaff20da3a2-goog

