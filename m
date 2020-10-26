Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17D2298DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780093AbgJZNa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:30:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38267 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780085AbgJZNa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:30:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so6200203pfp.5;
        Mon, 26 Oct 2020 06:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YkjKo9oWrVaFN0yahiPkCAqHwIJlt1SlrfiQtPqwIuE=;
        b=IAy8cAXRo8R//R/3N+NMT9HM8GuS/OhPQu6ueiMLsiqZvvS8cNXti+S7QKGIKP4Hcq
         VSH4Bu6aWbyC56Dmb3pufmK5BzFK5UlUlmKpB7mHLDMs3kjweFSw6+A+y1RJcNP9/bCw
         hjyEve3XuJeXZNu0coqghGoMxX79+5wA8VWRtA61qCz2/1tGkY8oQyOmwrFc049qQofn
         93Y1XgAre3cRf4t31ARbXpooxca4ovykZsYkawQXpXzj7v8Mt/tXVs1BvwPwadt4fwob
         NKvDkpdcVZbgI67ruXNYLHX7K8qKKez9tvM7bPuhKDWQXTryesz99CUi7pCeQAykPZjl
         wZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YkjKo9oWrVaFN0yahiPkCAqHwIJlt1SlrfiQtPqwIuE=;
        b=oMmV5f7TFI+6YaXp4eiSwwXhQ9KcIwzeS3/k933S/rRQ3oIEwx+P6WDAi9Rjx50d05
         BjMeoYZsxIHPsjwTSRmQSGRpyxt+Bm2v2p6Lp1RKVylwQur0/GHl82iBU6E+xdlHGhA4
         BxiWFx16+wPZrtsXyRR5y+CyuGnwojFsQ8/aa60aCEUi+K+1S8/AQIVgpUOPxbnuAkRK
         FC1ZE9vbfcJFtjAEYWS1IGV2pvWrWWfwthztuxT6iJTLxd+T7+Ag6ctRpSfvJO8/ieLG
         seRD1XPdJ1ab60MCicaBqJ5wnGu6okM9i/vjJf9GIbzp3ddn4Qro/HhlwZzTDh+gn8/Z
         ZqTw==
X-Gm-Message-State: AOAM533RshCYoDBMbsTDlOG4sH6XD7hFj5XXPx0ePh7RX/EP4C8As9Qf
        eacxljyfOBGfKcFZxY1KnN0=
X-Google-Smtp-Source: ABdhPJxTVU1i9uGCV0MlnhnHnsyPv9NXhhENISU8hnmVtuSERf9XzhxFZ5Hzxl/6qSoFxKkZ1xTFvQ==
X-Received: by 2002:a63:e34a:: with SMTP id o10mr7165647pgj.129.1603719056200;
        Mon, 26 Oct 2020 06:30:56 -0700 (PDT)
Received: from [10.230.28.230] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 204sm11978526pfz.74.2020.10.26.06.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 06:30:55 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: BCM5301X: Linksys EA9500 add fixed partitions
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
References: <20201026131351.258296-1-npcomplete13@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e64d76cc-90bb-5b54-04de-fde21542e4fe@gmail.com>
Date:   Mon, 26 Oct 2020 06:30:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026131351.258296-1-npcomplete13@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2020 6:13 AM, Vivek Unune wrote:
> This router has dual paritions to store trx firmware image and
> dual partitions for nvram. The second one in each of these cases acts
> as a backup store.
> 
> When tested with OpenWrt, the default partition parser causes two issues:
> 
> 1. It labels both nvram partitions as nvram. In factory, second one is
> labeled devinfo.
> 2. It parses second trx image and tries to create second 'linux' partition
> and fails with - cannot create duplicate 'linux' partition. I've set this
> partition to read-only for now
> 
> The following patch works around both of these issues.
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> ---
>   .../boot/dts/bcm47094-linksys-panamera.dts    | 41 +++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> index 5d5930edfb9d..13da16c5de68 100644
> --- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> +++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> @@ -292,3 +292,44 @@ fixed-link {
>   &usb3_phy {
>   	status = "okay";
>   };
> +
> +&nandcs {
> +	partitions {
> +		compatible = "fixed-partitions";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		partition@0 {
> +			label = "boot";
> +			reg = <0x0000000 0x0080000>;
> +			read-only;
> +		};
> +
> +		partition@80000 {
> +			label = "nvram";
> +			reg = <0x080000 0x0100000>;
> +		};
> +
> +		partition@180000{
> +			label = "devinfo";
> +			reg = <0x0180000 0x080000>;
> +		};
> +
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
> +
> +		partition@0x5200000 {

You would need to remove the 0x from the hex number here.

> +			label = "brcmnand";

Not sure how useful naming this partition brcmnand is, can we find a 
better name for it?
-- 
Florian
