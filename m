Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30369269150
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgINQUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgINQP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:15:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551822193E;
        Mon, 14 Sep 2020 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600100112;
        bh=gPbSbGy4lm8KvPqNHKfz7UVHDY/Zl4DSgvGAOQyQCKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cas+BpRQ+wt+1A0MeJeN14TH2LqTFfI73ofe5bl0ROHTBpkcv5IXj475BbdogR25Y
         yOpVw1ssCF4zEh5HX4R+9x7/HxysC1fyUmYo6Q/OK5zoRKZQBsoiRZF1MKlNijfkDi
         YCnUlt2SM9cQOj+c/uapn9an9fKVRCwiX8wWt/+w=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6A12740D3D; Mon, 14 Sep 2020 13:15:10 -0300 (-03)
Date:   Mon, 14 Sep 2020 13:15:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 21/26] perf tools: Add machine__for_each_dso function
Message-ID: <20200914161510.GN160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-22-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913210313.1985612-22-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 13, 2020 at 11:03:08PM +0200, Jiri Olsa escreveu:
> Adding machine__for_each_dso to iterate over all dso
> objects defined for the within the machine. It will
> be used in following changes.

prep work, applying.

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/machine.c | 12 ++++++++++++
>  tools/perf/util/machine.h |  4 ++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 863d949ef967..f8e8d0d80847 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -3181,3 +3181,15 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
>  	*addrp = map->unmap_ip(map, sym->start);
>  	return sym->name;
>  }
> +
> +int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv)
> +{
> +	struct dso *pos;
> +	int err = 0;
> +
> +	list_for_each_entry(pos, &machine->dsos.head, node) {
> +		if (fn(pos, machine, priv))
> +			err = -1;
> +	}
> +	return err;
> +}
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index a3c1d0bf89e5..504c707f22bb 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -252,6 +252,10 @@ void machines__destroy_kernel_maps(struct machines *machines);
>  
>  size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp);
>  
> +typedef int (*machine__dso_t)(struct dso *dso, struct machine *machine, void *priv);
> +
> +int machine__for_each_dso(struct machine *machine, machine__dso_t fn,
> +			  void *priv);
>  int machine__for_each_thread(struct machine *machine,
>  			     int (*fn)(struct thread *thread, void *p),
>  			     void *priv);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
