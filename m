Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8BE2A4496
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgKCLyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:54:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727109AbgKCLyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604404445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BPw+R9lbRaHll82w4OBRRxRYwhGO19DIYM+z7EqSIzo=;
        b=WBtVekXpxZUpdn3ewKGvkDvp4lqgl1mM3PcQYWORmR7XoW3//fs2pmrVRCjaU6QvHrj73+
        OlKw3tX/fsFGm/UqZT8rVPvnHvNh9Zndd9QApZnoy2qCQWhiEJVWx1lCnKVMLkKVyo7hW4
        F5HCaCRFDKg846tvrAN2IHd65w3aU4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-_uTXrKrDOZCjMFL4nIFQxw-1; Tue, 03 Nov 2020 06:54:03 -0500
X-MC-Unique: _uTXrKrDOZCjMFL4nIFQxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 822301868414;
        Tue,  3 Nov 2020 11:54:01 +0000 (UTC)
Received: from krava (unknown [10.40.195.210])
        by smtp.corp.redhat.com (Postfix) with SMTP id B6B9121E95;
        Tue,  3 Nov 2020 11:53:58 +0000 (UTC)
Date:   Tue, 3 Nov 2020 12:53:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf lock: Don't free "lock_seq_stat" if
 read_count isn't zero
Message-ID: <20201103115357.GF3597846@krava>
References: <20201021003948.28817-1-leo.yan@linaro.org>
 <20201021003948.28817-2-leo.yan@linaro.org>
 <20201102165626.GD3405508@krava>
 <20201103022944.GB13232@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103022944.GB13232@leoy-ThinkPad-X240s>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 10:29:44AM +0800, Leo Yan wrote:
> On Mon, Nov 02, 2020 at 05:56:26PM +0100, Jiri Olsa wrote:
> > On Wed, Oct 21, 2020 at 08:39:48AM +0800, Leo Yan wrote:
> > > When execute command "perf lock report", it hits failure and outputs log
> > > as follows:
> > > 
> > >   perf: builtin-lock.c:623: report_lock_release_event: Assertion `!(seq->read_count < 0)' failed.
> > >   Aborted
> > > 
> > > This is an imbalance issue.  The locking sequence structure
> > > "lock_seq_stat" contains the reader counter and it is used to check if
> > > the locking sequence is balance or not between acquiring and releasing.
> > > 
> > > If the tool wrongly frees "lock_seq_stat" when "read_count" isn't zero,
> > > the "read_count" will be reset to zero when allocate a new structure at
> > > the next time; thus it causes the wrong counting for reader and finally
> > > results in imbalance issue.
> > > 
> > > To fix this issue, if detects "read_count" is not zero (means still
> > > have read user in the locking sequence), goto the "end" tag to skip
> > > freeing structure "lock_seq_stat".
> > > 
> > > Fixes: e4cef1f65061 ("perf lock: Fix state machine to recognize lock sequence")
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/builtin-lock.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > > index 5cecc1ad78e1..a2f1e53f37a7 100644
> > > --- a/tools/perf/builtin-lock.c
> > > +++ b/tools/perf/builtin-lock.c
> > > @@ -621,7 +621,7 @@ static int report_lock_release_event(struct evsel *evsel,
> > >  	case SEQ_STATE_READ_ACQUIRED:
> > >  		seq->read_count--;
> > >  		BUG_ON(seq->read_count < 0);
> > > -		if (!seq->read_count) {
> > > +		if (seq->read_count) {
> > >  			ls->nr_release++;
> > 
> > it seems ok, but I fail to see what's nr_release for
> > the point is just to skip the removal of seq right?
> 
> To be honest, I'm not sure if I understand your question :)
> 
> Either remove "seq" or not, "nr_release" will be increased.  When remove
> "seq", the code line [1] will increase '1' for "nr_release"; when skip
> to remove "seq", "nr_release" is also increased 1 [2].  So I don't see
> the logic issue for "nr_release", do I miss anything?
> 
> Another side topic is the four metrics "nr_acquire", "nr_release",
> "nr_readlock", "nr_trylock" have been accounted, but they are not really
> used for output final result.  I'd like to defer this later as a task
> for refine the output metrics.

yes, that was my point, that I don't see nr_release being
used for anything

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Thanks,
> Leo
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-lock.c#n641
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-lock.c#n625
> 

