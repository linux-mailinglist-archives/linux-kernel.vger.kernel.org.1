Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41EF272F87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgIUQ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgIUQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:57:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F182CC061755;
        Mon, 21 Sep 2020 09:57:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so13552348wrs.5;
        Mon, 21 Sep 2020 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZWcf4o4W/TOv02FhPktF5h5j0wPcjqCWyDZq9Vq+FA8=;
        b=PavsxdAxnj5EY7eOcXgws5hp/IHUzisL6s5FVlkAlTAz7hFJKxs4Rn/JbgtQpokajP
         qseF1tQVTU5X2vzaQp6HpkAYl/K2AdP2umd4h5QhaAOlZliEmxULr5YQ1QNsDb0dRR4B
         PdkysKpn1weOfGqywDJF2vs7ffH4bcmeMc9B9xZXei1oWclRRTqaz4ZefyOZpAYmn1Ma
         vRxloyoVsJMgxslZeGE91+YyYIgfeVKHUBafTU/N72Ll4rC0zfrZSuF5nBR6v3JLGuy/
         0dw4jlSiSigUZC2NKK5HzlDkdyESK3DDkPuxnR52T30hXzmqrnrzuKBAnFsuN/gvGwjV
         pJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZWcf4o4W/TOv02FhPktF5h5j0wPcjqCWyDZq9Vq+FA8=;
        b=R61XYwyLs1To6Z7g8TmLs5uiw6ID+ZA5PRav89cZfRvdbRLM16Uo8JL5sLeWzyzFcd
         JiI8Zce289n+NbuHiBaDzi1Vujewq6Xw9rRT0POIGWjr75pmmF0UpB0JqeIH8m3+zoAv
         tsS16SRrIoSDIhGa1VE8wflLdUfBc9pJ/uqJ0wqOHLVA1x5ULtvLewKFRFMAZKj1ca7s
         zj8q14hqjbWOUGHmsR2BhxBUn4QNjsWPW0MxQDulSwQAGJ/paQZDsb+hTZ1XkpYqZUN2
         IGJ/VZ7HPx4sBtO4hprYFtc7BDx5bM0x9r1I5CYM/7n6XfR5HEPZjICj5qHajc7rSM6H
         i0lg==
X-Gm-Message-State: AOAM530c8Ib8CbmVc7d+wDzKeFb3zqHzrKN99iV/AjojgQDRA9DOeyvl
        aMwFPnq7qaR2ss6+iplK3bbwY4ADBDq/0g==
X-Google-Smtp-Source: ABdhPJzKzzHC71tc+e4rMjMCqpM3RWQL8J4eOkU2ha/2M88VX+RLT58y9NsE2KF6YUwCiXyeOgjX5w==
X-Received: by 2002:adf:92c2:: with SMTP id 60mr794619wrn.220.1600707468130;
        Mon, 21 Sep 2020 09:57:48 -0700 (PDT)
Received: from mamamia.internal (a89-183-108-204.net-htp.de. [89.183.108.204])
        by smtp.gmail.com with ESMTPSA id v17sm23222428wrc.23.2020.09.21.09.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:57:47 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Get rid of duplicate
 serial aliases
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200921164830.499548-1-a.heider@gmail.com>
 <20200921165357.yvajlsb6cjojbqqc@pali>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <670c25da-9a3a-9d67-dcc6-bd839235574a@gmail.com>
Date:   Mon, 21 Sep 2020 18:57:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200921165357.yvajlsb6cjojbqqc@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2020 18:53, Pali Rohár wrote:
> On Monday 21 September 2020 18:48:30 Andre Heider wrote:
>> The included armada-372x.dtsi already defines these two aliases.
> 
> Where? I do not see it in that file:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/marvell/armada-372x.dtsi

Oh sorry, it's in armada-37xx.dtsi:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/marvell/armada-37xx.dtsi#n20

> 
>>
>> Signed-off-by: Andre Heider <a.heider@gmail.com>
>> ---
>>
>> This goes on top of Pali's patch:
>> "arm64: dts: marvell: espressobin: Add ethernet switch aliases"
>>
>> The resulting .dtb files are the same.
>>
>>   arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
>> index 0775c16e0ec8..3169a820558f 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
>> @@ -17,8 +17,6 @@ aliases {
>>   		ethernet1 = &switch0port1;
>>   		ethernet2 = &switch0port2;
>>   		ethernet3 = &switch0port3;
>> -		serial0 = &uart0;
>> -		serial1 = &uart1;
>>   	};
>>   
>>   	chosen {
>> -- 
>> 2.28.0
>>

