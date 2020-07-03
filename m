Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112EC21393C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 13:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgGCLUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 07:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgGCLUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:20:25 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.131.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822D620674;
        Fri,  3 Jul 2020 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593775224;
        bh=XZV2sG8QqTdzSiq7SnjYcCThfjUEMWvB1l52rmNoim4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLfBFkQisxPyHEBBhZ55mltJcjX1WR/VYlemaoUPhuHPkzGQhtdbP0Rk0/dTpWO/X
         dP7ANoRuaHbHhDWdeBlWgVoc8Yu6pgHA6HNqzA3IeVXzj6dRVR01QVH7Gtg3dv0m15
         3edgi/Dv7U+XbF+bWqaP7awsOQCufOBrszsIKINA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9578F405FF; Fri,  3 Jul 2020 08:20:21 -0300 (-03)
Date:   Fri, 3 Jul 2020 08:20:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] perf tools: Some Intel PT related fixes for v5.8
Message-ID: <20200703112021.GA1320@kernel.org>
References: <20200629091955.17090-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629091955.17090-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 29, 2020 at 12:19:49PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are some Intel PT related fixes for v5.8.

Thanks, applied.

- Arnaldo
 
> 
> Adrian Hunter (6):
>       perf scripts python: export-to-postgresql.py: Fix struct.pack() int argument
>       perf record: Fix duplicated sideband events with Intel PT system wide tracing
>       perf scripts python: exported-sql-viewer.py: Fix unexpanded 'Find' result
>       perf scripts python: exported-sql-viewer.py: Fix zero id in call graph 'Find' result
>       perf scripts python: exported-sql-viewer.py: Fix zero id in call tree 'Find' result
>       perf scripts python: exported-sql-viewer.py: Fix time chart call tree
> 
>  tools/perf/builtin-record.c                       | 18 +++++++++---------
>  tools/perf/scripts/python/export-to-postgresql.py |  2 +-
>  tools/perf/scripts/python/exported-sql-viewer.py  | 11 +++++++++--
>  tools/perf/util/evlist.c                          | 12 ++++++++++++
>  tools/perf/util/evlist.h                          |  1 +
>  tools/perf/util/evsel.c                           |  8 +-------
>  tools/perf/util/evsel.h                           |  6 ++++++
>  7 files changed, 39 insertions(+), 19 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
