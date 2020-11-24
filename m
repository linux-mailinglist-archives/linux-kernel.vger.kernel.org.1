Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D24B2C1D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 05:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgKXE5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 23:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgKXE5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:57:01 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A89AC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:57:00 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v21so16396126pgi.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ncpwistDFnipYLn+/2FKxZUn+WKeJ5fneb6uwY/MPIQ=;
        b=GK1RxQqLnVhVj8jOqOYCtmv4YBATiByta/qF4Czg7CYzV4aaAlcHWuibeXBFnCfnB3
         q8y2DtxRlrZblPn2jL7oB7eABBb++nnhdu92oMJ41H3wFZr4K5hlbPXF8rTryakLDU0E
         R4ZZdLXGJ/WXMH/3JjEtTTXzJnIw7+3YJA4SJt2CmzEgqwLz3u1X3Lp2J1oLh6wT6ONT
         dQ0SVWXoxmq3qHedEZqSEIxmyJMo7aZTOspjvLxSNj/uB2kSUz2WD55Krs0qa14SOPeI
         bYynzPImk2G6i2AWdgx+KiTsaHjn4634ZOCDhHd5jKQSaInBSOpdCOGl0Cplea3W8s3r
         zZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ncpwistDFnipYLn+/2FKxZUn+WKeJ5fneb6uwY/MPIQ=;
        b=cetDQgKUDr94a0hprU1UH4gAJdH2cAsmPcBOGVerSUUI6Y5rQ7BqK53qHIXkvloW3m
         dZ4aWTXwhBaNulBCWSMD9JnZD4IiFXnDgSo+LL/90UaxEphjm5iyeS/6Db0GnEunYsAu
         VJP9uKuAvutmlgDpDxFlVPff/GbdrYKkFi0+/Og8JH0CHT4FBffvZZgTQFqTX5daA4va
         3ImymGwiajWFUWCidFRvVL9622kboa3VrNUCgL36ph/sQCm0t58Gmg3XrBC6SM2TCEEx
         ff3QoO5CaJW0u3YixuvZgUMSAZg02Nki7dN/LPI2pn0vXzmRRclixmqlWwqGVKJNRg1w
         uP7Q==
X-Gm-Message-State: AOAM5336FDeXxRfBqjyFr6ubBr7IZEq/mPzxSXpOmMVUmxvymhWTeaoL
        0BwCv6+s6u3G6g2uGpWYebOuMA==
X-Google-Smtp-Source: ABdhPJxCpsrFYmyMKV+7dRbT97Vja8EQkjD7PAm2TZk1FVxAs7v60jrow0dq2xqS6MwSng19pVxIqg==
X-Received: by 2002:a17:90a:1bc5:: with SMTP id r5mr2827375pjr.157.1606193819575;
        Mon, 23 Nov 2020 20:56:59 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id d68sm12501014pfd.32.2020.11.23.20.56.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 20:56:58 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:26:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 2/2] thermal: cpufreq_cooling: Reuse sched_cpu_util()
 for SMP platforms
Message-ID: <20201124045653.jpkcl75mxjihovhj@vireshk-i7>
References: <cover.1605770951.git.viresh.kumar@linaro.org>
 <1fa9994395764ba19cfe6240d8b3c1ce390e8f82.1605770951.git.viresh.kumar@linaro.org>
 <aefcc0e2-6c13-625a-4367-fe665330c0db@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aefcc0e2-6c13-625a-4367-fe665330c0db@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-20, 15:32, Lukasz Luba wrote:
> LGTM. It has potential. We will see how far we can improve IPA with this
> model.
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks Lukasz for your review :)

-- 
viresh
