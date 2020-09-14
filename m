Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99F72697B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgINVay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgINVaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:30:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DABDD206A5;
        Mon, 14 Sep 2020 21:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600119052;
        bh=pVKDwQxdNSincEJgZyefEWab4J3nDh6n1sPTCpDw89Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhKKH1J+qXTu8LJNvtlJIS+Mxvh0k5OInj6KEn25nD5Wpgjq4NvaDHZWuVtYoi3nu
         4LpM7PgXg7Xiji9cwv67Wzo1iaREkrvzIqVsKe7AY95p5ulMEYhy0Y1zJ6AAHWjyWf
         u1C2YoBDcKIX18FQLH5PAFuOLIgwuTMxURqERhA0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 172C640D3D; Mon, 14 Sep 2020 18:30:50 -0300 (-03)
Date:   Mon, 14 Sep 2020 18:30:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf bench: Fix 2 memory sanitizer warnings
Message-ID: <20200914213050.GD166601@kernel.org>
References: <20200912053725.1405857-1-irogers@google.com>
 <20200912205124.GF1714160@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912205124.GF1714160@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 12, 2020 at 10:51:24PM +0200, Jiri Olsa escreveu:
> On Fri, Sep 11, 2020 at 10:37:25PM -0700, Ian Rogers wrote:
> > Memory sanitizer warns if a write is performed where the memory
> > being read for the write is uninitialized. Avoid this warning by
> > initializing the memory.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
