Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE80D2AE6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKKDFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgKKDFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:05:03 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24748C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 19:05:02 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id v12so697029pfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 19:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I1w3h3DBfObfCB40Yy2KUFv6ARXtSGRtHeyDZbNE6k4=;
        b=V1NMi/4iIiNQHgVDraHGnT40akH5Er0Gj5d9uhS3IC9jkitlHw0MwCa+yugFpLcho9
         UECTZvvRdZXhGDFvtCkOunO+Psyw0fWUXDpL5bqXWMHpo579xwiNA29BtgxQiRdt+T5A
         Bznsxeavl/a0GYi8eQkR940PepwgqIqg7M90WqJgX0thdsa25WikcNjaKPDpyaMX8Poe
         gGuEXrgHCjn18O+Dszu4nkORzw0mdPkOVpBiUB55uFSNU9JIqlFX1zH7XfzOoRkwUn6D
         o3zqy36OSMA27ya0udvMh6heC+gyL+kC/gRFtBcQ3oE6aKPeWCnNJAY0xc00WgM/lkyt
         K0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I1w3h3DBfObfCB40Yy2KUFv6ARXtSGRtHeyDZbNE6k4=;
        b=FSfiu89lVtpu+nqv59ScULQGuD4TJp8zTzhp6/wtyUqwmNu5pswxqGVlrMXMpfA/gp
         5z6Bxy1yjoG57JAymZHF08gEjPjZO76z4Gl5w/nCJ09q6AZ8xpHrVZHZQxaP+tRFq6eW
         +iMrg58kzk3vnOJNinazItMCnYafMyuyNwlyPlQuCboXpOdk3Mqe1OWQLxjxmUTpNhzw
         2RlN1ywHGF8GMk+M58RnPUHmOSksvNUmY9ESQtAUMo9o+M0H6eXqERnoezSePIY+3fo8
         a0AuNbK4gXoOa7KFYNksVnRCUrwx0cupkNZKWeLv/yL/UhHj3DzYsa4DYxy7F4KxViet
         h9Hg==
X-Gm-Message-State: AOAM533tFF9WGm/wwOk8ynzcj158TQAPbF13JGpYm20hOsPAhn4swHks
        itvR4dFZU0BJ3ovjzmF4jHTfew==
X-Google-Smtp-Source: ABdhPJw6ancNyUx/MdbKSuZyA7R3MW3GoteeWvrZ1dDd6rpukLsiO635ahjTmcstRm3jVNjYQsJRvA==
X-Received: by 2002:a63:d74b:: with SMTP id w11mr19643079pgi.147.1605063901710;
        Tue, 10 Nov 2020 19:05:01 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.127.239.100])
        by smtp.gmail.com with ESMTPSA id t5sm406574pjq.7.2020.11.10.19.04.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 19:05:00 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:04:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH RESEND 2/2] perf test: Update branch sample parttern for
 cs-etm
Message-ID: <20201111030456.GC10969@leoy-ThinkPad-X240s>
References: <20201110063417.14467-1-leo.yan@linaro.org>
 <20201110063417.14467-2-leo.yan@linaro.org>
 <20201110180829.GF3429138@xps15>
 <20201110181929.GA355344@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110181929.GA355344@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 03:19:29PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 10, 2020 at 11:08:29AM -0700, Mathieu Poirier escreveu:
> > On Tue, Nov 10, 2020 at 02:34:17PM +0800, Leo Yan wrote:
> > > Since the commit 943b69ac1884 ("perf parse-events: Set exclude_guest=1
> > > for user-space counting"), 'exclude_guest=1' is set for user-space
> > > counting; and the branch sample's modifier has been altered, the sample
> > > event name has been changed from "branches:u:" to "branches:uH:", which
> > > gives out info for "user-space and host counting".
> > > 
> > > But the cs-etm testing's regular expression cannot match the updated
> > > branch sample event and leads to test failure.
> > > 
> > > This patch updates the branch sample parttern by using a more flexible
> > 
> > s/parttern/pattern
> 
> I'll fix it and add stable@ to the CC list, thanks

Thanks, Arnaldo and Mathieu.

Will take care for sending stable list in next time.

> > > expression '.*' to match branch sample's modifiers, so that allows the
> > > testing to work as expected.
> > > 
> > > Fixes: 943b69ac1884 ("perf parse-events: Set exclude_guest=1 for user-space counting")
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Here too I would CC stable.  With the above:
> > 
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> > > 
> > > diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> > > index 59d847d4981d..18fde2f179cd 100755
> > > --- a/tools/perf/tests/shell/test_arm_coresight.sh
> > > +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> > > @@ -44,7 +44,7 @@ perf_script_branch_samples() {
> > >  	#   touch  6512          1         branches:u:      ffffb22082e0 strcmp+0xa0 (/lib/aarch64-linux-gnu/ld-2.27.so)
> > >  	#   touch  6512          1         branches:u:      ffffb2208320 strcmp+0xe0 (/lib/aarch64-linux-gnu/ld-2.27.so)
> > >  	perf script -F,-time -i ${perfdata} | \
> > > -		egrep " +$1 +[0-9]+ .* +branches:([u|k]:)? +"
> > > +		egrep " +$1 +[0-9]+ .* +branches:(.*:)? +"
> > >  }
> > >  
> > >  perf_report_branch_samples() {
> > > -- 
> > > 2.17.1
> > > 
> 
> -- 
> 
> - Arnaldo
