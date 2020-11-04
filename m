Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB622A71AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbgKDXZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733045AbgKDXYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:24:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B852BC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:24:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x125so382641yba.17
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5sRZ6jhZ+T/gutzXbCBa2cQYYZrY2SCzTIYgh1jQP+0=;
        b=KPEQ4VrOxtoTLDuFgJFdWk6KRPwrcI/ihNJCiTdUkBKEYu92xvhA4SXzdybwWdc4ge
         8mbUKDP9DwLAgVQ9LoAveXPNRdT77u4tYK7hgrUwH1DDg69Exao6g4YGTrFlNI7Q/w4S
         F8eYHA6zVlAyFDxBjALghjyzMRvz5/b3Lh8CbxzbmV/WJZuXmDbovzL4rwSNauCh0lBn
         UR471uUcXqLneNOPe1RoDFHZxIQpmAzGHUT2zgAzJHIf6ztVlw6QTzchqb6yWo3fum7e
         8VY4oETIv6BIGaO+kuZw29D2uy/y5j6ySRsmxLo8TPojkay576ZnBosMBOA31raHLxDC
         oTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5sRZ6jhZ+T/gutzXbCBa2cQYYZrY2SCzTIYgh1jQP+0=;
        b=rRjOttvdiFyWSChSNck2OlWWmd9eMx06ALiKelLTQrZH3TwUZ6hvR/aYWGQLnpsclY
         PzUtTwOIGeNfmxGLGoj18I2Q3uvaadFg/kOoKn4vNrDmsv1d/XY/bg134qe/tAwnnY+s
         T/Sw98UxvVUXxJnd7aqO4gRHi+Lr8aFRmir2rLV8GwadVHh8LZviT0H28lt30NqIE7ar
         oZ2i+7eJq4/M3pcxzJ6NMZtUaj6y2Al3LahUCl/YCPoPWLV+o28Rb9o3QPnvM7uDowi7
         C8kp4XZZxLXniumn26/xJ00R7vQ5iWdlGj25SrGkN9uAjgkQOxsMyTIg3MXIVqf5nDH1
         +uCw==
X-Gm-Message-State: AOAM533cKjxDgppnzA67razjjwDvBU8rlGNGPBYrdrRcGnmski70d6Vq
        KLlt4tH7CQuduGtGXf7UsC3qxjxrAjTMOSk=
X-Google-Smtp-Source: ABdhPJz+alC8yp9zBJND6Vgcoky5QjmGBoY1he5RZG8ZuTerdEihYnn+YQqUYKoT1Mk3I8zQzC9AhaaEWWckVQ4=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a5b:389:: with SMTP id
 k9mr265028ybp.75.1604532264967; Wed, 04 Nov 2020 15:24:24 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:47 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-11-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 10/18] device property: Add fwnode_is_ancestor_of()
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

Add a helper function to check if a fwnode is an ancestor of another
fwnode. This will be useful for fw_devlink feature.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/property.c  | 27 +++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4c43d30145c6..2569ebd52e6b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -660,6 +660,33 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
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
index 2d4542629d80..2e5eed3ddf1c 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -88,6 +88,8 @@ struct fwnode_handle *fwnode_get_next_parent(
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
 					    unsigned int depth);
+bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
+				  struct fwnode_handle *test_child);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
-- 
2.29.1.341.ge80a0c044ae-goog

