Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EEC1B39E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDVITH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 04:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725899AbgDVITH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:19:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E50C03C1A7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 01:19:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o15so729832pgi.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 01:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EekerngQJFduX7Ew7inUaoXZRPxCiQxtmSV8TYCHEcQ=;
        b=qCwO0eD1AZwXFk3sb5mQcCFCpRtFPUmfPK9zYT8T5Ve+YHt9i6UnQMPkY3Aadh6wob
         XGRRa6+gg8IaXAsm9QPZkT+LepaJgJRjo5m5uuFz0bBQHvHetp/ZmOuZq0ki4nLKOjlK
         evfriyWh7Ywq7Z2uJyjSDiE/vazm725b6xVIn4la+5cjFTLEch4ecIdzk21SYMZxDcXu
         d4Z/PMxNMUnCBwYwcdTNIq9u2iv+TX15szgevkd8sk/UR9cVZtrsJaRcY3/0chKgS7A+
         kCgrMjqcvXsuSLrk7kRrm6AmBK4OWWLfwQe8uQvM/4DYYjDH3fIJl8h2uPCrBrqFXjAm
         UZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EekerngQJFduX7Ew7inUaoXZRPxCiQxtmSV8TYCHEcQ=;
        b=nG2VS1PG+zo3ppCqRAP+f5rKE8XN5kqyUhUH3gx21vwoGaGsPBtrdSoCOg1hT2nfvy
         qoYnQTyskhdRmz1pKeEAqwJYJXN9wl/wljx4jAaigU6Gg2TnueI52C8zQJ/oMHNJ3jPN
         0sc5XY4e2xHjVKNszC+L+xFCHG2/w3EV0cpqXGF6260Qf7tf0jEui8sTelHcqqFsiWsm
         goqpxK2Im4N581NIomlVaWWim+XBkjBqmqwAmuUzvKxIEm+qm0KtTKsGYRrsjAdgTNdn
         j8hUuT245070aiy7MhfJ831pkATKU+z5qd1O07kwaB8fBLxR+d9lInL9Pfzie40JyigL
         Aq0Q==
X-Gm-Message-State: AGi0PuazOjAYxikcCUHV2CxOOy50rGB1rxeq03gtdTWxEc49TjxV+nGi
        NDY7r7hCNnwCk+MjeLoAYJ4OcQ==
X-Google-Smtp-Source: APiQypKPAF045iErsq2ppQZYUssCS2doi5whkj5j7xoi1bp1IpONf49w0ItUKHzbG5D/VjfivgnGcQ==
X-Received: by 2002:a62:1ccb:: with SMTP id c194mr14373983pfc.325.1587543546649;
        Wed, 22 Apr 2020 01:19:06 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id c14sm4335274pgi.54.2020.04.22.01.19.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 01:19:05 -0700 (PDT)
Date:   Wed, 22 Apr 2020 13:49:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, rjw@rjwysocki.net,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] cpufreq: add i.MX7ULP support
Message-ID: <20200422081904.ls6z5yjrcjvow3x4@vireshk-i7>
References: <1587369314-23452-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587369314-23452-1-git-send-email-peng.fan@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-20, 15:55, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This is a splited patchset from https://patchwork.kernel.org/cover/11390589/
> patch 11/14 and patch 12/14 posted 2 months ago.
> 
> This is to use cpufreq dt driver target_intermediate to implement
> cpufreq for i.MX7ULP, because i.MX7ULP has some specific requirements
> for core clk changing.
> 
> To make cpufreq on i.MX7ULP full function, there still more patches
> required:
> https://patchwork.kernel.org/cover/11491149/
> https://patchwork.kernel.org/patch/11390559/
> 
> However with this current patchset applied, it not break anything,
> because the cpufreq device has not been registered, and opp table
> not added.
> 
> Peng Fan (2):
>   cpufreq: Add i.MX7ULP to cpufreq-dt-platdev blacklist
>   cpufreq: imx-cpufreq-dt: support i.MX7ULP
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  drivers/cpufreq/imx-cpufreq-dt.c     | 84 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 83 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh
