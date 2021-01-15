Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0127C2F72C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 07:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbhAOGRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 01:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbhAOGRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:17:22 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E601BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 22:16:41 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a188so4830619pfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 22:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i/sEWULimqzpeKYkuYLpPVcG8A3g4/+Vikje3p6e5B8=;
        b=bYOGptCh2oCiqOzDIGW9NizIOvcnGWkTQxqpL+4gsvBw8x5YFppWHoUQwk7wdj6lD+
         wV7BSPhqu4xxjGK4prtkFixgPr4YbGrnM/LOP7qPodhoa+0eyf8xSxx/KHwuFvNR81ji
         VRr7ioo2kIdHdC3lixII2x4kvVxsW7VGdA6G9VSZ38aMKSHPJYb+bP+DJoUZWfDQgKGo
         CtOB04FarL8lVwW2R0M+PhJUqhpowc/uxdde6IiFupc3aBbc03iIPqhhzKcPXR/94QnX
         VJF/C5yiXtt42qJkl41pElgu+X5eAOkRniVb5ftpQGduPsSqYFwnKsATv+8QUvB1Q5vG
         L6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i/sEWULimqzpeKYkuYLpPVcG8A3g4/+Vikje3p6e5B8=;
        b=NBL54Cibi6bkSO+njv2nUlbj9S8giWGJDCO2hWtEfWH5WaSs1CNjTCeiRhm9jz/aUw
         RlM7Bls9KjEZpTGb9ggkUSJkG6N13veZkSLaB9LF4hv5Lepn6n32FpMtEuWRh0v7eXsJ
         GmllcGNQGrZS7MABlE4jvXp/9os3a6wycR5yVp1PaY8SWYQDzfJuo+oIL6D9aPbgx1xk
         zupjKhU4vQey4rQsO+sCmN/cBamku/MfYBG0gx3JEnGgJyvhFV2TQNw7UOcdVx1WvCZj
         7CS2sVsLzwUfybztiGqJM7LkX1lM1V3U5wsX44ObUvJjtvAJ+txF/FnqO2M3eM+jr4UY
         PwrQ==
X-Gm-Message-State: AOAM531HnteoxvjB9zY2E9cAr1iVBSHmeIYS1BcvNdbtI7q8pVkJZaac
        jSrc6aoc8l97kLsY+T3Hld5Qow==
X-Google-Smtp-Source: ABdhPJxSR/IC+UR4IgWWgnR9XOWBKGmhmYQ/Vk3GviNMpk6tGxIlcgpXHNu6goGLw6iGkx66/I+Flw==
X-Received: by 2002:a63:4563:: with SMTP id u35mr10905284pgk.162.1610691401406;
        Thu, 14 Jan 2021 22:16:41 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id v15sm6576714pfn.217.2021.01.14.22.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 22:16:40 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:46:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: arm_mhuv2: Fix sparse warnings
Message-ID: <20210115061638.puvc5cxlf64p3yhy@vireshk-i7>
References: <db5dd593cfd8b428ce44c1cce7484d887fa5e67c.1609303304.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5dd593cfd8b428ce44c1cce7484d887fa5e67c.1609303304.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-12-20, 10:12, Viresh Kumar wrote:
> This patch fixes a bunch of sparse warnings in the newly added arm_mhuv2
> driver.
> 
> drivers/mailbox/arm_mhuv2.c:506:24: warning: incorrect type in argument 1 (different address spaces)
> drivers/mailbox/arm_mhuv2.c:506:24:    expected void const volatile [noderef] __iomem *addr
> drivers/mailbox/arm_mhuv2.c:506:24:    got unsigned int [usertype] *
> drivers/mailbox/arm_mhuv2.c:547:42: warning: incorrect type in argument 2 (different address spaces)
> drivers/mailbox/arm_mhuv2.c:547:42:    expected unsigned int [usertype] *reg
> drivers/mailbox/arm_mhuv2.c:547:42:    got unsigned int [noderef] __iomem *
> drivers/mailbox/arm_mhuv2.c:625:42: warning: incorrect type in argument 2 (different address spaces)
> drivers/mailbox/arm_mhuv2.c:625:42:    expected unsigned int [usertype] *reg
> drivers/mailbox/arm_mhuv2.c:625:42:    got unsigned int [noderef] __iomem *
> drivers/mailbox/arm_mhuv2.c:972:24: warning: dereference of noderef expression
> drivers/mailbox/arm_mhuv2.c:973:22: warning: dereference of noderef expression
> drivers/mailbox/arm_mhuv2.c:993:25: warning: dereference of noderef expression
> drivers/mailbox/arm_mhuv2.c:1026:24: warning: dereference of noderef expression
> drivers/mailbox/arm_mhuv2.c:1027:22: warning: dereference of noderef expression
> drivers/mailbox/arm_mhuv2.c:1048:17: warning: dereference of noderef expression
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/mailbox/arm_mhuv2.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Jassi, can you please send this for 5.11-rc4 ?

-- 
viresh
