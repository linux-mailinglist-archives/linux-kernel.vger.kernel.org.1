Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5472F8CAB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhAPJhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbhAPJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:37:01 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DA7C061757;
        Sat, 16 Jan 2021 01:36:20 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id p13so13040140ljg.2;
        Sat, 16 Jan 2021 01:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y1/w7su/UpjLoYG1ov/jnfBG4ouAVU7asO4b1yzoDl0=;
        b=GzbCj2MkywgL71ot3WCGYBGB9GTJISO1zj45D7yh6gkVVXYTr5IJdtSo8I119K/BzP
         45hqwF2CzF1d/NiA3fc9jW0/a4m4fivs1Q9jN0b+8+olnfDAeTzYoSR6g8lZUU0qSQQ+
         s9xK3wR/dWkXi6eJD6z7PA9aMnYvLMCorhnIj9SrvdDvCODaGHDtpeNcZiP4NABwDZhG
         LspKP+MldbY72Mcd6NtW+LHof8VggrvpfkxTlk+DFZIGNxxo/HuXSrHMCZ28a6K81dp/
         krC/427ADEdiJkD5y1BnwmbmiWh0Uxb3dROq5HFCa9kZA5juDI/f7CBJl4Q4BQetY6pm
         /+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Y1/w7su/UpjLoYG1ov/jnfBG4ouAVU7asO4b1yzoDl0=;
        b=VoP4ZCtXkV5anYq8kFyBN3mMVto5F9Vt7uX/dlEA4FhotEgnr0eyk1ZWhmrmJJumJv
         x0dCrtuVQOzJ9XMhQcZ7LCUVN8H3ZnefpfKpfccjf5jVIxgCIX4nZHOQggBOcmSkuFCv
         dxJ1SsVDkRyLqPne8JbVnN/oDqPxi7rZf2JJCburKr2DqJEVni1a9Vig+cvrD/TcFtld
         HBnWhpVFuzQ8/keXYqsZBJVts8UeGGoua5rLsPgnKPVqiPHcwJERHPHIqMyi1JpmRse+
         AMCrXHU58L7BcF6x189M6QPjCzluwND2INb9r/0w48F99KspL+C9flGozKysYzJYCSPR
         nNyA==
X-Gm-Message-State: AOAM531YzSoMjDovH0E8FBU02iqth+N3K0VwFimzd5nRjjR56DsLryC/
        MSagCDWufm6p2HuHO1Pg5hDQqJc91Kf1oA==
X-Google-Smtp-Source: ABdhPJyFgou3lwXctU4wQyITVlWwduN6ltASZdsQdknXs6mA3xX47n+j5xBShvtp5O9A38fjOwXmuA==
X-Received: by 2002:a2e:810c:: with SMTP id d12mr6634806ljg.400.1610789778971;
        Sat, 16 Jan 2021 01:36:18 -0800 (PST)
Received: from [192.168.1.100] ([178.176.75.157])
        by smtp.gmail.com with ESMTPSA id t9sm1212989lff.45.2021.01.16.01.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 01:36:18 -0800 (PST)
Subject: Re: [PATCH next 11/15] arm64: dts: mediatek: mt7622: harmonize node
 names and compatibles
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
 <20210116090656.11752-11-chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <8f859d54-f9f8-d7c9-db66-89860124b539@gmail.com>
Date:   Sat, 16 Jan 2021 12:36:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116090656.11752-11-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 16.01.2021 12:06, Chunfeng Yun wrote:

> This is used to fix dtbs_check warning
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 5b9ec032ce8d..4cfa09b0ca3c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -740,8 +740,8 @@
>   		status = "disabled";
>   	};
>   
> -	u3phy: usb-phy@1a0c4000 {
> -		compatible = "mediatek,mt7622-u3phy",
> +	u3phy: t-phy@1a0c4000 {

    What is "t-phy"? Perhaps you should have used just "phy" here...

> +		compatible = "mediatek,mt7622-tphy",
>   			     "mediatek,generic-tphy-v1";
>   		reg = <0 0x1a0c4000 0 0x700>;
>   		#address-cells = <2>;
> @@ -875,8 +875,9 @@
>   		status = "disabled";
>   	};
>   
> -	sata_phy: sata-phy@1a243000 {
> -		compatible = "mediatek,generic-tphy-v1";
> +	sata_phy: t-phy@1a243000 {

    Same here...

> +		compatible = "mediatek,mt7622-tphy",
> +			     "mediatek,generic-tphy-v1";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		ranges;

MBR, Sergei
