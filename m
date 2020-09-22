Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7829E273AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgIVGaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgIVGaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:30:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3F0C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:30:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so11496846pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PE69WmPVMn+IJmlNwMrcvYUlAlPJEaJLJZqHyK1P8TM=;
        b=aamF+ClIDjpvJiUytzHPfs1wtGhmMC599BqMR8vG8rvpPvw32+J1nXZfu7arbsAvs1
         wIS/2YKfKlHm3TY4OitYLnys1Wzt5GK1FhfGTlRcoSaSgRWTR6Uy6HaD+lCdJjbFQ4na
         OVjXwuWfmiKljpQLWnSa8rZpITyNwDfPjg3Kd2vYgQ1QrE2M/jo/0IF1V158zkJVp7WH
         /igG0IXkKi1B8Ip5P2nsAHocHWBossBeMPXMjbRUqYZ2QFEtXauNmwhw0o2cxLHzoklG
         tbAHlu/EvCmHLcvhBs/Kngdwptsv084BnaILyt6E6NvWQQfy3YgbhkaEanMKVrbhz7tb
         IUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PE69WmPVMn+IJmlNwMrcvYUlAlPJEaJLJZqHyK1P8TM=;
        b=Aftx65AspTkNMllf0Y4eUWVXM2J8oDUu9axYI0QfEYP9CiIUCvO9XGo4Zn7zXhp6i6
         HVSsJI1tBzyedZgkTtQUt4POFNo5YNj20CZm7PLHhI/jC0tOyKhOkx9pyqVJuTHNSoKl
         MoHkMOfXb/ATkZq2VQhzl2j4BcR6i+xPtjEy12PR1YdujynfvMx5EL+/RCIFCXbZ6A2J
         sKn53oHA3wbRhfaFLi00wkx53bd7Hnm9S6/kV3zpK9TsFPSU99nwyX/6MvFpYpZ3kMR5
         FUYUbtzen9XDrEGNbt3VZ1DVTB7a8c+46wWg5ZGuxi6GU6855BS3160VMlOIHId/ejiT
         zkbw==
X-Gm-Message-State: AOAM533dfanGWsKfKbyM3sqj8NNdCCBJAAgMA3KyoLLJwxjKy4e3RIvl
        j4wIxcr85hfKKb2AhSoNQjhk
X-Google-Smtp-Source: ABdhPJzXl7H6HlkGNUzou7nFL6LiQ+aHS/JMZoyJ9ZVcV1IME5IE0+0G7lPJvAA84pS8NFvqPv4C7w==
X-Received: by 2002:a63:63c7:: with SMTP id x190mr2370277pgb.90.1600756205192;
        Mon, 21 Sep 2020 23:30:05 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e1c:c062:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id 141sm14071215pfb.50.2020.09.21.23.30.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Sep 2020 23:30:04 -0700 (PDT)
Date:   Tue, 22 Sep 2020 11:59:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: actions: include header to fix missing prototype
Message-ID: <20200922062959.GE29035@Mani-XPS-13-9360>
References: <20200920202652.11469-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920202652.11469-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 10:26:52PM +0200, Krzysztof Kozlowski wrote:
> Include the header with prototype of owl_sps_set_pg to fix:
> 
>   drivers/soc/actions/owl-sps-helper.c:16:5: warning: no previous prototype for 'owl_sps_set_pg' [-Wmissing-prototypes]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/soc/actions/owl-sps-helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/actions/owl-sps-helper.c b/drivers/soc/actions/owl-sps-helper.c
> index 291a206d6f04..e3f36603dd53 100644
> --- a/drivers/soc/actions/owl-sps-helper.c
> +++ b/drivers/soc/actions/owl-sps-helper.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/soc/actions/owl-sps.h>
>  
>  #define OWL_SPS_PG_CTL	0x0
>  
> -- 
> 2.17.1
> 
