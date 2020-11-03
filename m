Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160252A4535
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgKCMbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgKCMbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:31:44 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A40BC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 04:31:44 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so7789864wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 04:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y5g02yisg2YY1sLEpz7UaUSABGGShGErCKYZaVBWDik=;
        b=ibxvv73cNC5BoJrVRc/HNlTXGT5LdQH6Xdd4KchdNSvNos3JpctjDBkt/IueeM+QaF
         c8Rzba0GgkPkcHNEBWeK5vW0wgJIxe430Pna4cVNyWK5CMTqjhlPeSWRYDTlqiNboOdc
         JaxC8ZkLZGhjDQZq8tdbM4ZLTX4hkTjQLXvzTcx447SSpxJ0Gq3A4YDD/bGiMWndOSo1
         MPuAEclfe7MHpHu0k+8518NsTKWOXc1+AeFGcZeGT3jv5bqvl72Qk2jwZtHmphdX7rXH
         r+SMWQJEJqvblpCkcwZK7qLkMJiNnc6iQN1Bx201q43Ka28PbwhuZmJz8OlOkDXY1K2N
         +B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5g02yisg2YY1sLEpz7UaUSABGGShGErCKYZaVBWDik=;
        b=ity0ayGSDEhyUZ7v6CuO+HokuNouxApjtV9BVJg7gvCc60/YZxXqd4pqvGNopPYPiY
         Y8bJJ2dOXUGFWghfuVcde8s94j+werLGuStAiP1w0AELObKOE+aD8Jv4vwGBm+Z33HUf
         2N2IPf6MR7zc7NFFJeMHiIMcmas+r1x7f8vDiwHInAvSdttFtBDMk0mth25vM87F6rBL
         zMXrnBgZS/SlECcxfIKzi0ETBoxDEVZsWV4Cr4ViFCeNke7oFQROHVT9Bvbz5sJWbqWk
         5sTSLMxLUJHLtlpSd52TKJasDY3ZdpYDfcTUq1GXxxdQtZdcj/bWtQJ8XESCP0RowiEq
         c38g==
X-Gm-Message-State: AOAM533KqRA0MQH95brJDGMamuOnOc3wB6cTuLvVthOKTq7IR1A3yv7O
        S3mw5c1wdEJ/i7V8EZY516DKKA==
X-Google-Smtp-Source: ABdhPJyoDx75NM2nei8klPiV6Zbdy71+3ncC5yA+p6RbdzsnUy2pt1TXTtGiX+SMswnf4kmnfXwTHg==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr3580057wmf.185.1604406702958;
        Tue, 03 Nov 2020 04:31:42 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id v6sm25922279wrb.53.2020.11.03.04.31.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 04:31:42 -0800 (PST)
Subject: Re: [PATCH v2 2/6] ASoC: codecs: lpass-wsa-macro: Add support to WSA
 Macro
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
 <20201029110829.16425-3-srinivas.kandagatla@linaro.org>
 <13987e14-0bd9-9659-b574-d3b7446bb789@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0bce847c-6437-9d12-6d54-d9ee99c7e896@linaro.org>
Date:   Tue, 3 Nov 2020 12:31:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <13987e14-0bd9-9659-b574-d3b7446bb789@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2020 15:47, Pierre-Louis Bossart wrote:
>> +static void wsa_macro_mclk_enable(struct wsa_macro *wsa, bool 
>> mclk_enable)
>> +{
>> +    struct regmap *regmap = wsa->regmap;
>> +
>> +    if (mclk_enable) {
>> +        if (wsa->wsa_mclk_users == 0) {
>> +            regcache_mark_dirty(regmap);
>> +            regcache_sync_region(regmap, 0x0, WSA_MAX_OFFSET);
> 
> I am not a regcache/regmap expert but the sequence seems odd. I could be 
> wrong, but one would typically sync *after* doing changes, no?

In this code path the MCLK is going from OFF to ON state, so the 
registers would be put in reset state, so we need to sync them with 
current cache state!

--srini

