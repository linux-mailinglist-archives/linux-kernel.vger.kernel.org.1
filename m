Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6838E28FD22
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 06:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbgJPEYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 00:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgJPEYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 00:24:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D9C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 21:24:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v12so556749ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 21:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uaKvvL6PdvuvPajs37zVh2CeImIwjzJwYqgylaWoxvY=;
        b=pUB8CQerjb2zmESbX0G6SuhCl3QUeB4EULY1wT/0Hh77UQBS6X6oNyFo+/Iqonblk1
         r+eYoSObbt+1c5koIh3AgKK4QM0KNWQBHJXVhI1vwIcDTFvD+1R+LVYfLysRqIKMZl3q
         VZv49M3y+shbySrHB7yJDOuGWor8D0ZO9mCcy58nxGrweN7rfG8DAYFWQkzptGJsXkfP
         iYd5M2R2wy5cgAct3z/Fw8GlC9o5IN4NxFFXGMe8jwtmamhKnp6evYhYzFzV09AENKeo
         /Aq/NhxUqnLMKziTUQK3Hue3ocYVdh3evC6gPRmus9bwGAGi6BAr3BAFEtW3Qbtfiny+
         6arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uaKvvL6PdvuvPajs37zVh2CeImIwjzJwYqgylaWoxvY=;
        b=aIUKQ/IQR4LmFs7niDeVXIWWzHA4qZQCvxofm0f5CLyqnN/aTGh9kO42c/d4Uimbxa
         R8NHOSUK3T/LeqTeUGdXe2xydvp2uor05TvBey4zReOAQIYkTUVZMGckoYwlJbSgFoJj
         sI6YBvheGI1H5UylxuodwRxYRE5Aah3v2ISVDwZLSNRUxpKCkT02ADfTA8u7sl8e5DGs
         fwE2autwxv5V7gu3XJXI+DRGsni4yaTzp6h1P0GR2ZJZAqW5MRRpznA99F/wImgdDHz7
         0xYOICgmgrVHBPpxowtmqYJwpUjl0l74tJguc/Q/V0+XoqiCVv2kSV5UKYrOtP8rZHOZ
         g+ng==
X-Gm-Message-State: AOAM53276AcEamZik1aGdKFmQir4t8DA6EVWFVqW+oP0R3zs0JwFGfYp
        94yVMKv6yRGEi7FyrNfbdfC7iQ==
X-Google-Smtp-Source: ABdhPJzhJEsFB0UnUoCHcC0UKadXnmNTkz9N688VQi2sWpc8Yc4LkwwrVyObejrv3HZkmaIIMkX6rw==
X-Received: by 2002:a17:902:9a89:b029:d5:ad3c:cf53 with SMTP id w9-20020a1709029a89b02900d5ad3ccf53mr2010788plp.8.1602822280078;
        Thu, 15 Oct 2020 21:24:40 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id q5sm912800pfb.184.2020.10.15.21.24.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 21:24:36 -0700 (PDT)
Date:   Fri, 16 Oct 2020 09:54:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, nks@flawful.org,
        georgi.djakov@linaro.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH V2 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20201016042434.org6ibdqsqbzcdww@vireshk-i7>
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
 <20201015180555.gacdzkofpibkdn2e@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015180555.gacdzkofpibkdn2e@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-20, 19:05, Sudeep Holla wrote:
> OK, this breaks with SCMI which doesn't provide clocks but manage OPPs
> directly. Before this change clk_get(dev..) was allowed to fail and
> --EPROBE_DEFER was not an error.

I think the change in itself is fine. We should be returning from
there if we get EPROBE_DEFER. The question is rather why are you
getting EPROBE_DEFER here ?

> We use dev_pm_opp_add to add OPPs
> read from the firmware and this change is preventing that.
> 
> Sorry for checking this so late, but noticed only when this hit mainline.
> 
> -- 
> Regards,
> Sudeep

-- 
viresh
