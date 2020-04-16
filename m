Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02341AC7F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409088AbgDPPBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 11:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439781AbgDPPBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:01:10 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12324C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:01:10 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x2so16631238qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lpQpTnB6uwsBydiAGN/TFRHwAzlMUvz1NbDPp1spzsM=;
        b=mCWSljnIyYpsxY8CPe5AE6ZgSkMm2M/cPwP743UpLY53s2viwDu0kj/PIq7UnhGNfb
         J3a4qq+HtTHZLRhcdSq1Kg2MAVHcynq1NRTpFwMkVDIKB4Ujwm0rzrEt/PJ39dnsP3hu
         zA8nzc6T2c+BEZJ9oDZduWF/dBdS1G8sveY0b87/A8I2dfxs+GpQTm+C4Tyc0pIVzPDP
         jg7QLsHHA9X5Cfwe5tKMBLjxq7jHFzG0p29fo7xBPYNWh3sc4Z85YK7cjarY07jZQKn5
         XdbmAsrO6EXePFpqy2GKT4qxIPfv+6DuRYlg4BwEk8XPPYE+piRmRaGStaYIS4GW49w8
         0t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lpQpTnB6uwsBydiAGN/TFRHwAzlMUvz1NbDPp1spzsM=;
        b=AOs8UlV1xD94aNTVC+dapNGDkoB1vwjroZ24Td9oR6PYf0+M79IM4O7A4LHGycfPF9
         0oOXRhFCNDIqygyk8D7rNNBsDpXcvI+3jiHUoBosW4HT9N5OkgqCMai+lc+5QaCa2lQK
         L4dn97rY60EuTIcCoethPpMZixUyORJ/rdzWgJxEWdRFE3HH2g3RWP/ZiWeuNk2eCGsL
         d0jYeqIjXz3ADCsPMZHA3in2QMu9A7b0f+AyIwqvleGMUH6O4YUEX+9mZIpVnCcBAGtm
         Vu5VZ+nSuyomv8Wji1Ilf8RYMyW35KemL7sjtjRMcDhTl4PQaiv3XviaROShEIoHVFSh
         ldVQ==
X-Gm-Message-State: AGi0Puawqz5IwTpkbu98b4FlQJTDll55f02PZPK/yHw+L2WCICQ+LCM7
        UI2g4s7daulKyO94T4UwL0s=
X-Google-Smtp-Source: APiQypIWW1+0WzMEPhUtUNzoXP4apgI30t35X7vMcRFurBcKiLWdMPgCAKYv1Tjz95vW24/lgRSjbA==
X-Received: by 2002:ac8:1406:: with SMTP id k6mr26273684qtj.102.1587049269049;
        Thu, 16 Apr 2020 08:01:09 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 190sm9010459qkl.46.2020.04.16.08.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:01:08 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8B616409A3; Thu, 16 Apr 2020 12:01:06 -0300 (-03)
Date:   Thu, 16 Apr 2020 12:01:06 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] perf tools: Add support for synthesized sample type
Message-ID: <20200416150106.GB31666@kernel.org>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-11-adrian.hunter@intel.com>
 <20200416145426.GA31666@kernel.org>
 <20200416145704.GA1842@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416145704.GA1842@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 16, 2020 at 11:57:04AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Apr 16, 2020 at 11:54:26AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Apr 01, 2020 at 01:16:07PM +0300, Adrian Hunter escreveu:
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -2136,7 +2136,7 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> > >  		}
> > >  	}

> > > -	if (evsel__has_callchain(evsel)) {
> > > +	if (type & PERF_SAMPLE_CALLCHAIN) {
> > >  		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);

> > This ends up looking unrelated, I had to go and look at the source to
> > see that this is just a simplification, i.e. earlier in this function
> > (perf_evsel__parse_sample) we have:

> >         u64 type = evsel->core.attr.sample_type;

> > So the above doesn't change anything, good, but slowed reviewing a bit,
> > please consider next time to have this in a separate patch, I'll do it
> > this time.

> I've added this as the cset comment:

> Using 'type' variable for checking for callchains is equivalent to using
> evsel__has_callchain(evsel) and is how the other PERF_SAMPLE_ bits are checked
> in this function, so use it to be consistent.

Then, reading the rest of the patch, evsel__has_callchain() is not
anymore equivalent to just looking at the PERF_SAMPLE_ bit in core.attr
:-)

- Arnaldo
