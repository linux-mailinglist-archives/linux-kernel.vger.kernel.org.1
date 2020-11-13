Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6383E2B163B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgKMHP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgKMHP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:15:56 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E043C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 23:15:56 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so7181135wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 23:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v5xpZZr95U5JcUyneXlTWfa5jYw6TW2I29KACwDy7/U=;
        b=kvtcmdhlqz7UMLzTgMUn7ufIw8j1SC0BKmAoEGkwqexV2VtVEzQ4q70qLer5fJNhO/
         KRYIg8az2cfRJtDl2HajNP43GTesqVAGQLDMz93fMTw+fgcp3ZCY5pK3g4JRkGKfzq5J
         fuNFckoITLgVgSZNG2tcJn2VSekmwierizldM1wSftdNy/+VTGdcemjfOISsLq0zvx91
         fpyrQVQDJl4YYPYgFuJsiW6ynpIaVTOp+Dvt8QgTxX1Ksl5qnQ7+8qEFL8B3ZqTihP/R
         L/HJiEDNU6K1SyNX+t9qYcc8RnTKdFvQ9U2LQXrFWq1oD6zs+1MovnF5/BDCxflZavwc
         6NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v5xpZZr95U5JcUyneXlTWfa5jYw6TW2I29KACwDy7/U=;
        b=mFbEYpWlsfW46tQdlfLSGegHYA5wMfOdUE5XrLjvqA5MlUz+xO1mKnYa07xGwxng8I
         Alm+ZdCktlaXjPR8UZxDRl++dlrf9jtc+NLKgDLMOgquBvtcu5FTaJC6l7xIIllawerv
         ZKSdrsgXN7iAeCvbFhP2CJl4CthUWwa4WnjM/9PsqekxvgJsR4XaFV7C6WbnVHAIQMX3
         V9yZ61IZE40pUdjog4LqgAGHmoLkYbqTlS9AH4/cRuWta0GYrFcbTBrH3gUP+drQmX9c
         0HgaZzYZL4NhcLvHsD2PWuvclvlhdJBueqJaJY52w2VmbTj+mwlmhPWiG59NSbI80tHO
         K+LQ==
X-Gm-Message-State: AOAM532OV2mfxaod/T2VVNwmIGt95cDFOFlW1ZvcEuPVUV3qJEATqg+T
        lBOyzC3chOMoCbHLBRhWbuSn4Q==
X-Google-Smtp-Source: ABdhPJwANxxAuFddE/nEKA1cnVEynUQs1Ak0olerHfl2oMWA1DVa3Nfx+DQu1OPxm/H+CYdi+M3EhA==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr1028245wmi.70.1605251755205;
        Thu, 12 Nov 2020 23:15:55 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id s4sm9939306wro.10.2020.11.12.23.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 23:15:54 -0800 (PST)
Date:   Fri, 13 Nov 2020 07:15:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Scott Wood <scottwood@freescale.com>, act <dmalek@jlc.net>,
        Dan Malek <dan@embeddedalley.com>,
        "Software, Inc" <source@mvista.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 11/25] soc: fsl: qe: qe_common: Fix misnamed function
 attribute 'addr'
Message-ID: <20201113071552.GE2787115@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-12-lee.jones@linaro.org>
 <20201112103300.GE1997862@dell>
 <VE1PR04MB66877659A67152AE02CF443F8FE70@VE1PR04MB6687.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VE1PR04MB66877659A67152AE02CF443F8FE70@VE1PR04MB6687.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020, Leo Li wrote:

> 
> 
> > -----Original Message-----
> > From: Lee Jones <lee.jones@linaro.org>
> > Sent: Thursday, November 12, 2020 4:33 AM
> > To: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > Qiang Zhao <qiang.zhao@nxp.com>; Leo Li <leoyang.li@nxp.com>; Scott
> > Wood <scottwood@freescale.com>; act <dmalek@jlc.net>; Dan Malek
> > <dan@embeddedalley.com>; Software, Inc <source@mvista.com>; Vitaly
> > Bordug <vbordug@ru.mvista.com>; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 11/25] soc: fsl: qe: qe_common: Fix misnamed function
> > attribute 'addr'
> > 
> > On Tue, 03 Nov 2020, Lee Jones wrote:
> > 
> > > Fixes the following W=1 kernel build warning(s):
> > >
> > >  drivers/soc/fsl/qe/qe_common.c:237: warning: Function parameter or
> > member 'addr' not described in 'cpm_muram_dma'
> > >  drivers/soc/fsl/qe/qe_common.c:237: warning: Excess function parameter
> > 'offset' description in 'cpm_muram_dma'
> > >
> > > Cc: Qiang Zhao <qiang.zhao@nxp.com>
> > > Cc: Li Yang <leoyang.li@nxp.com>
> > > Cc: Scott Wood <scottwood@freescale.com>
> > > Cc: act <dmalek@jlc.net>
> > > Cc: Dan Malek <dan@embeddedalley.com>
> > > Cc: "Software, Inc" <source@mvista.com>
> > > Cc: Vitaly Bordug <vbordug@ru.mvista.com>
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/soc/fsl/qe/qe_common.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/soc/fsl/qe/qe_common.c
> > > b/drivers/soc/fsl/qe/qe_common.c index 75075591f6308..497a7e0fd0272
> > > 100644
> > > --- a/drivers/soc/fsl/qe/qe_common.c
> > > +++ b/drivers/soc/fsl/qe/qe_common.c
> > > @@ -231,7 +231,7 @@ EXPORT_SYMBOL(cpm_muram_offset);
> > >
> > >  /**
> > >   * cpm_muram_dma - turn a muram virtual address into a DMA address
> > > - * @offset: virtual address from cpm_muram_addr() to convert
> > > + * @addr: virtual address from cpm_muram_addr() to convert
> > >   */
> > >  dma_addr_t cpm_muram_dma(void __iomem *addr)  {
> > 
> > Any idea who will pick this up?
> 
> I can pick them up through my tree, but I haven't created the
> for-next branch for the next kernel yet.  Will look through this
> series soon.  Thanks.

Thank you Leo.

There's not rush.  Just trying to ensure they don't get forgotten.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
