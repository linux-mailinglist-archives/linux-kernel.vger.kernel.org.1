Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331092FCBCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbhATHkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbhATHjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:39:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D6C061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:39:15 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w18so2686572pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c5W9HTV4ZUg3nj2NFCAAbwtU0pgjpXW7Cc6ji/9Up+Q=;
        b=NGQhmaAuVmTRmZ7B7R5DYxNsn4MKeNDRq2cdJO0FHJilzvxiFipzAfUtXcJUVrBV8U
         4H3XL3pM4cru/Im5s61GjBfEISSMInxvS9YWGkUdtaOcxTFhc4Rs22Ph390R+MMVc6s5
         Xz8u+F2Jz6EOYzR6nENXbXT6pPuEPVvrivG5BEsE55VS9qXB/lCfaOY4cUSItvzlHDJc
         RU4oJijPmpMxVvKviXUTzMYYycBwUqgPs85DEmqqjjTnSrkp1E/s9jLyXlZAPFxgAKz/
         rRfNBe/zgFivA5FA3GJE7+zTPK2ESKSMUWVD65kBqdo4nIz/SFz1EwN8jmR0NHe8xnLg
         JeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c5W9HTV4ZUg3nj2NFCAAbwtU0pgjpXW7Cc6ji/9Up+Q=;
        b=iz2V2W1xPumnJJn9HVnts0yFI9UXes1bckGXnVt0Js2BMO9VRvJLFBvlPJK0YXDc2J
         9w+/0oIKM/srn+rIDcwWOKn1TNZ9zW0ApFoOM6TP2GvDr0PMl87YeF80dtbeDqQfVG6g
         beN8lS0TtndItfmAIJfRE3P6Dz7LtUAzNr9rcanqVnXLZ0ZCCr1Jx19AQMiz/Czgyx4p
         ENGOFIATgh+XmCcsYRJzU2iFpm9hYsM8EqXNG0soNlihZFN2rgkVZtSx0zFWxkvDryYa
         SZp9pD67bYZz3hBXgszbzXZYWl3LUcXIUYganL6cFRXjJU7Sf4Qgk+fzArQluC00gKle
         v0Ow==
X-Gm-Message-State: AOAM531jZazNHlEAFiPzE6t+QtWFp8ITqFQnwwCtCd5/3khHAXz9gNeo
        LT2uXaiy3BNFl0kgB3d6ikwGxg==
X-Google-Smtp-Source: ABdhPJyi7pDcTfCjj8lDyzZ5io4YygHqpt470QGHSaW9p3ziuvuai1Bm9kVo88zy88tBHI9EHn8xQQ==
X-Received: by 2002:a62:e312:0:b029:1b6:cbbd:63e9 with SMTP id g18-20020a62e3120000b02901b6cbbd63e9mr7988186pfh.35.1611128354980;
        Tue, 19 Jan 2021 23:39:14 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u12sm1207254pgi.91.2021.01.19.23.39.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 23:39:14 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:09:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Prepare for ->set_opp() helper to work without
 regulators
Message-ID: <20210120073912.yl4rgkthdyyznbfh@vireshk-i7>
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
 <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
 <c657b5b0-b841-1b26-8008-2fb4b490d63d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c657b5b0-b841-1b26-8008-2fb4b490d63d@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-21, 20:16, Dmitry Osipenko wrote:
> 19.01.2021 09:35, Viresh Kumar пишет:
> > +	mutex_lock(&opp_table->lock);
> > +	opp_table->set_opp_data = data;
> > +	if (opp_table->sod_supplies) {
> > +		data->old_opp.supplies = opp_table->sod_supplies;
> > +		data->new_opp.supplies = opp_table->sod_supplies +
> > +					 opp_table->regulator_count;
> > +	}
> > +	mutex_unlock(&opp_table->lock);
> 
> Why do we need all these locks in this patch?

In case dev_pm_opp_set_regulators() and
dev_pm_opp_register_set_opp_helper() get called at the same time.
Which can actually happen, though is a corner case.

> The OPP API isn't thread-safe, these locks won't make the API
> thread-safe.

I am not sure what you mean by that, can you please explain ?

> At least both sod_supplies and set_opp() pointers should be
> set and unset under the lock.

The ->set_opp pointer isn't getting used for a comparison and so
putting that inside a lock won't get us anything. We are only using
set_opp_data and sod_supplies for comparison at both the places and so
they need to be updated within the lock.

-- 
viresh
