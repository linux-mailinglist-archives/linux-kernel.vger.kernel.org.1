Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6D2D70B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 08:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436750AbgLKHNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 02:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436728AbgLKHMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 02:12:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C3C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 23:11:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z83so9936349ybz.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 23:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=S/8U8Wqnz8DEcGGiOqsnrJd03FjrqIJ6MV2RgXvfHHw=;
        b=bHFK7rVtg7vjW5mqAuGF6w/HJr0MS15XcdG9l9J/NwPma77Y3WMVsmb6VppS+CoNzR
         KvP9mHQsBvTfcfn+lAY8cc+F2bFvgI5FKWm1kbJ7ZxpC3RLsRReZcwuVWcNjLwf5mPPZ
         Z5wiC4JHuHePQzWhflnd+rFLMYuRwnXKnavSlDwRFRfCEqEwT5a0lzkwygPz9XFhgpY6
         2Z+bhgYs3Tv9NRwjbroy7Sivgf8ygE9bpaNWGiWQuwJK1w6NQRBBDK/CNlxWTu6/by8s
         6KqfaUVS1CXysjPSRRw0miUqB++goVb1AvlRYwbwUbjCd6YNDcJwgWKAliSUlPM4Srqa
         3efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=S/8U8Wqnz8DEcGGiOqsnrJd03FjrqIJ6MV2RgXvfHHw=;
        b=WNmzGzEVvSYD+jw/Div77olUbDUy/vLuD6ZtzN7f6p2v5Oq0tQMePEa7wENA28Nrb6
         AONL1pI+u7U0c+NHbE17henj5iuPDwRgjturATjv6dRbCYy6bSaPczW4VZq5UTVSkOFx
         oWVy0NAHQxjoThJLKvp8f4+RUgZhnJBZjg0Ot9/PCwX6Uef3ycMBXTQ3mPYDNc71nAlT
         xYoCsb+E0Oqf41OvMZQ0P3WCHRHp2jH1RB49hQu71UnlCVFgfhMVC/BYenrLfip30i0m
         wH0OLrYfvKW8MQseM3d51OpIToXF9vtYVj8N6dGquPq0N1Rz2iZ3iALLijYMx67vy0kK
         sxfQ==
X-Gm-Message-State: AOAM531SKUBbSAjtTfjizu//o2IXRaneuY4fmGDfi+H3+bLhz40HhKHi
        ttxinyuvQNAQ50/iSvaWJJdZrgiU7xc=
X-Google-Smtp-Source: ABdhPJwRTQiqAJ5JI/0c+gXsHXlIYhxacBL2hWJrIemL9wBvY5jVOnTWKtM6UvkqYafnPR4cbDFWgKdmw7k=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:4155:: with SMTP id o82mr17218335yba.206.1607670710264;
 Thu, 10 Dec 2020 23:11:50 -0800 (PST)
Date:   Thu, 10 Dec 2020 23:11:45 -0800
Message-Id: <20201211071145.2199997-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] usb: typec: tcpci: Enable bleed discharge when auto discharge
 is enabled
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

Auto discharge circuits kick in only when vbus decays and reaches
VBUS_SINK_DISCONNECT_THRESHOLD threshold. Enable bleed discharge to
discharge vbus to VBUS_SINK_DISCONNECT_THRESHOLD upon disconnect.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index af5524338a63..f676abab044b 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -725,6 +725,8 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
 		tcpci->tcpc.set_auto_vbus_discharge_threshold =
 			tcpci_set_auto_vbus_discharge_threshold;
+		regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_BLEED_DISCHARGE,
+				   TCPC_POWER_CTRL_BLEED_DISCHARGE);
 	}
 
 	if (tcpci->data->vbus_vsafe0v)
-- 
2.29.2.576.ga3fc446d84-goog

