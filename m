Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3383922E859
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 11:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgG0JEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 05:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgG0JEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:04:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C49C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:04:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l2so3493393wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kqm25lF7ewtP6gQPXchdKeNoTYsJJHa4GocmE1fwErk=;
        b=XmcVqhm/0j31KrSqjLijP1s5O/yWVNg7px+madWmjsWNWEnyhRedmOJyD+xjYK/r7n
         8U8SVRacZPb6JwHk3RCn6JoCOcPvmJul8pfv6QdYnFXT7UhsTLPKKOez8SYps/oomt1p
         Mqjsy/gRiLkMI/JSZi9BTiVFUxhoa5MFURwilJliSiBhywoOmgkfw6aaAyPLOBvQ0KTe
         Itst60BaAacAOd20K1brUt6YD8fGLY8fMpaXhTktIehhpffXaTAywydveUbmy9UR1P91
         n9Ff8R7wZ8gbeMXLYl+5LV4uVOWZz8ybacK1NrAkRTZptBA2dsCYKtRppAMt/6jqp7is
         cKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kqm25lF7ewtP6gQPXchdKeNoTYsJJHa4GocmE1fwErk=;
        b=VSmek13qOMZuNK7Cu6pBzEWmn9NOORo5yh0BWlhq/XvDFKwJfMaMYhGIn07UHKpshZ
         /7YoPmK74Gs3+t2EBsik81N6rOygqzIxThRGM9ne+SxA+b21GVr8ze+Wb0INGkARh2Vw
         SRydDkhhcyRZ2yiIQwn+KIJkame9+yTAZsDMauHz6Vm+BhMs2b5+SxEm9JXatvphfFL9
         rbya7zWpYXX10vHqY2cLsNHd3mT+oAwSWYk0fBZD8j1IfPmJF44UTcaoufa2GHDxgj0i
         sJ7yJy/7hjr83zWKQ/710E0mKkV8PUWCUQVefQBYXkRHFXZYU/RrGAFj1l+DokpXQg3E
         GjaQ==
X-Gm-Message-State: AOAM5330Uw9aw1XBf3M9sqjaE8l1lAk01HmhBj7hC3v/29C49GijluqN
        f/rLa36xWl59C5HG8nNE9Z6tKSCqe/kM/g==
X-Google-Smtp-Source: ABdhPJyoMNFU464fyBQyU0C+Zj/H8Z010qinNwqPEnEO85BmQspEmZ4wPd3WZmuD3V+yssQpfa5Mgg==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr18401968wrs.270.1595840647556;
        Mon, 27 Jul 2020 02:04:07 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:24ff:55c1:a76d:5341? ([2a01:e34:ed2f:f020:24ff:55c1:a76d:5341])
        by smtp.googlemail.com with ESMTPSA id f17sm19136347wme.14.2020.07.27.02.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 02:04:07 -0700 (PDT)
Subject: Re: [PATCH] thermal: Fix zone lookup by ID
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200724170105.2705467-1-thierry.reding@gmail.com>
 <db6efeab-b2bc-bad5-9c75-89e3e306256c@linaro.org>
 <20200727090133.GG2781612@ulmo>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <baa76252-5f8c-0d2f-224b-221804289e1c@linaro.org>
Date:   Mon, 27 Jul 2020 11:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727090133.GG2781612@ulmo>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thierry,

thanks for testing the code.

On 27/07/2020 11:01, Thierry Reding wrote:
> On Fri, Jul 24, 2020 at 07:12:49PM +0200, Daniel Lezcano wrote:
>> Hi Thierry,
>>
>> Applied, thanks for the fix!
> 
> I ran into this as I was experimenting with the new netlink interface
> and got things wrong. Do you have any userspace that you use for testing
> this that I can use as a reference?
> 
> I have managed to get it to work now, but I'm still interested in any
> userspace that you might have for this.


  https://git.linaro.org/people/daniel.lezcano/thermal-genl.git/




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
