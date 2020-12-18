Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C509F2DDD3C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 04:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbgLRDSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 22:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgLRDS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 22:18:28 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F817C061248
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:20 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 189so853813qko.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MexoMrpocfiDELBIMfZC4WnBKRJGIn4XJQtzQN88OjA=;
        b=fqVywUIWwbkDBuzN7pb3rpgbc7m2Z/K7pcflU0QSfgaumC3wlPRB7usEcuLgeQUPhf
         dy/uHN7kH/OI/xigjBvo0MrYqpnMnnDiikdGJzIbyo8DpPK2U4zUd/TogqexNXBVZGkm
         uw8jBuciWeyNs+ZDlWeRBBRVQilKcphYc8r4VXvPVSvT84tMdjIxA9wkqxuxPfc9bN+M
         2iLrvHFNHzMcj8QJrelJCPH9EB0K12mBr3SMEJSJ5VIqxyN5kZ5Gg9fvqqFoPyxlbrkg
         5fg9zHRh/YxXCy3/2dQSRYrhRggsr/QsjGl0SPWYbvKH3nnEoLQ1K2tu3hWd4yT2J2QS
         FDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MexoMrpocfiDELBIMfZC4WnBKRJGIn4XJQtzQN88OjA=;
        b=GMd+vBKEXdU4ABg3EG/5F/WqwZXxK7HO+CjmgoL+iGfH6Wx/CJNr/wU0jPZWRkHTTw
         TYATWnnk81EVlwyVUbj5ay1LcJu+JfcDsweDE6pVStAKQx/V7domsn2PY63vEVbV+CRJ
         UP+9RMsBfaO+cxf3+W6JiNUqozUkNEO7XZxx+aRwTtG4Eo1wC1glj/gfEmd/nFYGCivc
         qV3eCnulTyUow7L91FMnXIFj65tpsV2VHbj0J47eiPvmLw/9+Ij9cBgyhfTXCvmBRmEk
         hHJDKfRf7pT6QHvKts95INdYeqlVXpwHWOzg4PQucqM9xWEAPqhLVpCnlLdUxxKCl3Wx
         HfDQ==
X-Gm-Message-State: AOAM533KAU44BmTrWH3gqgK3p7h6qI/FoM3XzCGTgXKSpNXPwv5G12cG
        35HRH4i6ACZthr4sPnjw4AtVueKuEctXsbU=
X-Google-Smtp-Source: ABdhPJx09rtyba685l2zujiI8kZCG8V+yZ+CgLvccZ9vlAQsRr2GR7lPJWV+aE6CRH9wvcLYeAXPA75UUMEtNrk=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:ad4:56ab:: with SMTP id
 bd11mr2307903qvb.53.1608261439412; Thu, 17 Dec 2020 19:17:19 -0800 (PST)
Date:   Thu, 17 Dec 2020 19:17:03 -0800
In-Reply-To: <20201218031703.3053753-1-saravanak@google.com>
Message-Id: <20201218031703.3053753-6-saravanak@google.com>
Mime-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cyclic dependencies in some firmware was one of the last remaining
reasons fw_devlink=on couldn't be set by default. Now that cyclic
dependencies don't block probing, set fw_devlink=on by default.

Setting fw_devlink=on by default brings a bunch of benefits (currently,
only for systems with device tree firmware):
* Significantly cuts down deferred probes.
* Device probe is effectively attempted in graph order.
* Makes it much easier to load drivers as modules without having to
  worry about functional dependencies between modules (depmod is still
  needed for symbol dependencies).

If this patch prevents some devices from probing, it's very likely due
to the system having one or more device drivers that "probe"/set up a
device (DT node with compatible property) without creating a struct
device for it.  If we hit such cases, the device drivers need to be
fixed so that they populate struct devices and probe them like normal
device drivers so that the driver core is aware of the devices and their
status. See [1] for an example of such a case.

[1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4cc030361165..803bfa6eb823 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1457,7 +1457,7 @@ static void device_links_purge(struct device *dev)
 #define FW_DEVLINK_FLAGS_RPM		(FW_DEVLINK_FLAGS_ON | \
 					 DL_FLAG_PM_RUNTIME)
 
-static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
+static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_ON;
 static int __init fw_devlink_setup(char *arg)
 {
 	if (!arg)
-- 
2.29.2.684.gfbc64c5ab5-goog

