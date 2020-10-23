Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C0296991
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372256AbgJWGMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898360AbgJWGMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:12:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523DEC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:12:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c20so324610pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sEILgJLNi06NCo6epaYREQDcaIzCOIdwa2hMmhI70Jg=;
        b=iEqMXrLl0RL9xxIe+yfy28ibTGW9XVZWczPvCKUllYRfiEFmJPM2anznMKLapDG9GX
         h7fnY0QO9J39RQvjjk6GD2akI/wjl1Mypvlg3BnfAVpyz9zhgpfuAQTjAXsBtCG5Exa5
         lxczUH9ovOtGzrFI/jP4wdP8IYbl1WAsqECR1KiSM7OSkr/+q8/tTjMMF2R5lWvKiINW
         SAfOCr02zbJAmeQJhWNSACGYQwgOsAk3WxHmdTiN5sumdBi8BI41NGlRqv1gibcDhA/7
         tGQ/GqL5zqisZz6Doa8Q/FVduwMTQPnLFWR+Rm5Cox9874x7+V4mYixHU/h1T3TOGmn5
         HN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sEILgJLNi06NCo6epaYREQDcaIzCOIdwa2hMmhI70Jg=;
        b=sHokVYIJPyheGJ3oBzLo5fUWxamsoGw+AqN1CAzCPbFQRsWAabBdEBKAR5BO1Q1RYB
         ey0RfQuPhF05f29K7iz4Ug6zOzKV2iseF1M9VGcZJaiMu1uzWQt/923sYGUxBJh8iRMh
         RM2tHFcUtcHszPH7yFc66QAm9EOnz3gvTaBuZydB45EkJmpdqRt9dJh/1Qw4BoE60FeN
         o8qipsOer0Vb8PAgFeK1mEwXBhZ5txcakwDppyyVWU0lRh9s88E5gnyuWHCqPJyYrFNU
         kgkhpCKrodUpeCS3N/gFKgcfW3z9wXY7zT8pU+cNdV4GPror4ubVhvl79HSqCcFp4KHf
         aDgw==
X-Gm-Message-State: AOAM531M0fd7B3WbBot0Mgh6QKxLEkqIF1m2OV1OgZ8wGG3RHIQAVjX7
        hwhDhxZN+CCDqfePGCieUQn+Bg==
X-Google-Smtp-Source: ABdhPJxwrBrDCshuFRMlZZPQRHvFk4BrZKTWyVBbDUgWGljRIN46qOVADLDi8JM3k8vZHA67hjjKQw==
X-Received: by 2002:a63:8f5d:: with SMTP id r29mr840712pgn.18.1603433568888;
        Thu, 22 Oct 2020 23:12:48 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id t15sm743131pjy.33.2020.10.22.23.12.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2020 23:12:48 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:42:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] sched/fair: check for idle core
Message-ID: <20201023061246.irzbrl62baoawmqv@vireshk-i7>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201022071145.GM2628@hirez.programming.kicks-ass.net>
 <20201022104703.nw45dwor6wfn4ity@vireshk-i7>
 <34115486.YmRjPRKJaA@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34115486.YmRjPRKJaA@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-20, 13:45, Rafael J. Wysocki wrote:
> On Thursday, October 22, 2020 12:47:03 PM CEST Viresh Kumar wrote:
> > And I am not really sure why we always wanted this backup performance
> > governor to be there unless the said governors are built as module.
> 
> Apparently, some old drivers had problems with switching frequencies fast enough
> for ondemand to be used with them and the fallback was for those cases.  AFAICS.

Do we still need this ? Or better ask those platforms to individually
enable both of them.

-- 
viresh
