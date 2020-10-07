Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCD128691D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgJGUbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgJGUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:30:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755F8C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 13:30:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o8so1610483pll.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pd+/ZpbnBV5l9qExxGdnTHpTNEUm5cV1GzwUJ6tqh44=;
        b=nEyvZX+2vjJOueDyZuWbV5vWft8TAIWEiARMuJgcgQhpHDYfg/KPbHubPg2PDWezaZ
         CKhFhBlogdbkd18w3DAOu7i+iectLFDenZL7hG/CtyzfjFRAwIPw+/2LGozuMjeuSxnF
         ASu4OJZ8TJPnCw3XwDkRKi+7pFaKpqChLq86E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pd+/ZpbnBV5l9qExxGdnTHpTNEUm5cV1GzwUJ6tqh44=;
        b=GNOOviUMsEZk4TVLguGTJMN0HxhaSQN3KA4XN/TWfvrH75tCvUavyUrM9cTCFIv3D1
         FtcWP25g+GXZ7YLJs6ZQ+HF3CtWHfkNpenFy6fDplgirO4pfrUz+C32iFj5tVjZ85S2h
         CE+0X3UIdLEvR26VxDykqHoHDCO6HRPYHJsy+QfiRtXc0+rld8Dy3JhnEDntoeC2h8kd
         S6lZwRxNHXYm8z3aZLL6a+OeArsIGTuqpG8ZuxKjnZ8bk6w2KH5LHVGClYs7LY6exjX3
         G1RBgvRA6AgELorfgj+0SystZYh8Agwc7nZT+wcwjfgrJ3jyQwhxHg+UivJqcxBUswjQ
         E1eA==
X-Gm-Message-State: AOAM5324DAFB7/PRWPMe47GehHsJIRy2Ag7JQizLxl3jNvF0sJJoYbBX
        EzMhXXZRRM7LTksp7B8htIRHLk/puYHJyANc
X-Google-Smtp-Source: ABdhPJxvzB5CQqKYSVpxXRdbhDUgduIv9j3T0qsKxz8w/h/kbw9HaWwcBy6dbTfM/ADqztFMkbJNtg==
X-Received: by 2002:a17:902:a5c6:b029:d3:8dc1:5240 with SMTP id t6-20020a170902a5c6b02900d38dc15240mr4478706plq.16.1602102656996;
        Wed, 07 Oct 2020 13:30:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j8sm4324781pfr.121.2020.10.07.13.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 13:30:55 -0700 (PDT)
Date:   Wed, 7 Oct 2020 13:30:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] counters: Introduce counter_atomic* counters
Message-ID: <202010071329.90E96DC2@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <cbace4e3f504359bd017a7fc2aab62178a1550ed.1602011710.git.skhan@linuxfoundation.org>
 <202010071056.E4804235E@keescook>
 <f0939f9d-d60f-7a97-31bd-e527c79ce284@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0939f9d-d60f-7a97-31bd-e527c79ce284@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 01:26:53PM -0600, Shuah Khan wrote:
> On 10/7/20 12:11 PM, Kees Cook wrote:
> > My instinct is to say leave it "int" and adjust documentation, which is
> > the least disruptive, but I am enticed by the desire to make sure a
> > counter doesn't "misbehave" and go negative when the usage wants it
> > always positive.
> > 
> 
> I would recommend leaving it as "int". Changing the API to unsigned has
> other ramifications and cascading changes.
> 
> My quick search shows me there are 612 atomic_inc_return usages and
> 14 out of them are forcing the return type from int to u32.
> 
> For atomic_read the numbers are 51 out of 5833 forcing u32. We have
> couple of options:
> 
> 1. Update the documentation since we have more cases where
>    int is just fine.
> 2. Add counter_atomic32_inc_return_u32() variant to cover these few
>    cases that are forcing the return.
> 
> I recommend going with option 1 with Documentation update and add
> option 2 when we convert one of these 60+.

Agreed: 1 seems best, and then later 2 if it feels justified. :)

-- 
Kees Cook
