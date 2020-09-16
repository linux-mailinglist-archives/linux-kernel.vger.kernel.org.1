Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9720126BED2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgIPIHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIPIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:07:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720EFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:07:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id jw11so1140896pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=al9Aj6fs6m+1M4OkCEo9LbifP4jLsy69rCvFZh8tgSo=;
        b=zzWy5FpNemcfGLEGQwn9nDnjgZhz9mWvEAhdUPA/Ylhu/AmfNsEo2+rh/3jna6Geck
         OP0RAVDF/RnzkFm8PSMVyDhbRcHqk+QknIGlSRD54RXMfRCxEwko2D/ST0dfUyzR/apl
         HG1dj8NhxvhQFs9NSzqlFxxslPCgdisM32diLBgmaAcmyFyb7WCI8i0TFY3/vUJMRTMf
         XvXWRMQTf+4bsLJ7BaiBMzd0R4mpg2yX42QTpafRpoUvsLZJddNWbdvtDBa7tuT4OND6
         h6CrlRIrk7qLDtPaodHamGUU9EKRuKol4PujdZjFkyUbywJKuQp50Ew/JrmLBwbwwEub
         JCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=al9Aj6fs6m+1M4OkCEo9LbifP4jLsy69rCvFZh8tgSo=;
        b=tZmVL3tU/ivT+4ygA4mlUyJ00zEbC/GEHqpt4ArhrKywC/rwJXtIrJEa/ZfnYez60h
         OQ5xN6QF5KMLTXhFkoQEbPNy/PPia+3pVLARkUA+aDTYw31B93I5HpQYwsNhx+lIZeNo
         6RJ9K4bH2YH5sbjVk7mbjsCPlIcTHtdCSWkP7yqT/QXDcSUwpyiupE/XhfWnateodcRy
         mOJFlTWwJLFbKzJN65rCOicUKwUwsdMz32wKITM6m837DiHphh+Vn7zpTZ53KMjMVJ90
         bkxUn22a105uzurnJ28/8fmZeBhUtp8Pv1ykaDI2uzoAk8rXHgpgahD55LVx+KDCNvkF
         EV2Q==
X-Gm-Message-State: AOAM532EiQYEgSewPINeFSU9p/x/q2HR3HENNyzFbb7sxWbFy51nQR7Z
        DpZGqJBoSbTz4UqIJWU8c7ByDA==
X-Google-Smtp-Source: ABdhPJwrXgqKRavyqwV2JZf/7NkYcdOZiJpy8XXK8VuazY2kkP30NBcE/tCboIIeuERfnF+hGcTHvA==
X-Received: by 2002:a17:90a:aa94:: with SMTP id l20mr2813436pjq.95.1600243654933;
        Wed, 16 Sep 2020 01:07:34 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id f28sm16163363pfq.191.2020.09.16.01.07.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 01:07:33 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:37:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: Unable to handle kernel paging request at virtual address dead -
 __clk_put
Message-ID: <20200916080728.ajqzw75spcmbbwsc@vireshk-i7>
References: <CA+G9fYvYEsxjU_cnm6oWFgOrU4x0T1CMoN-L2SHLGeJC6MF54Q@mail.gmail.com>
 <CAPDyKFqVB_hgDghaYU1B1BbWUuL6GHhWMbZEYM-cXDQ8T8ThfQ@mail.gmail.com>
 <20200916052239.7c5z4wqqrdpauti4@vireshk-i7>
 <CAPDyKFrxrKRuJec0pDLooovV3BJBVvmDizoL6N4eb+hv1D0NgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrxrKRuJec0pDLooovV3BJBVvmDizoL6N4eb+hv1D0NgA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-20, 09:37, Ulf Hansson wrote:
> I have the board as well. If you need some help with testing, just let me know.
> 
> In any case, I will try the revert and see how that changes things.

I am testing this with help of Naresh currently, will try to update
back today itself.

-- 
viresh
