Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64EC292567
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgJSKSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbgJSKSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:18:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD7C0613CE;
        Mon, 19 Oct 2020 03:18:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so9744249wmf.0;
        Mon, 19 Oct 2020 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jyCSS4cTjPFXhl4/RUNaCmks9VNBA8VC25KTtXeVMY0=;
        b=b6aRVscPivqUvHF5pqyiuMVkb6+/IO/I9zVsN6PZjZkK4RkcDU7aQoAbUfCMO6qYog
         1pF3mV+Rde3esTbTtWZc+dQ3MAPvES+jW7BAvYOWTXShCiToogyro7bEIH5P2W29c0Qg
         OFvRDzfKPzmVmUyWdvktMahSoQdfcaOVe34sutg1R5KTKI0hbtB10GXB4iMp0bflchCF
         SpwueeiUcR62Zl1TYIGdjqw6iJT19e9rDo2L7qKdPx27rDLMYfaYT0TyAE5Djjsp5M41
         MZNSOD1Qq8rBlmHgLp7HCMM4co6mOC4caTcL8mOI5DFkZrljIOWwJGdrRxcVFSqdxYMy
         m7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jyCSS4cTjPFXhl4/RUNaCmks9VNBA8VC25KTtXeVMY0=;
        b=ClLeJG5ub8k5DFz+vPWZ1F1g2feXKnGTIvvpEP+Arx71XexTNCH9q/mNJE6x7uTVJj
         tLgDKIJA5jYT/RRlVy2CLJ3TurFLT/BuUlbEjRWF0H03i8TXnhtyzYtivomlBOLd4+E0
         v4ym4f03m7yzFtrS42zDLXyDH58xk8Gf0FIvEL8X5OXu/jEfUzbtW4fC6XdCw0Nq/RjC
         IhdaEYe+OrG9tjJRh1YnZ228O2QqZ9Tnn4MlwmdzXza9vAeFxFq03HIyx3/kYaZE08JN
         KFSal0Fai29+IlmpWNjKYggTRL1ypeuFbzy8PMK42i6ec1lY9A4hiGgItE2+CGS20Zfy
         bQDQ==
X-Gm-Message-State: AOAM532S8/cBrkoKubzwkpJBDwC2jBVFXCH+5KCSUQJANk23HpIVw7vk
        Y1iwfng/UrJOzN60uhlL6wI=
X-Google-Smtp-Source: ABdhPJxqh0JBjgMiNMQsM5zfGmfBmaq0GMxI6SFeha4IKb3awYX27ltJlsnL97exdlDE3lr78UaG7w==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr16006756wml.99.1603102717032;
        Mon, 19 Oct 2020 03:18:37 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id o3sm17317744wru.15.2020.10.19.03.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 03:18:36 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: mailbox: mtk-gce: fix incorrect mbox-cells
 value
To:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     dennis-yc.hsieh@mediatek.com, ck.hu@mediatek.com,
        bibby.hsieh@mediatek.com, jaswinder.singh@linaro.org
References: <20201018193016.3339045-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <19590d90-978d-0b03-af79-fd8d7a7f1408@gmail.com>
Date:   Mon, 19 Oct 2020 12:18:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201018193016.3339045-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/10/2020 21:30, Fabien Parent wrote:
> As the binding documentation says, #mbox-cells must have a value of 2,
> but the example use a value 3. The MT8173 device tree correctly use
> mbox-cells = <2>. This commit fixes the example.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---

Fixes: 19d8e335d58a ("dt-binding: gce: remove atomic_exec in mboxes property")

With that:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> index cf48cd806e00..7771ecaac586 100644
> --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> @@ -47,7 +47,7 @@ Example:
>   		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
>   		clocks = <&infracfg CLK_INFRA_GCE>;
>   		clock-names = "gce";
> -		#mbox-cells = <3>;
> +		#mbox-cells = <2>;
>   	};
>   
>   Example for a client device:
> 
