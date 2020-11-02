Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6976F2A27BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgKBKIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgKBKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:08:34 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0FEC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:08:34 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id k9so8672261pgt.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 02:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/oNsh0ZZANxB+0DY/V3HzKuZqq+yTNfopsDbZ8CmqMY=;
        b=NNXYQiVnBj7e6N99x/I7VSQ9R0te6wFkmJ4X6uswDTHA4n2nJUhaDn2+sy7Swaz4ie
         Y8swEXn99HFOV4AUecW9zDU+6iP0MC6F3eoICr26QBNzfm3vMYDUxvt4llKrmK0x5OKo
         YwRL1FFWbN/XdSgz/U6HafHOKdyRHU5u1T3Orcw4fTo1oMKoe2lNd2e7SWX7CV8hXid6
         Wz2HjYwO3skk1QFrC1uSZcSIW6HQ/h6rQ+cXyEo2XdZVaBXGIZfuGzw+8uC6JO9GdZ5U
         po0iOsiykEcAYCkBVKCabvKe2EUd+vi0uM9FHCN/KrUt7gJGyRfBukxcDP5AXM0ycwT7
         r0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/oNsh0ZZANxB+0DY/V3HzKuZqq+yTNfopsDbZ8CmqMY=;
        b=MNWzk+Us+UPlD6EghW9XEDuvRLCpZki8ouKMxMvV9VquK1KW+afsQHNJ9uewgkh5J2
         RViz3fVBriem6CYEPbexduucO3tIhQNFTar83PwqtIgjAikPqcvxAt0qw1OCS4nmt/GP
         NA7VKsXPzyGHnDSDSb89uh7WdwUb/CukKA1TUYdG8tHHjr4EDn0KiaODQelhYufnipjZ
         RY0nE3dexblF1NfPY/b92GbtLTXHysArtL32S06JCzytDl0w27Z9JPsUSLUtMOZVEHT+
         hvRxILCI2AHOlmSvwyAr99I3UMnNYuzpObH6tqjGrbA7ognN7nb6AQ5MN8SFlvQAB3tX
         4sZg==
X-Gm-Message-State: AOAM530aF8pjIzuFHyKK95Ryptp3SkcxBmk0fSkILTVVo3r/PFsq1OKD
        HdKeuxv9HNrzPup8Cy4JYxAiWA==
X-Google-Smtp-Source: ABdhPJwpIEd4gQSbrsYHd8Mcy98MlIFLJwlPm1d8Be2RKs85mIe28v/7DCY+263yA3WlkcmZNYlSfA==
X-Received: by 2002:a17:90a:b383:: with SMTP id e3mr16489578pjr.61.1604311714137;
        Mon, 02 Nov 2020 02:08:34 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.141.182.112])
        by smtp.gmail.com with ESMTPSA id j20sm1332862pgk.59.2020.11.02.02.08.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 02:08:33 -0800 (PST)
Date:   Mon, 2 Nov 2020 18:08:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/9] perf c2c: Support AUX trace
Message-ID: <20201102100823.GB6633@leoy-ThinkPad-X240s>
References: <20201028063813.8562-1-leo.yan@linaro.org>
 <20201028063813.8562-7-leo.yan@linaro.org>
 <20201031202103.GA3380099@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031202103.GA3380099@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sat, Oct 31, 2020 at 09:21:03PM +0100, Jiri Olsa wrote:
> On Wed, Oct 28, 2020 at 02:38:10PM +0800, Leo Yan wrote:
> > This patches adds the AUX callbacks in session structure, so support
> > AUX trace for "perf c2c" tool.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-c2c.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 4d1a08e38233..24f4af997aab 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -369,6 +369,10 @@ static struct perf_c2c c2c = {
> >  		.exit		= perf_event__process_exit,
> >  		.fork		= perf_event__process_fork,
> >  		.lost		= perf_event__process_lost,
> > +		.attr		= perf_event__process_attr,
> > +		.auxtrace_info  = perf_event__process_auxtrace_info,
> > +		.auxtrace       = perf_event__process_auxtrace,
> > +		.auxtrace_error = perf_event__process_auxtrace_error,
> 
> so this will process aux data, but don't you have to
> say which events you want to synthesize?
> 
> like in script/report via --itrace option?

Indeed, we need to assign "session->itrace_synth_opts", otherwise, the
tool cannot output synthesized samples.

I tried to keep this patch set as small as possible, for easier
reviewing.

Comparing to the previous patch set, I moved out the patch "perf
auxtrace: Add option '-M' for memory events" [1] from this patch set,
at the end my purpose is to introduce the itrace option '-M' to
synthesize memory event; and "perf c2c" tool can use memory event
for output result.  Thus "perf c2c" needs to add itrace_synth_opts:

  struct itrace_synth_opts itrace_synth_opts = {
          .set = true,
          .mem = true,            /* Memory samples */
          .default_no_sample = true,
  };

> aybe arm differs from x86 in this, and it's happening
> in the background.. I have no idea ;-)

There should have no any difference between archs for 'itrace'
behaviour.

Since I moved the patch "perf auxtrace: Add option '-M' for memory
events" out from this patch set, thus I also left out the code for
adding itrace_synth_opts.  This introduced confusion for reviewing the
change (sorry!), I will add back the patch "perf auxtrace: Add option
'-M' for memory events" and add itrace_synth_opts for perf mem/c2c in
next patch set.

Thanks,
Leo

[1] https://lore.kernel.org/patchwork/patch/1298072/
