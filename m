Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D902D2B0EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgKLUHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgKLUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:07:48 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC3EC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:07:47 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c16so6573995wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mcvh+x9eP3MHV+XcX2JuuU2Aql775TyuS0/HjA6eBdc=;
        b=Y4yJgVCPWSUCpUqzFWW/WEUWmL7/iA/KvXcVd9Ni+RmWC//cFjcsLciJMQjyXwmbBE
         ep70vhwgZjIMNQWdXuJcyGWJ2xPsn/HM9TIGMJ8nEczmBhLHaepdC/HxioTceHU5Q9TR
         LKLMXaOqL7pJakQNMQCZXd6b7dzfqcJlUmbsDyKnH10SyDfbFq1gfYT8hjpAzqfgor95
         OZIeMbnMpOgkly6CKhtt87yHbWGNpBL1vj66XmyQTuMnOrkd+JEflpAkIA40/LLlJjrV
         A4r6zFr7JndJl8/o3zhlqlPmzVUHw1q0EeZh27URvTqTag49JZt5TF4w7U/Ry1UpSoe7
         /avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mcvh+x9eP3MHV+XcX2JuuU2Aql775TyuS0/HjA6eBdc=;
        b=uAKjaFWXLAmtTDNSdwFsJXSVSmq346BWBqvzvSyquMf/4Bx10EFATM6J0rksEoWW4K
         tyPji1kVeoXhJcaI2jC1uroqpDYvrAd4czKHE3J1Hj2twM9YnkOKReuyinTHm2LxtbeB
         mve7abpeeM4Uubj5iZWsB56EQInFKTPVrSOCICFptAAg5I37uhI6cnrv6SUpiIzM4Fo5
         94jILZ5wdPaRbDtia8jx//TF/VOorWWG1B0wqUV0pbCaxSqyQpvtkaW2muq9y0s9s1qH
         RauJ8fFpHj2Lw208ZsxeSTHtl9WM7gbL0650vm5HgAou4VATmXsPygY8CH4b5Mh/s1WJ
         C5Sg==
X-Gm-Message-State: AOAM531YhcM/fTPa8GLlEQDvm1/qHk+5xI3S2y1uAUKpn/ibt6UeISdl
        Ymv6tY+kSdVoGdaBT51W3f+7iQ==
X-Google-Smtp-Source: ABdhPJyPFqyvJ6jDQgqqd9ZTbKc5vN7yyib/hMkoqEJqq0tijdeGWTSUGNzPGzS+ELJtilLQmv1mkg==
X-Received: by 2002:a05:600c:2949:: with SMTP id n9mr1270855wmd.29.1605211666499;
        Thu, 12 Nov 2020 12:07:46 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id m3sm3770298wrv.6.2020.11.12.12.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:07:45 -0800 (PST)
Date:   Thu, 12 Nov 2020 20:07:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     santosh.shilimkar@oracle.com
Cc:     Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>, tomi.valkeinen@ti.com,
        kishon@ti.com, dmurphy@ti.com, s-anna@ti.com
Subject: Re: [PATCH 06/25] soc: ti: knav_qmss_queue: Remove set but unchecked
 variable 'ret'
Message-ID: <20201112200744.GA2787115@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-7-lee.jones@linaro.org>
 <20201112103130.GD1997862@dell>
 <30ad256b-07f0-f01e-ec4f-c12cf9dbe426@ti.com>
 <20201112132145.GI1997862@dell>
 <28b506c0-df0d-c100-8d92-f3051f61cd98@oracle.com>
 <20201112190202.GN1997862@dell>
 <764d71c8-447b-80dd-c46f-bdaf729b5a7a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <764d71c8-447b-80dd-c46f-bdaf729b5a7a@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020, santosh.shilimkar@oracle.com wrote:

> On 11/12/20 11:02 AM, Lee Jones wrote:
> > On Thu, 12 Nov 2020, santosh.shilimkar@oracle.com wrote:
> > 
> > > On 11/12/20 5:21 AM, Lee Jones wrote:
> > > > On Thu, 12 Nov 2020, Tero Kristo wrote:
> > > > 
> > > > > On 12/11/2020 12:31, Lee Jones wrote:
> > > > > > Cc:ing a few people I know.
> > > > > > 
> > > > > > On Tue, 03 Nov 2020, Lee Jones wrote:
> > > > > > 
> > > > > > > Fixes the following W=1 kernel build warning(s):
> > > > > > > 
> > > > > > >     drivers/soc/ti/knav_qmss_queue.c: In function ‘knav_setup_queue_pools’:
> > > > > > >     drivers/soc/ti/knav_qmss_queue.c:1310:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> > > > > > > 
> > > > > > > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > > > > > > Cc: Sandeep Nair <sandeep_n@ti.com>
> > > > > > > Cc: Cyril Chemparathy <cyril@ti.com>
> > > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > ---
> > > > > > >     drivers/soc/ti/knav_qmss_queue.c | 3 +--
> > > > > > >     1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > > 
> > > > > > Any idea who will take these TI patches?
> > > > > > 
> > > > > > https://urldefense.com/v3/__https://lore.kernel.org/linux-arm-kernel/20201111052540.GH173948@builder.lan/__;!!GqivPVa7Brio!KEeMCT-GwmLNnDFCOqxnunXXiCrCpj3ZFXpiMzj55VmlOJ-FVhKmom-O7sq-CkL8s0sjAg$
> > > > > > 
> > > > > 
> > > > > (Dropped a few inactive emails from delivery.)
> > > > > 
> > > > > Santosh is the maintainer for the subsystem, so my vote would go for him.
> > > > 
> > > > Thanks for your prompt reply Tero.
> > > > 
> > > > It looks as though Santosh has been on Cc since the start.  He must
> > > > just be busy.  I'll give him a little while longer before submitting a
> > > > [RESEND].
> > > > 
> > > Go ahead and re-post. These seems to be trivial so will pick
> > > it up.
> > 
> > If you are in receipt of the first iteration, there shouldn't be any
> > requirement for a [RESEND].  Unless you deleted them from your inbox?
> > 
> I haven't deleted anything. I thought you are going to repost based
> on "I'll give him a little while longer before submitting a [RESEND]"
> :-)

A [RESEND] is a tactic employed due to lack of response.

Usually because the original set has slipped through the gaps.

If you find the patches adequate and you still have them in your
possession, please feel free to merge them. :)


-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
