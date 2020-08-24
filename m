Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCA524FD7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 14:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHXMKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 08:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHXMKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:10:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC046C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:10:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v16so4139349plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UE8GsvqgRfc/MyLKuyAyg2OP5wLsadeZZ0TASbpeOos=;
        b=KTv84FgOZYRLZaVzaKcnEGSiCtWts+r2p99KbkS11TfoNQ/BrCBvN7N4i/4/qHxOsq
         CP1xcENdSEXYN3VrgKiqm3XSXW5FZLjPbs2bnilRxS0c5ke1bpt6oMDLCBzVUaNmI80H
         Uu2UdzVMM5csaNwdlcoX5mKA85TnAmliqBPhjktUQ6XmF+2ys2vH5kzZ+JlPDWoLUdiV
         Hzkwd7Ff+WKIKcm7fLxxNJivNlQEmdVhz/ohvd2+cyIRibD6OjtMjt2+pN+F8sHqYPzS
         Cyzh7HmJxTSzw7GgnJBd6B0xw5MX0UN3U/zwLzLPWvlekTPwJpjnEqlUGPtg5808CLSM
         96tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UE8GsvqgRfc/MyLKuyAyg2OP5wLsadeZZ0TASbpeOos=;
        b=I32iB00RdlylmFAVT4dnSz5wiLCluq+WrnMVerlxQQeDtlS/NErWH1auIma5OXCgOF
         cMDf0Zs310rS13gyjUOmfYBNWfSOYBgkiFBkLAfTjbsN4yUQuFQORuaR49NJmGKvGnhl
         Ome2JyDJ9R7lpF/4/fZ/yS3w445knfiJNgZ1k+zBrQUQTgJSt6d2amWZOHoh4Jyad/wr
         DAdmucSRV3FV3QtI2Aed7cEzKUDuaGx8P8tCLvX0a+N0a4HM3nfYefvuY/nQ6/0yDlMN
         ymoIBqGObBWGTNu33/mVoLENs84usJwqBFTjjx64XTFIhVNhCHvYo+82/bZsINxAaDcU
         kLFQ==
X-Gm-Message-State: AOAM530gp1AGqpy9y39n3cprNXjibfjfZirmRoi7YZQQQb4//ZyCLSlJ
        RBtoKfZCb2T9PM0tqkgzCo275w==
X-Google-Smtp-Source: ABdhPJzTb31VyJiQjxBciWNtrTi8EcV65QqVW5MQGVt8MNlXhG3Y/Wn8eVkWOXBIr1qDQ+OLlpCMkQ==
X-Received: by 2002:a17:90a:dc13:: with SMTP id i19mr4052844pjv.161.1598271007440;
        Mon, 24 Aug 2020 05:10:07 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id 124sm11616600pfb.19.2020.08.24.05.10.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 05:10:06 -0700 (PDT)
Date:   Mon, 24 Aug 2020 17:40:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 1/3] opp: Reduce code duplication in
 _set_required_opps()
Message-ID: <20200824121004.mvssnqu4khg75cyb@vireshk-i7>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-2-stephan@gerhold.net>
 <20200824111820.rcaingohxw3wozgd@vireshk-i7>
 <20200824113016.GA131681@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824113016.GA131681@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-20, 13:30, Stephan Gerhold wrote:
> You're right. Not sure why I removed it.
> 
> I suspect I had it in _set_required_opp() at some point, but I moved
> code around several times until I was happy with the result.
> 
> We should just add it back.
> Should I send a v2 with it fixed or would you like to handle it?

I have applied the first two patches to linux-next branch in my tree,
please have a look.

-- 
viresh
