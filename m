Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D492B064F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgKLNVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLNVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:21:49 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319A8C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:21:49 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so5510917wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t9OC41HUdp70sOva3B5Vc7/7aPmDJPqNV434fyKFWd8=;
        b=ChYlv/qgnWkGwE4gX1d9DmQt6LtEp0m6NV8y03tQDfbaQqzh4kPhBJ36iK0zIABNs/
         GrgZFdcJ6+LMqBqUK4Mn3NcWSi9Mpsa5apDJzuHmT+dFLVi4LawGT9DkjLcC3lu6k2Ah
         OEAuBZ1qCpotgOqL0kBlV41VUzUBesC3j1Jr+8BASn1bGwrTMY82iV2xrgoEnY2FK735
         14qrCGNH9020dbVa2cMzCy+bQZUOU3dhQBKKJSlF9da5hLLZ1Wed68SfC/oCYNLX/k0t
         cV/+x21+8O5GZ3IstzC6rITx1cHmOcol9ZSMZSoHrFhdI9TXEuyKmzoDiCrdJyjkFfqo
         a7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t9OC41HUdp70sOva3B5Vc7/7aPmDJPqNV434fyKFWd8=;
        b=kTKhEB8DTTh253XyWZqrlKgahQ8iCUFR9Fi67pVhoYOCWeW0C8WcDzyOeAhOt6B83o
         ZH+vNNJe1XUvnFZkAAxrtHZxz/V8EDA8JugWmYTIobjeUbSwj+SkqBCU8Nn9V5EGUdHP
         P6BqjtL1e5ydsB8IYhd2V+fSX/Wdb4g/h8XZA+gj3ZA7rFzhr0CF0MBLzbkS75SPOKyk
         pSCTsMiV5V7JFGsj7zw/BrGunw6n8+qQfl4dPcWxxau+1+z7SYQ1bzZb1DRDy0cI6hyk
         4313lcx01jt6WVuJH+gD7vU8JYc+cYXwomIB94LFV1VslnFPVyvgZpPP4t9tI+dIUbXJ
         xd6w==
X-Gm-Message-State: AOAM530SQdB1axEqDwWLW+IdZd4HuXvoo5JQGQ8AiDddijcN5y3mPNMU
        /6vOqVWMeD6l+0SNVSbqtOY2Cw==
X-Google-Smtp-Source: ABdhPJx+wFwlN4lWlCgL8nnuzrTwqxxyou9TYpunw0FdVf+yGZpzZZ69I4ffNfwwUzhYAludRve/OQ==
X-Received: by 2002:a1c:3d4:: with SMTP id 203mr9441354wmd.52.1605187307871;
        Thu, 12 Nov 2020 05:21:47 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id g66sm6496468wmg.37.2020.11.12.05.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:21:47 -0800 (PST)
Date:   Thu, 12 Nov 2020 13:21:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>, tomi.valkeinen@ti.com,
        kishon@ti.com, dmurphy@ti.com, s-anna@ti.com
Subject: Re: [PATCH 06/25] soc: ti: knav_qmss_queue: Remove set but unchecked
 variable 'ret'
Message-ID: <20201112132145.GI1997862@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-7-lee.jones@linaro.org>
 <20201112103130.GD1997862@dell>
 <30ad256b-07f0-f01e-ec4f-c12cf9dbe426@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30ad256b-07f0-f01e-ec4f-c12cf9dbe426@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020, Tero Kristo wrote:

> On 12/11/2020 12:31, Lee Jones wrote:
> > Cc:ing a few people I know.
> > 
> > On Tue, 03 Nov 2020, Lee Jones wrote:
> > 
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >   drivers/soc/ti/knav_qmss_queue.c: In function ‘knav_setup_queue_pools’:
> > >   drivers/soc/ti/knav_qmss_queue.c:1310:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> > > 
> > > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > > Cc: Sandeep Nair <sandeep_n@ti.com>
> > > Cc: Cyril Chemparathy <cyril@ti.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >   drivers/soc/ti/knav_qmss_queue.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > Any idea who will take these TI patches?
> > 
> > https://lore.kernel.org/linux-arm-kernel/20201111052540.GH173948@builder.lan/
> > 
> 
> (Dropped a few inactive emails from delivery.)
> 
> Santosh is the maintainer for the subsystem, so my vote would go for him.

Thanks for your prompt reply Tero.

It looks as though Santosh has been on Cc since the start.  He must
just be busy.  I'll give him a little while longer before submitting a
[RESEND].

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
