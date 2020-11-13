Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB22B18EB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgKMKTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:19:51 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F115CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:19:43 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 23so7763411wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RmkrxeBx46DhTuid3vYjjgytEVotpngZcVJnlj9M3tM=;
        b=nCt/I4kddXnWLS5DWKyA7EfwbtbE5EeCRPUdXTBaB7mouJ0mlP4lfIhY+KtGNrpoCs
         UqjT0hnPJcP+sZECJ1txcVZPMgOVQDeDqH4hd2pmqYFKFw72eCq8XFQyhdBzaT9/lQVf
         WlZhTUpe6T6c4w+7uqyKd81LL0q4hYfa6+2pnU7BYjf00DGkapnc5A8P/4J2neyhdzgr
         wOk+7L527/5n5Y3Bo1cRiWe2ssF0sIJDQ2v0AI9LLAN7gpAiY0jZUTE1yyravaB1gx5b
         swWQpOrzoo50CHAGhru818syrdIKbRuLISNol8KcoMHOVWtRWAbX+hL/sXiBt7tJrIJx
         x2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RmkrxeBx46DhTuid3vYjjgytEVotpngZcVJnlj9M3tM=;
        b=j88DsIpRcdcLbMOjQG96bES3YVYhECf6svK+UOHCJDkdwY56vXvdOGx9ZeZL8jeiKG
         GGVhOrlviSRDEnc8Fs7GIgpxkea+sTr/C3BTI/h6ZX1fz1OfjBVjQTXkFCwH9zYOIxF5
         qUGFRuvUVRlsBUQbd+fyyrinXj+djyEqFnpZnF1stlLPHRHLPW2K8WK8dlebvNURLs10
         SomPsRU1MW0jIiPFO3RDAHi8UQbzFAPy1BTeI4+ZWCM9FFqjW68UsuCb48pg7lf33EOR
         ndcuewL0X28IJsSdKuB76xhxYzCNf3tHcwgXRPTQ++Ww3mHpzAIY4f0kBMopeADkx8rL
         L1wg==
X-Gm-Message-State: AOAM532dT+YO73TS9oSYEs0eLOEJxmNIO0NNk3FS3ckafeW0nzLUAvgM
        wJGSw5qAK9/M8QUxe/rZo9Zn3A==
X-Google-Smtp-Source: ABdhPJyQLrgVxYbtgAvS0x3odOLq2yPYGt4sTtE+7H/0Q+/ULR7DVcmiPK2frcmdXhl9pAHZKVChNQ==
X-Received: by 2002:a1c:7d12:: with SMTP id y18mr1727783wmc.103.1605262782647;
        Fri, 13 Nov 2020 02:19:42 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id h62sm10243357wrh.82.2020.11.13.02.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 02:19:41 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:19:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mfd: syscon: Add
 syscon_regmap_lookup_by_phandle_optional() function.
Message-ID: <20201113101940.GH3718728@dell>
References: <20201110161338.18198-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110161338.18198-1-enric.balletbo@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Enric Balletbo i Serra wrote:

> This adds syscon_regmap_lookup_by_phandle_optional() function to get an
> optional regmap.
> 
> It behaves the same as syscon_regmap_lookup_by_phandle() except where
> there is no regmap phandle. In this case, instead of returning -ENODEV,
> the function returns NULL. This makes error checking simpler when the
> regmap phandle is optional.
> 
> Suggested-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> 
> Changes in v2:
> - Add Matthias r-b tag.
> - Add the explanation from the patch description to the code.
> - Return NULL instead of -ENOTSUPP when regmap helpers are not enabled.
> 
>  drivers/mfd/syscon.c       | 18 ++++++++++++++++++
>  include/linux/mfd/syscon.h | 11 +++++++++++
>  2 files changed, 29 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
