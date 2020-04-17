Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E461ADD3D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgDQMRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 08:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgDQMRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:17:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3832C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:17:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so2710926wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nj0KcmTNBEnCeGICVn8Q9U3854Hf8PCp4ALTufY7lqQ=;
        b=A26EpKW11XDtjvoa9KoX6PSI3LIarHh0IZddp9CCaFZzzrXUp2Krsgv0owsMCnj6ZI
         Z/LaR5MMhguYrG/wkAbGTlOxgLpbpxHBw3DrdTazmSdgKNhsRZCgnrETjbu2Rc/wZKD4
         LlLEBgA52DFYnhooJGjXMP8OiZKTjcURsVZB17/cR89j+vgQ/b0ZBGgWgg2u1Qb/UTZC
         L5t7VPqgWn4c4RR2j3AuKz+suEnGIbK42PcnG4dVe2A59UxX11WuULez5HqHTH/OlcYl
         3oj3AAXXk9BmcCA66v8XHhhykvdrp+ilS1OLEj86C8ym5og9m39LoWjmitMp9zabes1q
         ZLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nj0KcmTNBEnCeGICVn8Q9U3854Hf8PCp4ALTufY7lqQ=;
        b=eLJPLbS2pA0swCbURT5tS9I0aK8cXxMeAehqSyxN7nCLD2qh4LIPiv1ecEuFNglJBV
         X5KbFICt14XumlVNI3IlsK4SUy82nqrLBtZ+2puyvklYMu2RKLqQf8r82P6joCYuynqv
         zqgFgXveRs3bZUCPNZ+uB2D8u6J0gMWoziZ2uKYVPFgGu26ZKDFWFV5MljGxIUpQHiNh
         ay3HDoysKgoCWuU93VgLQrcuGudQD088qdPROlNrJ3ruyGBqZVOdzz9mInwzXlJdP2fc
         Zk6nqMMRLDHDCfRU5Mb0JtcKj3MAuYquGQmMCZcHXEU9nxUvnrqN2IT8SamQr26DnO4B
         b5XA==
X-Gm-Message-State: AGi0PuaZzDEytseP6b79UsWq42wT1dvr9Ci6igc5EGwZqnXGPwKtJ/Y3
        YDCRdNXNA2MjSsUvF0YMnyCLFQ==
X-Google-Smtp-Source: APiQypL39Wua+Wbmh6BMhWPY+2/P7Aev5UeBmGQVLI2broFdDiYHt270V8upcsc6wwxwPDFwlILjJQ==
X-Received: by 2002:a1c:ba09:: with SMTP id k9mr3064222wmf.176.1587125853280;
        Fri, 17 Apr 2020 05:17:33 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 60sm1647331wrr.7.2020.04.17.05.17.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 05:17:32 -0700 (PDT)
Subject: Re: [PATCH] nvmem: imx-ocotp: Improve logic to save many code lines
To:     Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1584604540-10097-1-git-send-email-Anson.Huang@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9794030e-a3f9-079a-02a0-8cee3e3c13b9@linaro.org>
Date:   Fri, 17 Apr 2020 13:17:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1584604540-10097-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/03/2020 07:55, Anson Huang wrote:
> Several logic improvements to save many code lines:
> 
>   - no need to use goto;
>   - no need to assign return value;
>   - combine different conditions of return value into one line.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied thanks,
--srini
> ---
>   drivers/nvmem/imx-ocotp.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index 50bea2a..7a1ebd6 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -196,7 +196,6 @@ static int imx_ocotp_read(void *context, unsigned int offset,
>   		if (*(buf - 1) == IMX_OCOTP_READ_LOCKED_VAL)
>   			imx_ocotp_clr_err_if_set(priv);
>   	}
> -	ret = 0;
>   
>   read_end:
>   	clk_disable_unprepare(priv->clk);
> @@ -435,17 +434,13 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
>   	       priv->base + IMX_OCOTP_ADDR_CTRL_SET);
>   	ret = imx_ocotp_wait_for_busy(priv,
>   				      priv->params->ctrl.bm_rel_shadows);
> -	if (ret < 0) {
> +	if (ret < 0)
>   		dev_err(priv->dev, "timeout during shadow register reload\n");
> -		goto write_end;
> -	}
>   
>   write_end:
>   	clk_disable_unprepare(priv->clk);
>   	mutex_unlock(&ocotp_mutex);
> -	if (ret < 0)
> -		return ret;
> -	return bytes;
> +	return ret < 0 ? ret : bytes;
>   }
>   
>   static struct nvmem_config imx_ocotp_nvmem_config = {
> 
