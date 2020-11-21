Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB82BBBF9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgKUCDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgKUCDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:03:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B755C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:03:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c9so14117083ybs.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fcRX8EQ81IWbj6+XDTRlZFv8SxEOqV4OLStJQB/GoqQ=;
        b=Vj45QhO9ZSi0OFJycyK5AzWKxaZwGDVhvQ4z/YZwUXcrdiuvMasH3fQQMKIg41YWQa
         pxWXr0qGp7dzU4C6qYb+d7Uv1Gm56yYRHErC8Alp46BYKTHGkXivfK4K1eszSPOtCF1T
         tpeUyllcJhacOxSqD5nPFxhGX0OEg0wjMp7gvYrSFG7ogRg71wamSFLD/VlVbg2TuZX/
         eBM7mLf3GEN1C5gWZTuOeL3ttJgas/vXbDCChXeOi/LtNg6+1tLMtqTAKP24z+iKFtH1
         ri6FX3ocRYsaWv9UyFVDpTewGEgXUatlTpvthQ4OOMVXk8S57eg7RCCYzuaeEhWiHTXq
         Uivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fcRX8EQ81IWbj6+XDTRlZFv8SxEOqV4OLStJQB/GoqQ=;
        b=YqUsvoplZk+2to+pfDlRcUiGqbTq7WJ0hkSA+oelF57Pauzcipq9dEUCuCjTRDPynV
         +r8yo3Sp1QGmiNJacHau8+vqbHHMofiGTDG4iavOdGblrwh3N0uKtnHZ3FaRx4Hn0Z3V
         9t7xJYG0VSXfeCt5fg/VysUCDV3AnzSaTbaRoGjnwYnQuPTI2rvhAE0sKU985lbp68th
         lXuFOmBV7lVwRt4LSaJLo7xTFpWV13+xQ++AS8XS5XMng4/cH9XPPvCICxu0S87J/vbe
         m4aeD9/+GLl0N1rOFmcqFR1p3Xew6JEff3uFUxmk7tBo7QY2NbQR8T2VrK+fzqL2xgQ9
         pvZw==
X-Gm-Message-State: AOAM533PuBMQUsUXRt9B3CpNYsjEM8aJiLuznUzcsXGoWsbU4FIrk9PW
        ALUcVAdxX6bsBtFqMJO3rT2l9A5C0jV5Uow=
X-Google-Smtp-Source: ABdhPJyEhyYRg3K0ym/U8YyY3pTaho98WkVJn/HloZlFw1kCa8i1tKS3G+uhnmUgvyIN+LExLDVXMDROSAqKLBc=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:aa63:: with SMTP id
 s90mr25460026ybi.340.1605924190358; Fri, 20 Nov 2020 18:03:10 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:25 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-11-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 10/17] device property: Add fwnode_is_ancestor_of() and fwnode_get_next_parent_dev()
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

Add fwnode_is_ancestor_of() helper function to check if a fwnode is an
ancestor of another fwnode.

Add fwnode_get_next_parent_dev() helper function that take as input a
fwnode and finds the closest ancestor fwnode that has a corresponding
struct device and returns that struct device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/property.c  | 52 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 55 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4c43d30145c6..35b95c6ac0c6 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -614,6 +614,31 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
 
+/**
+ * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
+ * @fwnode: firmware node
+ *
+ * Given a firmware node (@fwnode), this function finds its closest ancestor
+ * firmware node that has a corresponding struct device and returns that struct
+ * device.
+ *
+ * The caller of this function is expected to call put_device() on the returned
+ * device when they are done.
+ */
+struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
+{
+	struct device *dev = NULL;
+
+	fwnode_handle_get(fwnode);
+	do {
+		fwnode = fwnode_get_next_parent(fwnode);
+		if (fwnode)
+			dev = get_dev_from_fwnode(fwnode);
+	} while (fwnode && !dev);
+	fwnode_handle_put(fwnode);
+	return dev;
+}
+
 /**
  * fwnode_count_parents - Return the number of parents a node has
  * @fwnode: The node the parents of which are to be counted
@@ -660,6 +685,33 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 
+/**
+ * fwnode_is_ancestor_of - Test if @test_ancestor is ancestor of @test_child
+ * @test_ancestor: Firmware which is tested for being an ancestor
+ * @test_child: Firmware which is tested for being the child
+ *
+ * A node is considered an ancestor of itself too.
+ *
+ * Returns true if @test_ancestor is an ancestor of @test_child.
+ * Otherwise, returns false.
+ */
+bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
+				  struct fwnode_handle *test_child)
+{
+	if (!test_ancestor)
+		return false;
+
+	fwnode_handle_get(test_child);
+	while (test_child) {
+		if (test_child == test_ancestor) {
+			fwnode_handle_put(test_child);
+			return true;
+		}
+		test_child = fwnode_get_next_parent(test_child);
+	}
+	return false;
+}
+
 /**
  * fwnode_get_next_child_node - Return the next child node handle for a node
  * @fwnode: Firmware node to find the next child node for.
diff --git a/include/linux/property.h b/include/linux/property.h
index 2d4542629d80..0a9001fe7aea 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -85,9 +85,12 @@ const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
+struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode);
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
 					    unsigned int depth);
+bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
+				  struct fwnode_handle *test_child);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
-- 
2.29.2.454.gaff20da3a2-goog

