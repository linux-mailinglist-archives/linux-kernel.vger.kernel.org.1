Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71B4287DE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 23:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgJHVXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 17:23:04 -0400
Received: from one.firstfloor.org ([193.170.194.197]:44938 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgJHVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 17:23:04 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 9D9AF86865; Thu,  8 Oct 2020 23:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1602192180;
        bh=ybElbaa04AbvHreA/DQtIunzBizzYLX6+nmUSXuPEUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3xLgy4BUgb8o/p/KQcTrC91sOzqIm26xctKfxu+a5ErEnJ3ZXTn+4FAk4r3uOzzE
         5U7FtMgkv1OfNd6tRtQt7fV+1qLkD0/Z0jrP8JqunpcIzebi4bsVoczu3Q1nF7clQW
         9WMDA0kSdPkLXNNEuVtpvkFJ03Cfzz1N3TI+OmsE=
Date:   Thu, 8 Oct 2020 14:23:00 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Mark Wielaard <mark@klomp.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-toolchains@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andi Kleen <andi@firstfloor.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Additional debug info to aid cacheline analysis
Message-ID: <20201008212259.gdhlwdswn5pu4zos@two.firstfloor.org>
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
 <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
 <20201008070231.GS2628@hirez.programming.kicks-ass.net>
 <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Basically you simply want to remove this line in the top-level
> Makefile:
> 
> DEBUG_CFLAGS    := $(call cc-option, -fno-var-tracking-assignments)

It looks like this was needed as a workaround for a gcc bug that was there
from 4.5 to 4.9.

So I guess could disable it for 5.0+ only. 

-Andi
