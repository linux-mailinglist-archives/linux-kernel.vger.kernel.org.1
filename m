Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC292D0CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgLGJNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgLGJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:13:53 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783B0C0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 01:13:16 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h7so6687584pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xXyGHqMNoAToiZLip7CsylqLRv6dmkkfS4SqiTDrHnA=;
        b=RfA3pAHf0uB8kDYYj9jVtdiymX8U2HGk2Oz6idjWPU0gtUzxQH7entwmB9yomr7zwF
         PxVpEMh6Rjj9hBkLtQRKjZpGGUidn/XPCCZ/Tv0TYLu3hA2YcXPN5CRvls74eXc92Z5M
         ctb4S3aMmOZcrUPY5RdPVzaQsEr40wKSSxlpQcmvm2gvvPNB6oEdrZOhF2Cb9q2ZYo4W
         iDiK4aeyj+8wXV+rUeOKKUzZLibsm2gAcvzj9lKXgXPl5h5sf2KhTQoovbwMEZIOb6u/
         MSLtG2i6vTQmmgJXsxlCuVvMovUDwKG1s9YlCNqH8xiyJ+Bds7m026rAZeJFYJDQ53Ny
         6NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xXyGHqMNoAToiZLip7CsylqLRv6dmkkfS4SqiTDrHnA=;
        b=it/9e+1gRC7E4DRgHEX8iBlHZ+Lh9Kapekxy9bziUtz63EypnH4NOrvPc7swk/j6NV
         nyVF7tNfLHBgZ8Y2Fm0Qnqzix1+b3O5S7umKvR/Heg+5FfvtsY73nPYNJaYantm/wIAa
         R6K4GA0bVJ7TDSy4huQFcbc72u43D6XYDOhJprIb2GzO8pKbFa2Jwc/fy6bA2/XYHzvw
         TrSCvlPJlrwrAI7qrwDU9s4+LkudGdGQ5uWLHqK3dPWlPpzNOF3KCJxfvAsSZTwzuzyC
         I9iMZN9Q3bhrs0WfpfcFPm+mFqqv506F1zYetnhdcrdGR9/GOX1TrO9V9QRhGvCwYopp
         l8xw==
X-Gm-Message-State: AOAM5318wtaHXc1C98Z1W03+kkCMlmN9vZkRyrs2pZ+uI5ZFEFgZcn2A
        N4IwtxiUzhWcwj4IyLSgM66/0Q==
X-Google-Smtp-Source: ABdhPJzBRx7PrG7qtbioRHziCz+qPK7rVoQ62jUWugl/HEXUxpKFu7ssRkYNkjaYqXmqItxJgvSK5w==
X-Received: by 2002:a17:90a:8b8b:: with SMTP id z11mr15577306pjn.117.1607332395854;
        Mon, 07 Dec 2020 01:13:15 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id l10sm9616503pjg.3.2020.12.07.01.13.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 01:13:15 -0800 (PST)
Date:   Mon, 7 Dec 2020 14:43:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 2/2] thermal: cpufreq_cooling: Reuse sched_cpu_util()
 for SMP platforms
Message-ID: <20201207091312.cyi6rkt3owlkwsew@vireshk-i7>
References: <cover.1605770951.git.viresh.kumar@linaro.org>
 <1fa9994395764ba19cfe6240d8b3c1ce390e8f82.1605770951.git.viresh.kumar@linaro.org>
 <jhjzh2xtp45.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjzh2xtp45.mognet@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 01-12-20, 17:25, Valentin Schneider wrote:
> PELT time-scaling can make the util signals behave strangely from an
> external PoV. For instance, on a big.LITTLE system, the rq util of a LITTLE
> CPU may suddenly drop if it was stuck on a too-low OPP for some time and
> eventually reached the "right" OPP (i.e. got idle time). 
> 
> Also, as Peter pointed out in [1], task migrations can easily confuse an
> external observer that considers util to be "an image of the recent past".

I agree with what you wrote and such issues may happen here as they
can in case of schedutil as well. The idea behind this patchset was to
get the allocator (IPA) and consumer (schedutil) in sync with respect
to frequency and power. It is better to allocate the power that
schedutil is going to request, then to allocate something based on
different metrics. If there is a problem with PELT signal then I will
let both the entities suffer with that.

-- 
viresh
