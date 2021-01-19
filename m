Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E05D2FC29F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbhASVl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731299AbhASRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611078551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JI/5+9NPGytFKuzzS9MP1tan843R2RhG0K/QAOMhq74=;
        b=POULt0OYyIf3MbqVjB0up+VpxopgpGs56T3AF5lRhfD9fufKkXvGMJmt+LD+A0Bc+Gk4LV
        F8i2tLtRePah0z6BhTDdMxb/LkcTiyDSg+EvWL4fbKiXzoFkE9+zScqznS8BwuHh4RUdQS
        +fHvNLw7PmHbJD69ZVY+UlKbydqU3yQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-Hxh7nJvQPEGrXl-5CmObsA-1; Tue, 19 Jan 2021 12:49:07 -0500
X-MC-Unique: Hxh7nJvQPEGrXl-5CmObsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A42E107B457;
        Tue, 19 Jan 2021 17:49:05 +0000 (UTC)
Received: from krava (unknown [10.40.195.212])
        by smtp.corp.redhat.com (Postfix) with SMTP id 92A5510023B9;
        Tue, 19 Jan 2021 17:49:02 +0000 (UTC)
Date:   Tue, 19 Jan 2021 18:49:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 08/22] perf daemon: Add config file change check
Message-ID: <20210119174901.GD1717058@krava>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-9-jolsa@kernel.org>
 <CAM9d7cgSx7WFo5fwxSoU9h2vD19LJxaM7p5i5+W+HLM6kpkwpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgSx7WFo5fwxSoU9h2vD19LJxaM7p5i5+W+HLM6kpkwpw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 02:31:55PM +0900, Namhyung Kim wrote:
> On Sun, Jan 3, 2021 at 7:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to detect daemon's config file changes
> > and re-read the configuration when that happens.
> 
> Hmm.. maybe some of the code in the previous commit can be moved here.

do you mean the config file support?

I think this patch is quite small and straightforward - adds
the inotify processing for checking config change

perhaps we can separate some of the code from previous commit,
and make it simpler, I'll check

thanks,
jirka

> 
> Thanks,
> Namhyung
> 
> >
> > Using inotify file descriptor pluged into the main
> > fdarray object for polling.
> >
> > Example:
> >
> >   # cat ~/.perfconfig
> >   [daemon]
> >   base=/opt/perfdata
> >
> >   [session-cycles]
> >   run = -m 10M -e cycles --overwrite --switch-output -a
> >
> > Starting the daemon:
> >
> >   # perf daemon start
> >
> > Check sessions:
> >
> >   # perf daemon
> >   [772262:daemon] base: /opt/perfdata
> >   [772263:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
> >
> > Change '-m 10M' to '-m 20M', and check daemon log:
> >
> >   # tail -f /opt/perfdata/output
> >   [2021-01-02 20:31:41.234045] daemon started (pid 772262)
> >   [2021-01-02 20:31:41.235072] reconfig: ruining session [cycles:772263]: -m 10M -e cycles --overwrite --switch-output -a
> >   [2021-01-02 20:32:08.310137] reconfig: session 'cycles' killed
> >   [2021-01-02 20:32:08.310847] reconfig: ruining session [cycles:772338]: -m 20M -e cycles --overwrite --switch-output -a
> >
> > And the session list:
> >
> >   # perf daemon
> >   [772262:daemon] base: /opt/perfdata
> >   [772338:cycles] perf record -m 20M -e cycles --overwrite --switch-output -a
> >
> > Note the changed '-m 20M' option is in place.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 

