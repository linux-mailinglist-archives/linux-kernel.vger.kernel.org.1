Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07482AE825
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgKKF2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKKF2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:28:41 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E699C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 21:28:41 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i7so723435pgh.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 21:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hIypqJ4e3FN3cBqmDYFp/ukpPu5F8pbHcoa6hXtt4PQ=;
        b=Bi07GWgkywLD8FnMzsnRV8fLTAuN2+qZu0Cj9Kp9pjP+NQQHhWgn1pU3WB8pgMn2n+
         UW8bsf2q36bS1Pr6No/ET/LobIY64U7dGOwZ6n/QcWbqj8rlSJxzG+3BmzBhEDMA09w2
         MYapXURQbqfTStafXTCtXdqoh53hVadrYR3yLhA1VO+wnGmeNSEid6h/kxv7MgtWJElr
         rbJP4jXTHtgV0bB6r2rTBbgFmpubAnbiZKp70VKFvkaT3i2NDLMqjMt9NyrNjoAKdQnb
         noOLCsRAdBuokzBNEYVUXiyqYZLAJlkIAf9tqSMCdWRxtHNBMVFPXqT2cHU0QYwvGXcH
         AeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hIypqJ4e3FN3cBqmDYFp/ukpPu5F8pbHcoa6hXtt4PQ=;
        b=EshO9qiogMj/B8hHY6MwrwIkn8NiFB8anERk7XQOE1E2jFnTzzdag200IOgVw0TrNX
         70IjvbaqDW7VuS2q0/0kSKBVh8vE3COLEKlRniHDjK9IVFxnQcwoQCM6Ka7Z2MpvIvSq
         HwcFBG4TfTyUG8se4QDMvSlgFd9b+2yfWG/0E3G3dnM1ZY5V+ut/lsWfj58rZHrm0Nmt
         /Wt5uyNlpPpc+RQEXYBp0dlOorkqCpumXfhvNX1WzWDJYenfZ8O9ye1VnuG93h9B6ae/
         XDEdfaVSd23YRy1NRFcj1xCRxEVIPli7xYmLx9liJd9WLVKP0ThM8uecfG9uVObtonih
         Wz2g==
X-Gm-Message-State: AOAM533qN5dLxyFnP+vr8r9yNzJo6ydidVsIE1Be8A1rK8FMC0fK+uxo
        1cmeA91qRMu0691RLmiWu6LHYA==
X-Google-Smtp-Source: ABdhPJy+UjWMCnvsCPwS2fY07HaiW8jfw5IaL1WX8HYJ8EOAkR6Tyy/JIcfdQUPW43jmuQtNJVB7xA==
X-Received: by 2002:a62:25c7:0:b029:156:72a3:b0c0 with SMTP id l190-20020a6225c70000b029015672a3b0c0mr21528376pfl.59.1605072520699;
        Tue, 10 Nov 2020 21:28:40 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id t7sm840587pji.27.2020.11.10.21.28.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 21:28:39 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:58:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: stats: Switch to ktime and msec instead of
 jiffies and usertime
Message-ID: <20201111052837.ltxpsz4rrw3jbaod@vireshk-i7>
References: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
 <CAJZ5v0hqxzE3c6Nz7f=23OBYPA7z-pJaSwk9JGTFTr1SYDFubg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hqxzE3c6Nz7f=23OBYPA7z-pJaSwk9JGTFTr1SYDFubg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-20, 13:59, Rafael J. Wysocki wrote:
> Well, this may confuse user space using the stats today.
> 
> But whoever uses cpupower may be confused.

Yes, it will confuse them for once and they will probably learn of the
change, not sure how many of them would be there though who look at
these stats. I find them helpful during testing of my stuff sometimes
and they already look a bit confusing.

-- 
viresh
