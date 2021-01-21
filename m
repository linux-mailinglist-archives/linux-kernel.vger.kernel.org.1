Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8942FE1F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbhAUFpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAUFoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:44:24 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFA3C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:43:43 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t29so831524pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FxeqQLlBiVEtjte3uU6yOLE+0q+1Ny/d8SvyqMBGIDI=;
        b=Q3kMn01PavYDRljikwVmoQ58SNnRJItCYD6sarzeW8s8LO0t0IMFKCLlz3eNSN8ckC
         EIldqudUpuGq9Kivpeh1G1+cWWyjJ7vJh810dS7exPn3x9dz5f70bNpgF/puARWHqx3H
         gV5CLBdl1frMxKC4ERSA3ryWH7z/TupbULZGeRQe0YkqSxVCmEAOJTzpFcSiJ1iRWbvj
         qWDPUHJTtl5dEwUOPvUzEbTv9upx+/XrPuGBB0uEFYzqQGYZWHfTs0jnf/WjyJyj3WIc
         F7yD7B0f8bVNCKx4NfrFChEsoq4AuqsF+2KshGjUW7bMUbaiyHcLGAEz+cF9rM5CsKbz
         tXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FxeqQLlBiVEtjte3uU6yOLE+0q+1Ny/d8SvyqMBGIDI=;
        b=Lus7Jfvxm8zR0VqRwRKTDghSeqY859u6Ld/2uIv242NoUvhCwi5QYOj5z+Ok9MEJ3Y
         lDF8jOYVpLs09HM8SLm0TxPc0km1meuruU79tdikdhTg/nfHHDZ4vb+z1o/l5fsnKacK
         mmnznxpWsinNqi2gJfulTZPyX4JGQo1Va9vwCk3X4h67iSc5iaaNiStBHRPhMyt7QibK
         4fft0zCwfRwx1AH5Z6py2x+cVUk+JWzegclJARfMvNYyNyV/EgAQXtJ35hJN3m20gfL/
         qN0Kovt7UKJ28jBSzjchkzcmWPTFOkkWrLTyvgCDSCNqVRQviB0M1jyvimu2gQA6BRIL
         /rxA==
X-Gm-Message-State: AOAM532po4VD07SJWcQ6tmo3AoEGhw2+9a9jyXg6H9OGvPGuwgWx301/
        pdJ1pwXfmEupkGyOeE6AZxU+nHIWKq2vKg==
X-Google-Smtp-Source: ABdhPJw0AnPHHwfumz8a2zUwBYbd0YwKQu95oy53lAPbg35dVCJzU93t4cxmezlMjwUlH+mJub0JxA==
X-Received: by 2002:a63:ca51:: with SMTP id o17mr12851031pgi.314.1611207823111;
        Wed, 20 Jan 2021 21:43:43 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id k9sm4200309pji.8.2021.01.20.21.43.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 21:43:42 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:13:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: Re: [PATCH V5 5/5] of: unittest: Statically apply overlays using
 fdtoverlay
Message-ID: <20210121054340.e4do45uvdns5bl5f@vireshk-i7>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
 <a6b5e6ac-90ec-9571-4fce-de7344bfcee9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6b5e6ac-90ec-9571-4fce-de7344bfcee9@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On 20-01-21, 23:34, Frank Rowand wrote:
> It should be possible to apply this same concept to copying overlay_base.dts
> to overlay_base_base.dts, removing the "/plugin/;" from overlay_base_base.dts
> and using an additional rule to use fdtoverlay to apply overlay.dtb on top
> of overlay_base_base.dtb.

Are you suggesting to then merge this with testcases.dtb to get
static_test.dtb or keep two output files (static_test.dtb from
testcases.dtb + overlays and static_test2.dtb from overlay_base.dtb
and overlay.dtb) ?

Asking because as I mentioned earlier, overlay_base.dtb doesn't have
__overlay__ property for its nodes and we can't apply that to
testcases.dtb using fdtoverlay.

> Yes, overlay_base_base is a terrible name.  Just used to illustrate the point.
> 
> I tried this by hand and am failing miserably.  But I am not using the proper
> environment (just a quick hack to see if the method might work).  So I would
> have to set things up properly to really test this.
> 
> If this does work, it would remove my objections to you trying to transform
> the existing unittest .dts test data files (because you would not have to
> actually modify the existing .dts files).

-- 
viresh
