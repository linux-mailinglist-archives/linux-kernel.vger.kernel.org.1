Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CFA2FC042
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbhASToT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:44:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbhASTnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:43:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 797B422AAA;
        Tue, 19 Jan 2021 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611085345;
        bh=oWO8PSgWBYECR/QqH57H4hQxTYp4DqY7aYPA+MnYevI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+xwRqR9LdsWEhf83g2Y/APF/zLlmxBDdvI1SU17GVupGKosvGTFwF5Jq2Ha5678W
         8uL0v4+RE/i5frnEPmGvcOAWUaWiIkx05AqXw4gM7v9ApocIih6uGfhrfDShAafKdV
         e93oQ2oea41sLhhK9v8g5Yra014AWoVizd7R1oIM3cz/edUNu3LSTPlN0aA/D6iG4f
         MgDvlo9fGghjNdt7OTcZ/EmgaHHoKuuuLF7OSeETW91hxck1+ShILCZfu3L/uRrKtc
         uOaYgrhkTO5M5nhkDvzYLJS4rBVi/RilG5DP8xuQ3mm6sRxgGghfLicqi7+wwZ4DBu
         Le0yMD+n7ohSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D888340CE2; Tue, 19 Jan 2021 16:42:21 -0300 (-03)
Date:   Tue, 19 Jan 2021 16:42:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 03/22] perf tools: Add debug_set_display_time function
Message-ID: <20210119194221.GN12699@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-4-jolsa@kernel.org>
 <20210119145922.GL12699@kernel.org>
 <20210119173937.GB1717058@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119173937.GB1717058@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 19, 2021 at 06:39:37PM +0100, Jiri Olsa escreveu:
> On Tue, Jan 19, 2021 at 11:59:22AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > > +}
> > 
> >   78    12.70 ubuntu:18.04-x-sparc64        : FAIL sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
> > 
> > util/debug.c: In function 'fprintf_time':
> > util/debug.c:63:32: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type '__suseconds_t {aka int}' [-Werror=format=]
> >   return fprintf(file, "[%s.%06lu] ", date, tod.tv_usec);
> >                             ~~~~^           ~~~~~~~~~~~
> >                             %06u
> > 
> > I'll try to fix it.
> 
> thanks, hopefuly the %u will do

 cast to long, i.e.:

    return fprintf(file, "[%s.%06lu] ", date, (long)tod.tv_usec);

- Arnaldo
