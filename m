Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B168428E4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbgJNQtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbgJNQtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:49:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13DCC214D8;
        Wed, 14 Oct 2020 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602694147;
        bh=A1Yn3Qg5twHpUa/tSTQXbs9X+Wj34iy7VYyYuzWtF+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOfnVLnTlPv33ozlwOpjP7OtxYZi1UQo6HVB9kYfdd4GkPv4K6z4sOypEn6mXAUiU
         aDNHVOSeTHhrjCrE2CRHwURhnILwTFJn2kFileyndw/16Ot+ve1cYv8K5aRMYVvx0h
         fLl/23cSc9DFSUEyaTqWMhmdDHkAeQPyMytTjdjw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 16F2C4047F; Wed, 14 Oct 2020 13:49:05 -0300 (-03)
Date:   Wed, 14 Oct 2020 13:49:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        kjain@linux.ibm.com, irogers@google.com, yao.jin@linux.intel.com,
        yeyunfeng@huawei.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, =linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf jevents: Fix event code for events referencing std
 arch events
Message-ID: <20201014164905.GN3100363@kernel.org>
References: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
 <20201012105430.GH1099489@krava>
 <5b0aefe2-e0d5-b5ff-654c-4e93c427050f@huawei.com>
 <20201012112419.GJ1099489@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012112419.GJ1099489@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 12, 2020 at 01:24:19PM +0200, Jiri Olsa escreveu:
> On Mon, Oct 12, 2020 at 12:15:04PM +0100, John Garry wrote:
> > On 12/10/2020 11:54, Jiri Olsa wrote:
> > > > ff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > > > index 99df41a9543d..e47644cab3fa 100644
> > > > --- a/tools/perf/pmu-events/jevents.c
> > > > +++ b/tools/perf/pmu-events/jevents.c
> > > > @@ -505,20 +505,15 @@ static char *real_event(const char *name, char *event)
> > > >   }
> > > >   static int
> > > > -try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
> > > > -	  struct json_event *je)
> > > > +try_fixup(const char *fn, char *arch_std, struct json_event *je, char **event)
> > > >   {
> > > >   	/* try to find matching event from arch standard values */
> > > >   	struct event_struct *es;
> > > >   	list_for_each_entry(es, &arch_std_events, list) {
> > > >   		if (!strcmp(arch_std, es->name)) {
> > > > -			if (!eventcode && es->event) {
> > > > -				/* allow EventCode to be overridden */
> > > > -				free(je->event);
> > > > -				je->event = NULL;
> > > > -			}
> > > >   			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
> > > > +			*event = je->event;
> > > I'm bit rusty on this code, but isn't je->event NULL at this point?
> > 
> > je->event should be now assigned from es->event because of
> > FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD):
> > 
> > #define TRY_FIXUP_FIELD(field) do { if (es->field && !*field) {\
> > 	*field = strdup(es->field);				\
> > 	if (!*field)						\
> > 		return -ENOMEM;					\
> > } } while (0)
> > 
> > And es->event should be set.
> 
> right, thanks
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Ok, applied, please consider adding a Fixes tag next time.

- Arnaldo
