Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08FB2AC23E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbgKIR3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731708AbgKIR2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:28:48 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E68C0613CF;
        Mon,  9 Nov 2020 09:28:47 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id e27so13562712lfn.7;
        Mon, 09 Nov 2020 09:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oob/x6TgbSkIzBqStoRcBvlxDjkg5j4q3OalbOiwR7k=;
        b=nwt8yOV2OTG2ahjQwYOnUEq41venCHBjAIe1HrKvZtbjCkQRX3EFt+ZZHCrKKUUDtT
         vbrnhoIbeKSkewOHy7hSGjVR7EZlHvqkid/pllq1f5Ho1vG4R8A/ld0N32CtbLtKJfKB
         waziUWOsXQpXJuPgGFa65MTkG+FuzU0b3Ck3rqvX13B843l2PenlCwwMMBD6vqVnrwyr
         5S+Gb6vPBie3zBJXdpd5mZ1YXfCRFLAHIsospYWuyolMt2PZbDLzXwGF4Oe7/2DTEZ9F
         JY94p9nJ8mt/VG2IN8/woawnytMF5cIF9KxasuQenOeMe0qmZsCOY1Os06OIYJjpc9IN
         fGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oob/x6TgbSkIzBqStoRcBvlxDjkg5j4q3OalbOiwR7k=;
        b=hfpy69ukjs9Zcwgtz+n4D9kKcM9Jy9pCSn7ZcHpCRKcvN6XFK9BzTc34lrngKiaa8c
         zqPdjYTJhuX6+AujZrs+KyMADuonp8yB+6SOzD5J8lhSCylnMCFssKsyC7ZmVbx00tt2
         NswEFFexMGDGGbd+Oc7Ap74U3Ko/Tt3GOmVF70xc6FFwW/QdAewDxOLPlR2SiNEwMqud
         o/62jwTRyzWTm1IFAPF+KwR1J3tTF0WCtGrX03CVxJqGn5xJBjznnNolODWwUIl+OlO0
         Kg/7JEHa+hl0q+iHjz71KeqpBlL/uxz06YcSxMjIyJRumn3ZlChurLnB6Gw+/G1JIAjc
         cisA==
X-Gm-Message-State: AOAM532Z/hcs88jaUnOO0rIwRa5KpUHXAK2JwQcW0idxtzzqYSK2Ypgv
        n/dSwealJ9mkWmAykeMywWG5ET89+ec=
X-Google-Smtp-Source: ABdhPJzPG+Hasa7/HT5fpa2KLVVDf2BZ4VQ1pJwjqvsImle0uqW7VevhyqTA41Rp1oSUY3tyjrwo7g==
X-Received: by 2002:a19:90b:: with SMTP id 11mr6487389lfj.316.1604942926195;
        Mon, 09 Nov 2020 09:28:46 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id j64sm299533lfd.104.2020.11.09.09.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 09:28:45 -0800 (PST)
Subject: Re: [PATCH v2] ARM: dts: BCM5301X: Linksys EA9500 add fixed
 partitions
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     florian.fainelli@broadcom.com, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <e64d76cc-90bb-5b54-04de-fde21542e4fe@gmail.com>
 <20201101200804.2460-1-npcomplete13@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <b69adfa6-c867-816a-1f1d-d67fbfbd5f42@gmail.com>
Date:   Mon, 9 Nov 2020 18:28:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201101200804.2460-1-npcomplete13@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.2020 21:08, Vivek Unune wrote:
> This router has dual paritions to store trx firmware image and
> dual partitions for nvram. The second one in each of these cases acts
> as a backup store.

I'm quite sure CFE is supposed to flash new firmware to the backup
partition and then mark it as main one. The old firmware partition becomes a
new backup then.

That means you need to check which partition bootloader used to handle
partitioning properly.


> +		partition@200000 {
> +			label = "firmware";
> +			reg = <0x0200000 0x01D00000>;
> +			compatible = "brcm,trx";
> +		};
> +
> +		partition@1F00000 {
> +			label = "failsafe";
> +			reg = <0x01F00000 0x01D00000>;
> +			read-only;
> +		};

Here you assume CFE always boots from the first firmware partition.

Unless EA9500 CFE does sth stupid it seems like a 50% - 50% guess.
