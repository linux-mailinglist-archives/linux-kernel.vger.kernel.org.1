Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B1A26375A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 22:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgIIUa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 16:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIUa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:30:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF1C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 13:30:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so4369025wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 13:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=EH/tYSNFoJCWr2t8aRsA0EDrUno7CjChlXcQg1phvUQ=;
        b=es1xOsqiZH1BYB2PLDy2j2YtABYVa1MdPrIAiWWOaVI/C0Y16S/Ja0vPpouNWvvrrT
         NekHNPMJaIS4/C6FCEQSisMK3Ec02U9l0J3dtMYVfeiTft95aQkjuNK+delx9x4HbbBP
         ZL4ZU/LuIj7ajdB6EW5Z4L05zI0CM7ExA4iBW9iyfS7t+25MvHoq+03eFoUXBEFvmKYh
         +fbAeYe5uy6qLtuvK0cOBjZv6g3SYF8Jf5c6j/C4d3y99yK1Do1WVDdyTfXf2UG10wLi
         0OQZHC5ie62VbpWaKkM2yiMO8G5RVfwdPti7AEn4eQxzWFsgVmxBQ1TDNMgaUFkOM3ni
         DrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EH/tYSNFoJCWr2t8aRsA0EDrUno7CjChlXcQg1phvUQ=;
        b=t7c5SUMwzFW5ahdWzUcl/YgpDNH2h8QDWtJ2PPuFAfvAr8LTlBRms8IJiJQgWuBxl6
         z+uOTwMc1Cb3hUc2XHDdt5/AHjcsxBK4Vh6OIiW4MLWWvYGUth4lpSnMdaOo8qGtwrNZ
         rSGtuSNr1PTh3mpawtJKoCxhOlKnlFWKQD43oDksh8VqcqtAZic2I+YQ02SROpzbuU6l
         ORVhR83LHjGCRet2TtHvgiwtk+aHeUyFFc57+yNlw4KWMnpCgq1EW5rUaWlMpd5EFAtR
         77QVu/6xZ0tesd1c5skRHgAiBOX2YiXmba5bpPCA7ZOAKHtIWz0SYGSprM299OeY9jbJ
         fpaA==
X-Gm-Message-State: AOAM530dtzDSAS4Dxfuy7S12Y8FgcFT4YWkSF/4r8NmRau9aE6xhksjX
        /ZWlS8Evaex0ZyGg6rk8+0IHaQBUZnbs19H/
X-Google-Smtp-Source: ABdhPJyFPNZuENu1QBsJFAeobwACdwMTtJMX4e3vhAAmnMuWUXK9jLB0B2nuiiFis6TRa8ZLoR2e6Q==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr5507451wrt.32.1599683424396;
        Wed, 09 Sep 2020 13:30:24 -0700 (PDT)
Received: from [192.168.0.18] (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id n14sm298873wmi.33.2020.09.09.13.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 13:30:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] w1: Use kfree_sensitive instead of memset+kfree
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
References: <20200909194122.212486-1-alex.dewar90@gmail.com>
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <534193cc-24be-592b-0713-1973bbb0217f@gmail.com>
Date:   Wed, 9 Sep 2020 21:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909194122.212486-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-09 20:41, Alex Dewar wrote:
> Issue identified with Coccinelle.
Hmm, on second thoughts, I'm not sure this memory is so sensitive after 
all. Should we just remove the call to memset?
>
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>   drivers/w1/w1.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> index e58c7592008d..4f597b0fd1da 100644
> --- a/drivers/w1/w1.c
> +++ b/drivers/w1/w1.c
> @@ -71,8 +71,7 @@ static void w1_master_release(struct device *dev)
>   	struct w1_master *md = dev_to_w1_master(dev);
>   
>   	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
> -	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
> -	kfree(md);
> +	kfree_sensitive(md);
>   }
>   
>   static void w1_slave_release(struct device *dev)

