Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F30D2C6930
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbgK0QMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbgK0QMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:12:55 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A373C0613D1;
        Fri, 27 Nov 2020 08:12:54 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so6117931wrx.5;
        Fri, 27 Nov 2020 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eXqA66SSXSjOYL7nUJMPq8DdoGjGHwevZLW6WLAEElY=;
        b=N7gWS7x5A52K8T1zw0wAND5sZ/5XsYmmE0RCNZ2Wuy9ZUeZIIVoT/ZY2NeuhNfP7ux
         7Huzi2chLlyuA68tfuMVetfMpzQGD9t5WWNHEhOCaoQSyWhTkn1GqLUNT0BD6xeHy7Z2
         A6YRxpUCcPof9j+1WMCgyzySpnsVdfVqqITxfAzcrM0vuDI9pj3PJFiiZUacgaqk+Mgj
         YS1vaabEloZ8bf9ViOar13AYkzqjGv9PBIF1zkODv6FoKfRoxUXyxrdV1cULmcGl/LUi
         ZIFmBkp95BINqX82z5eRaNaSJ/kA6XpGi9vqLSKGSTijln/npRSAfzAv+bg1ZV7dK1rb
         nZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eXqA66SSXSjOYL7nUJMPq8DdoGjGHwevZLW6WLAEElY=;
        b=jcM4i4oew5qwCj6cVLRVbUXtPmRN64It0FXGESl5rtCvmdDFy4xjq79euFEe9JadcU
         nSisBXRXe9RX9l0QYM+hmtzDruP8aP05le1v4Q33BNwhcd02153xza7L2P5d+GRy4aSi
         emeIb8fWwKKyNTPbLR1j16q5Jj3y9XwBtd8GRHYfX736vd8zr0h+FXZwN4ylmGAmDD+z
         /mRz3zZaJ6QKy6YWlqVTuqNvCFe/DnpaGhLAIsmJas3s3PFChcHvJvDGdFJCviHFMFO6
         OKbDTEnBB1VjcW1IF42zkGH3RfybM2LAfDDs/0PhtF3tGITvvtYL6HlAiQ2NjFzJuT77
         1Pgw==
X-Gm-Message-State: AOAM533tZZhR26OYlt97+X/CWoC7KssDQ2lZKRjuNfSyBv4/k75KQf62
        j40ZWiA51+pgtKQ84ssh5ka/FH0JiWB+9Q==
X-Google-Smtp-Source: ABdhPJzp1q4bYCuJp9sGSOAEKbZTGkCjwZtlbkOLd/Quw+3RcvdAkkCqfaO9Of2YoaLukCQ8MNcbkA==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr11489578wrv.243.1606493573151;
        Fri, 27 Nov 2020 08:12:53 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id z19sm13971840wmk.12.2020.11.27.08.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 08:12:52 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: assign mediatek headers to Mediatek SoC
 support
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201103060733.25729-1-lukas.bulwahn@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9bce8087-b734-d6bd-c21a-3e9701cc1d94@gmail.com>
Date:   Fri, 27 Nov 2020 17:12:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201103060733.25729-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/2020 07:07, Lukas Bulwahn wrote:
> ./include/soc/mediatek/smi.h and ./include/linux/soc/mediatek/infracfg.h
> are currently not assigned to a specific section in MAINTAINERS.
> 
> ./include/soc/mediatek/smi.h is the header file for definitions in
> ./drivers/memory/mtk-smi.c, which is assigned to the section ARM/Mediatek
> SoC support in MAINTAINERS.
> 
> ./include/linux/soc/mediatek/infracfg.h is the header file for definitions
> in ./drivers/soc/mediatek/mtk-infracfg.c, which is assigned to the section
> ARM/Mediatek SoC support in MAINTAINERS.
> 
> Hence, assign those header files to ARM/Mediatek SoC support as well.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Matthias, please pick this minor non-urgent cleanup patch.
> 
> This patch is part of an initial experiment to assign all files to
> specific sections in MAINTAINERS. At the moment, about 3200 files are
> currently not assigned to specific sections and maintainers.
> 
> If you think these cleanup patch cause more churn than value, please let
> me know. Thanks.
> 
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b4197e9da495..1703c7d2e146 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2066,6 +2066,8 @@ F:	arch/arm/boot/dts/mt8*
>   F:	arch/arm/mach-mediatek/
>   F:	arch/arm64/boot/dts/mediatek/
>   F:	drivers/soc/mediatek/
> +F:	include/linux/soc/mediatek/infracfg.h
> +F:	include/soc/mediatek/smi.h

I the most important file is missing: mtk-mmsys.h
smi.h is part of drivers/memory and should be added to Krzysztof entry.

Regards,
Matthias


>   N:	mtk
>   N:	mt[678]
>   K:	mediatek
> 
