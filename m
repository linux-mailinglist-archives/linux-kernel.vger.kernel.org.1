Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E389F267ED3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgIMIlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgIMIlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:41:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E93DC061573
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so8363261wmk.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:reply-to:subject:to:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tex+uNDYHaejhEtvm138q5mgthApI/sMf1bIvv5O3f4=;
        b=oEyaYEDZ6CZD6dQhTgs8TxUEDDYrQEak3P2pKJfftye0U5p6GTP5csBYOoGwrB4qkY
         DwDLxBCuIbP6BqGqW0L05Q6sVNaHtwCyYNrQYmSKCVNdqfZaGQEnOviuRlTnAUKRMxeY
         JN4eJYJUZNRZx8jbsQdexRNApA9Pm4YgmwACHf58AAMs4vEA4Ls1dLPPEztHMVy0vfZF
         IYUIv+QVOoKUcif+hpNi5drtiLXFcQlGSj32xMl0H16UikGUx3PP/STx2Kp8VpWiboYB
         AGQVp/iQEeNyxh4UUyVUy3Cbph23rKsIR8XGiWMiFW/7KlN8qJ5g2WEKjwyTbbm71bEh
         52+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:subject:to:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tex+uNDYHaejhEtvm138q5mgthApI/sMf1bIvv5O3f4=;
        b=MlyO88dgX+T6TR+k3C8mC1/0eXoOxUtpxD+tuC2oHE6Tweo+EqSiffTIQWIZCkYUiY
         X6nBrZBYk4hMA9SW2OjkmJGsVWAvIVvq/oyxxm8tX+LzzoLtL6yYYw05yGgAKc473Y2N
         a7fc5iP6JkUC9KCDrisw0ImEhZv92CN9iVmx3RGob7GWJN9OFd8cMNpeoF9Em1fJ+FWg
         EDm+dai4pCanWGkgqgmkIt0Z4nPTmOV5DQ9xdzvavQLAB/UMyfVpOGBQ0pC5ZGcu7MBe
         UHMvPtYUfToF/BiTW1qrnR/MLqwVO8kkKuffdUpIrw5gh8ARHQHbiOyoSpvo38w8dVp3
         Vy0Q==
X-Gm-Message-State: AOAM5320tIFd8uFbZldHHQbA2Dz2rlMWe0+pj+D6L6V07p4slCv+0fre
        ezMhelnciGb8ZofXsyn0Fjhiw2+/Hu5ZiQ==
X-Google-Smtp-Source: ABdhPJz/i+LPSvNIlQpfBQXmfnVszzs6D5MhyOLQjLQg9mgr5Bvvg4AqBIwGAJntDG1B0Xa5kdI7xQ==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr9801293wml.176.1599986458971;
        Sun, 13 Sep 2020 01:40:58 -0700 (PDT)
Received: from [192.168.1.20] (host109-156-254-181.range109-156.btcentralplus.com. [109.156.254.181])
        by smtp.googlemail.com with ESMTPSA id q18sm13951043wre.78.2020.09.13.01.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2020 01:40:58 -0700 (PDT)
From:   Chris Clayton <chris2553@googlemail.com>
X-Google-Original-From: Chris Clayton <chris2553@gmail.com>
Reply-To: chris2553@googlemail.com
Subject: Re: [PATCH] misc: rtsx: do not setting OC_POWER_DOWN reg in
 rtsx_pci_init_ocp()
To:     ricky_wu@realtek.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        bhelgaas@google.com, vaibhavgupta40@gmail.com,
        rui_feng@realsil.com.cn, kdlnx@doth.eu,
        linux-kernel@vger.kernel.org
References: <20200824030006.30033-1-ricky_wu@realtek.com>
Message-ID: <c06d7691-01ab-303c-e687-dd8c51a8a9c5@gmail.com>
Date:   Sun, 13 Sep 2020 09:40:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200824030006.30033-1-ricky_wu@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Arnd,

On 24/08/2020 04:00, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> this power saving action in rtsx_pci_init_ocp() cause INTEL-NUC6 platform
> missing card reader
> 

In his changelog above, Ricky didn't mention that this patch fixes a regression that was introduced (in 5.1) by commit
bede03a579b3.

The patch that I posted to LKML contained the appropriate Fixes, etc tags. After discussion, the patch was changed to
remove the code that effectively disables the RTS5229 cardreader on (at least some) Intel NUC boxes. I prepared the
patch that Ricky submitted but he didn't include my Signed-off-by or the Fixes tag. I think the following needs to be
added to the changelog.

Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260")
Link: https://marc.info/?l=linux-kernel&m=159105912832257
Link: https://bugzilla.kernel.org/show_bug.cgi?id=204003
Signed-off-by: Chris Clayton <chris2553@googlemail.com>

bede03a579b3 introduced a bug which leaves the rts5229 PCI Express card reader on the Intel NUC6CAYH box.

My main point, however, is that the patch is also needed in the 5.4 (longterm) and 5.8 (stable) series kernels.

Thanks.


> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rtsx_pcr.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index 37ccc67f4914..3a4a7b0cc098 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -1155,10 +1155,6 @@ void rtsx_pci_init_ocp(struct rtsx_pcr *pcr)
>  			rtsx_pci_write_register(pcr, REG_OCPGLITCH,
>  				SD_OCP_GLITCH_MASK, pcr->hw_param.ocp_glitch);
>  			rtsx_pci_enable_ocp(pcr);
> -		} else {
> -			/* OC power down */
> -			rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
> -				OC_POWER_DOWN);
>  		}
>  	}
>  }
> 
