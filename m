Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31AB2B23CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgKMSbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKMSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:31:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1B1C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:31:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n186so11643594ybg.17
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=x9rd0cqtqEO1U/W9nH1RpPRNsf7T/Zd/d267HQ3tmqc=;
        b=fOjinsxPHAIEOIE0y9NnELNkDMUmCbPzgkwq6Dbcma49s5o7cNRJQAL0/NmZKDH8TY
         FbjMB0J2wrFnEGbs9EDdpd4oUSEisUYbj9OkoDk+V4i/rwvRuWXMnCt+sptXICVUe4+P
         SLliWOnWGKteE7wn9wgcR6K2jqRz+rq0TAChXGchDN3OMEl2ik+K2svwPm/KhSfw3omN
         IwAhBBIK/3C6hbsgQ1K5S75oxHjwPknHIIKxzBeRy4qQ5USbTjJhrUudiGajU/hDnJDj
         nDKY9oSWCEPdatF+mm9msO+6M2JAnUg/CKia0tlePuxov4ORDXyV0nzFt20J4cUVy6Df
         GMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=x9rd0cqtqEO1U/W9nH1RpPRNsf7T/Zd/d267HQ3tmqc=;
        b=PQqs3rgWWyigx/bibq4RjqCnIhO1fNfEANrODDOsSLwxsQtiWJG51tVWxKNDR4ZjlI
         a9CfYvLlrLpCpLtdg43DavfnUAyMJx5QHpBomDtWBxjEx4JzwkFxWMj2zzUY8i7arGXS
         y4+LIGhmF/e1cKXAkVxndI9TL7NJ+H+MxnF3UIiEdJjgk+kZ3bRNmzuJIayqPfGkrJX5
         7CKfISOJ/MdvXPHzhyYG5q03Yg4J4dbhHSVQp21s7gz4hzpINtr89n/LWKwv8ypK+E14
         2l6+/dhlCnRyut1iCBkjgx2FrxK9a/TS+BMHLlcP77YLLNsNEBCTX8sqLb+4RbpCubb3
         3snw==
X-Gm-Message-State: AOAM5337qgARl626rv5byeVdG1phFnQaYNrPUnESNwI/tcMKYR1YLR5J
        OvoEzvQPeUwygo8ce/kwRYOxbCzM3BCDmoLGhRQ=
X-Google-Smtp-Source: ABdhPJxugWXaNvBkXgK97oCLlVtZKyaaypLm2x8uDMm04ZPKGNdGsnilMcu84ngHIkpzTirPeNnf4We6SH2p4hCNQmc=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:57d6:: with SMTP id
 l205mr6696737ybb.117.1605292290929; Fri, 13 Nov 2020 10:31:30 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:31:26 -0800
Message-Id: <20201113183126.1239404-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] perf/x86: fix sysfs type mismatches
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change switches rapl to use PMU_FORMAT_ATTR, and fixes two other
macros to use device_attribute instead of kobj_attribute to avoid
callback type mismatches that trip indirect call checking with Clang's
Control-Flow Integrity (CFI).

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/events/intel/cstate.c |  6 +++---
 arch/x86/events/intel/uncore.c |  4 ++--
 arch/x86/events/intel/uncore.h | 12 ++++++------
 arch/x86/events/rapl.c         | 14 +-------------
 4 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 442e1ed4acd4..4eb7ee5fed72 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -107,14 +107,14 @@
 MODULE_LICENSE("GPL");
 
 #define DEFINE_CSTATE_FORMAT_ATTR(_var, _name, _format)		\
-static ssize_t __cstate_##_var##_show(struct kobject *kobj,	\
-				struct kobj_attribute *attr,	\
+static ssize_t __cstate_##_var##_show(struct device *dev,	\
+				struct device_attribute *attr,	\
 				char *page)			\
 {								\
 	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);		\
 	return sprintf(page, _format "\n");			\
 }								\
-static struct kobj_attribute format_attr_##_var =		\
+static struct device_attribute format_attr_##_var =		\
 	__ATTR(_name, 0444, __cstate_##_var##_show, NULL)
 
 static ssize_t cstate_get_attr_cpumask(struct device *dev,
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 86d012b3e0b4..80d52cbe2fde 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -94,8 +94,8 @@ struct pci2phy_map *__find_pci2phy_map(int segment)
 	return map;
 }
 
-ssize_t uncore_event_show(struct kobject *kobj,
-			  struct kobj_attribute *attr, char *buf)
+ssize_t uncore_event_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
 	struct uncore_event_desc *event =
 		container_of(attr, struct uncore_event_desc, attr);
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 83d2a7d490e0..9efea154349d 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -157,7 +157,7 @@ struct intel_uncore_box {
 #define UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS	2
 
 struct uncore_event_desc {
-	struct kobj_attribute attr;
+	struct device_attribute attr;
 	const char *config;
 };
 
@@ -179,8 +179,8 @@ struct pci2phy_map {
 struct pci2phy_map *__find_pci2phy_map(int segment);
 int uncore_pcibus_to_physid(struct pci_bus *bus);
 
-ssize_t uncore_event_show(struct kobject *kobj,
-			  struct kobj_attribute *attr, char *buf);
+ssize_t uncore_event_show(struct device *dev,
+			  struct device_attribute *attr, char *buf);
 
 static inline struct intel_uncore_pmu *dev_to_uncore_pmu(struct device *dev)
 {
@@ -201,14 +201,14 @@ extern int __uncore_max_dies;
 }
 
 #define DEFINE_UNCORE_FORMAT_ATTR(_var, _name, _format)			\
-static ssize_t __uncore_##_var##_show(struct kobject *kobj,		\
-				struct kobj_attribute *attr,		\
+static ssize_t __uncore_##_var##_show(struct device *dev,		\
+				struct device_attribute *attr,		\
 				char *page)				\
 {									\
 	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
 	return sprintf(page, _format "\n");				\
 }									\
-static struct kobj_attribute format_attr_##_var =			\
+static struct device_attribute format_attr_##_var =			\
 	__ATTR(_name, 0444, __uncore_##_var##_show, NULL)
 
 static inline bool uncore_pmc_fixed(int idx)
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7c0120e2e957..7dbbeaacd995 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -93,18 +93,6 @@ static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
  * any other bit is reserved
  */
 #define RAPL_EVENT_MASK	0xFFULL
-
-#define DEFINE_RAPL_FORMAT_ATTR(_var, _name, _format)		\
-static ssize_t __rapl_##_var##_show(struct kobject *kobj,	\
-				struct kobj_attribute *attr,	\
-				char *page)			\
-{								\
-	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);		\
-	return sprintf(page, _format "\n");			\
-}								\
-static struct kobj_attribute format_attr_##_var =		\
-	__ATTR(_name, 0444, __rapl_##_var##_show, NULL)
-
 #define RAPL_CNTR_WIDTH 32
 
 #define RAPL_EVENT_ATTR_STR(_name, v, str)					\
@@ -441,7 +429,7 @@ static struct attribute_group rapl_pmu_events_group = {
 	.attrs = attrs_empty,
 };
 
-DEFINE_RAPL_FORMAT_ATTR(event, event, "config:0-7");
+PMU_FORMAT_ATTR(event, "config:0-7");
 static struct attribute *rapl_formats_attr[] = {
 	&format_attr_event.attr,
 	NULL,

base-commit: 585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
-- 
2.29.2.299.gdc1121823c-goog

