Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EBD27712F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgIXMjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgIXMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:39:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD49C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:39:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so3385867wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zWTsbwqu5u31iU7OL0QOQ6Z5T6BsEEYTr2C+q8i32Ms=;
        b=A3sI1Nbs6OeluEErpb9S8ydWCHVOVgifN0EiclOoqeLwIYvSfvt80rDHa2tSUUxPbm
         DompAts1y/IGboXsPK6hEpVV1x+4RxKvesJ5bvpqOx3EC70hxN69do3zCuOY3ae0F8Pw
         fwTPyGq7r75jillegw2Snmd0x8WaPSPciNJ8gGY6KFDr+w0qs0QDf6/AMzaxfzyRvadk
         XhEbAPbtdVP0tcC5ZM7NSry6RYvnaiyv+I72bwo1R4xV0XWlifd2EmNVR6fcNgnaWlZ1
         Qk1ZX6pzTBYCI2ZRLX3qvn7h+k4BX/pDDtY8JoEo8v4cr+oC8aLxLQ1Kt5prI7tWrnCd
         mCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zWTsbwqu5u31iU7OL0QOQ6Z5T6BsEEYTr2C+q8i32Ms=;
        b=ByNwrevwruyO4FajLBTzbAvxhM3UtxUujJIn/hf1kQAaUUC80D++aW8Ad5yhX8YQh7
         ZC5uoPgJdfpXm97E5AsYskcVTV/h4XFsbfWbc8HAUWzFrj3pre0dkwZKbQJgV2+iE4Qz
         F0psJ/4c0XFxjVwon1/NgeVeip581i9j2HktsTR0A0VdaMHUTOdTjcs0p1FNKjKfXmru
         L0V+Ns9vDSjOGyqkZ3PvKOweBwhXlswL3vq77LK5xchKvGGiSa4Ild3FzE6kEjc7oP6a
         2bmOif6WogezZrWgqAVtcwfi9I04jv9w11Ssy0gJqg979hM+TlTFj2xi8KBxhGBpj0AU
         u8ZQ==
X-Gm-Message-State: AOAM5333tinfgJD6bVMINmkCXtN/y9/U3R/jnB+YgE3+XT7PTTQM1vLH
        yJhpPMeuQ70Ol5jykxIDGAK/Yw==
X-Google-Smtp-Source: ABdhPJzRewLMSesYUgH51L0Nb4lc9SwRXVKb/C8N6/c4ECvtlaXsKtencSQUQBWbkrMIfs03Twyikg==
X-Received: by 2002:a1c:f612:: with SMTP id w18mr4443877wmc.47.1600951179539;
        Thu, 24 Sep 2020 05:39:39 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id u8sm3169859wmj.45.2020.09.24.05.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:39:38 -0700 (PDT)
Date:   Thu, 24 Sep 2020 13:39:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Suman Anna <s-anna@ti.com>,
        kernel-team@android.com
Subject: Re: [PATCH] mfd: syscon: Don't free allocated name for regmap_config
Message-ID: <20200924123936.GJ4678@dell>
References: <20200903160237.932818-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200903160237.932818-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Sep 2020, Marc Zyngier wrote:

> The name allocated for the regmap_config structure is freed
> pretty early, right after the registration of the MMIO region.
> 
> Unfortunately, that doesn't follow the life cycle that debugfs
> expects, as it can access the name field long after the free
> has occured.
> 
> Move the free on the error path, and keep it forever otherwise.
> 
> Fixes: e15d7f2b81d2 ("mfd: syscon: Use a unique name with regmap_config")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixed the spelling mistake and applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
