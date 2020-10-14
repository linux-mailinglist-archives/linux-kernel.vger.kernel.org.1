Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A9328DFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbgJNLpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgJNLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602675908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FzQmap78sNVuipaEMgyjy6HFr6oEhHytPOHW5SRLOQ8=;
        b=aWpbHTIoOChK3d4JryghYs4ZUDwpXm60y9cq0g8QSef5cqHoYOaMfOvTb+QuY2PsQNsvI6
        vGnbZbeknkoDpwZGvU2pmoSULCY2e3ra76zgE1A5gio2rde+A7rlbudGdicNuaSDFcg+zH
        OcICz4r/SZugrEIxKVujbJvIi4jlZn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-RQo0crmVPZeWZM2Kzs65Ow-1; Wed, 14 Oct 2020 07:45:06 -0400
X-MC-Unique: RQo0crmVPZeWZM2Kzs65Ow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 780501015CB2;
        Wed, 14 Oct 2020 11:45:04 +0000 (UTC)
Received: from krava (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id A1E3055789;
        Wed, 14 Oct 2020 11:45:01 +0000 (UTC)
Date:   Wed, 14 Oct 2020 13:45:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peng Fan <fanpeng@loongson.cn>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf bench: Use condition variables in numa.
Message-ID: <20201014114500.GB1375972@krava>
References: <20201012161611.366482-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012161611.366482-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 09:16:11AM -0700, Ian Rogers wrote:

SNIP

> @@ -483,6 +484,18 @@ static void init_global_mutex(pthread_mutex_t *mutex)
>  	pthread_mutex_init(mutex, &attr);
>  }
>  
> +/*
> + * Return a process-shared (global) condition variable:
> + */
> +static void init_global_cond(pthread_cond_t *cond)
> +{
> +	pthread_condattr_t attr;
> +
> +	pthread_condattr_init(&attr);
> +	pthread_condattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
> +	pthread_cond_init(cond, &attr);
> +}
> +
>  static int parse_cpu_list(const char *arg)
>  {
>  	p0.cpu_list_str = strdup(arg);
> @@ -1136,15 +1149,18 @@ static void *worker_thread(void *__tdata)
>  	if (g->p.serialize_startup) {
>  		pthread_mutex_lock(&g->startup_mutex);
>  		g->nr_tasks_started++;
> +		/* The last thread wakes the main process. */
> +		if (g->nr_tasks_started == g->p.nr_tasks)
> +			pthread_cond_signal(&g->startup_cond);

should you remove the condition? it's not necessary
and making this racy, no?

just single pthread_cond_signal should be enough,
because the wait code is checking the number of tasks

jirka

