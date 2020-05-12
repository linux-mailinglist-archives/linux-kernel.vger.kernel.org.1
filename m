Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0561CFE29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 21:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgELTUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 15:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:20:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C176C061A0C;
        Tue, 12 May 2020 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Je0OOI8W2XkKcoCxSyh+zMTlf+5a9Fs/Gjgp620o+BE=; b=ht5EkaJzpB5XXcEZM05NDoEYVf
        x5vYKSLqFbuLN1zYCz2qUThj0DifHdUb6cIaES4ZJ+Dg0hFTz2sP0ZEoszCSJm0Bo9LtgQOVWVaCc
        /YEI7prZF1Q4TKVAveydU+Ij8elXaWyn3IjPGRbL2xO53XpJlzCmAzKg+uyu7qmrZ+dNRkTviyJ02
        rjY9wrzAoTQOTQCW5vUsZTkiprVqEoRWhVXvrQemd7Ln5BY5rgjzvquuJPtxALi4cuc6b3ZUn9S8y
        IUwW+ypEVPZJxB410UuRQ4CbSxGyBMBzMz1vhhm99pdWVLSxy9TvFStTQLWtml0xR5feWhG+dZdss
        9P1oDHYw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYaSS-0001Kw-Sh; Tue, 12 May 2020 19:20:52 +0000
Subject: Re: [RFC v1 2/3] drivers: nvmem: Add driver for QTI qfprom-efuse
 support
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ceb55c31-ae49-213a-6d12-7c55cb78b60d@infradead.org>
Date:   Tue, 12 May 2020 12:20:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589307480-27508-3-git-send-email-rbokka@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/20 11:17 AM, Ravi Kumar Bokka wrote:
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index d7b7f6d..c9345c5 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -121,6 +121,16 @@ config QCOM_QFPROM
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nvmem_qfprom.
>  
> +config QTI_QFPROM_EFUSE
> +	tristate "QTI_QFPROM_EFUSE Support"
> +	depends on HAS_IOMEM
> +	help
> +	  Say y here to enable QFPROM-Efuse support. This driver provides access

	                                                                  access to

> +          QTI qfprom efuse via nvmem interface.
> +
> +          This driver can also be built as a module. If so, the module
> +          will be called nvmem_qfprom-efuse.

The last 3 non-blank lines should be indented with one tab + 2 spaces
instead of lots of spaces.

> +
>  config NVMEM_SPMI_SDAM
>  	tristate "SPMI SDAM Support"
>  	depends on SPMI


-- 
~Randy

