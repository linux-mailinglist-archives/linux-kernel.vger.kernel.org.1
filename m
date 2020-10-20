Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A24293826
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392935AbgJTJgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405631AbgJTJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:36:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F979C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a12so1460882ybc.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=68+qkqJJ0yGLVD99S4hdTLHhp4Q61Io/XotXvcoBiV8=;
        b=ZR2wc6dslObVvINB9BUikIlKrnpZm/ejNhWBSswVwuHXvxAX9xWLlasnBYoDLa2QFX
         S3aAcemb9GkFUrue0XxER8DBdvl91wF3vcDl7FtI8k+F4cNA+/8PcCwYjSz/Klcs37SW
         zI7QywfZicOrHzgPcypyayEfKcsIE3m7k0jgGsDoGEh386tmay9J3AwoAPUcMit7307F
         1kvgZAJJ33mie4RXZSuuw4BXx+AdTYXnoEWClQ+HzXuTIti4Y5YXApZgujTAoa2c+1ve
         aGmsQoyeXW0qPmqWKsLQ3JdYooQko3Lu8UDl+FINeY1tWZGngo+nglwnFAv5W/AEPLLL
         hWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=68+qkqJJ0yGLVD99S4hdTLHhp4Q61Io/XotXvcoBiV8=;
        b=OhcnZIt9PEo866U9fDL4+Hkit5jx5He1qaZqvRc9YWx++RMHomN6c0xm4qvRl8WRh9
         J4U0AWjOFyhypDmTUZd2GB25PqjtVIBDHeYcRdoryQ80qVy5FBlZ+m1zMJ9T166YZC3J
         uFKZLuMQBW30vWHw1VohDdkWBifVmwZUDravt6bc+Uy/gyWzX5Q2ST3r2KpOAuKenb7M
         z9sEd8Oq6/NEZEYRak37rbVUa/zpSM6YtCxZ8LmEbpiAPQBrGZH8u5OKxmYLShdvNpDr
         pVeUWU7Z30B9cjXIbVqgLTvATPzUfIizssYkXI1EHlpkz3m2GspYAGEoek8EyhZDAhkb
         eubw==
X-Gm-Message-State: AOAM533je/V6gnB7ebEafN2lfiosIbyEtIvFoC+CmHIs9I+D+SRnusSI
        aa/lKa8UmRMUBnUnAYRAGeO7sV4LFVQ=
X-Google-Smtp-Source: ABdhPJyil+TPK0fD0mAFL5BbejbF9pJeXKE7dbv/JGrJAocl14Pd/3zIJQ3exhUfNX3qiZIpkT8FNM8G4Os=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:84cd:: with SMTP id x13mr2587479ybm.430.1603186600445;
 Tue, 20 Oct 2020 02:36:40 -0700 (PDT)
Date:   Tue, 20 Oct 2020 02:36:21 -0700
In-Reply-To: <20201020093627.256885-1-badhri@google.com>
Message-Id: <20201020093627.256885-5-badhri@google.com>
Mime-Version: 1.0
References: <20201020093627.256885-1-badhri@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v11 04/10] usb: typec: tcpm: Refactor logic for new-source-frs-typec-current
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

New source's current capability is now defined through
new-source-frs-typec-current. Refactor tcpm code to parse
new-source-frs-typec-current and infer local port's new source current
capability during frs.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
v9 is the first version of this patch in this series to rebase
TCPM code to read new source frs current from
new-source-frs-typec-current.

Changes since v10:
- Moving back to u32 for new-source-frs-typec-current.
---
 drivers/usb/typec/tcpm/tcpm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 55535c4f66bf..561480b67bce 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -363,8 +363,8 @@ struct tcpm_port {
 	/* port belongs to a self powered device */
 	bool self_powered;
 
-	/* FRS */
-	enum frs_typec_current frs_current;
+	/* Sink FRS */
+	enum frs_typec_current new_source_frs_current;
 
 	/* Sink caps have been queried */
 	bool sink_cap_done;
@@ -1713,7 +1713,7 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 	unsigned int cnt = pd_header_cnt_le(msg->header);
 	unsigned int rev = pd_header_rev_le(msg->header);
 	unsigned int i;
-	enum frs_typec_current frs_current;
+	enum frs_typec_current partner_frs_current;
 	bool frs_enable;
 	int ret;
 
@@ -1786,12 +1786,13 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 		for (i = 0; i < cnt; i++)
 			port->sink_caps[i] = le32_to_cpu(msg->payload[i]);
 
-		frs_current = (port->sink_caps[0] & PDO_FIXED_FRS_CURR_MASK) >>
+		partner_frs_current = (port->sink_caps[0] & PDO_FIXED_FRS_CURR_MASK) >>
 			PDO_FIXED_FRS_CURR_SHIFT;
-		frs_enable = frs_current && (frs_current <= port->frs_current);
+		frs_enable = partner_frs_current && (partner_frs_current <=
+						     port->new_source_frs_current);
 		tcpm_log(port,
 			 "Port partner FRS capable partner_frs_current:%u port_frs_current:%u enable:%c",
-			 frs_current, port->frs_current, frs_enable ? 'y' : 'n');
+			 partner_frs_current, port->new_source_frs_current, frs_enable ? 'y' : 'n');
 		if (frs_enable) {
 			ret  = port->tcpc->enable_frs(port->tcpc, true);
 			tcpm_log(port, "Enable FRS %s, ret:%d\n", ret ? "fail" : "success", ret);
@@ -4808,9 +4809,10 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 
 	/* FRS can only be supported byb DRP ports */
 	if (port->port_type == TYPEC_PORT_DRP) {
-		ret = fwnode_property_read_u32(fwnode, "frs-typec-current", &frs_current);
+		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
+					       &frs_current);
 		if (ret >= 0 && frs_current <= FRS_5V_3A)
-			port->frs_current = frs_current;
+			port->new_source_frs_current = frs_current;
 	}
 
 	return 0;
-- 
2.29.0.rc1.297.gfa9743e501-goog

