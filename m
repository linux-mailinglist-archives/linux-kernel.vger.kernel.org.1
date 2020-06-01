Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168D01EA74F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgFAPtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 11:49:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38367 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591026578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9dF7uCB1648YECMFKzBtBhwlp7nc6F6jTL+uh9lL11o=;
        b=XPK81cD4ZK/iyQ//hXo46XRcpVkbHQBSZn9lCS8fpR+pb/NJL8zi8XlN4VS7EkPrw5xfnJ
        biMbgzYgJZ0WUt9jZV2XsEr9yy/svrBVYl9VxsWS3BmAViAF0yJAmjP6F0IOPMB/y3ykwJ
        9OSJQI/HSYt8skPT76HS4Inw3UkVQLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-lDBtBB6RNj6GVQ0nSuun_w-1; Mon, 01 Jun 2020 11:49:34 -0400
X-MC-Unique: lDBtBB6RNj6GVQ0nSuun_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01A9E84634C;
        Mon,  1 Jun 2020 15:49:33 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id C35615D9C9;
        Mon,  1 Jun 2020 15:49:27 +0000 (UTC)
Date:   Mon, 1 Jun 2020 17:49:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 05/14] perf tools: Add parse_events_fake interface
Message-ID: <20200601154926.GD1031432@krava>
References: <20200524224219.234847-1-jolsa@kernel.org>
 <20200524224219.234847-6-jolsa@kernel.org>
 <CAP-5=fXaRv3rbjUYoTJUgc+GfnLku--O5LiHrM1W3ofaFz28rQ@mail.gmail.com>
 <20200601090850.GI881900@krava>
 <20200601150428.GJ31795@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601150428.GJ31795@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 12:04:28PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 01, 2020 at 11:08:50AM +0200, Jiri Olsa escreveu:
> > On Mon, Jun 01, 2020 at 12:28:31AM -0700, Ian Rogers wrote:
> > > On Sun, May 24, 2020 at 3:42 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Adding parse_events_fake interface to parse events
> > > > and use fake pmu event in case pmu event is parsed.
> > > >
> > > > This way it's possible to parse events from PMUs
> > > > which are not present in the system. It's available
> > > > only for testing purposes coming in following
> > > > changes.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > 
> > > Acked-by: Ian Rogers <irogers@google.com>
> > > 
> > > Alternatively fake_pmu could be an argument to parse_events.
> > 
> > yea I checked that and I was surprised how many parse_events calls
> > we have in perf, so I went this way.. but I haven't really tried it,
> > so it might look actually etter despite the many places we need to change,
> > I'll try
> 
> Thanks! My admitedly unchecked thinking is that most places will just
> pass NULL, only the test case will pass it, right?

I changed that per Ian's suggestion and it looks better,
so I'll post it in v2

jirka

