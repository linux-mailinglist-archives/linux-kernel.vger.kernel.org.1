Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23372D747D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 12:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389766AbgLKLHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 06:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgLKLGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:06:39 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 03:05:59 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id s2so4412330plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 03:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dZIcwioXHWW3JNXPwlkLYhTvg1RuyWuebcJZCuVrs6E=;
        b=mKABuCPKd1JzpkxUpTNwdTIDOVL5ItEy45+YU7piyW7/FDh/MQT5z1cA+Vpkis/dA3
         Q4jOee+UxpvLx7fenyY8P4RpRm+b+ZmiDcDqIU5A5dtYdotozARYVEzKEHGIsQmtgxCA
         ur5oK3vI0i6aDNgVLfoVOgLbdA8638qBmY5g2r3UWkFNLZ5Oj1NFC1GBTyvH1oGvetl9
         Z4DLSxXSpegoLKm8ZnYBPNPnkzWnhHkuBQWYZGUiO9AG76TqB0Z9hlff0arbppYHCCE3
         z1W1cTZ+u6UoYmAWeg5wnEFQuAzRexf8mEG8WNX5bRZdN1r+EeLZQZcoWx82mgXu8KKi
         ONmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZIcwioXHWW3JNXPwlkLYhTvg1RuyWuebcJZCuVrs6E=;
        b=F+IJyxgRlbXGrL50RP3Cjz39uBnGUUeUOcF2fbDHS2Hjc8+D4dKCL5RXPOTJoyWgWp
         1mSw79f9ElgH4M2lwdxyOsBn8UdjsKrEAUW3oRtrXKM7lwJ+PFK81GAxw0zpJMF5HBKO
         iXfsB0BnWi0bsTXCd9CvGQbT6cSH9OysN/xqM3ueHbEofb4A3iOf9y0DJmWXyk228FiD
         Y0AAamAh1j/ySpMNlJ0WwQINdqpjleHETJ4L7LpT6v3QfaHVk2TxwX38/8Oe/uZBZwZ2
         cywddnmtZIvXigTMTyM/ix4oG8ZFWqG7JjGlIvGz7QzsGT5K68Wr5kT/srBA6S0HLXHZ
         Jd4w==
X-Gm-Message-State: AOAM530XYQiVdPsGnnCCVcJqvxdPVx7+pT/2mgRIjlLE71jTtgCORsZP
        II3L9Ro87XON3eA1tczazh8E2A==
X-Google-Smtp-Source: ABdhPJys0+doBaPiq4gQvhWxl+e969zxyvAhWVYQG14+fORCmHboJs10j5b4GXTHY28/CV+lbo4Psg==
X-Received: by 2002:a17:902:9f8b:b029:da:726d:3f17 with SMTP id g11-20020a1709029f8bb02900da726d3f17mr10431206plq.35.1607684759065;
        Fri, 11 Dec 2020 03:05:59 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id g16sm9286390pfb.201.2020.12.11.03.05.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 03:05:57 -0800 (PST)
Date:   Fri, 11 Dec 2020 16:35:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Cleanup init_amu_fie() a bit
Message-ID: <20201211110555.ht3stotrpbkkdxju@vireshk-i7>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
 <20201210103815.GA3313@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210103815.GA3313@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-20, 10:38, Ionela Voinescu wrote:
> Basically, that's functions purpose is only to make sure that invariance
> at the level of the policy is consistent: either all CPUs in a policy
> support counters and counters will be used for the scale factor, or
> either none or only some support counters and therefore the default
> cpufreq implementation will be used (arch_set_freq_scale()) for all CPUs
> in a policy.

Why is it important to have this thing at policy level ? If we are
okay with only one policy having AMUs and not the other one, then what
about only some CPUs of both the policies having it. Does it break
anything ?

-- 
viresh
