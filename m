Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0725CA0A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgICUPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 16:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbgICUPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:15:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0FF1206C0;
        Thu,  3 Sep 2020 20:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599164137;
        bh=n+3Wp9V3/5aQhV31y4gQSuF5aEZJ87VPqglKL2WFwV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wUFdAONfMbsiICSCwoh6ZkO/krezxjj0k6F5lF4CicUs1fqe5U2WCaWRKNmSaDE58
         Mgpk5rox+3B6vBDXAfS/mJxPj4cJWaWclErkN5MsgYcPxQuujwPMqY6kvMh2TH9Hk3
         kvXctSz+bzs76+ZB+DPfhrcEQbRx4tdx9Pm/fqKY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9151A40D3D; Thu,  3 Sep 2020 17:15:35 -0300 (-03)
Date:   Thu, 3 Sep 2020 17:15:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/6] perf tools: Consolidate --control option parsing
 into one function
Message-ID: <20200903201535.GL3495158@kernel.org>
References: <20200901093758.32293-1-adrian.hunter@intel.com>
 <20200901093758.32293-2-adrian.hunter@intel.com>
 <d4769bfe-8d5a-b510-23ae-65012889bf92@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4769bfe-8d5a-b510-23ae-65012889bf92@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 02, 2020 at 07:06:51PM +0300, Alexey Budankov escreveu:
> 
> On 01.09.2020 12:37, Adrian Hunter wrote:
> > Consolidate --control option parsing into one function, in preparation for
> > adding FIFO file name options.
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/builtin-record.c | 22 ++--------------------
> >  tools/perf/builtin-stat.c   | 22 ++--------------------
> >  tools/perf/util/evlist.c    | 24 ++++++++++++++++++++++++
> >  tools/perf/util/evlist.h    |  1 +
> >  4 files changed, 29 insertions(+), 40 deletions(-)
> 
> Acked-by: Alexei Budankov <alexey.budankov@linux.intel.com>

Thanks, applied.

- Arnaldo
