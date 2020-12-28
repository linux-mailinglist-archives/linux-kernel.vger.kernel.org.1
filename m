Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE722E6952
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441746AbgL1Qry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 11:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbgL1MzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 07:55:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FCD322573;
        Mon, 28 Dec 2020 12:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609160069;
        bh=cCr9rjr5oy6TVkR4t8ptkBnMacdfaREGpVlXYRjz16w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAmbgUMKHomsZQXSf3pdqO6VeQKjIo9oLoo18Su6+qJ/3zKyVt8fWKNLlGC0szWCM
         DHuYxhQmmrzC2SdHCVroQuT3ZdDdP79cKz6ovN2D7hfgwvvz3B6+nhmpqu42f1k885
         +5Ra2LQB2HP4G1VK5eGwMljUUNcvrj29aISIZFcgQG0u4sbM4MhAOWDxsQO8exrtLS
         efYmHWW6W1NTDZRkfNv8PUFifn0rVJ9F5dw6dBwxd6HWYRDWPYLI3pijXo46QzsRob
         43uJKcUbeK2YWdQOALsGaj8dNaEuuGSyPcx9+9+AJiyrRDfTosOGB22bx9TUXAlVGX
         noM9Uhp8ofsOA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5AA3B411E9; Mon, 28 Dec 2020 09:54:43 -0300 (-03)
Date:   Mon, 28 Dec 2020 09:54:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        He Zhe <zhe.he@windriver.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] perf arm64: Support SDT
Message-ID: <20201228125443.GA521329@kernel.org>
References: <20201225052751.24513-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201225052751.24513-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 25, 2020 at 01:27:48PM +0800, Leo Yan escreveu:
> This patch is to enable SDT on Arm64.
> 
> Since Arm64 SDT marker in ELF file is different from other archs,
> especially for using stack pointer (sp) to retrieve data for local
> variables, patch 01 is used to fixup the arguments for this special
> case.  Patch 02 is to add argument support for Arm64 SDT.
> 
> This patch set has been verified on Arm64/x86_64 platforms with a
> testing program usdt_test.  The testing approach is described in the
> patch set v1 [1].
> 
> Changes from v1:
> * Added Arnaldo's patch for fixing memory leak (Arnaldo);
> * Refined patch "perf probe: Fixup Arm64 SDT arguments" to use
>   asprintf() and check pointer is valid or not (Arnaldo);
> * Minor changes in patch "perf arm64: Add argument support for SDT"
>   for the regular expression;
> * Added Masami's Ack tag for patch 03.
> 
> [1] https://lore.kernel.org/patchwork/cover/1356212/
> 

This one made it into 5.11
 
> Arnaldo Carvalho de Melo (1):
>   perf probe: Fix memory leak in synthesize_sdt_probe_command()
 
These were now merged in perf/core.

> Leo Yan (2):
>   perf probe: Fixup Arm64 SDT arguments
>   perf arm64: Add argument support for SDT

Thanks,

- Arnaldo
