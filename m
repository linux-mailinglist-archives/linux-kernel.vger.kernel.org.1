Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F91C2AE968
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgKKHL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKKHLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:11:50 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B26C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:11:49 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id o15so1490108wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ml6PMBaMdFDEy5Cihm6+FmPFIeFXEafrUdTFMLASd9E=;
        b=GV4S2ZXkOxCagQ53RcS3RswBTLPTJkjFHCxQqoLalJcCstL2cipsXEFTze7tcBJn0H
         6rFzpMSqYZ5WSVNPj0FUgKXpY5ctl+lm5GAeewjrnMgU5A15S0/c6I8Aar9dW4mGFZiP
         s9dOfiKFIYIZB5X4YryGY3rk4gkPVunwXANld/SMSTFtHCntvgkujXT0QaECPFjFrNOP
         Egha1gfJFatfdoifUMvO2cyspRJ3Ca7VesllAsEo7o8N0eERP+GVYKJ2vqxK8Xm0GA8I
         +XvPjnVxqR0aAFpB6lg2bnQClfJjlMcb54RnGJpiKE+E9Te1xcWm+tyTUxo91HzOU53P
         2Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ml6PMBaMdFDEy5Cihm6+FmPFIeFXEafrUdTFMLASd9E=;
        b=ENEP2tzq97CMC95TR38f6h+e2aiwg8Rg3t/duYv2YZe3mQko1JRaovFz3R+gT9wz82
         KVM2VoF/oJpf3lrxg6HI7Zxa4mT65UZDYByqthC6AXICnRE4wFyr1CoTiagyo64FHOPl
         9S4oEuZ5l49ym5UsP+aA6ZRviWkUDSk9YPw31VwDtPjiO6ncrJsk8nKCQdp9G5MBGlHQ
         B6Pfp8t7SXnTe4DzW8Ztd9q6cAXMesNiAxj0FQF7eVV6ct15wH3DjEX1soJF/OyE7Ise
         evbfEuuDcLamex0w7YZW/54Xq90eCLc6UeQBCd9IUD7HE6lon0YSMYrtdNUDCTr3v06G
         dPSA==
X-Gm-Message-State: AOAM533JcMcUVqD95/6/YNjuLZJyMkZfGe3VE2XAZIM2T2GFUW5JrcuG
        BMZ2Y8D4XnbXgN7age2AXjtvww==
X-Google-Smtp-Source: ABdhPJxd5V9hBaQhFHndQvFgOC34xorRnkpEOEnsw04IEsk6Qls2e1Sk6kWuIFHVVuBvBlvZKRIGVg==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr27058400wrw.378.1605078708299;
        Tue, 10 Nov 2020 23:11:48 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id r9sm1137645wrg.59.2020.11.10.23.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 23:11:47 -0800 (PST)
Date:   Wed, 11 Nov 2020 07:11:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 19/25] soc: qcom: smp2p: Remove unused struct attribute
 provide another
Message-ID: <20201111071145.GM2063125@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-20-lee.jones@linaro.org>
 <20201111052038.GG173948@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111052038.GG173948@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Bjorn Andersson wrote:

> On Tue 03 Nov 09:28 CST 2020, Lee Jones wrote:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/soc/qcom/smp2p.c:74: warning: Function parameter or member 'flags' not described in 'smp2p_smem_item'
> >  drivers/soc/qcom/smp2p.c:149: warning: Function parameter or member 'out' not described in 'qcom_smp2p'
> > 
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: linux-arm-msm@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/soc/qcom/smp2p.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> > index a9709aae54abb..43df63419c327 100644
> > --- a/drivers/soc/qcom/smp2p.c
> > +++ b/drivers/soc/qcom/smp2p.c
> > @@ -52,7 +52,6 @@
> >   * @remote_pid:		processor id of receiving end
> >   * @total_entries:	number of entries - always SMP2P_MAX_ENTRY
> >   * @valid_entries:	number of allocated entries
> > - * @flags:
> >   * @entries:		individual communication entries
> >   *     @name:		name of the entry
> >   *     @value:		content of the entry
> > @@ -65,7 +64,6 @@ struct smp2p_smem_item {
> >  	u16 remote_pid;
> >  	u16 total_entries;
> >  	u16 valid_entries;
> > -	u32 flags;
> 
> This struct describes the data shared between processors in the SoC and
> as such these 32 bits are significant. I believe we have an incoming
> patch that adds handling of some flag, so let's document it properly
> at that time.

Sounds reasonable.

> I've applied the second half of the patch for now.

Thanks.  And for the other applied patches too.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
