Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E5228D050
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgJMOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgJMOhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:37:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8299A2483E;
        Tue, 13 Oct 2020 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602599831;
        bh=p99AYKtrxIUxwIeQStB6PMEshjgWsgACJEnEwCoIH0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pc0ROQMpOfzi/iLrhEmet9HB6W1CgfroDvf6K+Hcxu/efEG2o/lA3imY++Qg0T2mY
         sMaPDkFJb9SZywlhYKaYmmd/JaDlj7et22L2Z1EcRMXlx2gG8d17IbjXA27LZBJRMA
         SbqFJqBrjlAugEGN2iRCVv2lPuevZYBW931S5pE8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 69414403AC; Tue, 13 Oct 2020 11:37:09 -0300 (-03)
Date:   Tue, 13 Oct 2020 11:37:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv4] perf kvm: add kvm-stat for arm64
Message-ID: <20201013143709.GD1063281@kernel.org>
References: <20200917100225.208794-1-sergey.senozhatsky@gmail.com>
 <20200929033450.GB529@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929033450.GB529@jagdpanzerIV.localdomain>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 29, 2020 at 12:34:50PM +0900, Sergey Senozhatsky escreveu:
> On (20/09/17 19:02), Sergey Senozhatsky wrote:
> > Add support for perf kvm stat on arm64 platform.

> > Example:
> >  # perf kvm stat report

> > Analyze events for all VMs, all VCPUs:

> >     VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time
> > 
> >    DABT_LOW     661867    98.91%    40.45%      2.19us   3364.65us      6.24us ( +-   0.34% )
> >         IRQ       4598     0.69%    57.44%      2.89us   3397.59us   1276.27us ( +-   1.61% )
> >         WFx       1475     0.22%     1.71%      2.22us   3388.63us    118.31us ( +-   8.69% )
> >    IABT_LOW       1018     0.15%     0.38%      2.22us   2742.07us     38.29us ( +-  12.55% )
> >       SYS64        180     0.03%     0.01%      2.07us    112.91us      6.57us ( +-  14.95% )
> >       HVC64         17     0.00%     0.01%      2.19us    322.35us     42.95us ( +-  58.98% )

> > Total Samples:669155, Total events handled time:10216387.86us.

> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > Tested-by: Leo Yan <leo.yan@linaro.org>

> Arnaldo, any opinion on this?

I'm not finding the actual patch, just this reply from you, lets try
with b4 using this message Message-Id... Magic! But it isn't applying,
can you please refresh the patch to what is in my perf/core branch?

- Arnaldo

[acme@five perf]$ b4 am -csl 20200929033450.GB529@jagdpanzerIV.localdomain
Looking up https://lore.kernel.org/r/20200929033450.GB529%40jagdpanzerIV.localdomain
Grabbing thread from lore.kernel.org/linux-arm-kernel
Analyzing 2 messages in the thread
---
Writing ./20200917_sergey_senozhatsky__1_2_3.mbx
  [PATCHv4] perf kvm: add kvm-stat for arm64
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    + Link: https://lore.kernel.org/r/20200917100225.208794-1-sergey.senozhatsky@gmail.com
---
Total patches: 1
---
 Link: https://lore.kernel.org/r/20200917100225.208794-1-sergey.senozhatsky@gmail.com
 Base: not found
       git am ./20200917_sergey_senozhatsky__1_2_3.mbx
[acme@five perf]$ vim ./20200917_sergey_senozhatsky__1_2_3.mbx
[acme@five perf]$
[acme@five perf]$        git am ./20200917_sergey_senozhatsky__1_2_3.mbx
Applying: perf kvm: add kvm-stat for arm64
error: patch failed: tools/perf/arch/arm64/util/Build:1
error: tools/perf/arch/arm64/util/Build: patch does not apply
Patch failed at 0001 perf kvm: add kvm-stat for arm64
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
[acme@five perf]$
