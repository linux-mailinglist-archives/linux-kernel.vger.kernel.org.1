Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3653627452E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIVPYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVPYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:24:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621B4C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:24:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d4so3756695wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MDxzFez2Jq/oZCpozKmvOzUQY5QqDzy9m2DduV+VOac=;
        b=s+ISX4IpStUvjoIf0zi+9KXPBxYJcGpsmlbDp9NVdZkwJWfvW6ISr+oD4IjsxFtfOu
         IyO30GRnPmC04zufw402514h6x0v93uhCpPKbhqU8WyLaRBiGawvfgpPmFyNJL3ziZPP
         /Zo7y4muRtXmPTA3zPZJsgpod6YYRUL87KsYxMoHwbZGFkrh1zQYuh0U7mBwmatjbv3h
         wV/HPZpDF2aiOnZj0fhQgedkvjWX9WLpN9UXgH8JBTNoCWUy6mRrYTCIYuDxkfKOwoA+
         reEfhhGjMLJY3a4GfYg+iO/Jd8HNH5oKhZfHl3HhhpBXlfbmCOUiTyoy7NYtZjpik6FI
         PCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MDxzFez2Jq/oZCpozKmvOzUQY5QqDzy9m2DduV+VOac=;
        b=MB7rEfYxQfGTMva1Z8zvkc0vX0eQF4TidFFVk9uetQP7Oh9Picc7bGFjXMvg8cVthJ
         PEa0rQfc/oL1A4ABa6Kfkgs5CdqC2a8I/YjQ0abfjb9/D52EjNyaVEnui83lYhKJzylP
         CgxHrKA1T0FHooIAEDKCsL/53jA5zFTDe3bCJ4D8H4fIIbxYgr1q2yo3uhOpzdcSPxjF
         rS7ZA6js8EcD8tCSrme67xUkWMB9kQW6lxmI9D7G4R/dF7Tva7ryeinEyaWqw5CQLm6s
         oqx0XUMEGzO5sy3KyPzoHJ1pqKxLW36Hk05OkZoWGUzEMPL4ZsvkoXAd+VT0wWnFOG80
         1Cbg==
X-Gm-Message-State: AOAM530mYrJBvI9OWJJo9Tucy3TZIheThqej2XRq+WcEoEKelMtAnwTK
        vm5VUitWMbDtYN0L1Qy4oUKWl4MnAqonJw==
X-Google-Smtp-Source: ABdhPJzXglh8d6Rj2NJwN9yUbmdtspM/AEg87GMODl5yYYPsWqYfzGebm3RIS+wF8F0Lg9zv7B7K5g==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr1510955wmf.37.1600788249723;
        Tue, 22 Sep 2020 08:24:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2047:2ab9:c10c:f4f? ([2a01:e34:ed2f:f020:2047:2ab9:c10c:f4f])
        by smtp.googlemail.com with ESMTPSA id h204sm5053528wmf.35.2020.09.22.08.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 08:24:09 -0700 (PDT)
Subject: Re: [PATCH] thermal/idle_inject: Fix comment of idle_duration_us and
 name of latency_ns
To:     zhuguangqing83@gmail.com, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, rafael.j.wysocki@intel.com,
        zhuguangqing@xiaomi.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200917073553.898-1-zhuguangqing83@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f1d0d69f-ab45-ac04-b2e7-76d9380c22a6@linaro.org>
Date:   Tue, 22 Sep 2020 17:24:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917073553.898-1-zhuguangqing83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2020 09:35, zhuguangqing83@gmail.com wrote:
> From: zhuguangqing <zhuguangqing@xiaomi.com>
> 
> The comment of idle_duration_us and the name of latency_ns can be misleading,
> so fix them.
> 
> Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
