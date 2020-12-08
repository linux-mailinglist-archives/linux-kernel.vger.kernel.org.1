Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9A62D28F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgLHKby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgLHKbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607423427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wTTs5k06KawVFBsrzimy1ln5wExel7K+JmVgKzEhQOY=;
        b=J/UqyKYpEBLuq9v2S2461h4lEdx99lG51e0TLpT+SX9ncbQPJnDvJUrgOZJEb4VA+qeOrI
        xjOXViW+ItcY5PatG4oNgPa3cGJy6rIq0F9xzhjKripXKyr033NYXNM6JQV9lp2N/QkITO
        BEkqoeVrYIpQj/6fec7zhkARhBKVKIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-AW8qbANlORSGoDUt7EcDjg-1; Tue, 08 Dec 2020 05:30:24 -0500
X-MC-Unique: AW8qbANlORSGoDUt7EcDjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86481393B9;
        Tue,  8 Dec 2020 10:29:47 +0000 (UTC)
Received: from krava (unknown [10.40.193.58])
        by smtp.corp.redhat.com (Postfix) with SMTP id A117C5D9DD;
        Tue,  8 Dec 2020 10:29:44 +0000 (UTC)
Date:   Tue, 8 Dec 2020 11:29:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH V2 06/12] perf mem: Clean up output format
Message-ID: <20201208102943.GB4135722@krava>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
 <20201130172803.2676-7-kan.liang@linux.intel.com>
 <20201204232756.GK3613628@krava>
 <978f0cb9-43d6-1ae5-e1ce-5ec4cc9fca12@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <978f0cb9-43d6-1ae5-e1ce-5ec4cc9fca12@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:19:06PM -0500, Liang, Kan wrote:
> 
> 
> On 12/4/2020 6:27 PM, Jiri Olsa wrote:
> > On Mon, Nov 30, 2020 at 09:27:57AM -0800, kan.liang@linux.intel.com wrote:
> > 
> > SNIP
> > 
> > > @@ -172,7 +172,7 @@ dump_raw_samples(struct perf_tool *tool,
> > >   {
> > >   	struct perf_mem *mem = container_of(tool, struct perf_mem, tool);
> > >   	struct addr_location al;
> > > -	const char *fmt;
> > > +	const char *fmt, *field_sep;
> > >   	if (machine__resolve(machine, &al, sample) < 0) {
> > >   		fprintf(stderr, "problem processing %d event, skipping it.\n",
> > > @@ -186,60 +186,41 @@ dump_raw_samples(struct perf_tool *tool,
> > >   	if (al.map != NULL)
> > >   		al.map->dso->hit = 1;
> > > -	if (mem->phys_addr) {
> > > -		if (symbol_conf.field_sep) {
> > > -			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s0x%016"PRIx64
> > > -			      "%s%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
> > > -		} else {
> > > -			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
> > > -			      "%s0x%016"PRIx64"%s%5"PRIu64"%s0x%06"PRIx64
> > > -			      "%s%s:%s\n";
> > > -			symbol_conf.field_sep = " ";
> > > -		}
> > > -
> > > -		printf(fmt,
> > > -			sample->pid,
> > > -			symbol_conf.field_sep,
> > > -			sample->tid,
> > > -			symbol_conf.field_sep,
> > > -			sample->ip,
> > > -			symbol_conf.field_sep,
> > > -			sample->addr,
> > > -			symbol_conf.field_sep,
> > > -			sample->phys_addr,
> > > -			symbol_conf.field_sep,
> > > -			sample->weight,
> > > -			symbol_conf.field_sep,
> > > -			sample->data_src,
> > > -			symbol_conf.field_sep,
> > > -			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
> > > -			al.sym ? al.sym->name : "???");
> > > +	field_sep = symbol_conf.field_sep;
> > 
> > hum, what's the point of having field_sep?
> 
> 
> To keep the fmt consistent.
> 
> The patch divides the "printf(fmt,..." into two part. In the first half
> part, the symbol_conf.field_sep may be modified to " ";
> In the second half part, we should not use the modified
> symbol_conf.field_sep for the below check. The field_sep keeps the original
> value and should be used.

ok, I missed it's being moified.. thanks

jirka

