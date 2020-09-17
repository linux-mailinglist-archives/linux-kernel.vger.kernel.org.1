Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6026E500
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgIQTF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgIQTEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 15:04:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEDEC20853;
        Thu, 17 Sep 2020 19:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369483;
        bh=Y/aD44verb5Ad90cflRgVw8Fr5G6DKZ63+nraijYl6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7YjaK5qsjx7FU2jAm9jA0rCNma0KABXHI7EpnGWdeyib9phv3IeVfjUQi3CiJOg1
         nyAXPTEExk6DolrUcGNxztOZWnTIQ3xlmasxuTzHjp3L1aJXsDzbBOp2LuNXIWnn3f
         DLC628o2YTOvYidJvCRN/FSXRxVs1/U7/hdUZNbw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BBCF2400E9; Thu, 17 Sep 2020 16:04:41 -0300 (-03)
Date:   Thu, 17 Sep 2020 16:04:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Zejiang Tang <tangzejiang@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Improve perf option help information in perf.txt
Message-ID: <20200917190441.GC1426933@kernel.org>
References: <1599645194-8438-1-git-send-email-tangzejiang@loongson.cn>
 <CAM9d7cignBfmuNB9hkKFW4Zsm7LT86zX54VEyQPuDGdkdQv-tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cignBfmuNB9hkKFW4Zsm7LT86zX54VEyQPuDGdkdQv-tQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 09, 2020 at 10:03:34PM +0900, Namhyung Kim escreveu:
> On Wed, Sep 9, 2020 at 6:53 PM Zejiang Tang <tangzejiang@loongson.cn> wrote:
> >
> > Perf could use many options, such as:-vv, --exec-path,
> > --html-path, -p, --paginate,--no-pager, --debugfs-dir,
> > --buildid-dir, --list-cmds, --list-opts. Add these options
> > in perf.txt.
> >
> > Signed-off-by: Zejiang Tang <tangzejiang@loongson.cn>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks
> Namhyung
> 
> 
> > ---
> >  tools/perf/Documentation/perf.txt | 69 ++++++++++++++++++++++++++-------------
> >  1 file changed, 47 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> > index 3f37ded..c130a3c 100644
> > --- a/tools/perf/Documentation/perf.txt
> > +++ b/tools/perf/Documentation/perf.txt
> > @@ -12,32 +12,57 @@ SYNOPSIS
> >
> >  OPTIONS
> >  -------
> > ---debug::
> > -       Setup debug variable (see list below) in value
> > -       range (0, 10). Use like:
> > -         --debug verbose   # sets verbose = 1
> > -         --debug verbose=2 # sets verbose = 2
> > -
> > -       List of debug variables allowed to set:
> > -         verbose          - general debug messages
> > -         ordered-events   - ordered events object debug messages
> > -         data-convert     - data convert command debug messages
> > -         stderr           - write debug output (option -v) to stderr
> > -                            in browser mode
> > -         perf-event-open  - Print perf_event_open() arguments and
> > -                            return value
> > -
> > ---buildid-dir::
> > -       Setup buildid cache directory. It has higher priority than
> > -       buildid.dir config file option.
> > +-h::
> > +--help::
> > +        Run perf help command.
> >
> >  -v::
> >  --version::
> > -  Display perf version.
> > +        Display perf version.
> >
> > --h::
> > ---help::
> > -  Run perf help command.
> > +-vv::
> > +        Print the compiled-in status of libraries.
> > +
> > +--exec-path::
> > +        Display or set exec path.
> > +
> > +--html-path::
> > +        Display html documentation path.
> > +
> > +-p::
> > +--paginate::
> > +        Set up pager.
> > +
> > +--no-pager::
> > +        Do not set pager.
> > +
> > +--buildid-dir::
> > +        Setup buildid cache directory. It has higher priority
> > +        than buildid.dir config file option.
> > +
> > +--list-cmds::
> > +        List the most commonly used perf commands.
> > +
> > +--list-opts::
> > +        List available perf options.
> > +
> > +--debugfs-dir::
> > +        Set debugfs directory or set environment variable PERF_DEBUGFS_DIR.
> > +
> > +--debug::
> > +        Setup debug variable (see list below) in value
> > +        range (0, 10). Use like:
> > +          --debug verbose   # sets verbose = 1
> > +          --debug verbose=2 # sets verbose = 2
> > +
> > +        List of debug variables allowed to set:
> > +          verbose          - general debug messages
> > +          ordered-events   - ordered events object debug messages
> > +          data-convert     - data convert command debug messages
> > +          stderr           - write debug output (option -v) to stderr
> > +                             in browser mode
> > +          perf-event-open  - Print perf_event_open() arguments and
> > +                             return value
> >
> >  DESCRIPTION
> >  -----------
> > --
> > 2.1.0
> >

-- 

- Arnaldo
