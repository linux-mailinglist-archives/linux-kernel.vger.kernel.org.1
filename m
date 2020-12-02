Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE852CC03B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgLBPCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgLBPCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:02:33 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554E9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 07:01:53 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g185so8904795wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 07:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wCxT7QSABY+FrHWg7o6I+Pegp/1kG+37hvn92Koh8mY=;
        b=IwPAUqLTwiLMpK2JWdu4paO6qWlQtpp62tp7Uyw7W2HjLYqwYqwowmc/rZnQBLn6tG
         Z4gIVcDcsEv++cjz48F7JPtjxp84mQzUSbId70oXIJsB57VjU6K5Pc3Mp+UCAZFdDMye
         A/yFuQfxSbScA1144Admg+5wCSzGGjcjzt99kH2V39FxyPj8Gg3UZ99509fxCMXCeRCP
         5ky7y12H0J2qir8MIPXX+qu0v1PT8zCvl98WVl0L9rZZ0+R2odXlU0/hI1N8rjSJcZtk
         HmWSB7VTZdI5fAV6GKZcXUvXrwoYO1O4PiFvqKoXdrw5eGH5rKhJkJ9WWDYVHGu+zAtJ
         tHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wCxT7QSABY+FrHWg7o6I+Pegp/1kG+37hvn92Koh8mY=;
        b=krBnRenaGSoyP4s+374FCvEjxHJ0KJPtNoArXT5QPq0Z6G+88NlvRkOBi/RGZfKeZc
         m2XQQDKlUmL27LySqjVPyS5OMClNf4wsPLO0l1CBSg4Ngf1q2KhW9LfXP+yWd3UPQRmj
         yR4YCd+SC7+IlKwHm1a1l7ntiwWJVEPkPLBwKdc3HPcoC/J+VfQkoFRBKwtj4uohGxig
         9s/NHhT8tbKCjwNN9XGR3g/MKzeVazNs+sgjwsQ276NFbaCvL8H3wLJaB0s0mK3IL4gH
         MULYaBRdeuwDZJ95PIMjc5V5AtNUbtuaIsy9tRVHXohFqk6y/Hr+pT2O7R3psoEv7W4m
         H0jA==
X-Gm-Message-State: AOAM530WQ55cVoAAlhE78P0RAmN/FCbH8mZE22JrXBUvPb9Tlm7BQQZb
        oQJoMa2HWXimzjzmk4KiJ7PGVQ==
X-Google-Smtp-Source: ABdhPJwUFaN3Mkut9/f0dARotHECT9w4RzfSAPkxQ9jRp9JjLsOwf0QtrfoW3U/0Y5AlE9TBmNoiZg==
X-Received: by 2002:a1c:2e16:: with SMTP id u22mr3598698wmu.149.1606921311766;
        Wed, 02 Dec 2020 07:01:51 -0800 (PST)
Received: from [192.168.43.23] ([37.172.217.20])
        by smtp.googlemail.com with ESMTPSA id l16sm2371592wrx.5.2020.12.02.07.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 07:01:51 -0800 (PST)
Subject: Re: [PATCH v2 0/5] Thermal devfreq cooling improvements with Energy
 Model
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, ionela.voinescu@arm.com
References: <20201118120358.17150-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dcc7e2fe-9ffb-0c81-c4df-e5b7874ebfd5@linaro.org>
Date:   Wed, 2 Dec 2020 16:01:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118120358.17150-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2020 13:03, Lukasz Luba wrote:
> Hi all,
> 
> This patch set is a continuation of my previous work, which aimed
> to add Energy Model to all devices. This series is a follow up
> for the patches which got merged to v5.9-rc1. It aims to change
> the thermal devfreq cooling and use the Energy Model instead of
> private power table and structures. The new registration interface
> in the patch 3/5 helps to register devfreq cooling and the EM in one
> call. There is also another improvement, patch 2/5 is changing the
> way how thermal gets the device status. Now it's taken on demand
> and stored as a copy. The last patch wouldn't go through thermal tree,
> but it's here for consistency.

The patch 5/5 is reviewed by the maintainers. If they agree, I can apply
the patch with this series.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
