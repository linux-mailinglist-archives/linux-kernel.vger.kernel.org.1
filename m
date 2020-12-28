Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24512E3516
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 09:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgL1Icz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 03:32:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbgL1Icy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 03:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609144288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0irfHFdDSN+gi4QxY+Eyd06TB6TiH/k57Saupd0Qtc=;
        b=fTwdWk6hknkqzViJTPIJyzTB4kge/tf2KnHH7IE88WbaBiiLM4Hxu7jJ43Hvznh30yYvjc
        Uj+gz5Inqc61uhWeFYvNJts40UzpAqDZOfvTsNIhNbVkPGyUo6gUsxInW9DsiNcqQvDjql
        PmrkjHF28rv2/RoO6u2J0Axl0+CELCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-2dg01nSANUGl60BCcEA5eg-1; Mon, 28 Dec 2020 03:31:25 -0500
X-MC-Unique: 2dg01nSANUGl60BCcEA5eg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17607107ACF6;
        Mon, 28 Dec 2020 08:31:24 +0000 (UTC)
Received: from krava (unknown [10.40.192.84])
        by smtp.corp.redhat.com (Postfix) with SMTP id AF71E19441;
        Mon, 28 Dec 2020 08:31:21 +0000 (UTC)
Date:   Mon, 28 Dec 2020 09:31:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/3] tools/lib/fs: Diet cgroupfs_find_mountpoint()
Message-ID: <20201228083120.GA450923@krava>
References: <20201216090556.813996-1-namhyung@kernel.org>
 <20201216090556.813996-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216090556.813996-2-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 06:05:55PM +0900, Namhyung Kim wrote:

SNIP

> +		*p++ = '\0';
>  
> -			while (token != NULL) {
> -				if (subsys && !strcmp(token, subsys)) {
> -					/* found */
> -					fclose(fp);
> +		/* check filesystem type */
> +		if (strncmp(p, "cgroup", 6))
> +			continue;
>  
> -					if (strlen(mountpoint) < maxlen) {
> -						strcpy(buf, mountpoint);
> -						return 0;
> -					}
> -					return -1;
> -				}
> -				token = strtok_r(NULL, ",", &saved_ptr);
> -			}
> +		if (p[6] == '2') {
> +			/* save cgroup v2 path */
> +			strcpy(mountpoint, path);
> +			continue;
>  		}
>  
> -		if (!strcmp(type, "cgroup2"))
> -			strcpy(path_v2, mountpoint);
> +		/* now we have cgroup v1, check the options for subsystem */
> +		p += 7;
> +
> +		p = strstr(p, subsys);

not sure this is a real problem, but this would mixe up for
cpu/cpuacct/cpuset no? we are using the function for perf_event
subsys only, but it's globaly availble

jirka

> +		if (p == NULL)
> +			continue;
> +
> +		/* sanity check: it should be separated by a space or a comma */
> +		if (!strchr(" ,", p[-1]) || !strchr(" ,", p[strlen(subsys)]))
> +			continue;
> +
> +		strcpy(mountpoint, path);
> +		break;
>  	}
> +	free(line);
>  	fclose(fp);
>  
> -	if (path_v2[0] && strlen(path_v2) < maxlen) {
> -		strcpy(buf, path_v2);
> +	if (mountpoint[0] && strlen(mountpoint) < maxlen) {
> +		strcpy(buf, mountpoint);
>  		return 0;
>  	}
>  	return -1;
> -- 
> 2.29.2.684.gfbc64c5ab5-goog
> 

