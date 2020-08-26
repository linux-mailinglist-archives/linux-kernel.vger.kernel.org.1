Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F65252C11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgHZLEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 07:04:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44928 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbgHZLBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598439655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gZ+hqhThII7IwmcsnaMAeSwJTx05ieaUKU5K5IUdmV8=;
        b=CB/99UXETy0DoyDPWmGmYUD3M83/ls91GWyeCGOzbdj7uFKC5AAIBc2H6ptrMT2AQuF7Bn
        rFH5596x476dWKBXmXRfa+xTlLxKQQN8T/cBRB1Uvh2CjKaieyBHIpbPMlL5Md973NnPV/
        c7yndQGMs6BkN2X8Pd5WV1tY26TcxlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-SMahhIo4OnmoYq_HW2SUvw-1; Wed, 26 Aug 2020 07:00:53 -0400
X-MC-Unique: SMahhIo4OnmoYq_HW2SUvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A96EC807334;
        Wed, 26 Aug 2020 11:00:50 +0000 (UTC)
Received: from krava (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3A7B010023A5;
        Wed, 26 Aug 2020 11:00:47 +0000 (UTC)
Date:   Wed, 26 Aug 2020 13:00:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Message-ID: <20200826110046.GF703542@krava>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <bc078472-e859-b7dc-c451-d737dd573edf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc078472-e859-b7dc-c451-d737dd573edf@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 09:14:11AM +0100, John Garry wrote:

SNIP

> >   				goto free_strings;
> >   		}
> > -		err = func(data, name, real_event(name, event), desc, long_desc,
> > -			   pmu, unit, perpkg, metric_expr, metric_name,
> > -			   metric_group, deprecated, metric_constraint);
> > +		je->event = real_event(je->name, je->event);
> > +		err = func(data, je);
> >   free_strings:
> > -		free(event);
> > -		free(desc);
> > -		free(name);
> > -		free(long_desc);
> >   		free(extra_desc);
> > -		free(pmu);
> >   		free(filter);
> > -		free(perpkg);
> > -		free(deprecated);
> > -		free(unit);
> > -		free(metric_expr);
> > -		free(metric_name);
> > -		free(metric_group);
> > -		free(metric_constraint);
> >   		free(arch_std);
> > +		free(je);
> >   		if (err)
> >   			break;
> > diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> > index 2afc8304529e..e696edf70e9a 100644
> > --- a/tools/perf/pmu-events/jevents.h
> > +++ b/tools/perf/pmu-events/jevents.h
> 
> Somewhat unrelated - this file only seems to be included in jevents.c, so I
> don't see why it exists...

ah right.. I won't mind getting rid of it
 
> > @@ -2,14 +2,28 @@
> >   #ifndef JEVENTS_H
> >   #define JEVENTS_H 1
> > +#include "pmu-events.h"
> > +
> > +struct json_event {
> > +	char *name;
> > +	char *event;
> > +	char *desc;
> > +	char *topic;
> > +	char *long_desc;
> > +	char *pmu;
> > +	char *unit;
> > +	char *perpkg;
> > +	char *metric_expr;
> > +	char *metric_name;
> > +	char *metric_group;
> > +	char *deprecated;
> > +	char *metric_constraint;
> 
> This looks very much like struct event_struct, so could look to consolidate:
> 
> struct event_struct {
> 	struct list_head list;
> 	char *name;
> 	char *event;
> 	char *desc;
> 	char *long_desc;
> 	char *pmu;
> 	char *unit;
> 	char *perpkg;
> 	char *metric_expr;
> 	char *metric_name;
> 	char *metric_group;
> 	char *deprecated;
> 	char *metric_constraint;
> };

as Andi said they come from different layers, I think it's
better to keep them separated even if they share some fields

thanks,
jirka

