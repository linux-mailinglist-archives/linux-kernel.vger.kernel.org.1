Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEB72F9D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbhARLG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389395AbhARLFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:05:50 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE065C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:05:09 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id r4so8446324pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F9OQYnavHQh6bInpVCgqxHJv31pmZgSymN0VE7tszfk=;
        b=uHiQpPrKff4B+Bu4b3Uw6CEvRp88ejQHmkcqCav+K5jRXxOd7H9iZ8b3LdJ43LJK8H
         1H/PN0RmI1u69Yl0uDvL00yx47sYssOdXGQhn4ARwTmp143byQ15wYJRMGqo+ZHvd9Nj
         Kb9w3CXJzRQdjggnlhx9eZ8Ak60nAyHb0qDe1HIvCwlnCsjQ9xq1gW/swlR9o5tCa9q+
         ASr4qB87WY74lv8qtdQY2s5IoFw9mFLmpvwtufih4qTHZzHPDlaLpe+3ABgptj7HtTZj
         c7uquBZ5TMvWqU/zPQx7OD7j8dx4YW1FEoN1VUXWVUAby0EQEwOkI7v/qCU0R63Z0q9e
         r0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9OQYnavHQh6bInpVCgqxHJv31pmZgSymN0VE7tszfk=;
        b=kMPhLlsatH1854Gm8FZT+d2kidlHbNq1QE7hgazaWY0qVO4yQYb0P/unHi4sEz+8uc
         jYEmpZmJKrbXIpyNMClGKoUhqLiJl+fuRz4af/Ck2IGgcwWJ8X0L4CCG+t1Ny6dwI6F9
         h56hsvFYfu5k6J0I3x/Z/G3LwaOkE1+I8o2KeveJm4neda9zhPtQsF61gOEE+e7utyZ+
         fGXcrDzsTt4GejGnNgyU+WPKBSDelwYJIA7eSXN0grVpQNxNLl2yUYuWtyL8gxX90Zb8
         1Ix9SBeFl6nYowuDzQFM9y+EBjYky2G2Ul63bvY6dnv+ff9ehdK2h3B86Vc9JmlhT5h6
         T4lg==
X-Gm-Message-State: AOAM531uKU1t++XBR4zTMDjdofhugmRW7WjwJqtxf33oYTDPnOCcE6En
        MbOWBi3Fe0XPbkqY0p5sBQS+kQ==
X-Google-Smtp-Source: ABdhPJxeVSyHqI2EvkjRyPU8nAOFau0V4zeSgemv9Z5asSa44ik/HYhXmOYIPlsQxBg9EFClym1bIw==
X-Received: by 2002:a17:90b:f08:: with SMTP id br8mr25567326pjb.134.1610967909472;
        Mon, 18 Jan 2021 03:05:09 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id k8sm525490pfp.114.2021.01.18.03.05.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 03:05:08 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:35:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] PM: domains: Make set_performance_state()
 callback optional
Message-ID: <20210118110506.linvsoca7jbl42iq@vireshk-i7>
References: <20210118011330.4145-1-digetx@gmail.com>
 <20210118011330.4145-2-digetx@gmail.com>
 <20210118072855.anncyl6z3e5uznvd@vireshk-i7>
 <CAPDyKFquCGUSTvcCpmN0vm1eGEz9B_hYSNm7wojhgwuXT=jkEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFquCGUSTvcCpmN0vm1eGEz9B_hYSNm7wojhgwuXT=jkEQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-21, 11:59, Ulf Hansson wrote:
> Good point! I certainly overlooked that when reviewing. We need to
> reevaluate the new state when propagating to the parent(s).
> 
> To me, it looks like when doing the propagation we must check if the
> parent has the ->set_performance_state() callback assigned. If so, we
> should call dev_pm_opp_xlate_performance_state(), but otherwise just
> use the value of "state", when doing the reevaluation.
> 
> Does it make sense?

That will work but I am wondering if there is a way to avoid the
unnecessary propagation if we can somehow find out if someone above in
hierarchy supports pstates or not ?

-- 
viresh
