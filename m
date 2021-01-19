Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680BB2FB3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbhASIYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbhASIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:23:21 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B626C061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:22:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id my11so1120852pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NWqB/GoVkdljpMDCGL3FVT5zZbqPZEOnVZhu+cjokqA=;
        b=pVXBoUg0EM0/gtnwyxcJZc6u2KLdurCxF5teoMEf/ZP9Xk4o6Luw09oLCWinIQ1m7w
         48bP0e1rpkg5PE6dzyyKa2ajONBarWT+3WQh1j8VseGWSqzScxZVd55T+73gdz4XFmHr
         aaLRqaENQ66rHSJJTc0CzBnZYxI4nl0ceDyib9Lo1Jv80KQVNe7mBTOkOtoFj99sfpDt
         tTb+bmPnyuo8U/5Vr0ARuCw7Txxq3ovfZTcwWwmHr5L1eFJgv7GVOdGk3qvN1ZiYCT6n
         Txj8DMfGx8E9zjOYev6DyWkh0B72kMGoukk2/JUVuvM89e1poI0ZnQwHJuJWhJtTaIdv
         qGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NWqB/GoVkdljpMDCGL3FVT5zZbqPZEOnVZhu+cjokqA=;
        b=dToRyujLa4gKsERufNPcNBzLmhvr8Ia6T61cxmQMr+Fwtx8iZrKMKz9Z3pQ9wYVfcj
         LdO1ED7H+EqiuHRvczHa59K+gMOXT+x7FPYhdjplBMSzFBxvbcWkpsLP8G/2auIIx6gU
         Kb0N9pOh3vUAf/UTH9z8ToCDS8xajBQr/Wo6REoIY6jDM4A6vrlv2izjQQ/L8Vr9tRY6
         SHpvHsNTeRzY50xDL+S/+6RgPZ7v7fw+yQxFhURcUJdQFQK1dn0sqRngsq/SEZ9YOAhQ
         G8MLO1967GcQhP8jfvB0hN68X7fsEqYMT81tvp26DM9DvFSVFVofelJx//Ms0HO1y5/5
         vpiw==
X-Gm-Message-State: AOAM533qizu1eXpEu2knPlP4GiQ/uX46IzckPXcga5mmswrk2S5Uon9l
        jQOtTxxBBnKpY+7vSRGoJZ4tEQ==
X-Google-Smtp-Source: ABdhPJxXowidB3QV6SfYuccQQERZU3/i23rKOz8wxL9hyQZP9P1g8KIW9bxPHRaRu72azEIyZ4VllQ==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr4002698pjb.113.1611044555937;
        Tue, 19 Jan 2021 00:22:35 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g5sm9206465pfb.194.2021.01.19.00.22.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 00:22:35 -0800 (PST)
Date:   Tue, 19 Jan 2021 16:22:11 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        vgarodia@codeaurora.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
Subject: Re: [PATCH] venus: core: Fix platform driver shutdown
Message-ID: <20210119082210.GC17701@dragon>
References: <20201221095820.27192-1-stanimir.varbanov@linaro.org>
 <20210119074044.GB17701@dragon>
 <72d85c1b-ec0b-3cf1-dbbc-6c4924e4beec@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72d85c1b-ec0b-3cf1-dbbc-6c4924e4beec@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 09:59:41AM +0200, Stanimir Varbanov wrote:
> On 1/19/21 9:40 AM, Shawn Guo wrote:
> > On Mon, Dec 21, 2020 at 11:58:20AM +0200, Stanimir Varbanov wrote:
> >> With TZ system reboot cannot finish successfully. To fix that
> >> enable core clocks by runtime pm before TZ calls and disable
> >> clocks after that.
> >>
> >> Fixes: 7399139be6b2 ("media: venus: core: add shutdown callback for venus")
> >> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> > 
> > Hi Mauro,
> > 
> > Could you help pick this fix up?
> 
> Shawn, it is part of linux-next already.

Ha, sorry, I did not check linux-next.  I sent the message because
I see this fix is still missing after I rebase my Yoga C630 branch
to 5.11-rc4.  We will get this fix into 5.11, right?

Shawn
