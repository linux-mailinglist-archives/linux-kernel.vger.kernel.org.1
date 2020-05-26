Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0590A1BE17B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgD2Oqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 10:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Oqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:46:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C159C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:46:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j1so2908822wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Ficmofxvg1gGlcOqmwoo/4T3OdE1Nj+sekhSCfgbec=;
        b=cWGcfd37tz1qVZcYhvT2L/iBeU7Z9JdDjY+jlvkqguZEBWg21l9NQBbEhfqreAHF0r
         PgFOGOS0MuAq132t+zlontVtEyhwErfv+U75h8RTQVurtuURP+rNnNwItWYiPXCfrdHV
         M0aPXzhFltqtsifSRCoICBK9GZvlMeEtQqt6DgYTKdkeb+TpCnlNguP/Xv6wxhoFkJWG
         tYIBTK1lJVb2HjZCuOovIjkp1WTLPka/RHm4hD0HC20Zoy212oEIgR2awZtUMzR5c3XI
         aUTxaOZ4iJXDWIUI8OQS8pHpNV8iVSsHW2+ZUV3oVUJIGte4ATKKW/APRmdqMVeu/1Br
         eN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Ficmofxvg1gGlcOqmwoo/4T3OdE1Nj+sekhSCfgbec=;
        b=ZjGznnhDMTmxPedlewZqRyDuWt5rqjsWpdCn5BER3uux1Q0psFt9hH3T1SqVhptgZ7
         nndhXqypYFyOzJUN1wUzDpW32YkfaYwnKBa9fJD4DBdfmBzxyFp+iFRJ8yy4bRCIWk2J
         ouJiXqxQWoLbzGceHIWP0yvZqZZnlTGIoYwDC2hJZZKRMwSHaUYAR1vIqzlNTyk7QTlJ
         2OxaSpl3eW5CwjJl8hwuihWvOBwj8IbMgcqfRqL1jsJTd0Z/JO01q0rNd5kHVo0bQ0ZU
         MHta8AoQNTT45y57SI6ngEMRPQr/06maJ2n5rFx4EHIKzeie9cRGaNHhTXvJE3EXxf+p
         nOGw==
X-Gm-Message-State: AGi0PuYp0JywqquFo8qXywbEzCHgW+zv/5nniBUQWM101zoKR6nwW2zu
        zKpWXBiixIi0hpMzNR27s4r9WA==
X-Google-Smtp-Source: APiQypIJBdvXFYtYk7flefaHVSe/KkfD3c1Yp1Mc7/t3OCPyBa7dFoaFaqO6BQHC4L0I7gFa541a+w==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr39673966wrw.307.1588171594821;
        Wed, 29 Apr 2020 07:46:34 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id a9sm7675575wmm.38.2020.04.29.07.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 07:46:34 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: ti-soc-thermal: avoid dereferencing ERR_PTR
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20200424161944.6044-1-sudipm.mukherjee@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6255085b-984b-58b1-69e7-81c3b9cf1fc7@linaro.org>
Date:   Wed, 29 Apr 2020 16:46:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424161944.6044-1-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2020 18:19, Sudip Mukherjee wrote:
> On error the function ti_bandgap_get_sensor_data() returns the error
> code in ERR_PTR() but we only checked if the return value is NULL or
> not. And, so we can dereference an error code inside ERR_PTR.
> While at it, convert a check to IS_ERR_OR_NULL.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---

Applied thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
