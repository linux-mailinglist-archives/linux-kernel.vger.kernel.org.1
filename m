Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAEB2B0D51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKLTCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKLTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:02:07 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AA7C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:02:05 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b8so7183118wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UWqlo59xqRNbYAmn4BNS5/vO78FqqGPqkNlmHGs4xwA=;
        b=MJ6c3goReMhaSFgiRLRh0X9/s6/nsnmyHSY05hBaUKTo1vyUEnnrqyHV1fpaHjPkAY
         Ge28+57V/vdo4/piTxzgOHYOWbAHbV0uO1F66kg/+vL0PrMJPxnq2qHDdlD48qy8dmKR
         mq9F+2Evv3b0QF6eNP02TeYyrxp2GuE/s4ZHq8SDqItPLwH+ABB6lhrrX32medDC/pNa
         e7b3heiLAjvxuAwdSQdKZ6I41ZcLfwAvRCSiaorLeWLd9gP5yyYJ80JJ83FNNNEj7YGT
         Rw8cobZWIhfe5eIDmfyJWbcIVhDcXRqTDY4SRc7feutL5WpLFhjwv+D0zR1zySulCpsK
         LMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UWqlo59xqRNbYAmn4BNS5/vO78FqqGPqkNlmHGs4xwA=;
        b=tDclcGtq1fgm0K7vtkkOg1dDuJ77iQMv27Dxhd8kbAgmk8Z+0Coe0Qt0yDFti2s++2
         RtsfYN46VM1KGqPkT9tlkguPYxfWan77ghnDXn3hjpFBLAyIdvYXMVI3fnPegHCdux8B
         lVmIyqAmFOAH8HQJZLLd+3xdU2LiCPHaYF/CL5WBs0jsh+ucKDhnhLMkWSjBEw1PZtBp
         1/sowxJdialoq2Ym0BGWLsyVNq9bzr7n1Bbdp6zIUpapnGYI+zJ+nOHtc4lyXiXATnzq
         OanfxGK4c63VeXO0tHzwpZ4sjT9cq3/LEfekIT4SKx98+SiFC+lkTzpb5VR6wngioYjc
         mzCg==
X-Gm-Message-State: AOAM530BDqCM+nC7ax/ynhSPkOVRZOR4Azhpa1nsO+xH5VfslD8LTHzQ
        kSusxNLVa4VORtbJf/JhljWZ7A==
X-Google-Smtp-Source: ABdhPJy/tf9x9XL6lVW1EsHu7SfnFG0sEdt1ylmwiJj8zF3LcgC+ynQzPEu1SA5jj1NtLF7/FzILIQ==
X-Received: by 2002:adf:f24b:: with SMTP id b11mr1178399wrp.342.1605207724638;
        Thu, 12 Nov 2020 11:02:04 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 18sm7082827wmo.3.2020.11.12.11.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:02:03 -0800 (PST)
Date:   Thu, 12 Nov 2020 19:02:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     santosh.shilimkar@oracle.com
Cc:     Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>, tomi.valkeinen@ti.com,
        kishon@ti.com, dmurphy@ti.com, s-anna@ti.com
Subject: Re: [PATCH 06/25] soc: ti: knav_qmss_queue: Remove set but unchecked
 variable 'ret'
Message-ID: <20201112190202.GN1997862@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-7-lee.jones@linaro.org>
 <20201112103130.GD1997862@dell>
 <30ad256b-07f0-f01e-ec4f-c12cf9dbe426@ti.com>
 <20201112132145.GI1997862@dell>
 <28b506c0-df0d-c100-8d92-f3051f61cd98@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28b506c0-df0d-c100-8d92-f3051f61cd98@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020, santosh.shilimkar@oracle.com wrote:

> On 11/12/20 5:21 AM, Lee Jones wrote:
> > On Thu, 12 Nov 2020, Tero Kristo wrote:
> > 
> > > On 12/11/2020 12:31, Lee Jones wrote:
> > > > Cc:ing a few people I know.
> > > > 
> > > > On Tue, 03 Nov 2020, Lee Jones wrote:
> > > > 
> > > > > Fixes the following W=1 kernel build warning(s):
> > > > > 
> > > > >    drivers/soc/ti/knav_qmss_queue.c: In function ‘knav_setup_queue_pools’:
> > > > >    drivers/soc/ti/knav_qmss_queue.c:1310:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> > > > > 
> > > > > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > > > > Cc: Sandeep Nair <sandeep_n@ti.com>
> > > > > Cc: Cyril Chemparathy <cyril@ti.com>
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >    drivers/soc/ti/knav_qmss_queue.c | 3 +--
> > > > >    1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > Any idea who will take these TI patches?
> > > > 
> > > > https://urldefense.com/v3/__https://lore.kernel.org/linux-arm-kernel/20201111052540.GH173948@builder.lan/__;!!GqivPVa7Brio!KEeMCT-GwmLNnDFCOqxnunXXiCrCpj3ZFXpiMzj55VmlOJ-FVhKmom-O7sq-CkL8s0sjAg$
> > > > 
> > > 
> > > (Dropped a few inactive emails from delivery.)
> > > 
> > > Santosh is the maintainer for the subsystem, so my vote would go for him.
> > 
> > Thanks for your prompt reply Tero.
> > 
> > It looks as though Santosh has been on Cc since the start.  He must
> > just be busy.  I'll give him a little while longer before submitting a
> > [RESEND].
> > 
> Go ahead and re-post. These seems to be trivial so will pick
> it up.

If you are in receipt of the first iteration, there shouldn't be any
requirement for a [RESEND].  Unless you deleted them from your inbox?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
