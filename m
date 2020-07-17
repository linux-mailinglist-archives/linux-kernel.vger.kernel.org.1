Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355AB22428D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 19:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGQRsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 13:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgGQRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:48:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AB7C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:48:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so18511663wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5cA5RUvmio3ClfgI8pU8wP7vKSaKk9ymiyczHiblSGI=;
        b=UJ82aaZ4PJK8DnGxDFuapcONUWsOBY4gwWplow/60/Zk2yXslUz9HCaPjWO+Km5nKC
         27vfnD952Rb/9LSYSZOL02rQnrSnJaK1IwSwmE/rX2/ln1d4/fFEbSNhxTiC+EOs1ncU
         NnK44j2uDxeNyoYTQtYB2cZqLPuF4QPR7Bg7vkLkr2yoZvhMNf+wTLkojOlmr+xcWTVn
         ZdgntFQnkGBIBWbSnwueqHT4tjrr8V+jnPTtwx3QRfyvEutVRHQcaXCxGJH1NSc5s6iy
         BntSWida+dRK+0gBvTvmEQ1apQxLxX653kDCCWPaLlix1Twrr2qLZuUNhb4tkFfX6Cxp
         HVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5cA5RUvmio3ClfgI8pU8wP7vKSaKk9ymiyczHiblSGI=;
        b=WcxGtblNbQUnisgH6qqZ2GPS3jz9bOSWQxkQoaDB5VAqiyN8wTp9mnNgbCBB2EElQg
         O6n4WSqNOqTjPehM0ApMabT07yChqkgoqvWG6Egu616VpCTw+h0FVG6u7QWwQnQZHkm0
         8/0InuIO+WYqWLG1mMRkbSTYR8DBzaYUsry2tJIiNMZYA4+PPBJwE0sZughW8Ynt6bLR
         VlAXK2CtwL2myBdVspvvlJrUPbakEyV53aBh93MN0T5m82Xl6udZGkgJCvcJyRJ/t09f
         KSKmyp5QYovRtpECPlpMTt4iJY3XBzCnsF2WlfqHMXfmtG4yWt2kkMA/YZBaQi3gGgZk
         5rnA==
X-Gm-Message-State: AOAM533uQZAq2DUtqEsC6LtEct6bY8DITPgQHtoZUUrmv7GVJcuaNPoy
        HiU5Ch2CuvCIUoc4Vp3p6wkpN/WBUsg=
X-Google-Smtp-Source: ABdhPJyWMku0BhtQCMKfPdwWx2yy2ByNeIqXqO791I/1KbbAS5AmVGrTO2Xbjy3zaxaCCCEHxjDZ+g==
X-Received: by 2002:a05:600c:2511:: with SMTP id d17mr10745367wma.127.1595008108118;
        Fri, 17 Jul 2020 10:48:28 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:45c9:b95c:ccef:aae6? ([2a01:e34:ed2f:f020:45c9:b95c:ccef:aae6])
        by smtp.googlemail.com with ESMTPSA id l15sm15314927wro.33.2020.07.17.10.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 10:48:27 -0700 (PDT)
Subject: Re: [PATCH] net: genetlink: Move initialization to core_initcall
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, jiri@mellanox.com, xiyou.wangcong@gmail.com,
        johannes.berg@intel.com, mkubecek@suse.cz, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200715074120.8768-1-daniel.lezcano@linaro.org>
 <3ab741d2-2d44-fbcb-709d-c89d2b0c3649@linaro.org>
 <20200717.103439.774880145467935567.davem@davemloft.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <059ad7df-b555-a08d-1f81-5fcb31e2e21e@linaro.org>
Date:   Fri, 17 Jul 2020 19:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717.103439.774880145467935567.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2020 19:34, David Miller wrote:
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> Date: Wed, 15 Jul 2020 09:43:00 +0200
> 
>> if you agree with this change, is it possible I merge it through the
>> thermal tree in order to fix the issue ?
> 
> No problem:
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
