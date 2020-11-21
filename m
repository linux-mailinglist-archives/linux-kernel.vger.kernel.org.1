Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EAB2BBBE8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgKUCDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgKUCC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:02:57 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB4CC061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:02:57 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q199so8347140pfc.21
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=u8gSY0xV7Hxd2w8NGW6IzppBe4J1ijRyucJg3LQF0Gk=;
        b=fsbK5xxw4z7i23FSKugbrasJEIXN13Q4zN4isokluNuL4HjEO/jGHpCycjM7g9sfqR
         +kbOqa7qcSGga0Lm/F27nYxTNhPX4fRgh4Mf9+oYz6aUhraA4s7J5QNNMCxQsLKJfiu6
         hO9xCcF+bjceWP/4mkj62eK+d2GhPUnH8ipvjoF5lXH5cwi6X4Wyh+5rcJdkI2Y7Mg6U
         iT6tK3+H9NRURvDqYLmMIA70OMrl2Yj+fQCQc8tKeIPW+uVGa3W2KjLifbeHcVbYlj5y
         Q04w/t2ewdvVIWyUrX6OqLnatW7MndjTFeg7RNiUGjOroBN0Dv6izRyJdeVw3DlHXFza
         a27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u8gSY0xV7Hxd2w8NGW6IzppBe4J1ijRyucJg3LQF0Gk=;
        b=m7Ykygjhu6dxNlOE9ByeqvbZH6kQptiz2cvQsFTj1i9jc085R7cXkVHJYmbqRAXqDP
         PJHONP+KdtnyFvtCbzZieD4EruFt58IMqDPGNICdONf9q9EtQK2rUxp6a6NwOKY4ydg8
         5N6xO6r1ukOd1YCsUh000h+IPzTLUjCtP0WozwaMxg0RD4/RyBE5EJ7Evzmw3TB2LyqS
         3DbROWObqQnNbTr/b5eEO3pOCkVaTw7qlepOIgojr0ckT9QsT/56hGRS7z+QClpYLLLP
         9RrMJoV6rQ1i4GiT2y9SKkVHeQl6W/Z0cpCNWJ7lYuMplUNudCesPfl9BYkMUQTvf+ud
         +wHQ==
X-Gm-Message-State: AOAM531fHbJIlqFmEz56KeJmoV+STKis+ypYoW4ElTae/Flz2S6h6UVD
        T+9bcMvcNghr92HDCR/9uNftvl41vORqJaw=
X-Google-Smtp-Source: ABdhPJzP83DwhORfMb+bJuQz5UmJs3XebCnI6uLqfDOyEgb2ymxIPPeS7NMxGqPYiMO5s4yUrfepUAr2i5NMiTs=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a17:90a:f28e:: with SMTP id
 fs14mr6235679pjb.91.1605924177080; Fri, 20 Nov 2020 18:02:57 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:20 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-6-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 05/17] Revert "of: platform: Batch fwnode parsing when
 adding all top level devices"
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 93d2e4322aa74c1ad1e8c2160608eb9a960d69ff.

The fw_devlink_pause/resume() optimization attempt is getting replaced
with a much more robust optimization by the end of this series. So, stop
using those APIs.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b557a0fcd4ba..79bd5f5a1bf1 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -538,9 +538,7 @@ static int __init of_platform_default_populate_init(void)
 	}
 
 	/* Populate everything else. */
-	fw_devlink_pause();
 	of_platform_default_populate(NULL, NULL, NULL);
-	fw_devlink_resume();
 
 	return 0;
 }
-- 
2.29.2.454.gaff20da3a2-goog

