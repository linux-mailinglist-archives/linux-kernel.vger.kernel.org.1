Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1282F1930
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbhAKPG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbhAKPGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:06:55 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BE4C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:06:15 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 30so12683789pgr.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dOiO62KsX0NSWhPyER9EWahr6YjNU7/wBoB4Mtw/qG8=;
        b=I26iCUdkJfEx0eL31iUzJKV2NGdBGlmztRk2l8NK8xPkktIFW5IWvNoEP2hsV8zjMx
         i1xgmbxWlTLia+1PSEw+AJHXzbfB9CEzh5ZKH+62fcbJUj2iZgaVOmkSC9H5Z/I40TEk
         GZq0G17/BBzM6hFL7POwOT8QdIGBt445DdakOul8CW7fZd9Iq6SfgLLoWlq4m7yMSlT/
         l2NBW9RJVqmtPHqJsOaS6/xx+QyjUQNPsPZH8Nn8CGZ30W2oBx6m2/6IsDMpzzJBlMJo
         3wG2SGQ2/+YfIFVldeAezNkqg1eHTZ/4jmuV8Ni64dQbFHtGKKrekFIw14+QXiDBRE+v
         lv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dOiO62KsX0NSWhPyER9EWahr6YjNU7/wBoB4Mtw/qG8=;
        b=TEHJ3Cut4dalQ++a/t27JKEaC/pSGBSyMU6LI8gc21XcGY3aVZqyT+YpmzbiJZygsS
         f77qs/zXmXgny8tsAnRD27XfY8QDT37uSA9j6bX3YKtrfLbY3iTfYPcnODVquCCljfpt
         veu6fhDMcOSbDcrBP8gJuVkAlwptpYByd/XeuzXjCJM4UIdRNTQmwzROcweubd9Y+84H
         BeUqrVdyOcw/+yq0bhJz55FGu2kJJi78ryZbqey/x+JzlLOKYLvVYFQXGZmgFdazzTh/
         /auHB7YEKTM2EiVtO1WNYDUp2Ig0aD9POttZVpDsG2FHw1+KtYOwlFs9H6G45ZVDG2lv
         P4Ww==
X-Gm-Message-State: AOAM532evP+Dtpj1gntYroMJglKo+1nqLAGSn12SfNba9VcTfelggefl
        37VocRf56zEugptS0Bv/6Vu60Q==
X-Google-Smtp-Source: ABdhPJyM+zLWM6rli5NSRUi4NFJ6N14FxaYpUYt+V4qKxrq6RHNrPGzbbWI8N8JhW19Eaf2LTFHNOg==
X-Received: by 2002:a63:d917:: with SMTP id r23mr49303pgg.126.1610377574968;
        Mon, 11 Jan 2021 07:06:14 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id x1sm62153pgj.37.2021.01.11.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:06:14 -0800 (PST)
Date:   Mon, 11 Jan 2021 23:06:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/7] perf cs-etm: Calculate per CPU metadata array size
Message-ID: <20210111150608.GC222747@leoy-ThinkPad-X240s>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-4-leo.yan@linaro.org>
 <96ec434e-4103-02ac-a05a-761a9ca8cb0d@arm.com>
 <CAJ9a7VjtUuRRYBBu63kSXKwrGdB8ZoWJz-bE1g9tMLSbkFVDGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VjtUuRRYBBu63kSXKwrGdB8ZoWJz-bE1g9tMLSbkFVDGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Mon, Jan 11, 2021 at 12:09:12PM +0000, Mike Leach wrote:
> Hi Leo,
> 
> I think there is an issue here in that your modification assumes that
> all cpus in the system are of the same ETM type. The original routine
> allowed for differing ETM types, thus differing cpu ETM field lengths
> between ETMv4 / ETMv3, the field size was used after the relevant
> magic number for the cpu ETM was read.
> 
> You have replaced two different sizes - with a single calculated size.

Thanks for pointing out this.

> Moving forwards we are seeing the newer FEAT_ETE protocol drivers
> appearing on the list, which will ultimately need a new metadata
> structure.
> 
> We have had discussions within ARM regarding the changing of the
> format to be more self describing - which should probably be opened
> out to the CS mailing list.

I think here have two options.  One option is I think we can use
__perf_cs_etmv3_magic/__perf_cs_etmv4_magic as indicator for the
starting of next metadata array; when copy the metadata, always check
the next item in the buffer, if it's __perf_cs_etmv3_magic or
__perf_cs_etmv4_magic, will break loop and start copying metadata
array for next CPU.  The suggested change is pasted in below.

Another option is I drop patches 03,05/07 in the series and leave the
backward compatibility fixing for a saperate patch series with self
describing method.  Especially, if you think the first option will
introduce trouble for enabling self describing later, then I am happy
to drop patches 03,05.

How about you think for this?

Thanks,
Leo

---8<---

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a2a369e2fbb6..edaec57362f0 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2558,12 +2558,19 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 				err = -ENOMEM;
 				goto err_free_metadata;
 			}
-			for (k = 0; k < CS_ETM_PRIV_MAX; k++)
+			for (k = 0; k < CS_ETM_PRIV_MAX; k++) {
 				metadata[j][k] = ptr[i + k];
 
+				if (ptr[i + k + 1] == __perf_cs_etmv3_magic ||
+				    ptr[i + k + 1] == __perf_cs_etmv4_magic) {
+					k++;
+					break;
+				}
+			}
+
 			/* The traceID is our handle */
 			idx = metadata[j][CS_ETM_ETMTRACEIDR];
-			i += CS_ETM_PRIV_MAX;
+			i += k;
 		} else if (ptr[i] == __perf_cs_etmv4_magic) {
 			metadata[j] = zalloc(sizeof(*metadata[j]) *
 					     CS_ETMV4_PRIV_MAX);
@@ -2571,12 +2578,19 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 				err = -ENOMEM;
 				goto err_free_metadata;
 			}
-			for (k = 0; k < CS_ETMV4_PRIV_MAX; k++)
+			for (k = 0; k < CS_ETMV4_PRIV_MAX; k++) {
 				metadata[j][k] = ptr[i + k];
 
+				if (ptr[i + k + 1] == __perf_cs_etmv3_magic ||
+				    ptr[i + k + 1] == __perf_cs_etmv4_magic) {
+					k++;
+					break;
+				}
+			}
+
 			/* The traceID is our handle */
 			idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
-			i += CS_ETMV4_PRIV_MAX;
+			i += k;
 		}
 
 		/* Get an RB node for this CPU */
