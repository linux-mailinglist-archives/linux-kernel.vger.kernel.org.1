Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E500A25F739
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 12:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgIGKFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 06:05:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32010 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728317AbgIGKFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599473140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CuC6q8yusAoYjdeZd4GNZG0aUrdOTeaoNa5nhD8Wxpk=;
        b=GdbvkXEHF2pewqDIlY3vHbaVzGWWYGbpL8vdibXSL0oOb5Fe4T3dql+Z+SY5XczJDkDNfD
        sgIVgzqNk994OBv3cHkPrjanICJ7TuFvVdRY/Cjn4FusQQsIANzHzoefmLL5KAWM/jQRMx
        Fi42WrCDchQK0vxWwK796SwUFPm00FM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-bQvGFapZNvCeS1k86X8gfw-1; Mon, 07 Sep 2020 06:05:36 -0400
X-MC-Unique: bQvGFapZNvCeS1k86X8gfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08035801ADD;
        Mon,  7 Sep 2020 10:05:34 +0000 (UTC)
Received: from krava (ovpn-114-209.ams2.redhat.com [10.36.114.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0416B7E42C;
        Mon,  7 Sep 2020 10:05:29 +0000 (UTC)
Date:   Mon, 7 Sep 2020 12:05:29 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com
Subject: Re: [PATCH v9 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
Message-ID: <20200907100529.GF1199773@krava>
References: <20200907064133.75090-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907064133.75090-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:11:28PM +0530, Kajol Jain wrote:
> Patchset enhance current runtime parameter support. It introduces new
> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
> used to specify perpkg events.
> 
> The "PerCore" and "PerChip" specifies whether its core or chip events.
> Based on which we can decide which runtime parameter user want to
> access. Now character  '?' can refers different parameter based on user
> requirement.
> 
> Initially, every time we want to add new terms like chip, core, thread
> etc, we need to create corrsponding fields in pmu_events and event
> struct.
> This patchset adds an enum called 'aggr_mode_class' which store all these
> aggregation like perchip/percore. It also adds new field 'AggregationMode'
> to capture these terms.
> Now, if user wants to add any new term, they just need to add it in
> the enum defined.
> 
> This patchset also adds  changes of adding new structure
> called 'json_event' inside jevents.c
> file to improve the callback prototype inside jevent file.
> Initially, whenever user want to add new field, they need to update
> in all function callback which makes it more and more complex with
> increased number of parmeters.
> With this change, we just need to add it in new structure 'json_event'.
> link to the RFC patch: https://lkml.org/lkml/2020/8/25/217
> 
> Changelog:
> v8 -> v9
> - Free aggr_mode memory [Jiri Olsa].

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> v7 -> v8
> - Change commit typo from jevents.h to jevents.c
> - Make json_events function static in first patch.
> 
> v6 -> v7
> - Remove min and get_cpu_str functions from jevents.c
> - Make json_events function static to solve warning part [John Garry].
> - Add event attribute in json_events function to remove strcpy from
>   real_event function, as suggested by Jiri Olsa.
> - Add warning while checking aggr_mode value [Jiri Olsa].
> 
> Kajol Jain (5):
>   perf/jevents: Remove jevents.h file
>   perf/jevents: Add new structure to pass json fields.
>   perf jevents: Add support for parsing perchip/percore events
>   perf/tools: Pass pmu_event structure as a parameter for
>     arch_get_runtimeparam
>   perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events
> 
>  tools/perf/arch/powerpc/util/header.c         |   7 +-
>  .../arch/powerpc/power9/nest_metrics.json     |  35 ++-
>  tools/perf/pmu-events/jevents.c               | 234 +++++++++---------
>  tools/perf/pmu-events/jevents.h               |  23 --
>  tools/perf/pmu-events/pmu-events.h            |   6 +
>  tools/perf/util/metricgroup.c                 |   5 +-
>  tools/perf/util/metricgroup.h                 |   3 +-
>  7 files changed, 154 insertions(+), 159 deletions(-)
>  delete mode 100644 tools/perf/pmu-events/jevents.h
> 
> -- 
> 2.26.2
> 

