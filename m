Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4652FCB52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbhATHJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbhATHJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:09:10 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91BCC06179A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:07:55 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id i7so14596157pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/Mp9fOS78Y/0IRdvug0VEaslDq+2Dzu5+PGexsJRwk=;
        b=t4z/jvbja90P87o9pl6tpF1ugjD+IDqHYndMLfkVDGqCv2rZ5AShl24QrtsPayujL3
         gdrUufyj7xYAIVXOms+rIoPuJotKin8Pok1fyA79RMtI0QgJn1mHnPMTQeQymzylTjfJ
         ITWmWeM/jAY+T2Uq+wwybk/WTS5cIjqnq4b25KAEiu5TyTIuhX3Rf/gz1ZpPEiPGMuD6
         mrghefXPS/SnkD56s+1FIu1Gq1mTRo6QvQqguCOjn0EZIW+VkwDyvZNlYNophSX6hVHL
         LPgl7QVnBViGsEYvGgh7jU4S8QkxlkKbQ6ygkAxsap92LQtoDHqngiSxzEPRf5ftPPeJ
         lf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/Mp9fOS78Y/0IRdvug0VEaslDq+2Dzu5+PGexsJRwk=;
        b=YcSsJNsSD6290zirESv/jDD0BpihmODNZU0I4JmVDst5A0/cg3EZpFtNcCBoowAR/m
         Q44lXs4iHWXLJGuZWqNj/MyTBffoiegZU4HSe1KvCifTCk7tY6FTQtnktf7yg07MP1hl
         capP4iCC7qCjNyyJEY3yaPZKSW8G3D4HV2hpXkKAVVAGXr+sNTmGzZp1gl8fIIfu4NHW
         oiZyAIzYVd4zPjicWXqMj5cqfwJNXGibWolSTN2ELMi2bh4QkPHk0Qk+uMyNZDH1gLno
         /rAEkBZovjPsqlCI4bNFXQA2g7Q0roRwJeNGopqQB6hLOBvjyB0qA5zCKenonmoc93zX
         TKvg==
X-Gm-Message-State: AOAM531pwVJoYuwOs7nTTwJGrSMNWv5e9YIlkCX3BjrrM67GCkuKzI9N
        5lxC9XoC6jdgT+ZUzDauj9WH0g==
X-Google-Smtp-Source: ABdhPJyNluEFcdQwMzI6wmLSDEsTG2nP/T+MiU0oKYkCQdXTfP553Eo4hp3H0LPfiJa+VDWiUaSSHA==
X-Received: by 2002:a63:d42:: with SMTP id 2mr2129450pgn.236.1611126475217;
        Tue, 19 Jan 2021 23:07:55 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id i62sm1154296pfc.150.2021.01.19.23.07.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 23:07:54 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: [PATCH V5 5/5] of: unittest: Statically apply overlays using fdtoverlay
Date:   Wed, 20 Jan 2021 12:36:47 +0530
Message-Id: <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611124778.git.viresh.kumar@linaro.org>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that fdtoverlay is part of the kernel build, start using it to test
the unitest overlays we have by applying them statically.

Some unittest overlays deliberately contain errors that unittest checks
for. These overlays will cause fdtoverlay to fail, and are thus not
included in the static_test.dtb.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/unittest-data/Makefile | 50 +++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 009f4045c8e4..ece7dfd5cafa 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -38,3 +38,53 @@ DTC_FLAGS_testcases += -@
 
 # suppress warnings about intentional errors
 DTC_FLAGS_testcases += -Wno-interrupts_property
+
+# Apply overlays statically with fdtoverlay.  This is a build time test that
+# the overlays can be applied successfully by fdtoverlay.  This does not
+# guarantee that the overlays can be applied successfully at run time by
+# unittest, but it provides a bit of build time test coverage for those
+# who do not execute unittest.
+#
+# The overlays are applied on top of testcases.dtb to create static_test.dtb
+# If fdtoverlay detects an error than the kernel build will fail.
+# static_test.dtb is not consumed by unittest.
+#
+# Some unittest overlays deliberately contain errors that unittest checks for.
+# These overlays will cause fdtoverlay to fail, and are thus not included
+# in the static test:
+#			overlay.dtb \
+#			overlay_bad_add_dup_node.dtb \
+#			overlay_bad_add_dup_prop.dtb \
+#			overlay_bad_phandle.dtb \
+#			overlay_bad_symbol.dtb \
+#			overlay_base.dtb \
+
+apply_static_overlay := overlay_0.dtb \
+			overlay_1.dtb \
+			overlay_2.dtb \
+			overlay_3.dtb \
+			overlay_4.dtb \
+			overlay_5.dtb \
+			overlay_6.dtb \
+			overlay_7.dtb \
+			overlay_8.dtb \
+			overlay_9.dtb \
+			overlay_10.dtb \
+			overlay_11.dtb \
+			overlay_12.dtb \
+			overlay_13.dtb \
+			overlay_15.dtb \
+			overlay_gpio_01.dtb \
+			overlay_gpio_02a.dtb \
+			overlay_gpio_02b.dtb \
+			overlay_gpio_03.dtb \
+			overlay_gpio_04a.dtb \
+			overlay_gpio_04b.dtb
+
+quiet_cmd_fdtoverlay = FDTOVERLAY $@
+      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $^
+
+$(obj)/static_test.dtb: $(obj)/testcases.dtb $(addprefix $(obj)/,$(apply_static_overlay))
+	$(call if_changed,fdtoverlay)
+
+always-$(CONFIG_OF_OVERLAY) += static_test.dtb
-- 
2.25.0.rc1.19.g042ed3e048af

