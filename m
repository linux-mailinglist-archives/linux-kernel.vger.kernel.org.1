Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FCF2EB712
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbhAFAul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbhAFAuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:50:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D70E922DD3;
        Wed,  6 Jan 2021 00:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894198;
        bh=WeDGqIHo+9q9HNBgyoOKDVhLdCzgAE48YybVm9P3H1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phMn1CoFywKGp3nEKwKrrS82Aa5tt7FbodIygqEMl42UHRL28edaxDRwKeXOFDHRo
         mblNYv6Jqi6nNkQCxOz/o2Bfq8lvsG7mxf0kRnV+36FQxKfIH7i6Q5pu4xsJvWyKG7
         yQwEwZ93hGSE+LZBbWjrBpuQQR2N2GnlLRfGwRKoQyc4yaInzczu0l1ZnraJtvTEFU
         v2+H7vWPPd4bCjG5pLQz8v3USWJSrmNU4igN08mUU8leVSl/DAv6e3HueC7iJqoCKj
         np4AOe9Nisg7wdRCd22/mn6Hk5drDc6woQEJRWpKePxKbkSzOwVh8oKVXFyKKCcj6F
         vSGILMi3KUFDA==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com, kernel-team@fb.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC cpumask 3/5] cpumask: Add a "none" alias to complement "all"
Date:   Tue,  5 Jan 2021 16:49:54 -0800
Message-Id: <20210106004956.11961-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106004850.GA11682@paulmck-ThinkPad-P72>
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

With global support for a CPU list alias of "all", it seems to just make
sense to also trivially extend support for an opposite "none" specifier.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.rst | 6 ++++++
 lib/cpumask.c                                   | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index cdf4e81..7dd1224 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -76,6 +76,12 @@ is equivalent to "foo_cpus=0-N" -- where "N" is the numerically last CPU on
 the system, thus avoiding looking up the value in "/sys/devices/system/cpu"
 in advance on each deployed system.
 
+        foo_cpus=none
+
+will provide an empty/cleared cpu mask for the associated boot argument.
+
+Note that "all" and "none" are not necessarily valid/sensible input values
+for each available parameter expecting a CPU list.
 
 This document may not be entirely up to date and comprehensive. The command
 "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 9f8ff72..7fbcab8 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -110,6 +110,11 @@ int cpulist_parse(const char *buf, struct cpumask *dstp)
 		return 0;
 	}
 
+	if (!strcmp(buf, "none")) {
+		cpumask_clear(dstp);
+		return 0;
+	}
+
 	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
 }
 EXPORT_SYMBOL(cpulist_parse);
-- 
2.9.5

