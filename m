Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21BE2A7191
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733126AbgKDXYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733055AbgKDXYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:24:32 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7272C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:24:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u13so400833ybk.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HXkyO8z8X08APZbARCQP/2vgXX6ay0o50V4fzW8aU6s=;
        b=I0A/S4Q3YJdLVtlrppRCljyO3Nbqezxq71d58jzcyH2drf1IpsBN1WngrsFLfhJTk9
         cKkqvnL+/3U4DIuWdfhDuhwsYLFWPNF78W/a6aonqyWMtVdjVAR7eB5kwpqK0KAOOL6N
         ZbkOjr3Nl/48a42VD9DUcuCEqznCBSw27YQ2GuEzLPSJyfF4DzgTnGjVGKpzio+WjoB4
         ELOqLtaqJ/80inf1AL67t7zsC6/XrE5aL/v/W5ctpfs5PGfpoRpzSWRYGakuX3vfISnD
         ktU9aHTXftzitdhU+WBUAe3RXa6WeH0zPY4VncGHbbLiZmL5g+xNvv5bSAD6wYtz7yVh
         tnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HXkyO8z8X08APZbARCQP/2vgXX6ay0o50V4fzW8aU6s=;
        b=Yfm3o6p+W3u6rjRT+e5tp9pPDveUHRYeaUNKCh1Y7Oy9mPKdpm3OeRMRqZfBHiFdNO
         XaUldkJF5FnkeFRvK1zEsL0inKjUmB5x/wiyDd+Uv3+39ucBN8We05h883fhQWwERGo7
         EYRxW9NTrZOMnv4FDbDQ+qo3kCSGCD5bnb3DGs6VQK2MKIv+ByeQ05dj5AZe4od/HHj1
         wFsPtWfa6hpO6nJsiS5muV+H3KABedZBzzNmIhnbAbJqNE667Ba1uB1YErEmYlPKJL+w
         mAoCr2D8OK99/IXA1G5W46iYnCR8ePuMoJyTFd/isRK7iz1a7PTOi32HAH6+cjS3vXec
         lbGA==
X-Gm-Message-State: AOAM531MKFyuSyQqbYk5ZdED74ccEQLSzaaxPxMumAjYSeYgNBFG7452
        hAFuRfCX/MyazHX/NQasbRy583/o/jvVxgA=
X-Google-Smtp-Source: ABdhPJxd/2TF8pjIl7zpCGZmXXH1OB+9XkGkNjTUWRF8D12cDv1hHerte9U8InbxYaLdAQ3BrkNZwCbn2uTFCK8=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:774f:: with SMTP id
 s76mr259364ybc.235.1604532269897; Wed, 04 Nov 2020 15:24:29 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:49 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-13-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 12/18] driver core: Add fw_devlink_parse_fwtree()
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

This function is a wrapper around fwnode_operations.add_links().

This function parses each node in a fwnode tree and create fwnode links
for each of those nodes. The information for creating the fwnode links
(the supplier and consumer fwnode) is obtained by parsing the properties
in each of the fwnodes.

This function also ensures that no fwnode is parsed more than once by
marking the fwnodes as parsed.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 19 +++++++++++++++++++
 include/linux/fwnode.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4a0907574646..ee28d8c7ee85 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1543,6 +1543,25 @@ static bool fw_devlink_is_permissive(void)
 	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
 }
 
+static void fw_devlink_parse_fwnode(struct fwnode_handle *fwnode)
+{
+	if (fwnode->flags & FWNODE_FLAG_LINKS_ADDED)
+		return;
+
+	fwnode_call_int_op(fwnode, add_links, NULL);
+	fwnode->flags |= FWNODE_FLAG_LINKS_ADDED;
+}
+
+static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *child = NULL;
+
+	fw_devlink_parse_fwnode(fwnode);
+
+	while ((child = fwnode_get_next_available_child_node(fwnode, child)))
+		fw_devlink_parse_fwtree(child);
+}
+
 static void fw_devlink_link_device(struct device *dev)
 {
 	int fw_ret;
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index ec02e1e939cc..9aaf9e4f3994 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -15,12 +15,15 @@
 struct fwnode_operations;
 struct device;
 
+#define FWNODE_FLAG_LINKS_ADDED		BIT(0)
+
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
 	const struct fwnode_operations *ops;
 	struct device *dev;
 	struct list_head suppliers;
 	struct list_head consumers;
+	u32 flags;
 };
 
 struct fwnode_link {
-- 
2.29.1.341.ge80a0c044ae-goog

