Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F729A991
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898066AbgJ0K0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:26:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41972 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898046AbgJ0K0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:26:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id s9so1235296wro.8;
        Tue, 27 Oct 2020 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qLG8HT/Mlv9M4LmYodAr5CWZX0Y3ZAsGE5UGgEezEGg=;
        b=Iydivj8UDtVRIkriCxVC6L3hv7zmWqlgdUMcMIHoIjsadiHhjQs4D5YU4VfJyAdG4u
         t9q1CZ0+aOBCNjPXu+IZ/oztHDei5PK2gVBrAl5xMXEeozUVcUTAOUt4721mJPWRbmop
         UzvRRcJ+U4GaW6DlWZnljumnRTHroh5itrDOtvB9bIXP6VsXsqTI1BTYHYeV0IvUMQ3d
         5lFnES1ZvRfLONqO1GArQo3nBJkXtCbeciU+tsuuQNuZObEh4Qk7bCWyUV1yNsORG9XD
         61NLfQ4fdZOiee+7bXniRdDnHMGzPgrf7ydsrmbCXXrr+eT8Rzss2irjleqOzzACxTb8
         9FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLG8HT/Mlv9M4LmYodAr5CWZX0Y3ZAsGE5UGgEezEGg=;
        b=i1bKiYdWk4LsnJalBlSlN1EbvmG9WNm89jHB+YwCWdHPeFsXN+U4kJ6rloNBImR9L8
         z85OdZNozTqLOeDXMfjXT1yJPvkeDDToZ1srpUM+KjC0beJVb6ZGcls3ovndGGeV+LaG
         dFgvb2AhcBtV3FF4+Xqb7keGM0DH4/hVTlSii/FZdCLdIXA4HiSAHUnfA5lztAuNRUr1
         1coSZfEnWKntlusU48OD3wApUqgl+tdb8MTnEi1YC7VguHLVNUdWwXzMoFgAdP9YgOG/
         +uGad7GSMdItr3l7Z2cHI1L9AFqX46vY+uSyt2PMwzE2Qd/BGZlKr93/QtYyd8ssrOHP
         knDg==
X-Gm-Message-State: AOAM53027n/iE7h7ka9CLQr7iRpLFnApLKe51Anwn7Gp6hNDrmSKwr2P
        TWF7xe2MXV+DDYcXrOphY5k=
X-Google-Smtp-Source: ABdhPJyJS1diLzgQhtPIEDKUGQZ12t0ydx30T3gdaD6BkMglnZXU83UYALJGS1fnFYYJjEloEAjPPA==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr1947246wrs.406.1603794357330;
        Tue, 27 Oct 2020 03:25:57 -0700 (PDT)
Received: from ziggy.stardust ([213.195.117.206])
        by smtp.gmail.com with ESMTPSA id n83sm1362890wma.39.2020.10.27.03.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 03:25:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] soc: mediatek: pm-domains: Add default power off
 flag
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com
References: <1603370857-30646-1-git-send-email-weiyi.lu@mediatek.com>
 <1603370857-30646-3-git-send-email-weiyi.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <32fbc5c6-88e4-7cdc-2491-5226d819db37@gmail.com>
Date:   Tue, 27 Oct 2020 11:25:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1603370857-30646-3-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/10/2020 14:47, Weiyi Lu wrote:
> For some power domain, like conn on MT8192, it should be default OFF.
> Because the power on/off control relies the function of connectivity chip
> and its firmware. And if project choose other chip vendor solution,
> those necessary connectivity functions will not provided.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-pm-domains.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index b7ccf94..50a7ae1 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -24,6 +24,7 @@
>   #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
>   #define MTK_SCPD_FWAIT_SRAM		BIT(1)
>   #define MTK_SCPD_SRAM_ISO		BIT(2)
> +#define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
>   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>   
>   #define SPM_VDE_PWR_CON			0x0210
> @@ -506,17 +507,26 @@ static int scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node
>   	 * software.  The unused domains will be switched off during
>   	 * late_init time.
>   	 */
> -	ret = scpsys_power_on(&pd->genpd);
> -	if (ret < 0) {
> -		dev_err_probe(scpsys->dev, ret, "failed to power on domain %pOFN\n", node);
> -		goto err_unprepare_clocks;
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF)) {
> +		if (scpsys_domain_is_on(pd))
> +			dev_warn(scpsys->dev,
> +				 "A default off power domain %pOFN has been ON\n", node);
> +	} else {
> +		ret = scpsys_power_on(&pd->genpd);
> +		if (ret < 0) {
> +			dev_err_probe(scpsys->dev, ret, "failed to power on domain %pOFN\n", node);
> +			goto err_unprepare_clocks;
> +		}
>   	}
>   
>   	pd->genpd.name = node->name;
>   	pd->genpd.power_off = scpsys_power_off;
>   	pd->genpd.power_on = scpsys_power_on;
>   
> -	pm_genpd_init(&pd->genpd, NULL, false);
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
> +		pm_genpd_init(&pd->genpd, NULL, true);
> +	else
> +		pm_genpd_init(&pd->genpd, NULL, false);
>   
>   	scpsys->domains[id] = &pd->genpd;
>   	return 0;
> @@ -603,7 +613,8 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
>   			"failed to remove domain '%s' : %d - state may be inconsistent\n",
>   			pd->genpd.name, ret);
>   
> -	scpsys_power_off(&pd->genpd);
> +	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
> +		scpsys_power_off(&pd->genpd);

Is that really needed? Turning the domain off when it's already off shouldn't hurt.

Regards,
Matthias
