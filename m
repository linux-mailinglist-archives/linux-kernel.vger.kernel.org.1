Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03EE271041
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 21:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgISTbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgISTby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 15:31:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD8C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 12:31:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so8378429wmj.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nhO64xCI4d4r54ZrWnpLalMx3gX9IygCuaPxGjDx99M=;
        b=Tydqc+qocqvnz2vAK6WPkAGgnydb9gSTS2fJ6ETQF3KtpWS+d12fFMWuHhG06PgIiH
         j8cZ9oAGiWg0wL4VD8YjU+KUq/iQAe8STAP3+LpVPSFKZGtOtKKL33/2/yW6Cu7n40Wy
         7Uhrtt3jOzepOcePj+W5S2+ywlbIT9N3e9bW6ZyiXEMO7BgiNhgvRceKHVZMts9Mcty3
         2n24pNmcZpMHW5tFUv9bSjVDvmkPSLxsTNnYDiAgKeYTiEJebAzE7GyxAHAh0jjVRNrW
         g29AMco/b9piZzP5j1YmAKIb3yrCa3uITV3y4BcCSL6fd8p55wt+HFAXSlzyoWI7HOcj
         tzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nhO64xCI4d4r54ZrWnpLalMx3gX9IygCuaPxGjDx99M=;
        b=T7AVYah7oJcxb/aIM5Lh+2kaBnn5HIprW/WhDBKEQ5axyzqvjio01u2NnuWiVZ5eTR
         JauddTrzOeho4JvrguXKVSJl3S87ITUsCh3LxWcFRenEuRIi96frFe1ULa0D4Ww5i4y0
         rs5mFnBWB++WdOrry3zJA8Atq/0bNKEn79qPBdtfzFt7tiENWKPbubD7C+gT8NAwkVc2
         LoBMDWHJM4SCtYZndALx8t0JLeKnVUePtdpQsntQ9DmlI8Olqk5pMUo2euQAXvmROsB9
         LWkQZljqr0EULMIAA0TkFWmxm7jb8xbZbyK041BPJD20RgO3RfTgnPrkcd+iWwLBuVv6
         ueLQ==
X-Gm-Message-State: AOAM532FE9godprgYin+X1GUQCDiupquuLkDVADFPVjJwjhKkSn1PQrU
        gdMTahE0hfb2pQ959LaXL3HQQ2EgEzwAYA==
X-Google-Smtp-Source: ABdhPJzunn6qDr4P1aW+zfdh47dIikbU0rsyCB3FHmxe0aDSJgTLqHEQXgP+YIxCawHHutNcaRX3lg==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr21021614wmi.163.1600543913008;
        Sat, 19 Sep 2020 12:31:53 -0700 (PDT)
Received: from [192.168.43.148] (92.40.169.140.threembb.co.uk. [92.40.169.140])
        by smtp.gmail.com with ESMTPSA id b18sm13020585wrn.21.2020.09.19.12.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 12:31:52 -0700 (PDT)
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: Use kmemdup cf. kmalloc+memcpy
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philippe Cornu <philippe.cornu@st.com>,
        =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200909190213.156302-1-alex.dewar90@gmail.com>
 <c14d055d-1f6e-8c46-3a6e-7794ec69e6fe@baylibre.com>
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <89c599d2-6766-df68-5359-7672679b3d89@gmail.com>
Date:   Sat, 19 Sep 2020 20:31:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c14d055d-1f6e-8c46-3a6e-7794ec69e6fe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-11 13:57, Neil Armstrong wrote:
> On 09/09/2020 21:02, Alex Dewar wrote:
>> kmemdup can be used instead of kmalloc+memcpy. Replace an occurrence of
>> this pattern.
Friendly ping?
>>
>> Issue identified with Coccinelle.
>>
>> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index 52f5c5a2ed64..7e9a62ad56e8 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -1049,12 +1049,10 @@ static void debugfs_create_files(void *data)
>>   	};
>>   	int i;
>>   
>> -	dsi->debugfs_vpg = kmalloc(sizeof(debugfs), GFP_KERNEL);
>> +	dsi->debugfs_vpg = kmemdup(debugfs, sizeof(debugfs), GFP_KERNEL);
>>   	if (!dsi->debugfs_vpg)
>>   		return;
>>   
>> -	memcpy(dsi->debugfs_vpg, debugfs, sizeof(debugfs));
>> -
>>   	for (i = 0; i < ARRAY_SIZE(debugfs); i++)
>>   		debugfs_create_file(dsi->debugfs_vpg[i].name, 0644,
>>   				    dsi->debugfs, &dsi->debugfs_vpg[i],
>>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Thanks,
> Neil

