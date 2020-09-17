Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC826D829
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIQJyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgIQJyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:54:55 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA245C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 02:54:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j7so839271plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PJlBiIeS5Wdy2999YEJLifVI7R/wk8pty4fRR2lBgRs=;
        b=G5eUcMixy97pPQRUaJlNCnHmF1P60hPgz2mFAP2BIXDpYT4BtxuJZ5UPzi8yFOlFNE
         Dz8ouauaaFmcaB3SHVoxU/TaIi829YIaHyMBX31XgvQkQNFCpYA0+wooNtQNBiGkpKRZ
         jqJKXZE5if2AYb+oKIBZfs1Bs0KgrkaKWGK+9uzU9wRYYl7rGNIGrUzX6hKpcLMqY9/X
         BcYB7f0hMmHpqlmGlJm+XV4oL3DwqPocu2PAVBrBchDHKLJXnpen7XzWFlGSMlt2symy
         4bOcvaUGowUIwKl3vcp2csFrTzXrxIsuhieHLrOh3vbfVbhAnWwJ1C3qYxbvE1cFnXdK
         i/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJlBiIeS5Wdy2999YEJLifVI7R/wk8pty4fRR2lBgRs=;
        b=hj0Y05YV54mwrupRwxsfhgS+25yJ3KQ+CjOytI5lHA64n/mBVlzOvEIoZebJMy9h13
         oZVVhDkl8WRh2TzOIYBP4lZZMHgrW8OfFSFT5VgPIJ6c0E6mlyMqtQYjLM8DQxYYJs7W
         g/pre7ZNvVhZgxYvde6xArzyBuKYmuxGa4xImbF2aGpZTAyBi01vVsaBPyDjKLrixETt
         7WNbwzh5At3SqtZmBuoNmLXszlSxtzPNZmVMQlUyY2h/UYX/nLNwdfYhpbL3h2aiBjfL
         j7Zk2DkyJXTSSCiAi9bu6aKpewWVWdtgXvbwprs0CEOad/8UMUul3EkM+AqymtIDSe0A
         AunQ==
X-Gm-Message-State: AOAM533+FwMphs5it+6J20TzJaLir3yb/g6dLUZ5Bfj06wHi961+WQDI
        Av8Hcim+roNRR/QVtPQQPi4=
X-Google-Smtp-Source: ABdhPJzuOpGFgvMt8I8gvUiYn7kWUfZIBqIbyo3e/S95bnvOZqn2ju/2Bwet3gGY2zXMf+u8ss2D8w==
X-Received: by 2002:a17:90b:891:: with SMTP id bj17mr4239804pjb.11.1600336494426;
        Thu, 17 Sep 2020 02:54:54 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id c20sm5411643pfc.209.2020.09.17.02.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 02:54:53 -0700 (PDT)
Date:   Thu, 17 Sep 2020 18:54:50 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] perf kvm: add kvm-stat for arm64
Message-ID: <20200917095450.GA3049@jagdpanzerIV.localdomain>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
 <20200917084744.GB12548@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917084744.GB12548@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/17 16:47), Leo Yan wrote:
[..]
> > +static void event_get_key(struct evsel *evsel,
> > +			  struct perf_sample *sample,
> > +			  struct event_key *key)
> > +{
> > +	key->info = 0;
> > +	key->key = perf_evsel__intval(evsel, sample, kvm_exit_reason);
> 
> Now the perf/core branch doesn't have API perf_evsel__intval(), and it
> has been replaced with evsel__intval(); so please
> 
> s/perf_evsel__intval/evsel__intval

ACK.
The kernel I'm using still have perf_evsel__intval().

> > +	if (key->key == ARM_EXCEPTION_TRAP) {
> > +		key->key = perf_evsel__intval(evsel, sample,
> 
> Ditto.

ACK. Sorry about that.

> Otherwise, this patch is good for me and I have tested this patch with
> below commands:
> 
>   $ perf kvm stat record
>   $ perf kvm stat report

"perf kvm stat live" should also work.

> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks!

	-ss
