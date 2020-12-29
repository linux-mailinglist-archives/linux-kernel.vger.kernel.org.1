Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356D82E702D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgL2LwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:52:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgL2LwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:52:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92A8820825;
        Tue, 29 Dec 2020 11:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609242700;
        bh=LE43JNvhJKsI7wyMokRmVvhFB60Mt6PQwR/tbJeav5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0Xt0F+rKbYfMo4KJCTqm8fus/HfA7VIADDVUsD7/4j3ItvNKg1c1woGDwLcyxoqM
         i8pgXpWrVZaEcIwQILJpoJHwl6ynsQKXKChR4rQm1upSoQWkB3sXUEzexw8H0ssbtx
         hiemlXe9P9fruKTEfN/GSHlpM+/j+0V+3kK8FoFjhhH3mbFvzjdQhVp3yjcOe648j3
         biyWjPKdRIoaxqCxrx08Pi7JszKN90VFgydKITkt2IfudUn3HTEmgj4KARgei4VO/U
         rq/bcmOvO1wegwUM7s/HyhlGWazS/wPscXIDROYIw1wMtiy/8iS+viJinDbqLZGnfn
         ZIpW3G41DhDng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1BF2D411E9; Tue, 29 Dec 2020 08:51:58 -0300 (-03)
Date:   Tue, 29 Dec 2020 08:51:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/3] tools/lib/fs: Cache cgroupfs mount point
Message-ID: <20201229115158.GH521329@kernel.org>
References: <20201216090556.813996-1-namhyung@kernel.org>
 <20201216090556.813996-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216090556.813996-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 16, 2020 at 06:05:56PM +0900, Namhyung Kim escreveu:
> Currently it parses the /proc file everytime it opens a file in the
> cgroupfs.  Save the last result to avoid it (assuming it won't be
> changed between the accesses).

Which is the most likely case, but can't we use something like inotify
to detect that and bail out or warn the user?

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/api/fs/cgroup.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/lib/api/fs/cgroup.c b/tools/lib/api/fs/cgroup.c
> index 262a4229e293..1573dae4259d 100644
> --- a/tools/lib/api/fs/cgroup.c
> +++ b/tools/lib/api/fs/cgroup.c
> @@ -8,6 +8,14 @@
>  #include <string.h>
>  #include "fs.h"
>  
> +struct cgroupfs_cache_entry {
> +	char	subsys[32];
> +	char	mountpoint[PATH_MAX];
> +};
> +
> +/* just cache last used one */
> +static struct cgroupfs_cache_entry cached;
> +
>  int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
>  {
>  	FILE *fp;
> @@ -16,6 +24,14 @@ int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
>  	char *p, *path;
>  	char mountpoint[PATH_MAX];
>  
> +	if (!strcmp(cached.subsys, subsys)) {
> +		if (strlen(cached.mountpoint) < maxlen) {
> +			strcpy(buf, cached.mountpoint);
> +			return 0;
> +		}
> +		return -1;
> +	}
> +
>  	fp = fopen("/proc/mounts", "r");
>  	if (!fp)
>  		return -1;
> @@ -75,6 +91,9 @@ int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
>  	free(line);
>  	fclose(fp);
>  
> +	strncpy(cached.subsys, subsys, sizeof(cached.subsys) - 1);
> +	strcpy(cached.mountpoint, mountpoint);
> +
>  	if (mountpoint[0] && strlen(mountpoint) < maxlen) {
>  		strcpy(buf, mountpoint);
>  		return 0;
> -- 
> 2.29.2.684.gfbc64c5ab5-goog
> 

-- 

- Arnaldo
