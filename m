Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA80252F25
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 15:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgHZNAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 09:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgHZNAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:00:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B7992080C;
        Wed, 26 Aug 2020 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598446805;
        bh=IWtrVErsNt6biC0nU1M0P0Qygjeyy2+q3KfSsdSxkWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wQEodM1+P3RE3vRwZe7NXLBYax59zSpUQettpNZkIZoxD716uYg5Y5dr9ygkgcHjM
         LWkQwKSuXf8I3r9R3XC4g3l++FvC9PSokP/AXKlm9mD65LGE8kl1GXp0xBjoONt9Zg
         7c1c2LddBk9KWYIuXi54lB7MgG0vUI3uuo0OOsxU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 46B4040D3D; Wed, 26 Aug 2020 10:00:03 -0300 (-03)
Date:   Wed, 26 Aug 2020 10:00:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf stat: Fix s390x compile error on F32
 utils/stat-display.c
Message-ID: <20200826130003.GE1059382@kernel.org>
References: <20200825063304.77733-1-tmricht@linux.ibm.com>
 <20200825071442.GB631468@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825071442.GB631468@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 25, 2020 at 09:14:42AM +0200, Jiri Olsa escreveu:
> On Tue, Aug 25, 2020 at 08:33:04AM +0200, Thomas Richter wrote:
> 
> SNIP
> 
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 57d0706e1330..cbe836649f84 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -117,12 +117,11 @@ static void aggr_printout(struct perf_stat_config *config,
> >  				cpu_map__id_to_die(id),
> >  				config->csv_output ? 0 : -3,
> >  				cpu_map__id_to_cpu(id), config->csv_sep);
> > -		} else {
> > +		} else if (id > -1)
> >  			fprintf(config->output, "CPU%*d%s",
> >  				config->csv_output ? 0 : -7,
> >  				evsel__cpus(evsel)->map[id],
> >  				config->csv_sep);
> > -		}
 
> I think we want multiple if lines within  { } but
> scripts/checkpatch.pl does not scream about this, so leaving this to
> Arnaldo ;-)

Yeah, I removed the removal of the {} for a multiline else block, added
your Acked-by, thanks,

- Analdo
 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka
> 
> >  		break;
> >  	case AGGR_THREAD:
> >  		fprintf(config->output, "%*s-%*d%s",
> > -- 
> > 2.26.2
> > 
> 

-- 

- Arnaldo
