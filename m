Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A82FC2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbhASWFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:05:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389055AbhASRqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611078281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oTjNMHeboundc5h9sRP2B5BdgMsx/d+tmyfkTkd8wsU=;
        b=exfatGQ7XvfeE28IeVjuie48ot+X6omSQzq3HkbL+RO9sSMA/DUwyxaKW5MIFbseclq5Mf
        XWMS02Adi4aPIpCUnyy68AH8K0dugAdxyOuRUCaPkLPggZsQRFalWaVLE7hrdOUqVCog6x
        DIFkK3N8MM5l+7vpiRBold34ZLqxzCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-tX1BP-R4NNOvL8narF7lng-1; Tue, 19 Jan 2021 12:44:37 -0500
X-MC-Unique: tX1BP-R4NNOvL8narF7lng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B042801817;
        Tue, 19 Jan 2021 17:44:35 +0000 (UTC)
Received: from krava (unknown [10.40.195.212])
        by smtp.corp.redhat.com (Postfix) with SMTP id F02065C8A7;
        Tue, 19 Jan 2021 17:44:32 +0000 (UTC)
Date:   Tue, 19 Jan 2021 18:44:32 +0100
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
Subject: Re: [PATCH 12/22] perf daemon: Allow only one daemon over base
 directory
Message-ID: <20210119174432.GC1717058@krava>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-13-jolsa@kernel.org>
 <CAM9d7cj7TaJH3CtkQDjfD9OuV77LzbcY4y_EW7PWi+winu8gcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj7TaJH3CtkQDjfD9OuV77LzbcY4y_EW7PWi+winu8gcw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 02:37:42PM +0900, Namhyung Kim wrote:

SNIP

> >
> > +static int check_lock(struct daemon *daemon)
> > +{
> > +       char path[PATH_MAX];
> > +       char buf[20];
> > +       int fd, pid;
> > +       ssize_t len;
> > +
> > +       scnprintf(path, sizeof(path), "%s/lock", daemon->base);
> > +
> > +       fd = open(path, O_RDWR|O_CREAT|O_CLOEXEC, 0640);
> > +       if (fd < 0)
> > +               return -1;
> > +
> > +       if (lockf(fd, F_TLOCK, 0) < 0) {
> > +               filename__read_int(path, &pid);
> > +               fprintf(stderr, "failed: another perf daemon (pid %d) owns %s\n",
> > +                       pid, daemon->base);
> > +               return -1;
> > +       }
> 
> So the fd is (a kind of) leaked and the lock is released only when
> the daemon is going to die, right?

yes, that's the idea, I'll put it in some comment

thanks,
jirka

