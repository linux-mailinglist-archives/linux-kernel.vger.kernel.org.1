Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0731A3006ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbhAVPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbhAVPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:01:29 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8585C061786;
        Fri, 22 Jan 2021 07:00:48 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a25so5706185ljn.0;
        Fri, 22 Jan 2021 07:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6GrCTWs9NpgE1Px7KRrjvWHXnrcw5duvcL0Gwzimd2w=;
        b=Slaj1/41gm8rh3MOfTkdZwL4K/4GdtHj/pHos4/CrTfmr2lzcgkGJJq8+yaGop18bg
         CdhzlaU/z2dN0CKqrswH9260qc83ArCv1duN0XVhG/G84pUWb10pllTEjc6BaiLq828M
         ECgffjibkhV8eGXSOyTSZAhZGxDxayz636nhTxIeGm684QNnElS88LYZeAhTHV1zdjXQ
         GHCwWYU4T2ZbxpABAfbgIUns2dEd/yVju/YTabGaBgQC6n/rrXy94qVpp6VOS2IAMwRa
         vXVzn+4zcjyyDsoskufSF66gS2Z6G1V7X9UZ7fzthhA7f9eQjxfmf50fqiiAfKxIkjP+
         qbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6GrCTWs9NpgE1Px7KRrjvWHXnrcw5duvcL0Gwzimd2w=;
        b=h5UkbwPLAMg7aEgEb7nDCFAbQebWVl/GP49i6J2FEMmTgLrjewfRTj1SPTStTKzIje
         U/Iv1V+YV4O1FYLa7+xpIUE73PBxp26lZJWCuptFsRS6HjDOguT3hgXFXH72bl4fIus1
         EfRDwEOaohDdtS+5mhupKZvAfojg75l7yTakH1GqZtmPkqf58SLANF6TzLZuXjVjQW8C
         VmGcPvp2HZSOrWJpCUIkRxcbOebIcaXTsfLKUTTtBpVCStLrA2R5+Bz/e1dx+CkJF7ci
         Tk9bFRjteqKBoYWTi0NtistTNI+OrdkoiBy+XLnHhzAYxXx2Dicfl0HZrEfup5GorYbS
         RWxg==
X-Gm-Message-State: AOAM532X2eNUBAlGj/RBX2gVyjjJBpyBGBFBtFYB0ugu5dZpwjlU9bDb
        sBJoryysVbbtGJU3jH+FDt1yNP5g3ts=
X-Google-Smtp-Source: ABdhPJx9mKv9rqJmvUdmog+2xB5v2ILlYxLdsXX+YdCOhP2lmSIgXrd+cxPEZW+e4LMvXo6ELDZW0Q==
X-Received: by 2002:a2e:97d7:: with SMTP id m23mr2446905ljj.456.1611327646209;
        Fri, 22 Jan 2021 07:00:46 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id d1sm973726ljl.72.2021.01.22.07.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:00:45 -0800 (PST)
Subject: Re: [PATCH] memory: tegra: Remove calls to dev_pm_opp_set_clkname()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <1430e70777fdcf1c946ca2fef296f439762a4f21.1611295029.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <36db9831-0d68-2502-ad64-5aab05b16974@gmail.com>
Date:   Fri, 22 Jan 2021 18:00:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <1430e70777fdcf1c946ca2fef296f439762a4f21.1611295029.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.01.2021 09:00, Viresh Kumar пишет:
> There is no point calling dev_pm_opp_set_clkname() with the "name"
> parameter set to NULL, this is already done by the OPP core at setup
> time and should work as it is.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Dmitry, am I missing something obvious here ?

The dev_pm_opp_set_clkname() ensures that the OPP table has a clk
assigned to the table.

The _allocate_opp_table() ignores all clk_get() errors except the
-EPROBE_DEFER.

The opp_table->clk must be not a PTR_ERR for these memory drivers.

On the other hand, the memory drivers also do the devm_clk_get()
themselves, hence technically clk_get() of _allocate_opp_table()
shouldn't fail. But I'll need to take a closer look at the clk core, to
check whether clk_get() could fail for the implicit _allocate_opp_table().

Tegra124-emc driver also has dev_pm_opp_set_clkname(), BTW.
