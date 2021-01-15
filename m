Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAE42F764D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbhAOKKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:10:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbhAOKKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610705327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0jeUwGI24ohWKSyY8tSQWF3OB5jLgFvaJzhPbJkeUE=;
        b=FMB4Yl2ROyi7z2cWSxDYp5blNuJwE03SLmRU51yHE/XN2B8iSYWYRS3l/0rHQwzXMDDNk+
        KLtd+YosGOxn8U9lOe0YyLVoja8fzhnWHRfZVHFjDTmWTO/0Ulg7cSkVKTbIDKgrmitL8z
        y4dBVFAs4z9Gl4EAnJ67spJPiu8AIVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-sdLOY6Q2MPaLCnJQIn-OZQ-1; Fri, 15 Jan 2021 05:08:45 -0500
X-MC-Unique: sdLOY6Q2MPaLCnJQIn-OZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6855287950E;
        Fri, 15 Jan 2021 10:08:43 +0000 (UTC)
Received: from krava (unknown [10.40.194.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 12CF171C87;
        Fri, 15 Jan 2021 10:08:39 +0000 (UTC)
Date:   Fri, 15 Jan 2021 11:08:39 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Subject: Re: [PATCH v7 4/5] perf metric: Add utilities to work on ids map.
Message-ID: <20210115100839.GB1478666@krava>
References: <20210112230434.2631593-1-irogers@google.com>
 <20210112230434.2631593-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112230434.2631593-5-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 03:04:33PM -0800, Ian Rogers wrote:

SNIP

>  
> +struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2)
> +{
> +	size_t bkt;
> +	struct hashmap_entry *cur;
> +	int ret;
> +	struct expr_id_data *old_data = NULL;
> +	char *old_key = NULL;
> +
> +	if (!ids1)
> +		return ids2;
> +
> +	if (!ids2)
> +		return ids1;
> +
> +	if (hashmap__size(ids1) <  hashmap__size(ids2)) {
> +		struct hashmap *tmp = ids1;
> +
> +		ids1 = ids2;
> +		ids2 = tmp;
> +	}
> +	hashmap__for_each_entry(ids2, cur, bkt) {
> +		ret = hashmap__set(ids1, cur->key, cur->value,
> +				(const void **)&old_key, (void **)&old_data);
> +		free(old_key);
> +		free(old_data);
> +
> +		if (ret)
> +			break;

should this return NULL instead?

> +	}
> +	hashmap__free(ids2);
> +	return ids1;
> +}
> +

SNIP

