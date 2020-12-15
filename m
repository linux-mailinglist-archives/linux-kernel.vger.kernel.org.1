Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708C02DB6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgLOW73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbgLOW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:59:27 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EDBC06138C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 14:58:37 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id a12so21380316wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 14:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S4/ArqoyhM6R2IAWg2ouJlOV41Dq/1z4QTe3XTdQngE=;
        b=XgUtemt7u7kpgcD8bks8ksl/53beQQmR3zAfJWl1PB+4OuvLHyBXcROwXia6ohjhJk
         OrqiJGR25c9nL0FlW8UOLqn/wpYdHH2rcQ2QdbWXeiYmOYYRtgiyHtqPisQl5hxyd3Rc
         n0ZzptJbGWYLgbFGuNcTlgxoVqLExFn0TQAu26J48CVg8LDRUAgtaTp5No0k6Kp9sjl4
         OKNaTCO1aZICVLEd3pWsGCjXJC4vXKffZQVSHdTwRRrVLe9TH9dbZuJADiSt5DRb4pII
         zXpIaREccXPg3RONSCzCjGXZH+3A8YQlfQiNBFuQcSqopRwT8FYdwUcLQAyXCEHOmc5E
         myqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S4/ArqoyhM6R2IAWg2ouJlOV41Dq/1z4QTe3XTdQngE=;
        b=jctPuhfGPYObSgGW8N93KUbJ/x+yMCqDUj0LF4qUC35q5uyYQJgZnxSpQti8inWVqa
         7MIo/mMDv3eEa0FgI+cf3I47Xtl3sEft6DEYDpCNndb4wQIdWF26HN5g0cJ1tjQ9oUg5
         svtus69VkuWJaBNO3k9tt6/RyDUWohgflvIf6k+Q5UV0LsXNxcwsLqZwdqq1Aq7I1kj9
         ldzQQv28sQxa4lC1UKux+U9kGbh4UTRtdH5QOGy9Ve+cmRQW4STZVqZXZfjygSGrNVsj
         wsYgppurmsJ3XXoVqWRSzzo6vsWdQysG92X8Tx1NcAp8Q0EqWcKXWk95D591uc1WKOsd
         QzFg==
X-Gm-Message-State: AOAM532SJYqIzh15WYhKkvZZmCXTOHS2a2A6Mj9o5zIf8U0sgbhzL66a
        rDnD8N19bFLb5+YFlNSh20iGtQ==
X-Google-Smtp-Source: ABdhPJzN+VdxNoGz5CCRLdungxTDGe3IPh+5/50yEjoJhTIvajc8CLWn1+HPO2cFAFPRxOGqY6emOQ==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr36427160wrx.53.1608073115832;
        Tue, 15 Dec 2020 14:58:35 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:1dbc:8063:5912:c6b3])
        by smtp.gmail.com with ESMTPSA id t1sm83494wro.27.2020.12.15.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 14:58:35 -0800 (PST)
Date:   Tue, 15 Dec 2020 23:58:32 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4] thermal/core: Precompute the jiffies
Message-ID: <20201215225832.GB3581@linaro.org>
References: <20201202120657.1969-1-daniel.lezcano@linaro.org>
 <20201202120657.1969-2-daniel.lezcano@linaro.org>
 <1c909a38-1777-556d-fe87-29394a1b1d56@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c909a38-1777-556d-fe87-29394a1b1d56@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 09:38:06AM -0500, Thara Gopinath wrote:
> Hi Daniel,
> 
> On 12/2/20 7:06 AM, Daniel Lezcano wrote:
> > The delays are stored in ms units and when the polling function is
> > called this delay is converted into jiffies at each call.
> > 
> > Instead of doing the conversion again and again, compute the jiffies
> > at init time and use the value directly when setting the polling.
> 
> A generic comment. You can avoid patch 1 of this series and directly
> have patch 2 , right? There is no need to rename polling_delay/passive_delay
> to *_delay_ms and then remove it again?

Yes, I can simplify that.

> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---

[ ... ]

> > +static inline void thermal_zone_set_polling_delay(
> > +	struct thermal_zone_device *tz, int delay_ms)
> > +{
> > +	tz->polling_delay_ms = delay_ms;
> > +	tz->polling_delay_jiffies = msecs_to_jiffies(delay_ms);
> > +	if (delay_ms > 1000)
> > +		tz->polling_delay_jiffies = round_jiffies(tz->polling_delay_jiffies);
> > +}
> 
> How about one function instead?
> static inline void thermal_zone_set_delay_jiffies(int *delay_jiffes, int
> delay_ms)
> {
> 	*delay_jiffies = msecs_to_jiffies(delay_ms);
> 	if (delay_ms > 1000)
> 		*delay_jiffies = round_jiffies(*delay_jiffies);
> }
> 
> And then calling thermal_zone_set_delay_jiffies(&tz->passive_delay_jiffies,
> passive_delay)..
 
Yes, agree. I'll do this change.

Thanks for the review

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
