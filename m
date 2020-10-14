Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAD328DC18
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgJNIyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgJNIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:54:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8910C04584F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x7so2175357wrl.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=igXAGBZC9WRS0I/AyJdOZqEGrrLVhVIpGzSowNyr2S0=;
        b=M2tbV51onY3LaSYyRp+gNKzHKdD1dV4O5AG8S5KolqzZ90e03BZZNn2wyVP1oPJEUJ
         lFASq5qRGTJLPNlVbFzJ8hard+hy+6Se2HKXouyfXElFXG7BLjWA4EAHfbkGaySPrPpC
         HT3a3K6au8hyK9yW8F5Ndx9RJZJadGoOJqi2bWu46a/Sy9liIhQvZU4jMLlEXmGBs7EF
         WKbmRojzpxa2jpUHLZY6nsnyekcgZGVyWrdmMIERUhMHwgakUGIEewqUEecgc+Hb7+8b
         W7ZO1wiOzxCM3FqbGUAjaVNwbo+HKyeZZNFb5PD/GPA1qGL56WwtlBBtH4mlzegpK04X
         gyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=igXAGBZC9WRS0I/AyJdOZqEGrrLVhVIpGzSowNyr2S0=;
        b=h5pbYZho6c97SMMok3Qk1KmX3YqR/q7ejnQLGQZY/5jN70eqf6bR8IruGQryhVXCNy
         fD4iHUw22i8KSJmEausfzUisibSc6Xl+HMpFdA/pcJojxDBz/GZJNpfqmcD1gXX2GtvJ
         MagmVuGUn4dHlcWgD9BcGYtR+7chzR914un7t04y8zkLMiD/43NifGgNO7EiOZUCxQCl
         FlpzwmotExbIhxk0hm3oywTUCQKUb5nKuu6RU/YvQ6jmyolxgilZRi5BT2p97k/x8HUI
         CPi0kfI0Q3Swcwa1J8e3/iREE5eemVasVupLOBs/pZkd0jFx0nGmKvGX6OWzKconEz6d
         CAOA==
X-Gm-Message-State: AOAM532GB585odTfFTCq4JGXm6po1Y4lXgRletREPp/KVEWB5KiNPtXq
        y/hgCXscGNV98TESpYmZm0Bnng==
X-Google-Smtp-Source: ABdhPJzbkjqD8I+Z8lDzCXaHlpsMBtBwnqNrfKiGd87gkNXVVvK+Vq3IKM5kNlDae/JDF0StKJBFTw==
X-Received: by 2002:adf:90c4:: with SMTP id i62mr3044450wri.98.1602652176442;
        Tue, 13 Oct 2020 22:09:36 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id t124sm1823330wmg.31.2020.10.13.22.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 22:09:35 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Mario <jmario@redhat.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 4/8] perf c2c: Change header from "LLC Load Hitm" to "Load Hitm"
Date:   Wed, 14 Oct 2020 06:09:17 +0100
Message-Id: <20201014050921.5591-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014050921.5591-1-leo.yan@linaro.org>
References: <20201014050921.5591-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metrics "LLC Load Hitm" contains two items: one is "local Hitm" and
another is "remote Hitm".

"local Hitm" means: L3 HIT and was serviced by another processor core
with a cross core snoop where modified copies were found; it's no doubt
that "local Hitm" belongs to LLC access.

But for "remote Hitm", based on the code in util/mem-events, it's the
event for remote cache HIT and was serviced by another processor core
with modified copies.  Thus the remote Hitm is a remote cache's hit and
actually it's LLC load miss.

Now the display format gives users the impression that "local Hitm" and
"remote Hitm" both belong to the LLC load, but this is not the fact as
described.

This patch changes the header from "LLC Load Hitm" to "Load Hitm", this
can avoid the give the wrong impression that all Hitm belong to LLC.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 404d4739b8c1..fa7a1c55b989 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1328,7 +1328,7 @@ static struct c2c_dimension dim_iaddr = {
 };
 
 static struct c2c_dimension dim_tot_hitm = {
-	.header		= HEADER_SPAN("----- LLC Load Hitm -----", "Total", 2),
+	.header		= HEADER_SPAN("------- Load Hitm -------", "Total", 2),
 	.name		= "tot_hitm",
 	.cmp		= tot_hitm_cmp,
 	.entry		= tot_hitm_entry,
-- 
2.17.1

