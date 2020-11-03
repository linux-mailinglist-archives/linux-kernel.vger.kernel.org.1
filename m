Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DD22A3A6D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgKCC3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgKCC3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:29:54 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AC2C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 18:29:53 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y14so12871286pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 18:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wdkmteix8A4gNgFVEGww/ERZCRHTeyb15q8nCWpffyo=;
        b=whE7ofcxwO6tJr765yKyefT3UFbmSkP1tItF+4eCaBE+3SnpOi84eqF42zULPcvNRl
         JY8zUOKBWAV2BYnYCGrQFZ6zcsaP2h14i4Vy2WRbkTZzNkHr/u2lwUADl2/0mZYFIQfn
         swVVjvJoNq48frkwTAgq4/9z5oKhlS9fvhxeiiQAn4xgzhI1dWk0jS2JOoJCV/T//taZ
         kuQMFU7QFU1PrMc6rPWU1DOLCAr+19A0vE/O9RKE9MKa0l1IhXU9d9/F9bxiMM37rqqk
         oqCxC86Wh6+7+GVsdTwIeGpIc6gXuSzveB5RwqPL5gTA1fe49p6rDqnSXydABR7fXWUu
         etAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wdkmteix8A4gNgFVEGww/ERZCRHTeyb15q8nCWpffyo=;
        b=LtxyBA3oYQtsHMuMa16VhoSv2fRRw/dEZzcxyjCoNUhqi62eJ5sT6S0UMIxSHBtKYj
         YUGUMNovEiIekANqCNvN7Z842n9319oREcwnj0NyHdas+a3A6JA8FZDEwr4H8URMNV9D
         IH0fWKbPWMUNTEnrxGkRMrD1IT1ZTYKwLWeYioXyp66Eylmeq6LwU+xkjPPs7sHZ0vOd
         UfQC9KULhOJJO5Uvz3h1DPaGp5EgDvQiJCIVUZBPMPKwqyRWVurVQopQUaqcfw14iBuG
         4C4z5JfSPzC9RECY4ALgeZyWcK29sTiQLsPgGdAiXhP11NiGPQi1UpKJYQcI26lmMSPi
         ouNQ==
X-Gm-Message-State: AOAM533eN95t05CIcEHlY0AYRTRrknvQFbAA3pR3ShzIN3C5rq04agaF
        qsPPwVIG3fdr/Mw4cgzS28ciKg==
X-Google-Smtp-Source: ABdhPJySOh59Yr4Z7bpkPn7Nq+q1Sw31GYyhuZrR6v3q0qxbJSZlRb6Gw/35O8rXDR84qivdMgtcVw==
X-Received: by 2002:a65:4945:: with SMTP id q5mr1674696pgs.83.1604370592513;
        Mon, 02 Nov 2020 18:29:52 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.141.182.112])
        by smtp.gmail.com with ESMTPSA id e8sm15054147pfn.175.2020.11.02.18.29.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 18:29:51 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:29:44 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
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
Message-ID: <20201103022944.GB13232@leoy-ThinkPad-X240s>
References: <20201021003948.28817-1-leo.yan@linaro.org>
 <20201021003948.28817-2-leo.yan@linaro.org>
 <20201102165626.GD3405508@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102165626.GD3405508@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:56:26PM +0100, Jiri Olsa wrote:
> On Wed, Oct 21, 2020 at 08:39:48AM +0800, Leo Yan wrote:
> > When execute command "perf lock report", it hits failure and outputs log
> > as follows:
> > 
> >   perf: builtin-lock.c:623: report_lock_release_event: Assertion `!(seq->read_count < 0)' failed.
> >   Aborted
> > 
> > This is an imbalance issue.  The locking sequence structure
> > "lock_seq_stat" contains the reader counter and it is used to check if
> > the locking sequence is balance or not between acquiring and releasing.
> > 
> > If the tool wrongly frees "lock_seq_stat" when "read_count" isn't zero,
> > the "read_count" will be reset to zero when allocate a new structure at
> > the next time; thus it causes the wrong counting for reader and finally
> > results in imbalance issue.
> > 
> > To fix this issue, if detects "read_count" is not zero (means still
> > have read user in the locking sequence), goto the "end" tag to skip
> > freeing structure "lock_seq_stat".
> > 
> > Fixes: e4cef1f65061 ("perf lock: Fix state machine to recognize lock sequence")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-lock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 5cecc1ad78e1..a2f1e53f37a7 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -621,7 +621,7 @@ static int report_lock_release_event(struct evsel *evsel,
> >  	case SEQ_STATE_READ_ACQUIRED:
> >  		seq->read_count--;
> >  		BUG_ON(seq->read_count < 0);
> > -		if (!seq->read_count) {
> > +		if (seq->read_count) {
> >  			ls->nr_release++;
> 
> it seems ok, but I fail to see what's nr_release for
> the point is just to skip the removal of seq right?

To be honest, I'm not sure if I understand your question :)

Either remove "seq" or not, "nr_release" will be increased.  When remove
"seq", the code line [1] will increase '1' for "nr_release"; when skip
to remove "seq", "nr_release" is also increased 1 [2].  So I don't see
the logic issue for "nr_release", do I miss anything?

Another side topic is the four metrics "nr_acquire", "nr_release",
"nr_readlock", "nr_trylock" have been accounted, but they are not really
used for output final result.  I'd like to defer this later as a task
for refine the output metrics.

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-lock.c#n641
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-lock.c#n625
