Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C7D28B310
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbgJLKyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387594AbgJLKym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602500081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qPJ45JPlRtxIDOSgccXtlyZSlu7XvLptXEsZTVYbzZE=;
        b=G3QVzOtvGUIyDwgN/hBLbl3m9gh7+tXzE0Vi1Bbv/jh63T725wiRr27t5uoL4/2kV1nu+l
        d3dgzSdn84ho5MsfaJahfhMQt/lk8f41iZYY6Y/G4RwR5nSar6c78zrjD030ShGeQB8K4n
        H3/1AYKqeQAm5mstU6aJXkEB3YLDV4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-3UKdPpfaO5u1tseIXESGrg-1; Mon, 12 Oct 2020 06:54:37 -0400
X-MC-Unique: 3UKdPpfaO5u1tseIXESGrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA921868409;
        Mon, 12 Oct 2020 10:54:35 +0000 (UTC)
Received: from krava (unknown [10.40.195.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 695B555785;
        Mon, 12 Oct 2020 10:54:31 +0000 (UTC)
Date:   Mon, 12 Oct 2020 12:54:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, kjain@linux.ibm.com, irogers@google.com,
        yao.jin@linux.intel.com, yeyunfeng@huawei.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        =linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf jevents: Fix event code for events referencing std
 arch events
Message-ID: <20201012105430.GH1099489@krava>
References: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 11:19:28PM +0800, John Garry wrote:
> The event code for events referencing std arch events is incorrectly
> evaluated in json_events().
> 
> The issue is that je.event is evaluated properly from try_fixup(), but
> later NULLified from the real_event() call, as "event" may be NULL.
> 
> Fix by setting "event" same je.event in try_fixup().
> 
> Also remove support for overwriting event code for events using std arch
> events, as it is not used.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 99df41a9543d..e47644cab3fa 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -505,20 +505,15 @@ static char *real_event(const char *name, char *event)
>  }
>  
>  static int
> -try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
> -	  struct json_event *je)
> +try_fixup(const char *fn, char *arch_std, struct json_event *je, char **event)
>  {
>  	/* try to find matching event from arch standard values */
>  	struct event_struct *es;
>  
>  	list_for_each_entry(es, &arch_std_events, list) {
>  		if (!strcmp(arch_std, es->name)) {
> -			if (!eventcode && es->event) {
> -				/* allow EventCode to be overridden */
> -				free(je->event);
> -				je->event = NULL;
> -			}
>  			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
> +			*event = je->event;

I'm bit rusty on this code, but isn't je->event NULL at this point?

jirka

>  			return 0;
>  		}
>  	}
> @@ -678,7 +673,7 @@ static int json_events(const char *fn,
>  			 * An arch standard event is referenced, so try to
>  			 * fixup any unassigned values.
>  			 */
> -			err = try_fixup(fn, arch_std, eventcode, &je);
> +			err = try_fixup(fn, arch_std, &je, &event);
>  			if (err)
>  				goto free_strings;
>  		}
> -- 
> 2.26.2
> 

