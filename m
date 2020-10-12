Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E80228B3BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbgJLLY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387635AbgJLLY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602501867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Asn23qFx4Q0YR7PdPb45EKlx8mKy8F35eEdDp868CY=;
        b=WCDq1RMviZuNHhxV1T2hLNEs83ZZc8RGdpmvm4z7TZD/sPLjyJYDG0WN8lT5wJIj3txRxi
        MPLdO5m+2DVS4fl/MeK2K4OZxxpyYx924icEAJS9wlAlBGsxzjvaMesOv6Cawui7bgKDn9
        8t7UrLRb80YOkB9VvL4yGY4vuODLtyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-PVnoWT1tNGSFJIr4C_7n2w-1; Mon, 12 Oct 2020 07:24:26 -0400
X-MC-Unique: PVnoWT1tNGSFJIr4C_7n2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F497802B4B;
        Mon, 12 Oct 2020 11:24:24 +0000 (UTC)
Received: from krava (unknown [10.40.195.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id B50E510013BD;
        Mon, 12 Oct 2020 11:24:20 +0000 (UTC)
Date:   Mon, 12 Oct 2020 13:24:19 +0200
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
Message-ID: <20201012112419.GJ1099489@krava>
References: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
 <20201012105430.GH1099489@krava>
 <5b0aefe2-e0d5-b5ff-654c-4e93c427050f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0aefe2-e0d5-b5ff-654c-4e93c427050f@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 12:15:04PM +0100, John Garry wrote:
> On 12/10/2020 11:54, Jiri Olsa wrote:
> > > ff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > > index 99df41a9543d..e47644cab3fa 100644
> > > --- a/tools/perf/pmu-events/jevents.c
> > > +++ b/tools/perf/pmu-events/jevents.c
> > > @@ -505,20 +505,15 @@ static char *real_event(const char *name, char *event)
> > >   }
> > >   static int
> > > -try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
> > > -	  struct json_event *je)
> > > +try_fixup(const char *fn, char *arch_std, struct json_event *je, char **event)
> > >   {
> > >   	/* try to find matching event from arch standard values */
> > >   	struct event_struct *es;
> > >   	list_for_each_entry(es, &arch_std_events, list) {
> > >   		if (!strcmp(arch_std, es->name)) {
> > > -			if (!eventcode && es->event) {
> > > -				/* allow EventCode to be overridden */
> > > -				free(je->event);
> > > -				je->event = NULL;
> > > -			}
> > >   			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
> > > +			*event = je->event;
> > I'm bit rusty on this code, but isn't je->event NULL at this point?
> 
> je->event should be now assigned from es->event because of
> FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD):
> 
> #define TRY_FIXUP_FIELD(field) do { if (es->field && !*field) {\
> 	*field = strdup(es->field);				\
> 	if (!*field)						\
> 		return -ENOMEM;					\
> } } while (0)
> 
> And es->event should be set.

right, thanks

Acked-by: Jiri Olsa <jolsa@redhat.com>

jirka

