Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621DC29E458
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgJ2Hhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgJ2HYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CDDC0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 21:10:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o9so671415plx.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 21:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VtMYoH7uqw8segSlpcpBhgMzv0tEH1FAyE5x4ELwZvc=;
        b=IFjlPGcCJsg+rrCXLPGWirDPkMDWOVrFgu1ZQsJ/12/k4uFBGE5W2C1zr4S2lQ8fDZ
         Js0TgSs1Gi5Qo9Vf7LKcU6AUczD5Ch7bsJU/C5YjJw2Xa1cmUjaEOc9OFYyo/gwDt8Ah
         5+sWKwXXMA7k1mVzbD2r8h7xyvo0aot2TDQpdpZpPrLNVdUnQcHZqc14BfYrZVbkFWRH
         hqDx+0K6V9JAaOojJ/Rt/OEg4IDDIB9OCCoSvD+oguFOUS0xa/mivTX00s3NRmpukMYK
         KfrwDsXRlSNTelbQWzDx/AIKZJlVCBFH2kjApE7+EwU7ABaskutN735ytPRhb+xMAjyh
         qx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VtMYoH7uqw8segSlpcpBhgMzv0tEH1FAyE5x4ELwZvc=;
        b=bL27VfoyPgZXq50D73MnmYwa59bzA4ZfSdzHMH6HvEMxMYLf3gldGw+XSBg3Rts70J
         IB1nhFsGvK1GQn3SxReWVRSlBrlnvu8RxgtDvDn8O63R8YuLqaZWVvehynb8ToX4vd1X
         24m5flkves0NZzYcoeKivDCcM1NYSFjyHA/nOQrq7Dr/uMERwg04CoK4ch2BMi+47+x0
         CKIxS13jmszclf8gqIylwZ+Fs9YdvD0DFghvK5ttxDG+w7KYL0bmbbemBSkh0DvoVIML
         iTjKbvucliaTu7uIMTlEUXe6ag4WVLlLNTgwXsuvYag6+D13+y3+loEvlfZZgJjtBLZc
         qdbQ==
X-Gm-Message-State: AOAM532LHUL+cd1QJf4rlR0YiZp6i6QPx89Aw8mG8pBCNomeorcZkOXI
        009MOTPNowccF6eNDOWhTy1Duw==
X-Google-Smtp-Source: ABdhPJwB+wZltGbkPfEulY/us8CH6U0GVvR4+yZJIJGeq/vLXBPgXhWC5ZATCaEuCnT2aQP5lb9Iog==
X-Received: by 2002:a17:902:c404:b029:d6:30a7:dee8 with SMTP id k4-20020a170902c404b02900d630a7dee8mr2267617plk.78.1603944622778;
        Wed, 28 Oct 2020 21:10:22 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 66sm891814pgg.72.2020.10.28.21.10.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 21:10:21 -0700 (PDT)
Date:   Thu, 29 Oct 2020 09:40:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Reduce the size of critical section in
 _opp_table_kref_release()
Message-ID: <20201029041019.xps4dcavkvk6imp5@vireshk-i7>
References: <e0df59de670b48a923246fae1f972317b84b2764.1603785323.git.viresh.kumar@linaro.org>
 <160392797572.884498.11353243518476305974@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160392797572.884498.11353243518476305974@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-10-20, 16:32, Stephen Boyd wrote:
> Quoting Viresh Kumar (2020-10-27 00:57:06)
> > There is a lot of stuff here which can be done outside of the big
> > opp_table_lock, do that. This helps avoiding few circular dependency
> > lockdeps around debugfs and interconnects.
> > 
> > Reported-by: Rob Clark <robdclark@gmail.com>
> > Reported-by: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Any Fixes tag?

The circular dependency lockdep appears with 5.11 stuff and so we
don't need to fix it in any of the earlier releases. And so I didn't
wanted to bother with the fixes tag, as the code had been like this
for ever.

> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Thanks a lot. I was a bit worried about the crazy idea I had to solve
this :)

-- 
viresh
