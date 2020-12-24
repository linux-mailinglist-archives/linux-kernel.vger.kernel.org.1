Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E5E2E2773
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgLXNwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 08:52:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgLXNwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:52:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAFEF22287;
        Thu, 24 Dec 2020 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608817886;
        bh=wLns9vObxxx0pxYvhSFlfHflWryqLD1ESlAgSO2vQzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0rk2V/EOWGfxa2SCoYMVf3Or9GON8qDDMmsEYC50MuqFekPdhhubnt/l7KbLITuh
         Wz0S+lgMlY6x4sE8etFCZDmncYRQDpjf9TBHFYtJ38J4sHl665TPVyGKgu3jrm9leh
         x6P9vNtWfiBXPxZJi3Y6c/5zQhnGxbPW1pYbtocoRjk7QyWBwc9pyfnt868qu7afM/
         ZZrRVFRbxYb8hkRyscgI7/pQOhgFfj35cvsReXYj7qSefUkUxns3LDE7/kjVVud8q0
         rgqWsFMNXGw7h6kH5IYtZbSbq+AERbOpUB05zx8ZmRJUlXsiu3UCsY0grv57e32HDM
         ErNBZQHCs8EdQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5E20C411E9; Thu, 24 Dec 2020 10:51:39 -0300 (-03)
Date:   Thu, 24 Dec 2020 10:51:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf probe: Fixup Arm64 SDT arguments
Message-ID: <20201224135139.GF477817@kernel.org>
References: <20201223063905.25784-1-leo.yan@linaro.org>
 <20201223063905.25784-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223063905.25784-2-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 23, 2020 at 02:39:04PM +0800, Leo Yan escreveu:
> Arm64 ELF section '.note.stapsdt' uses string format "-4@[sp, NUM]" if
> the probe is to access data in stack, e.g. below is an example for
> dumping Arm64 ELF file and shows the argument format:
> 
>   Arguments: -4@[sp, 12] -4@[sp, 8] -4@[sp, 4]
> 
> Comparing against other archs' argument format, Arm64's argument
> introduces an extra space character in the middle of square brackets,
> due to argv_split() uses space as splitter, the argument is wrongly
> divided into two items.
> 
> To support Arm64 SDT, this patch fixes up for this case, if any item
> contains sub string "[sp", concatenates the two continuous items.  And
> adds the detailed explaination in comment.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/probe-file.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 064b63a6a3f3..60878c859e60 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -794,6 +794,8 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
>  	char *ret = NULL, **args;
>  	int i, args_count, err;
>  	unsigned long long ref_ctr_offset;
> +	char *arg;
> +	int arg_idx = 0;
>  
>  	if (strbuf_init(&buf, 32) < 0)
>  		return NULL;
> @@ -815,8 +817,34 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
>  	if (note->args) {
>  		args = argv_split(note->args, &args_count);
>  
> -		for (i = 0; i < args_count; ++i) {
> -			if (synthesize_sdt_probe_arg(&buf, i, args[i]) < 0)
> +		for (i = 0; i < args_count; ) {
> +			/*
> +			 * FIXUP: Arm64 ELF section '.note.stapsdt' uses string
> +			 * format "-4@[sp, NUM]" if a probe is to access data in
> +			 * the stack, e.g. below is an example for the SDT
> +			 * Arguments:
> +			 *
> +			 *   Arguments: -4@[sp, 12] -4@[sp, 8] -4@[sp, 4]
> +			 *
> +			 * Since the string introduces an extra space character
> +			 * in the middle of square brackets, the argument is
> +			 * divided into two items.  Fixup for this case, if an
> +			 * item contains sub string "[sp,", need to concatenate
> +			 * the two items.
> +			 */
> +			if (strstr(args[i], "[sp,") && (i+1) < args_count) {
> +				arg = strcat(args[i], args[i+1]);
> +				i += 2;
> +			} else {
> +				arg = strdup(args[i]);
> +				i += 1;
> +			}
> +
> +			err = synthesize_sdt_probe_arg(&buf, arg_idx, arg);
> +			free(arg);

So you free here unconditionally because either you used something you
got from argv_split() that strdup'ed all the entries in the array it
returns, or that you strdup'ed in the else branch.

But then you may not free all the things argv_split() returned, right?
Also, that strcat(args[i], args[i+1]), are you sure that is safe? strcat
expects dest to have enough space for the concatenation, I don't see
argv_split[] adding extra bytes, just a strdup().

So probably you need asprintf() where you use strcat() and then, at the
end of the loop, you need to free what argv_split() returned, using
argv_free(), no?

Also please check strdup() (and then asprintf) managed to allocate, else
synthesize_sdt_probe_arg() will receive its 'desc' argument as NULL, do
_another_ strdup on it and boom.

Or am I missing something? :)

I just looked ant synthesize_sdt_probe_command() is leaking the args it
gets from argv_split()

So this patch is needed, ack?

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 064b63a6a3f311cd..bbecb449ea944395 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -791,7 +791,7 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
 					const char *sdtgrp)
 {
 	struct strbuf buf;
-	char *ret = NULL, **args;
+	char *ret = NULL;
 	int i, args_count, err;
 	unsigned long long ref_ctr_offset;
 
@@ -813,12 +813,19 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
 		goto out;
 
 	if (note->args) {
-		args = argv_split(note->args, &args_count);
+		char **args = argv_split(note->args, &args_count);
+
+		if (args == NULL)
+			goto error;
 
 		for (i = 0; i < args_count; ++i) {
-			if (synthesize_sdt_probe_arg(&buf, i, args[i]) < 0)
+			if (synthesize_sdt_probe_arg(&buf, i, args[i]) < 0) {
+				argv_free(args);
 				goto error;
+			}
 		}
+
+		argv_free(args);
 	}
 
 out:
