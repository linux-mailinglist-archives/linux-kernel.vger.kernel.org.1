Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95C928E552
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbgJNR1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJNR1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:27:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAB5C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:27:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a3so5924642ejy.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IMqbIe+mRlbJqVmn4jLKuZAagD2wd8VSkTOeSKBklkc=;
        b=hV8O+PlEsf4AkEsIk1Kd2NA86+Y2rTSlTZfxqzMEk4It3CmJ1C+np1XJz85Z66n/uy
         1YwHX1rpGAfH2ySSIIcNV+LDXHhtVC7ydyYmq2hhVVIkjMuk+G+wlAYiuU8ByUN/bQ9K
         H/mVkwvllPo9FQShEvlD1vFmuZ1eGCw7tesO8q/ffoAMU+e+5177tqZDJWPZKFDmxTGH
         Vwq+0SqQKp6sTHlLfoTw39MRTTYAT+3w81NJTPYG9gtVIRWcePY2g/M7/5AnhG6gEjKe
         Z0OlVUerYL5eRNM+KeGrqcN6cPRrApECGLRafRg0d2NrODSQTPdDyYsrMb+yEqWvWYmL
         uadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IMqbIe+mRlbJqVmn4jLKuZAagD2wd8VSkTOeSKBklkc=;
        b=hUjCWmg7OTcXyWq5Hg2jTPzizxKM4de73+eey4v/KiySNeQ7YT/BPhQ/4vpTQYKHdH
         tLw8xXgKA4AEUK928Nz3tUXw/VQxqPNb8zSzljjBZYZpAQrqwWHkLgyL95E30jRyio8e
         xWEF6sE5rsZcH31TKb922BzQdPi1pDa6i5s39eZPqjJDRKV6ApY8GRFOIDwqiUYqZJoN
         3zKFuujrEzSpGZiHUOMHnr2koTJqtUxk4V9LdC1WsIap/4sG/VEB/fo6uu7u/pta4kIJ
         8BGXdDJM3DnfLdT9u/n3kuYJFX2bgQ2B0TMEyhCQercW3r9T+sPuOi4SHJ3pUBJW+npo
         WArQ==
X-Gm-Message-State: AOAM5313PzGFt4uNVFT2uE5Q9t3FnPU8rGMtA0SDMCRe3lhOdz0qR04G
        AeYWCBt/ie4aTynLe4jyTgE=
X-Google-Smtp-Source: ABdhPJzuruQ0SOv8YkRjJX2YZSUrSCF5Y+6FbjrBAcz/miorPAMM/CgAToSSJuhVSnidrXaMLsvZ3g==
X-Received: by 2002:a17:907:3393:: with SMTP id zj19mr113551ejb.258.1602696422591;
        Wed, 14 Oct 2020 10:27:02 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id x2sm95032edr.65.2020.10.14.10.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 10:27:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 14 Oct 2020 19:27:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 00/15] Introduce threaded trace streaming for basic
 perf record operation
Message-ID: <20201014172700.GA3595702@gmail.com>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Budankov <alexey.budankov@linux.intel.com> wrote:

> 
> Patch set provides threaded trace streaming for base perf record
> operation. Provided streaming mode (--threads) mitigates profiling
> data losses and resolves scalability issues of serial and asynchronous
> (--aio) trace streaming modes on multicore server systems. The patch
> set is based on the prototype [1], [2] and the most closely relates
> to mode 3) "mode that creates thread for every monitored memory map".
> 
> The threaded mode executes one-to-one mapping of trace streaming threads
> to mapped data buffers and streaming into per-CPU trace files located
> at data directory. The data buffers and threads are affined to NUMA
> nodes and monitored CPUs according to system topology. --cpu option
> can be used to specify exact CPUs to be monitored.

Yay! This should really be the default trace capture model everywhere 
possible.

Can we do this for perf top too? It's really struggling with lots of cores.

If on a 64-core system I run just a moderately higher frequency 'perf top' 
of 1 kHz:

  perf top -e cycles -F 1000

perf stays stuck forever in 'Collecting samples...', and I also get a lot 
of:

  [548112.871089] Uhhuh. NMI received for unknown reason 31 on CPU 25.
  [548112.871089] Do you have a strange power saving mode enabled?

Thanks,

	Ingo
