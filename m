Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091572ACB99
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 04:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbgKJDTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 22:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgKJDTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:19:34 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1150EC0613CF;
        Mon,  9 Nov 2020 19:19:34 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id r10so8920587pgb.10;
        Mon, 09 Nov 2020 19:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=joZ0UwTM2riPXx20HoPLv33hiAIzPPd4tHYUHsZneFE=;
        b=EIfee/lZh7v9ZQXbL+inP3xW76VtAffEOc3yh20gN53vyExmDKWhYLG4DXuFdxfQT7
         NJRuws7Z/RVVsvAUA+bDL7gmoYg/m8S9go8nbUvc/SrPeym8aYQpPytVKp74BT+TMSuN
         hY39ySJ5+6uzOi7NfP61rnNAW5r37YhKT85Y9+zxzfpUrxJBh7FFN7BRWRPa3QJ9FAXb
         8mm4mvflPFsJMLEYXKKqPWxLJLkqZ021u8Ygp3Zco+1Jcg6vP1pfNLi2H7WGmlVL5Nyo
         IrTNfF1hD/Gj6GIH96b5JImVYAyHl7RUxXzVhS9Q2xhRs4zzH5vvu/zvHmFca0DhZsl+
         Cw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=joZ0UwTM2riPXx20HoPLv33hiAIzPPd4tHYUHsZneFE=;
        b=q+Cr8zDWDQTctaMgyllhyDnuY/9S/LMkkog7juyTbyUqVQTnG+XH7WeJQf1tOfy2lW
         muBM9vYFMBCGslhMLmhD5imRAcvNrwEirVQ1Y7rg7rkq1rI0Nu9IqYhugflgt0vuwEb4
         XjAA+HyTnrp7h+4Y3R0/9fFlQl/2wVU9YQB6X1KxyfCYVOQ9Gsjivo8i69c5cEahU4DB
         Zm182T1CFA4Z8fELAG89NbQOuk5CjNVKjHr8oSwWappz9/4h7PbkzIvOmGILbxrjlXNB
         cmrOBdjdtEf8Bz0AYmx7uwcIVlkOudZvshRV0GHdBL0XfIWlLJiBHniZh3eirL8LFAEu
         /6uA==
X-Gm-Message-State: AOAM531fBd9OIqmUPxUT5+ubNh0k7uXRgvCdB99qEq9boppFoowEkf4y
        5HVao8gS8wqox4PB42x4KB1SNnZG6dg=
X-Google-Smtp-Source: ABdhPJzuUrAv1E9O3d0K4Th2pQCk4Jt/dk8nCn8MuALaWpuewUA+IpASgvZLhdM4DhGZp82y38UhQQ==
X-Received: by 2002:a17:90b:ec2:: with SMTP id gz2mr2592216pjb.211.1604978373169;
        Mon, 09 Nov 2020 19:19:33 -0800 (PST)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g4sm12201070pgu.81.2020.11.09.19.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 19:19:32 -0800 (PST)
Subject: Re: [PATCH v2 02/13] ARM: dts: mmp2-olpc-xo-1-75: Delete
 #address-cells from ssp3
To:     Lubomir Rintel <lkundrak@v3.sk>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200718205019.184927-1-lkundrak@v3.sk>
 <20200718205019.184927-3-lkundrak@v3.sk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a98683e3-c666-a308-9c67-b898134c13fe@gmail.com>
Date:   Mon, 9 Nov 2020 19:19:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20200718205019.184927-3-lkundrak@v3.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/2020 1:50 PM, Lubomir Rintel wrote:
> On the XO-1.75, this node represents a bus interface that operates in slave
> mode and thus is only able to accommodate a single subnode; no address
> cells are necessary.
> 
> The Documentation/devicetree/bindings/spi/spi-controller.yaml binding
> prefers that we drop the property instead of setting it to zero.
> 
> This fixes a DT validation error:
> 
>   arch/arm/boot/dts/mmp2-olpc-xo-1-75.dt.yaml: spi@d4037000:
>       { ... } is valid under each of {'required': ['spi-slave']},
>                                      {'required': ['#address-cells']}
> 
> We also need to drop #size-cells:
> 
>   arch/arm/boot/dts/mmp2-olpc-xo-1-75.dt.yaml: spi@d4037000:
>       '#address-cells' is a dependency of '#size-cells'
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

This patch causes the following warning to be issued when validating the
mmp2 DTS files against specific bindings:

arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge):
/soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge):
/soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2-olpc-xo-1-75.dt.yaml: Warning (spi_bus_reg):
Failed prerequisite 'spi_bus_bridge'

Is there a fix that we can apply to silence this warning? Thanks!
-- 
Florian
