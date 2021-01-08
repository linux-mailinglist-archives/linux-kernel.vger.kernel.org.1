Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5565B2EF10B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbhAHLEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbhAHLEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:04:20 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E26C0612F5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:03:40 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x126so6020854pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1sfWteEPIwPxsDCyxg0+qs2wloQ/QxrLcMBDTNFJ1uU=;
        b=XgAv98TOhVy3rZvI/3cAfUw9tg6TR9jjQSrh2EknQrnA71XA6/hajQYrJNsAXRVX3q
         SuDH7S8cyF8FBpn+OW8YSCNsR2BT0wtfkzqA4HNPn3ICQT8KGH1bC3M+yidkqJQCl2C4
         tNvpxfg87nmUIHrWl/Q+aOsWcvK4aFcvCNFwqXhryCf/rTBTn4T/Anoyrh9GFbeY0KkM
         zT9G+vJA7UViRruopx9ht/zeW7ZLEHUWBRk/Yl2F/Pnnmc6W9v77hCnFESXOi8yDi1IQ
         IolYvcj6xwpWw54ehXNm6m6Ewaa9QQQsspkXIfyxTkHyjqakYdKtU3ldg6sLM/tWuFiC
         28VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1sfWteEPIwPxsDCyxg0+qs2wloQ/QxrLcMBDTNFJ1uU=;
        b=PTnxPO3WC7VN+cfaRt3yenBD6+0DaZbWrIEp3BfZj3w7JWEmj7NZBKiIaFSOKv65S0
         f8bKnsN21ZXl7lP+qNJrP/oTbVzu6cPczQDziqQBpTsnUsv9ljPldJgXAe3NGcG/X22k
         tkFJi2s9BHb+huGTlZerK6lzI6IDDWaMvEsLDrFUo8eh4tqyLC6FoK3ywTobDaHTMaGR
         qjooH8JUbC4nUTQWl2gn83ilNrbYfrxPG4SXdPf0wJM8imh9daO1J5PD0T3E2PSA8TPR
         smkWOfEncvokCtgSv4h9rmJqe11BGThkQ+WCaneLYhpMFmO78AUJj3RyYshvMyTDrXE0
         G4RA==
X-Gm-Message-State: AOAM530r0qWnGsUgEASjHZIkNKfiaGPS6IQenhGuJ3xL1j6Jah+VLkkr
        0FmkSauVmqqiBbqSbONllv8d8w==
X-Google-Smtp-Source: ABdhPJzJ7VA3hppVGJAZ3Pyh3Q7SgQosY0A5tMnbnP44dvavh6CSWhlpQ+AuP0tevZmuwBKMRlpr5w==
X-Received: by 2002:aa7:8747:0:b029:19e:ac1:1e42 with SMTP id g7-20020aa787470000b029019e0ac11e42mr3204103pfo.3.1610103819581;
        Fri, 08 Jan 2021 03:03:39 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id 8sm8732417pfz.93.2021.01.08.03.03.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 03:03:38 -0800 (PST)
Date:   Fri, 8 Jan 2021 16:33:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] arm64: topology: Make AMUs work with modular
 cpufreq drivers
Message-ID: <20210108110336.udylbu6jkjc6mr55@vireshk-i7>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
 <8f0fe23d1c9effed71d5660c939472d43726a61b.1608010334.git.viresh.kumar@linaro.org>
 <20201216000349.GA5299@arm.com>
 <20201216043805.bx6laemhfm2eaufv@vireshk-i7>
 <20201216193724.GA375@arm.com>
 <20201217105049.z3aqhl4mo56hhqvk@vireshk-i7>
 <20210108094416.GA19952@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108094416.GA19952@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-21, 09:44, Ionela Voinescu wrote:
> Now that I think of it again (after spending 30 minutes trying to come
> up with a more clear solution) I realised this is not actually a
> problem :).
> 
> The only location that checks the invariance status is schedutil, but
> what a cpufreq governor does becomes irrelevant if you remove the
> cpufreq driver.

Good catch :)

> The only potential problem is if one then inmods a
> cpufreq driver that's not invariant. But I think that might be on "if"
> too many to consider. What do you think?

Yeah, there is no need to worry about this then I think.

I will resend the patches soon.

-- 
viresh
