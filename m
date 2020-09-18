Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237B126FF07
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgIRNpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgIRNpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600436745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=efzsaHlUqPH0ci0tLnQf07x4M/ur8etejmLSyfLHLrs=;
        b=JPYGoxo5wDWbW6h8uvrhcrf3CetDYHJJfU6M0CkA//foptuDpoHnThp0G3rz7Zabi5l3hw
        lbY076mM1ezvATY/ZzvQ5DoGBCNd4PVTz9kJX1rG7kVW8q5Wf2y/j02PiOFp4Nka4eK3eb
        eR9LhUxiN0eEkI/nYzzUC8QqkBj8Ea4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-IIq6tZdDMRSoEPED1XWKMw-1; Fri, 18 Sep 2020 09:45:42 -0400
X-MC-Unique: IIq6tZdDMRSoEPED1XWKMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63E1518BA285;
        Fri, 18 Sep 2020 13:45:40 +0000 (UTC)
Received: from krava (ovpn-114-24.ams2.redhat.com [10.36.114.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id E6BD21992F;
        Fri, 18 Sep 2020 13:45:36 +0000 (UTC)
Date:   Fri, 18 Sep 2020 15:45:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH 3/4] perf tools: Copy metric events properly when expand
 cgroups
Message-ID: <20200918134535.GC2626435@krava>
References: <20200916063129.1061487-1-namhyung@kernel.org>
 <20200916063129.1061487-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916063129.1061487-4-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 03:31:28PM +0900, Namhyung Kim wrote:

SNIP

> +					free(new_expr);
> +					return -ENOMEM;
> +				}
> +
> +				memcpy(new_expr->metric_refs, old_expr->metric_refs,
> +				       nr * alloc_size);
> +			} else {
> +				new_expr->metric_refs = NULL;
> +			}
> +
> +			/* calculate number of metric_events */
> +			for (nr = 0; old_expr->metric_events[nr]; nr++)
> +				continue;
> +			alloc_size = sizeof(*new_expr->metric_events);
> +			new_expr->metric_events = calloc(nr + 1, alloc_size);
> +			if (!new_expr->metric_events) {
> +				free(new_expr->metric_refs);
> +				free(new_expr);
> +				return -ENOMEM;
> +			}
> +
> +			/* copy evsel in the same position */
> +			for (idx = 0; idx < nr; idx++) {
> +				evsel = old_expr->metric_events[idx];
> +				evsel = evlist__get_evsel(evlist, evsel->idx);

this probably won't happen, but evlist__get_evsel can return NULL

jirka

> +				new_expr->metric_events[idx] = evsel;
> +			}
> +
> +			list_add(&new_expr->nd, &new_me->head);
> +		}
> +	}
> +	return 0;
> +}

SNIP

