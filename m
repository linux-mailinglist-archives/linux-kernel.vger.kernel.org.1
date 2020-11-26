Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F62C5B01
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404530AbgKZRrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404191AbgKZRrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:47:08 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42EE82053B;
        Thu, 26 Nov 2020 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606412827;
        bh=wZoV0n/gzcizNkKCUyreIySmJ5xKQd/MwQIk8OXyokk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GyJCwguj1YSfCMQZPzU3q8b54bSLlm2/m9D+JN0uAuGm5dcOt2c3xJchSoH1ZqV81
         pF7SO9WAji9Z4MmVs6uNsFuj/2HbpJKxe73rGLW/IU8z/jxtpSR6G/YV3xGvXPd3kn
         vCcWIGQPyYq/me352k1dWZ/yW/Z2DIAKBlzZ6LfI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 53C8C40E29; Thu, 26 Nov 2020 14:47:05 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:47:05 -0300
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
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 10/25] perf tools: Add check for existing link in buildid
 dir
Message-ID: <20201126174705.GB70905@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-11-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-11-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 26, 2020 at 06:00:11PM +0100, Jiri Olsa escreveu:
> When adding new build id link we fail if the link is already
> there. Adding check for existing link and output debug message
> that the build id is already linked.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/build-id.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 2aacc8b29f7e..4a391f13f40d 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -755,8 +755,25 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
>  	tmp = dir_name + strlen(buildid_dir) - 5;
>  	memcpy(tmp, "../..", 5);
>  
> -	if (symlink(tmp, linkname) == 0)
> +	if (symlink(tmp, linkname) == 0) {
>  		err = 0;
> +	} else if (errno == EEXIST) {
> +		char path[PATH_MAX];
> +		ssize_t len;
> +
> +		len = readlink(linkname, path, sizeof(path) - 1);
> +		if (len <= 0) {
> +			pr_err("Cant read link: %s\n", linkname);
> +			goto out_free;
> +		}
> +		path[len] = '\0';
> +
> +		if (strcmp(tmp, path)) {
> +			pr_debug("build <%s> already linked to %s\n",
> +				 sbuild_id, linkname);
> +		}
> +		err = 0;
> +	}
>  
>  	/* Update SDT cache : error is just warned */
>  	if (realname &&
> -- 
> 2.26.2
> 

-- 

- Arnaldo
