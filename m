Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C92293AED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394263AbgJTMFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394026AbgJTMFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:05:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7699A20691;
        Tue, 20 Oct 2020 12:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603195523;
        bh=K4sjzkNcXvUoloVSjUzgNqm/eHbsqryKhWp71/kiZDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZ8Mw7xi7RSnDC2Sd3J/jE9orMWOkzWCIux8XGZE27R+uvhyFcuOLYUgS+1GArTEJ
         I6mosx8y7nO0nVNm/MuSuYC9v+zOIGqfdNDDHalPWbAgLbbzZk4jGsQRxQR0y6VSua
         0nPOVqzAbzEGxriUm1HjA5ctWFyZOZw+IFAza2RI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 669DE403C2; Tue, 20 Oct 2020 09:05:20 -0300 (-03)
Date:   Tue, 20 Oct 2020 09:05:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf version: Add a feature for libpfm4.
Message-ID: <20201020120520.GB2294271@kernel.org>
References: <20201019232545.4047264-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019232545.4047264-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 19, 2020 at 04:25:45PM -0700, Ian Rogers escreveu:
> If perf is built with libpfm4 (LIBPFM4=1) then advertise it in perf -vv.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-version.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index d09ec2f03071..9cd074a3d825 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -80,6 +80,7 @@ static void library_status(void)
>  	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
>  	STATUS(HAVE_AIO_SUPPORT, aio);
>  	STATUS(HAVE_ZSTD_SUPPORT, zstd);
> +	STATUS(HAVE_LIBPFM, libpfm4);
>  }
>  
>  int cmd_version(int argc, const char **argv)
> -- 
> 2.29.0.rc1.297.gfa9743e501-goog
> 

-- 

- Arnaldo
