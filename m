Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D459029E215
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbgJ2CFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgJ1ViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:38:08 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C5C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:38:08 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id f1so245758oov.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+XiyYcEFSv40qmGk78jL7y009Wmf2FvqP17FLO0o/wQ=;
        b=S/EeI5L5iAm7mA8nFOB8+fUM0G/jJrP+3a8lJEOvcn/KPF20Ut2xnUHnE6YtHhm5qf
         68rA3FoD3tGHI1O5h37n4AdrDUFnHG8vciVcUz6pK0xlsMhjfCIKNKnDd9Gei3hMkYv0
         7q6zQwD2pXp6tVZb4J6ieDqgGAB+l7vQUfiM9H2t0NPgKwMTEYXULF/4vKrKewrVzN5i
         cCRiO6JBIWYcDuPj96QowHAxkNmd9t5j+V7gpngfEkCCexC5lG8w4cu9KBeoerQoAZed
         fyTzQ+I4md8wSyL73/OBkeU3RcBiLN9QuDALxnTy3nONHMpeAcDi77n0b785ivDcM+KK
         Ztsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+XiyYcEFSv40qmGk78jL7y009Wmf2FvqP17FLO0o/wQ=;
        b=M48MUKTPTgrondKg82NtMAq5IUIubBypTq2sX7D3xAYd6snI5QQQb+9QGh7sPgVeo8
         AxI9CUFjrkjFWo7I/a1A/DPCVrkFgv4e3eq9TPlWmRQf9QbXkHa9Olga6i3NrLabSU4/
         QP8qUO2OGZUq9Neo4XJmCn4pZtJ/JUdqIySqlpjS5aCUPJdk41AFUf3QDvzW9eSYZbdD
         BEhzbYTlaZFZqnX9BVywNqXeC1NVnRmAJg9R944MIqL5SorTnKp7NxA4z16/ylGqZJ6U
         4La7avfefjmrvt6HT04CHBV6PtUcpRb94ruFbHC6wMXauJZ18q0ccgM+PBFObCZYsBw8
         c6vQ==
X-Gm-Message-State: AOAM533Yzd1fYJ+OjysRN/auT4BoaL28s5YOtQnZ8gv59GWAXWRWLvIP
        dr71wW3/NjXrYQsvGhnmXmuVmGyTue0M5g==
X-Google-Smtp-Source: ABdhPJyOEsX2NrkArkQ+lhEF+JTD42MIssKbrKwgoF/zEzysvAYajpmNlBFC5Ml9f1fcMV7VXNEE5Q==
X-Received: by 2002:a4a:d0a4:: with SMTP id t4mr6387691oor.21.1603902959220;
        Wed, 28 Oct 2020 09:35:59 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d145sm2810205oob.37.2020.10.28.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 09:35:58 -0700 (PDT)
Date:   Wed, 28 Oct 2020 11:35:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jeevan Shriram <jshriram@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add SDX55 pincontrol driver
Message-ID: <20201028163556.GD3151@builder.lan>
References: <20201028083017.611810-1-vkoul@kernel.org>
 <20201028083017.611810-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028083017.611810-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28 Oct 03:30 CDT 2020, Vinod Koul wrote:
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdx55.c b/drivers/pinctrl/qcom/pinctrl-sdx55.c
[..]
> +static const struct msm_function sdx55_functions[] = {
[..]
> +	FUNCTION(qdss_gpio),
> +	FUNCTION(qdss_gpio0),
> +	FUNCTION(qdss_gpio1),
> +	FUNCTION(qdss_gpio2),
> +	FUNCTION(qdss_gpio3),
> +	FUNCTION(qdss_gpio4),
> +	FUNCTION(qdss_gpio5),
> +	FUNCTION(qdss_gpio6),
> +	FUNCTION(qdss_gpio7),
> +	FUNCTION(qdss_gpio8),
> +	FUNCTION(qdss_gpio9),
> +	FUNCTION(qdss_gpio10),
> +	FUNCTION(qdss_gpio11),
> +	FUNCTION(qdss_gpio12),
> +	FUNCTION(qdss_gpio13),
> +	FUNCTION(qdss_gpio14),
> +	FUNCTION(qdss_gpio15),

As there are no overlaps within pingroups you can keep qdss_gpio as a
single function.

> +	FUNCTION(qdss_stm0),
> +	FUNCTION(qdss_stm1),
> +	FUNCTION(qdss_stm2),
> +	FUNCTION(qdss_stm3),
> +	FUNCTION(qdss_stm4),
> +	FUNCTION(qdss_stm5),
> +	FUNCTION(qdss_stm6),
> +	FUNCTION(qdss_stm7),
> +	FUNCTION(qdss_stm8),
> +	FUNCTION(qdss_stm9),
> +	FUNCTION(qdss_stm10),
> +	FUNCTION(qdss_stm11),
> +	FUNCTION(qdss_stm12),
> +	FUNCTION(qdss_stm13),
> +	FUNCTION(qdss_stm14),
> +	FUNCTION(qdss_stm15),
> +	FUNCTION(qdss_stm16),
> +	FUNCTION(qdss_stm17),
> +	FUNCTION(qdss_stm18),
> +	FUNCTION(qdss_stm19),
> +	FUNCTION(qdss_stm20),
> +	FUNCTION(qdss_stm21),
> +	FUNCTION(qdss_stm22),
> +	FUNCTION(qdss_stm23),
> +	FUNCTION(qdss_stm24),
> +	FUNCTION(qdss_stm25),
> +	FUNCTION(qdss_stm26),
> +	FUNCTION(qdss_stm27),
> +	FUNCTION(qdss_stm28),
> +	FUNCTION(qdss_stm29),
> +	FUNCTION(qdss_stm30),
> +	FUNCTION(qdss_stm31),

Ditto.

> +	FUNCTION(qlink0_en),
> +	FUNCTION(qlink0_req),
> +	FUNCTION(qlink0_wmss),
> +	FUNCTION(qlink1_en),
> +	FUNCTION(qlink1_req),
> +	FUNCTION(qlink1_wmss),
> +	FUNCTION(spmi_coex),
> +	FUNCTION(sec_mi2s),
> +	FUNCTION(spmi_vgi),
> +	FUNCTION(tgu_ch0),
> +	FUNCTION(uim1_clk),
> +	FUNCTION(uim1_data),
> +	FUNCTION(uim1_present),
> +	FUNCTION(uim1_reset),
> +	FUNCTION(uim2_clk),
> +	FUNCTION(uim2_data),
> +	FUNCTION(uim2_present),
> +	FUNCTION(uim2_reset),
> +	FUNCTION(usb2phy_ac),
> +	FUNCTION(vsense_trigger),
> +};
> +
> +/* Every pin is maintained as a single group, and missing or non-existing pin
> + * would be maintained as dummy group to synchronize pin group index with
> + * pin descriptor registered with pinctrl core.
> + * Clients would not be able to request these dummy pin groups.
> + */
> +static const struct msm_pingroup sdx55_groups[] = {
> +	[0] = PINGROUP(0, uim2_data, blsp_uart1, qdss_stm31, ebi0_wrcdc, _,
> +		       _, _, _, _),

Please break the 80 character suggestion and leave these unwrapped.

[..]
> +	[108] = UFS_RESET(ufs_reset, 0x0),

SDX55 doesn't have UFS support and I'm not able to find any UFS_RESET
register in the TLMM block. So I suspect this is a copy paste issue
somewhere.

PS. Don't forget to drop the macro, if we don't need it.

> +	[109] = SDC_PINGROUP(sdc1_rclk, 0x9a000, 15, 0),
> +	[110] = SDC_PINGROUP(sdc1_clk, 0x9a000, 13, 6),
> +	[111] = SDC_PINGROUP(sdc1_cmd, 0x9a000, 11, 3),
> +	[112] = SDC_PINGROUP(sdc1_data, 0x9a000, 9, 0),
> +};
> +
> +static const struct msm_pinctrl_soc_data sdx55_pinctrl = {
> +	.pins = sdx55_pins,
> +	.npins = ARRAY_SIZE(sdx55_pins),
> +	.functions = sdx55_functions,
> +	.nfunctions = ARRAY_SIZE(sdx55_functions),
> +	.groups = sdx55_groups,
> +	.ngroups = ARRAY_SIZE(sdx55_groups),
> +	.ngpios = 108,

If we had UFS_RESET, this should include it; i.e. be 109.

Regards,
Bjorn
