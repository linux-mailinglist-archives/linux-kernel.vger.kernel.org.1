Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F12DBAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 06:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgLPFge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 00:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPFge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 00:36:34 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D29C061793
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 21:35:54 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id x22so1168437wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 21:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=46+bFXnPo8iQM9fEzQMiLxl9oMk4d+Z3r7l4XDfQLrc=;
        b=us+J1NA118GWJT384Ew9P6GKa7R24N3Q5dkKlpOnuYvhqqg48ME4uoqiywu/QnK2Z8
         9Dp+hsJe+OTQgq/QqAzNioEhZP3ulTJ2ccSRUHXHqyoNo9C3q8jxGQrheUJ0M/TUykwG
         FaWwt93EOTh6b9viTqho/3lWCTYotucm0FyDM7AQ/omDKgHkpcfWxPUmwyPCxy58NfSc
         vtFzvEecVZMWXhCGSA4j0j+eGEICyeBYvQ6Lkkvg9TtHPiZObcWIwPduQcoYQg/W3D4C
         1erlcSYg5BGxfk04Rmv2wdL4gPWSkX4osCix8LSWvzNK9b27BiXA/BIePjXMF68ubvpc
         DxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=46+bFXnPo8iQM9fEzQMiLxl9oMk4d+Z3r7l4XDfQLrc=;
        b=YxkhkagsW9C+nDvwzQL2MmMoD8iGw9A+1AbE5RAluW71xznQhsoUX0/CrSMeG8TCOr
         YWhHOJxyyNkFaYiCM42O+ccKMPt8dxBNaTkvgZn5wAuQRlk7IIdiW/SuTYCedz6RB0lH
         tM7Ib0GPE9r5o2AtIeyWBOUnsrUHr0HSGTUFMcEO2WqZVq5wYjqleoagbtY/cCwhF0eB
         GCj7UJvKA+Sy9KMVWGpx3eixGSmSCjyjOJaqqTmrI5+ndUsGXGjaUheznbMLNMjPUkK1
         ZZApyN9KK7MSTm72RO7AH8W/iWhi1pcFcjn2R21Tw92C8pDtvGdYr/E399nnubXw4rBv
         ad+Q==
X-Gm-Message-State: AOAM532/KKVy9WSJ5efpx83C5qDpHmNnPxcVo86KNuuuXLCL69n3Ivjp
        +08PeaNk/AMRb/SSl9RvCCeIF+EwjQZkGg==
X-Google-Smtp-Source: ABdhPJza57fAj0r8CySshfcz+NBHCMyumj9f3HjQRoUry11jLrn8Su33dkSg+39KS89I2zK+SdU6Aw==
X-Received: by 2002:a1c:f70f:: with SMTP id v15mr1533554wmh.38.1608096952273;
        Tue, 15 Dec 2020 21:35:52 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1dbc:8063:5912:c6b3? ([2a01:e34:ed2f:f020:1dbc:8063:5912:c6b3])
        by smtp.googlemail.com with ESMTPSA id m81sm1011553wmf.29.2020.12.15.21.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 21:35:51 -0800 (PST)
Subject: Re: [PATCH] thermal: int340x: Support Alder Lake
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117194802.503337-1-srinivas.pandruvada@linux.intel.com>
 <46cad4d0f14b33e77d2cead3b87177cfaa3e03cc.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f4ca6e36-b905-dd34-e589-0563c3390c10@linaro.org>
Date:   Wed, 16 Dec 2020 06:35:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <46cad4d0f14b33e77d2cead3b87177cfaa3e03cc.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2020 02:59, srinivas pandruvada wrote:
> On Tue, 2020-11-17 at 11:48 -0800, Srinivas Pandruvada wrote:
>> Add ACPI IDs for thermal drivers for Alder Lake support.
>>
> This patch was not in PULL request.
> It is simple patch, adding ids. Can we send as part of second PULL?

Ah, sorry. I missed it.

Yes, I will send a second PR with.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
