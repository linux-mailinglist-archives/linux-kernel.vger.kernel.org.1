Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552232FC1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbhASStC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:49:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391094AbhASSc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611081089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqb74V5AhafMYMFpHPXkG1pPly+8D7Y3DyJlHln6xC8=;
        b=KdhkyWAyWoWW7gdHNVcw196j0lR9tT1koF6SbxniyP0xHFLH40wPQ/QKmX6om7ep0qQiju
        Xq3WbmXJ09h6fGLH0iLeUjQZjjIoTNbBRsKy4kpm1LK7V3Nn9GUgvJDjEgL0Iln5POz55j
        7ioe2pH21CdQP1JhosvaqfxdRaA0VKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-20OTp-AEOx6BYtyu7DoayA-1; Tue, 19 Jan 2021 13:31:25 -0500
X-MC-Unique: 20OTp-AEOx6BYtyu7DoayA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A2521800D41;
        Tue, 19 Jan 2021 18:31:23 +0000 (UTC)
Received: from krava (unknown [10.40.195.212])
        by smtp.corp.redhat.com (Postfix) with SMTP id 28CB560C0F;
        Tue, 19 Jan 2021 18:31:19 +0000 (UTC)
Date:   Tue, 19 Jan 2021 19:31:19 +0100
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
Subject: Re: [PATCH 07/22] perf daemon: Add daemon command
Message-ID: <20210119183119.GE1717058@krava>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-8-jolsa@kernel.org>
 <CAM9d7ciSkns0=0LqWK2BrTFOON2z4wx5vjb=zhP5=iUoXXjeDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciSkns0=0LqWK2BrTFOON2z4wx5vjb=zhP5=iUoXXjeDQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 01:08:17PM +0900, Namhyung Kim wrote:

SNIP

> > +               if (!session)
> > +                       return -ENOMEM;
> > +
> > +               pr_debug("reconfig: found new session %s\n", name);
> > +               /* This is new session, trigger reconfig to start it. */
> > +               session->state = SESSION_STATE__RECONFIG;
> > +       } else if (session->state == SESSION_STATE__KILL) {
> > +               /*
> > +                * The session was marked to kill and we still
> > +                * found it in config file.
> > +                */
> > +               pr_debug("reconfig: found current session %s\n", name);
> > +               session->state = SESSION_STATE__OK;
> > +       }
> > +
> > +       if (!strcmp(var, "run")) {
> > +               if (session->run && strcmp(session->run, value)) {
> > +                       free(session->run);
> > +                       pr_debug("reconfig: session %s is changed\n", name);
> > +                       session->state = SESSION_STATE__RECONFIG;
> > +               }
> > +               session->run = strdup(value);
> 
> Please check the result.

right, will add

> 
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int server_config(const char *var, const char *value, void *cb)
> > +{
> > +       struct daemon *daemon = cb;
> > +
> > +       if (strstarts(var, "session-"))
> > +               return session_config(daemon, var, value);
> > +       else if (!strcmp(var, "daemon.base"))
> > +               daemon->base = strdup(value);
> 
> It seems these config items are mandatory.  Is there a check
> for their presence?

base needs to be there, I'll add the check

missing session should just put daemon to sleep and it
should be woken up by config file change

that seems like a good test actualy, will try to add it

> 
> 
> > +
> > +       return 0;
> > +}
> > +
> > +static int client_config(const char *var, const char *value, void *cb)
> > +{
> > +       struct daemon *daemon = cb;
> > +
> > +       if (!strcmp(var, "daemon.base"))
> > +               daemon->base = strdup(value);
> > +
> > +       return 0;
> > +}
> > +
> > +static int setup_client_config(struct daemon *daemon)
> > +{
> > +       struct perf_config_set *set;
> > +       int err = -ENOMEM;
> > +
> > +       set = perf_config_set__load_file(daemon->config_real);
> > +       if (set) {
> > +               err = perf_config_set(set, client_config, daemon);
> > +               perf_config_set__delete(set);
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +static int setup_server_config(struct daemon *daemon)
> > +{
> > +       struct perf_config_set *set;
> > +       struct session *session;
> > +       int err = -ENOMEM;
> > +
> > +       pr_debug("reconfig: started\n");
> > +
> > +       /*
> > +        * Mark all session for kill, the server config will
> > +        * set proper state for found sessions.
> > +        */
> > +       list_for_each_entry(session, &daemon->sessions, list)
> > +               session->state = SESSION_STATE__KILL;
> 
> Probably we can put them in a different state like INIT or READY?

it's convenient, because all session we find will be changed
to OK and the rest will be killed

SNIP

> > +               return -1;
> > +       if (session->pid > 0) {
> > +               pr_info("reconfig: ruining session [%s:%d]: %s\n",
> > +                       session->name, session->pid, session->run);
> > +               return 0;
> > +       }
> > +
> > +       if (chdir(session->base)) {
> > +               perror("chdir failed");
> > +               return -1;
> > +       }
> > +
> > +       fd = open("/dev/null", O_RDONLY);
> > +       if (fd < 0) {
> > +               perror("failed to open /dev/null");
> > +               return -1;
> > +       }
> > +
> > +       close(0);
> > +       dup2(fd, 0);
> 
> The man page says dup2() will close the second file descriptor.

right, I overlooekd that, close calls are not needed then

SNIP

> > +               /* Reconfig session. */
> > +               pr_debug2("reconfig: session '%s' start\n", session->name);
> > +               if (session->pid > 0) {
> > +                       session__kill(session);
> > +                       pr_info("reconfig: session '%s' killed\n", session->name);
> > +               }
> > +               if (session__run(session, daemon))
> 
> Does it call a config function?  Or is it called already?

daemon__reconfig kills and starts sessions based
on the config data read by setup_server_config

> 
> > +                       return -1;
> > +               pr_debug2("reconfig: session '%s' done\n", session->name);
> > +               session->state = SESSION_STATE__OK;
> 
> I think RUNNING is a better name.

I'll check, I'll put the state graph in comment,
so we can discuss the changes

thanks,
jirka

