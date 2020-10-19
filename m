Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758312931EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 01:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbgJSXZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 19:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388935AbgJSXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 19:25:50 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54522C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 16:25:50 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id d21so32657pjw.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=hVoEUBBLsBOYTlMxR028+vSCpNpVugOz3/Q1izjKLSk=;
        b=CEDkG+R7Xb2cd6iFUDzQsW0eKIVKrO3BH+/f6UbUFBy3wIF0PyrD6gv+68jRUPc1nI
         wDD84gFn2xssC5gYEJna+vRLNWi9C2nFWydBIl5LBCONrGAgoOIhJarM4SOOV9wdQ8g4
         k5Eb2ZtJHG1ZzRCJSlD6lf6K8KWrYArgN2cG/yXFwd6NGsWF3U3vFN/VsIwRdtn2vVKN
         Y/+w5/IozrYDBMMpVebVwAMc7K+crybnc8NKrL9dhTNyzGuHFQRAnr67R//O0ucDtsUo
         SGJPozmR2XCctwA4UZLuh2gSwDTpHSnk6Cjs4LCzEv7bEtTwnN7YH3A68Ah8JzX3Zlcz
         0l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=hVoEUBBLsBOYTlMxR028+vSCpNpVugOz3/Q1izjKLSk=;
        b=Ftp6tODs1DKUWcmDfp7j0VJ9WAERPWCLwSuHAcwRsmZ1kPmT2m2s8uywkgbBVnT0jI
         BwjnsIIEq8VfHNN6DuvEARDjFKx/0YnPrRNglssySexK+HP3HgYkIcSP7hGnCvfAuu9A
         8ya5ATyCkhHJg7sOcYGEj9TPof7Rs96aGgl1mGPALcHyzgo+Hl94vvR5ikwlHM+am6z/
         pT9d44Zv0HFiVMblYZilfb2K1ufOYf0+RaUiKdCZzGFJ5oqfR5rslqs3ZrI6Spfr0BLN
         V9k2AUTaYv9rHGypBdsc3Ptsa5HWOjn4WFbos76i/RjktCeNx0QYlgsni8U7/gSpvdmu
         JNwA==
X-Gm-Message-State: AOAM533g2b2dgDyX+gNhNBTboZyNasrRmMWl9YXaIl+2oPecp1lSOEqq
        oi+//dlk5TFd6Ualxays5lhYuuhnl9DB
X-Google-Smtp-Source: ABdhPJyql3m3LjAJlakTptuv8ABYlyTUcDHopcgD2qQFf/rTBdfyU1DqMPGMCohiN62Cfvt/2zrgW+Nx5vpx
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:90a:c796:: with SMTP id
 gn22mr152258pjb.224.1603149949738; Mon, 19 Oct 2020 16:25:49 -0700 (PDT)
Date:   Mon, 19 Oct 2020 16:25:45 -0700
Message-Id: <20201019232545.4047264-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] perf version: Add a feature for libpfm4.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If perf is built with libpfm4 (LIBPFM4=1) then advertise it in perf -vv.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-version.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index d09ec2f03071..9cd074a3d825 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -80,6 +80,7 @@ static void library_status(void)
 	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
 	STATUS(HAVE_AIO_SUPPORT, aio);
 	STATUS(HAVE_ZSTD_SUPPORT, zstd);
+	STATUS(HAVE_LIBPFM, libpfm4);
 }
 
 int cmd_version(int argc, const char **argv)
-- 
2.29.0.rc1.297.gfa9743e501-goog

