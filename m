Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D70527329A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgIUTQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:16:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53602 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgIUTQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:16:24 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3A5C920B36E7;
        Mon, 21 Sep 2020 12:16:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A5C920B36E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600715783;
        bh=c1UaOqqN8L8mnVxjNiUIJWteiuc/MyzZUtEtEiVniLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjY2ic5vypIguJogutpWx0j/sWdqdWq6zci8/1klZOLIblS7qPS5blAF2lHqNE3A6
         n47+vWUxwRJsoc5EGc6nEx8oBz/jTJq+DHuXDQb2TuF0f5/h/aoVemuftZhAenbGrW
         taD3o8mraHu5bUrnOBVEzdzm5QxXmCJD17YdZYVc=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: kaslr: Refactor early init command line parsing
Date:   Mon, 21 Sep 2020 14:15:56 -0500
Message-Id: <20200921191557.350256-2-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
References: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't ask for *the* command line string to search for "nokaslr" in
kaslr_early_init(). Instead, tell a helper function to search all the
appropriate command line strings for "nokaslr" and return the result.

This paves the way for searching multiple command line strings without
having to concatenate the strings in early init.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 arch/arm64/kernel/kaslr.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index b181e0544b79..4c779a67c2a6 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -50,10 +50,16 @@ static __init u64 get_kaslr_seed(void *fdt)
 	return ret;
 }
 
-static __init const u8 *kaslr_get_cmdline(void *fdt)
+static __init bool cmdline_contains_nokaslr(const u8 *cmdline)
 {
-	static __initconst const u8 default_cmdline[] = CONFIG_CMDLINE;
+	const u8 *str;
 
+	str = strstr(cmdline, "nokaslr");
+	return str == cmdline || (str > cmdline && *(str - 1) == ' ');
+}
+
+static __init bool is_kaslr_disabled_cmdline(void *fdt)
+{
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
 		int node;
 		const u8 *prop;
@@ -65,10 +71,10 @@ static __init const u8 *kaslr_get_cmdline(void *fdt)
 		prop = fdt_getprop(fdt, node, "bootargs", NULL);
 		if (!prop)
 			goto out;
-		return prop;
+		return cmdline_contains_nokaslr(prop);
 	}
 out:
-	return default_cmdline;
+	return cmdline_contains_nokaslr(CONFIG_CMDLINE);
 }
 
 /*
@@ -83,7 +89,6 @@ u64 __init kaslr_early_init(u64 dt_phys)
 {
 	void *fdt;
 	u64 seed, offset, mask, module_range;
-	const u8 *cmdline, *str;
 	unsigned long raw;
 	int size;
 
@@ -115,9 +120,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	 * Check if 'nokaslr' appears on the command line, and
 	 * return 0 if that is the case.
 	 */
-	cmdline = kaslr_get_cmdline(fdt);
-	str = strstr(cmdline, "nokaslr");
-	if (str == cmdline || (str > cmdline && *(str - 1) == ' ')) {
+	if (is_kaslr_disabled_cmdline(fdt)) {
 		kaslr_status = KASLR_DISABLED_CMDLINE;
 		return 0;
 	}
-- 
2.25.1

