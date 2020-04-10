Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 317781A4718
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDJNz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 09:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgDJNz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 09:55:56 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A7EE206A1;
        Fri, 10 Apr 2020 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586526956;
        bh=Wk8gfKcBbUSGznCJZW1P3U7gPvmkGvHYIMeyJethKKE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BGbueT13JtKonWUkqQwoa7dTTW6d9sRwQP11Rz74KAaaaw/AS6Ns46GS6Mggu9WMC
         rXxBJIwBpL3kvttbn0nLmDSglhLFc+ZY0H2IkNbHBcbCSCZWo1RPMa7fD95bzgTebW
         JurZW4sHyFLWIT7YL3lIoWi9edZ+8jds+/nLMSms=
Message-ID: <fb784ea2a4b3d4219a4e2604beee0b15cb2275b4.camel@kernel.org>
Subject: Re: [PATCH] tracing: make some symbols static in tracing_map.c
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jason Yan <yanaijie@huawei.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Date:   Fri, 10 Apr 2020 08:55:55 -0500
In-Reply-To: <20200410094427.1f1ede4d@gandalf.local.home>
References: <20200410073312.38855-1-yanaijie@huawei.com>
         <20200410094427.1f1ede4d@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-10 at 09:44 -0400, Steven Rostedt wrote:
> Tom,
> 
> Care to ack this?
> 

Sure,

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Tom


> -- Steve
> 
> 
> On Fri, 10 Apr 2020 15:33:12 +0800
> Jason Yan <yanaijie@huawei.com> wrote:
> 
> > Fix the following sparse warning:
> > 
> > kernel/trace/tracing_map.c:286:6: warning: symbol
> > 'tracing_map_array_clear' was not declared. Should it be static?
> > kernel/trace/tracing_map.c:297:6: warning: symbol
> > 'tracing_map_array_free' was not declared. Should it be static?
> > kernel/trace/tracing_map.c:319:26: warning: symbol
> > 'tracing_map_array_alloc' was not declared. Should it be static?
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> > ---
> >  kernel/trace/tracing_map.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/tracing_map.c
> > b/kernel/trace/tracing_map.c
> > index 9e31bfc818ff..74738c9856f1 100644
> > --- a/kernel/trace/tracing_map.c
> > +++ b/kernel/trace/tracing_map.c
> > @@ -283,7 +283,7 @@ int tracing_map_add_key_field(struct
> > tracing_map *map,
> >  	return idx;
> >  }
> >  
> > -void tracing_map_array_clear(struct tracing_map_array *a)
> > +static void tracing_map_array_clear(struct tracing_map_array *a)
> >  {
> >  	unsigned int i;
> >  
> > @@ -294,7 +294,7 @@ void tracing_map_array_clear(struct
> > tracing_map_array *a)
> >  		memset(a->pages[i], 0, PAGE_SIZE);
> >  }
> >  
> > -void tracing_map_array_free(struct tracing_map_array *a)
> > +static void tracing_map_array_free(struct tracing_map_array *a)
> >  {
> >  	unsigned int i;
> >  
> > @@ -316,7 +316,7 @@ void tracing_map_array_free(struct
> > tracing_map_array *a)
> >  	kfree(a);
> >  }
> >  
> > -struct tracing_map_array *tracing_map_array_alloc(unsigned int
> > n_elts,
> > +static struct tracing_map_array *tracing_map_array_alloc(unsigned
> > int n_elts,
> >  						  unsigned int
> > entry_size)
> >  {
> >  	struct tracing_map_array *a;
> 
> 

