Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC8029905E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782896AbgJZPBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:01:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44159 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782665AbgJZPBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:01:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id t9so12957220wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U97g4DPk37yBTbr4sK3d+QCMl4K1OpjO58zJeloILjc=;
        b=uXgwrHyoB/oVh3VPXCniZeS4cme8VQiCH4mJUmf6fVFsiJN8mC6nzwHz7tC7EytqYj
         CYZOV4+jlcL+Lnwom/Y/MzEXEyGvOsAk4/W2ZB7rIus+ZQdJ/Ks2SNbvhRK8F87shls9
         Lw4JZBQbl9pfHwKgQuaAMIA5khCEmy7TAyQgZNi9hgsm4wgru7pbE447D3lSzDmF+s2t
         k5XtQtIjhJ8JiyGsOK5VdEcFmVWzcEt4Y38gT3sbizazWSA+54IJEjmEYhi+NeVYt9no
         xKIJoIFKtET6z4mPQj08LxJguvP1H5cqHgwChbub9D5MfAWYZ6nPUHuQp25epRa/HGhk
         wLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U97g4DPk37yBTbr4sK3d+QCMl4K1OpjO58zJeloILjc=;
        b=k6g7K+z/62dg8OawnuFAu3Uy274ZIdP7BzFdPfRC414asS0aTUF6IlOAjF9l7qDYr/
         cQ6NYVmuA5+ih+98YEJngIKC9GLWty4aApZgFubjKEFhcaPSXiDAJ1PEBgbsOzfVOuiV
         wUO0z2SlcuwRZlu1CPawbsm/F4jOIf/2sn5+R1w+aaF4n9V0/uPNT0tfXDkpTu77OZub
         Vpy3SquaPSNNEc3LbMdaTx5kWlhtv5MN11xxcqQgpyafCXPj3DhEtVTrss31bAvNV9GW
         CLcmgGj9bI5UYX4N1SWHPNPPbbBApfxUYv6u3ZUeqcL08V9t041gfFUuoddALC3/KLkJ
         XPXA==
X-Gm-Message-State: AOAM530OMl5v06JO+Xp1PBn3wH3zjLyc9DH78/apRYwSWR0o5Mbu3WXK
        EuX3zSs35wMXL9M2zgN5zQB/mg==
X-Google-Smtp-Source: ABdhPJwwb/Bivg+EAjiajD6Nc7JOqnZTCvtVkr5/QG5ozwvdx65HSpznlKuBPwU9mfAMsDDOYJjP8g==
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr18073433wrm.79.1603724496207;
        Mon, 26 Oct 2020 08:01:36 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id w11sm22317715wrs.26.2020.10.26.08.01.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 08:01:35 -0700 (PDT)
Subject: Re: [PATCH] Asoc: qcom: lpass-sc7180: Fix MI2S bitwidth field bit
 positions
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>
References: <1603373219-19374-1-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <335f1d55-8a85-8501-fd69-0397f44e21af@linaro.org>
Date:   Mon, 26 Oct 2020 15:01:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1603373219-19374-1-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/10/2020 14:26, Srinivasa Rao Mandadapu wrote:
> From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> 
> Update SC7180 lpass_variant structure with proper I2S bitwidth
> field bit positions, as bitwidth denotes 0 to 1 bits,
> but previously used only 0 bit.
> 
> Fixes: commit cba62c8b49bead ("Merge series "ASoC: qcom: Add support for SC7180 lpass variant" from Rohit kumar <rohitkr@codeaurora.org>:")
this should be 12 chars long, for this particular fix it should be!

Fixes: 24caf8d9eb108 ("ASoC: qcom: lpass-sc7180: Add platform driver for 
lpass audio")
> 

No empty line after Fixes tag!


> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>   sound/soc/qcom/lpass-sc7180.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
> index c6292f9e..bc998d5 100644
> --- a/sound/soc/qcom/lpass-sc7180.c
> +++ b/sound/soc/qcom/lpass-sc7180.c
> @@ -188,7 +188,7 @@ static struct lpass_variant sc7180_data = {
>   	.micmode		= REG_FIELD_ID(0x1000, 4, 8, 3, 0x1000),
>   	.micmono		= REG_FIELD_ID(0x1000, 3, 3, 3, 0x1000),
>   	.wssrc			= REG_FIELD_ID(0x1000, 2, 2, 3, 0x1000),
> -	.bitwidth		= REG_FIELD_ID(0x1000, 0, 0, 3, 0x1000),
> +	.bitwidth		= REG_FIELD_ID(0x1000, 0, 1, 3, 0x1000),
>   
>   	.rdma_dyncclk		= REG_FIELD_ID(0xC000, 21, 21, 5, 0x1000),
>   	.rdma_bursten		= REG_FIELD_ID(0xC000, 20, 20, 5, 0x1000),
> 
--srini
