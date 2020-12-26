Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1932A2E2E53
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 15:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLZOHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 09:07:34 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:45107 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgLZOHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 09:07:32 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D35GL3jYmz8v53;
        Sat, 26 Dec 2020 15:06:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608991610; bh=9CoTgr9jhIVIzQsReVlJlsXyk5irSU1vGHHGHILF/Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=YsYa5TV1nAaXWrXSXvd9q4ZWw0dpVyYpZEbVWHft4Gp1KB5hX1PmOtjemGjv2uWB+
         upigNSS+uDB08Ugo13AJSLs0MNanqOnTfxyEektg6CpS0jkLYcY4BpGCyJhMsBgajb
         pGNG6BIJAzuU2SXOK3orkJstxFNRD9L6EAnlG53dHeMZtCaRG4pd7LG4OK9G9HhiMc
         nQJT808KeQfWFCPSIHlpX86lrRWLDtSDHPU8WLTPWjhKnXe7wft+pWnWu6rvsaML23
         PM8GP1qSy4bsA28RbwQeI7bTijQ4IFEudo6bF2lVzi2gv9rL/Fr4VYhIVjEgUuvZ2i
         LSgxGarnVmqcA==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a02:810d:8080:2d9f::1276
Received: from x1.nicolai.tech (unknown [IPv6:2a02:810d:8080:2d9f::1276])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19T4Hgasqy+FbjjZUypsD2YCRCr2depchM=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D35GJ0xDGz8sYn;
        Sat, 26 Dec 2020 15:06:48 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de, joe@perches.com,
        akpm@linux-foundation.org
Subject: [PATCH v2 4/4] checkpatch: kconfig: clarify warning for paragraph length
Date:   Sat, 26 Dec 2020 15:05:11 +0100
Message-Id: <20201226140511.662368-5-nicolai.fischer@fau.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226140511.662368-1-nicolai.fischer@fau.de>
References: <b1c83a13-204f-25ff-d08b-d08559e25a3b@fau.de>
 <20201226140511.662368-1-nicolai.fischer@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checkpatch displays a warning if it detects a help text
of a Kconfig option which is too short. However the warning does
not contain any further information.
This adds the expected and currently detected number of lines
to the warning, which makes it more obvious why checkpatch
is warning.

Furthermore this makes it easier to quickly identify false
positives, e.g. when a help message contains a Kconfig keyword
and falsely triggers checkpatch to stop counting lines,
it will be more apparent, because the user can see how many lines
they wrote and how many of those were counted correctly.

Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index aa2205ee9ab8..bc363933e0aa 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3356,7 +3356,7 @@ sub process {
 			}
 			if ($is_start && $is_end && $length < $min_conf_desc_length) {
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
+				     "please write a paragraph ($length/$min_conf_desc_length lines) that describes the config symbol fully\n" . $herecurr);
 			}
 			if ($is_start && $is_end && defined $help_stat_real) {
 				WARN("CONFIG_DESCRIPTION",
-- 
2.29.2

