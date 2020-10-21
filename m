Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A9294615
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 02:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439722AbgJUAmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 20:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439705AbgJUAmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 20:42:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D3C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:42:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e10so448284pfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B3KB6nIVt2KuhQ4iDNkhmd6uAR4HfgCoAa05p/jW19Q=;
        b=ElApT+HXih0ss1XvmHd9UcfeW8dj33YfcSwnyCoVAHoLn7yqtPZkW6mPZmQar97WjO
         JZYZKqDRxRw3XDXuk+oX0LKHLeWKGlej5lVE3oy1ZC/ZrBRm7aKp+o6QyEc5C5oRA1B0
         txB2YF0ScgvGrHjTDoY7nNI4pkCV4F01XzAK3v+llzRocaHvFiz2x7UzQqYSmqMyfDg9
         3+0ZYuMMzgnJrf2mEvObuMiuvuT5K/UjhFSssQ3AW3bUUgkK3Yz1o1y9ct8Ad2k2IK1a
         8fnZF7i9mbDv01pnLSI7yIMkVVM8+YcHvE7pzjHetRQhPv3qK0R0CNdBPC6wkEkgcgKa
         HdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B3KB6nIVt2KuhQ4iDNkhmd6uAR4HfgCoAa05p/jW19Q=;
        b=PN+9jrOyjwtcImfNi47TTeHpE2KC69x779dvppyO9YKET2RmSkjnkaeOmyPJvPKAyr
         rvt5xp7Fs2enrvQa9lS72eE0js/w1WaC/CY9Ysh524xpJoc+zcoUmGKT08ufqYQmz27q
         DmHlVOVZVaT0QVTE5y5pN4MzNgHPrrtJzJAhp6bGRkY3v+S3AqgpY13arRXd1VsUhAYk
         kFHY40MqSK4iLVNrrM+RKVEE0Hv7Ji7v5RVMjpw5fmu+waIYhxrQGY8A/xb1EuK/EEkH
         OblcTMsM7ChvzFd7fgPmpGAqbrkIbJ0S0Cblwmf8uwpXWh36/6SSjpANPPllcOWpzEsc
         h1OQ==
X-Gm-Message-State: AOAM531N5D5WV93MBsgBnCMfDkmGMNZsdCt24iWbEhCk0fNbC3voqm7b
        kLPtoHxd2gNXaLlFsJHyYqHAkw==
X-Google-Smtp-Source: ABdhPJxwKSunRCi9dWZskbMa6ou3vB49+WHIvU/DfPo3Z1G+sCI4a11vUWDI20ZrVClak4SpAp4xkw==
X-Received: by 2002:a63:1f0f:: with SMTP id f15mr783464pgf.312.1603240950693;
        Tue, 20 Oct 2020 17:42:30 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([14.192.49.12])
        by smtp.gmail.com with ESMTPSA id kb15sm244562pjb.17.2020.10.20.17.42.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 17:42:30 -0700 (PDT)
Date:   Wed, 21 Oct 2020 08:42:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf lock: Don't free "lock_seq_stat" if read_count
 isn't zero
Message-ID: <20201021004223.GA7226@leoy-ThinkPad-X240s>
References: <20201021002619.28072-1-leo.yan@linaro.org>
 <20201021002619.28072-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021002619.28072-2-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Wed, Oct 21, 2020 at 08:26:19AM +0800, Leo Yan wrote:
> When execute command "perf lock report", it hits failure and outputs log
> as follows:
> 
>   perf: builtin-lock.c:623: report_lock_release_event: Assertion `!(seq->read_count < 0)' failed.
>   Aborted
> 
> This is an imbalance issue.  The locking sequence structure
> "lock_seq_stat" contains the reader counter and it is used to check if
> the locking sequence is balance or not between acquiring and releasing.
> 
> If the tool wrongly frees "lock_seq_stat" when "read_count" isn't zero,
> the "read_count" will be reset to zero when allocate a new structure at
> the next time; thus it causes the wrong counting for reader and finally
> results in imbalance issue.
> 
> To fix this issue, if detects "read_count" is not zero (means still
> have read user in the locking sequence), goto the "end" tag to skip
> freeing structure "lock_seq_stat".

Please ignore this patch set and directly to review patch set v2; I
forgot adding "fixes" tag in this patch, so updated in patch set v2.

Sorry for spamming.

Leo
