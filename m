Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9592FF5CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbhAUU0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:26:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbhAUUY5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:24:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D19E23A54;
        Thu, 21 Jan 2021 20:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611260656;
        bh=SvvmmQ+xItm/c5z2bDBApGlidlaKB6PzvX24NzF6+uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REsIYYJuovg/hARvfHLhjx1FJfBkVMIL6ZKbITaU3htHAdOmT2ocKYHF+DH28ypWW
         eM/os3W96zs3JwI36vZg+h0VKhXo5VIyjz4zfyePjrNqLl8te2RLjjclVPNyLBGMNq
         Om8i0rbnQ1lKGaruLliZ0I/fpB22KS4tSOvupC77cKFR2zi2j4mMKpGQUZdZ61InrZ
         V+WiqIaUjAfuR2G6rAHGJdEzhxr/qWW20qUn8qd/OPaZUBsLCV1163TGfqZKBIQLo5
         W55Ya+VqngDqsXyP9NomjypJfM2Puk3/TnYrKqBd7NxWusZT9vkm9qu2lnAnNphlbI
         /9Rux26fqwbmg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 61F0540513; Thu, 21 Jan 2021 17:24:13 -0300 (-03)
Date:   Thu, 21 Jan 2021 17:24:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf script: Fix overrun issue for
 dynamically-allocated pmu type number
Message-ID: <20210121202413.GC356537@kernel.org>
References: <20201209005828.21302-1-yao.jin@linux.intel.com>
 <20210120215004.GD1798087@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120215004.GD1798087@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 20, 2021 at 10:50:04PM +0100, Jiri Olsa escreveu:
> On Wed, Dec 09, 2020 at 08:58:28AM +0800, Jin Yao wrote:
> > After:
> >          swapper     0 [000] 1397040.402011:     272384               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
> >          swapper     0 [000] 1397040.402011:       5396  uncore_imc/data_reads/:
> >          swapper     0 [000] 1397040.402011:        967 uncore_imc/data_writes/:
> >          swapper     0 [000] 1397040.402259:     249153               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
> >          swapper     0 [000] 1397040.402259:       7231  uncore_imc/data_reads/:
> >          swapper     0 [000] 1397040.402259:       1297 uncore_imc/data_writes/:
> >          swapper     0 [000] 1397040.402508:     249108               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
> >          swapper     0 [000] 1397040.402508:       5333  uncore_imc/data_reads/:
> >          swapper     0 [000] 1397040.402508:       1008 uncore_imc/data_writes/:
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> > v2:
> >   Remove Fixes tag because this issue has always been here, not caused by
> >   1405720d4f26 ("perf script: Add 'synth' event type for synthesized events").
> >   No functional change in v2. 
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
