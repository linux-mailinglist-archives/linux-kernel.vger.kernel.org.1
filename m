Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29404277A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgIXUeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:34:07 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E51C0613CE;
        Thu, 24 Sep 2020 13:34:07 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m13so175259otl.9;
        Thu, 24 Sep 2020 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ehQMQDpfRuKgE9q3WkgCEw7GDoAOhOo3QuUUp/OPUqQ=;
        b=l312+u+7ga5J92oQ6XTu4UEadfft1HHNg8cWkHDfv1zdbNqUNoPaYJJf+u5myxV0ze
         NhB7GnffmjU6GM2/5X55WeGIODktQ6O6FmCo8F3UTN9IJtVE7NxD00no52Ng12M75Km0
         FIBHT+scEFtSSBIWf7qVEGVJxI1Ju9ltKeAFPQWvM8gXvlFoMsfvWIHpApaBsbGYIVru
         VYmj73BdUKflBMum1ph00dBuR5+gBntRrg6/ZG9gxNNBZU3Q5chIwW8YCtkTe6cuktJ2
         NEKqJ/me49prJuHwT6dMRKXGIRaG6jeuskOiW4JfyuFNjGPah4xM8pxuyFke4Z5S+OF1
         Jtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ehQMQDpfRuKgE9q3WkgCEw7GDoAOhOo3QuUUp/OPUqQ=;
        b=pTJ0qiU9aZ7A4OqDoMLMzhNQSZj7V2mwzaq/i762KzLr84QoC9YdxZJZbA0Cy4aQye
         aQmL3mGREb7ICrgttHbjdhcOlXKHDS90W+sNjFFYs1Sf+W/4q5Jhy1syeufgTp4qD6O/
         ZlYhDVA/LDvb8F05zWAxs0nyKbluZmpKBajI/73ME44aqB5uk4LLEtzsgAO8ILta0dGA
         9m5SdsObZBMy0ns2A7Bt7gIQ25d4K19smYt97pP1L/vss1JwbgBO1XU4WZ6fVed852pu
         HbPtKC+pd6L6BdGqqJE79sf6SmoS/EWAWy2ei6UOXQByg83CY1Vo0YwAijpOTDAf1nYV
         wL9w==
X-Gm-Message-State: AOAM531j3+sXczMzsHDf5dDuUcD8pKdnI2WDyQQLRhjiCd4QBFNLaqF0
        /4IVW2d0ohV3GHTwmWHWWtDhWoPGSlAg/w==
X-Google-Smtp-Source: ABdhPJx2d9TJEBv6QBxIXw1aHF4k4DJ3YCNStZz1ImZ4Pxd88NKzog6I53M3G4zKwxUTDfWnZqDSVg==
X-Received: by 2002:a9d:75d1:: with SMTP id c17mr636430otl.59.1600979646227;
        Thu, 24 Sep 2020 13:34:06 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id y84sm103879oia.10.2020.09.24.13.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 13:34:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/bridge: sii902x: Enable I/O and core VCC supplies
 if present
To:     Fabio Estevam <festevam@gmail.com>
Cc:     DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
 <CAOMZO5B4S3JCVQAi-y=vKaQv3AF6eXronTkmG_DZs_ALtEHtgA@mail.gmail.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <4ea79371-8036-1e26-e1ba-1bb98d1e5410@gmail.com>
Date:   Thu, 24 Sep 2020 15:34:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5B4S3JCVQAi-y=vKaQv3AF6eXronTkmG_DZs_ALtEHtgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/20 3:22 PM, Fabio Estevam wrote:
Hi Fabio,

> On Thu, Sep 24, 2020 at 5:16 PM Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
> 
>> +       ret = regulator_enable(sii902x->cvcc12);
>> +       if (ret < 0) {
>> +               dev_err(dev, "Failed to enable cvcc12 supply: %d\n", ret);
>> +               regulator_disable(sii902x->iovcc);
>> +               return PTR_ERR(sii902x->cvcc12);
> 
> return ret;

Thank you for catching that. I will fix it in v2.

>>
>>          ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
>> @@ -1012,11 +1052,11 @@ static int sii902x_probe(struct i2c_client *client,
>>          regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
>>          regmap_write(sii902x->regmap, SII902X_INT_STATUS, status);
>>
>> -       if (client->irq > 0) {
>> +       if (sii902x->i2c->irq > 0) {
> 
> Unrelated change.
[snip]
>   Unrelated change.
[snip]
> Unrelated change.
[snip]
> Unrelated change.

The i2c initialization is moved into a separate function. Hence 'client' 
is no longer available. Instead, it can be accessed via 'sii902x->i2c'.

Alex
