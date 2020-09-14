Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F612696DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgINUm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgINUm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600116177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HXvDq/r7BsYC8fftoQ6piw4/64GDm32rwel30baKrC0=;
        b=RG8+U8S4EE8m6dQ/yoMb9A8o5ej30a+DGHaVYXHfqkyCERhr4nR4oaROCuAkZAeKTB4awp
        d5V0Pk+nY8losp8Zb1y3A39YhHHhbbHU3kAfr+0PI32LMHoy1MAHzKKWjqg2jys/ZT1Zdy
        XcdQd5XZyf7SUTckK8U8uZXlhN+M1SA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-TO5gs9RDPceAFD7C3IDPMg-1; Mon, 14 Sep 2020 16:42:53 -0400
X-MC-Unique: TO5gs9RDPceAFD7C3IDPMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B58231091065;
        Mon, 14 Sep 2020 20:42:50 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 39D391A914;
        Mon, 14 Sep 2020 20:42:47 +0000 (UTC)
Date:   Mon, 14 Sep 2020 22:42:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 24/26] perf tools: Add buildid-list --store option
Message-ID: <20200914204246.GW1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-25-jolsa@kernel.org>
 <CAM9d7ch5Od3Pz6GORmkW6RfUQL6ON0DVJ+dndA9mGCv6ppLsbA@mail.gmail.com>
 <20200914151413.GB160517@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914151413.GB160517@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 12:14:13PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 14, 2020 at 03:42:55PM +0900, Namhyung Kim escreveu:
> > On Mon, Sep 14, 2020 at 6:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding buildid-list --store option to populate
> > > .debug data with build id files.
> > 
> > Hmm.. isn't it better to add it to the buildid-cache command?
> 
> Yes, that is the right place. 'buildid-list' is about perf.data files,
> buildid-cache is about .debug cache.

I saw it in buildid-list, because it works over perf.data
by default and --store option made it obvious for me

but I guess we could have the same, like:

  $ perf buildid-cache --store[=path]

with path being perf.data by default

thanks,
jirka

