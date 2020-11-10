Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24E22ADE17
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbgKJSTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:19:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730618AbgKJSTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:19:32 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63C920797;
        Tue, 10 Nov 2020 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605032372;
        bh=XCPLaolMQI6N9k9I1q0k4/0i3VqmFIS19Tg4sdymaF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zrh/MWjsBAwQHzVas5+2aIvrPaUpaaRV9kj5ArhfSab9Vt49T+/ziWFXZjI+6IGRT
         UBMdc22xDbwguVG5wLeSm0OpSUxgUjJArsh8qBXH5kqYTdyISebBkwiMZUmYmmlwvp
         ypvT8mQ9/0avj/I2uv7zJ3D89uXmxtSwOrK0yXps=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 25E81411D1; Tue, 10 Nov 2020 15:19:29 -0300 (-03)
Date:   Tue, 10 Nov 2020 15:19:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
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
Message-ID: <20201110181929.GA355344@kernel.org>
References: <20201110063417.14467-1-leo.yan@linaro.org>
 <20201110063417.14467-2-leo.yan@linaro.org>
 <20201110180829.GF3429138@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110180829.GF3429138@xps15>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 10, 2020 at 11:08:29AM -0700, Mathieu Poirier escreveu:
> On Tue, Nov 10, 2020 at 02:34:17PM +0800, Leo Yan wrote:
> > Since the commit 943b69ac1884 ("perf parse-events: Set exclude_guest=1
> > for user-space counting"), 'exclude_guest=1' is set for user-space
> > counting; and the branch sample's modifier has been altered, the sample
> > event name has been changed from "branches:u:" to "branches:uH:", which
> > gives out info for "user-space and host counting".
> > 
> > But the cs-etm testing's regular expression cannot match the updated
> > branch sample event and leads to test failure.
> > 
> > This patch updates the branch sample parttern by using a more flexible
> 
> s/parttern/pattern

I'll fix it and add stable@ to the CC list, thanks
 
> > expression '.*' to match branch sample's modifiers, so that allows the
> > testing to work as expected.
> > 
> > Fixes: 943b69ac1884 ("perf parse-events: Set exclude_guest=1 for user-space counting")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Here too I would CC stable.  With the above:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> > 
> > diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> > index 59d847d4981d..18fde2f179cd 100755
> > --- a/tools/perf/tests/shell/test_arm_coresight.sh
> > +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> > @@ -44,7 +44,7 @@ perf_script_branch_samples() {
> >  	#   touch  6512          1         branches:u:      ffffb22082e0 strcmp+0xa0 (/lib/aarch64-linux-gnu/ld-2.27.so)
> >  	#   touch  6512          1         branches:u:      ffffb2208320 strcmp+0xe0 (/lib/aarch64-linux-gnu/ld-2.27.so)
> >  	perf script -F,-time -i ${perfdata} | \
> > -		egrep " +$1 +[0-9]+ .* +branches:([u|k]:)? +"
> > +		egrep " +$1 +[0-9]+ .* +branches:(.*:)? +"
> >  }
> >  
> >  perf_report_branch_samples() {
> > -- 
> > 2.17.1
> > 

-- 

- Arnaldo
