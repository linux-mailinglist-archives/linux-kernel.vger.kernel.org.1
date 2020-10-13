Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF5D28D21D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389670AbgJMQWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389406AbgJMQWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:22:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 757E125271;
        Tue, 13 Oct 2020 16:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602606142;
        bh=WdHLl7lvBHFeej18gwouWeuZ//ygU1XtG9PhW9+5VTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0I7jHwVtd46K7kY+jW6NyImvbi0Kgl4Dilkr7xrKPXLmAHEhaSy8jtUTGipEll0E
         Uist+XzE9Q4vO1E4bvzbOXdrLvZ8AijxAVa+otbPNTbgdmbMFFlVx1/yjIUJbXDz4P
         0xRdl9vFtpZT3qQ/JvOrikCI6LSKPvte7bL8/o24=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 853B74047F; Tue, 13 Oct 2020 13:22:20 -0300 (-03)
Date:   Tue, 13 Oct 2020 13:22:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 03/15] perf data: open data directory in read access
 mode
Message-ID: <20201013162220.GK1063281@kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <9ac7f12e-f5a4-dd91-a19a-bb7e5be27636@linux.intel.com>
 <20201012160339.GB466880@tassilo.jf.intel.com>
 <49bfe810-f1cc-b1c6-67d3-b0a746552fd6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bfe810-f1cc-b1c6-67d3-b0a746552fd6@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 12, 2020 at 07:52:33PM +0300, Alexey Budankov escreveu:
> 
> On 12.10.2020 19:03, Andi Kleen wrote:
> > On Mon, Oct 12, 2020 at 11:55:07AM +0300, Alexey Budankov wrote:
> >>
> >> Open files located at data directory in case of read access mode.
> > 
> > Need some rationale. Is this a bug fix? Did the case not matter
> > before?
> 
> This is not a bug fix. The case didn't matter before.

In such cases can you please write a paragraph explaining why it didn't
matter before and now it is required?

- Arnaldo
 
 > 
> >>
> >> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> ---
> >>  tools/perf/util/data.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> >> index c47aa34fdc0a..6ad61ac6ba67 100644
> >> --- a/tools/perf/util/data.c
> >> +++ b/tools/perf/util/data.c
> >> @@ -321,6 +321,10 @@ static int open_dir(struct perf_data *data)
> >>  		return -1;
> >>  
> >>  	ret = open_file(data);
> >> +	if (!ret && perf_data__is_dir(data)) {
> >> +		if (perf_data__is_read(data))
> >> +			ret = perf_data__open_dir(data);
> >> +	}
> >>  
> >>  	/* Cleanup whatever we managed to create so far. */
> >>  	if (ret && perf_data__is_write(data))
> >> -- 
> >> 2.24.1
> 
> Alexei
> 

-- 

- Arnaldo
