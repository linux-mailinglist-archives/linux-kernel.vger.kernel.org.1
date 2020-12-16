Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DA2DBBC3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 08:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgLPG7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 01:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgLPG7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 01:59:50 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB51C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 22:59:10 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g20so11568083plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 22:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhh1pQkLVhgQ5Bdk80ml0sCZvQJ6VWOxAZ9L31P9tUQ=;
        b=BnP51QMuAt6sAG2RdDeSxYVxGgP79V4uDOcZBlu0sOd1MHHkLty0B+WMApPX1Jh3jU
         MBVzoqP0+FbiNLa9PSVDIim3rZ4q+DjIJdOpIP4pp/LT+r+8DR687fjgN+YKrpjJNzIe
         MU8AbohgA9+vmBoaoMKYBnHYukMRf1Atl1wMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhh1pQkLVhgQ5Bdk80ml0sCZvQJ6VWOxAZ9L31P9tUQ=;
        b=pR1mJcqR2oFPBJ3YWuS25wrgxqWh4IE3aOvbc/EBg1T/R/qwmF2cz2JKf2IZa7/jBd
         2XIuCoRVsHzAVKHWHl7YRTL5fBhiDeyfhwOZdtVMTcwADN9Gr3PDJ142uSAG1yCYH1FZ
         sQhTpUwDzkssbNYELPDjRDI83fsIwK/qasykmGaPw5l68v6upAXrnXhp7ranmlfUvFfU
         IWuNWGyCINIJXs46fZOoGViDmWlLNxWnz8F83HazVd7mdf6DmazkDM4cc9nKvgZKkMcK
         pMT34jZ/r2jI7DhqOqkYp8SsY0CUHDmS/8ykT0Hr8JUu/KsmKGjW2oZUHCg/+Fn6hQyj
         iMaw==
X-Gm-Message-State: AOAM531t9roeHuekX43P+QanS3rME8EJbk4eh2zJEP21/OrPnB17g84U
        iiR7+dGoP2wyuQI0yjVLG2sv8w==
X-Google-Smtp-Source: ABdhPJygsZN1K2nEB30fjcwNAUaVZFw2oTn9RqNYSj7yNc/nOa7BtV5IN0wam+sODhmGLeMwRB6sXQ==
X-Received: by 2002:a17:902:aa4b:b029:d8:f87e:1f3c with SMTP id c11-20020a170902aa4bb02900d8f87e1f3cmr21431244plr.23.1608101949683;
        Tue, 15 Dec 2020 22:59:09 -0800 (PST)
Received: from localhost ([2620:15c:2ce:200:f693:9fff:fef4:20dd])
        by smtp.gmail.com with ESMTPSA id k129sm1295423pgk.1.2020.12.15.22.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 22:59:09 -0800 (PST)
From:   Denis Nikitin <denik@chromium.org>
To:     linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     al.grant@arm.com, al.grant@foss.arm.com,
        linux-kernel@vger.kernel.org, denik@chromium.org
Subject: [PATCH] perf inject: correct event attribute sizes
Date:   Tue, 15 Dec 2020 22:58:16 -0800
Message-Id: <20201216065816.1840893-1-denik@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201124195818.30603-1-al.grant@arm.com>
References: <20201124195818.30603-1-al.grant@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf inject reads a perf.data file from an older version of perf,
it writes event attributes into the output with the original size field,
but lays them out as if they had the size currently used. Readers see
a corrupt file. Update the size field to match the layout.

Signed-off-by: Al Grant <al.grant@foss.arm.com>
Signed-off-by: Denis Nikitin <denik@chromium.org>
---
 tools/perf/util/header.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index be850e9f8852..0d95981df8dd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3331,6 +3331,14 @@ int perf_session__write_header(struct perf_session *session,
 	attr_offset = lseek(ff.fd, 0, SEEK_CUR);
 
 	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
+			/*
+			 * We are likely in "perf inject" and have read
+			 * from an older file. Update attr size so that
+			 * reader gets the right offset to the ids.
+			 */
+			evsel->core.attr.size = sizeof(evsel->core.attr);
+		}
 		f_attr = (struct perf_file_attr){
 			.attr = evsel->core.attr,
 			.ids  = {
-- 
2.29.2.684.gfbc64c5ab5-goog

