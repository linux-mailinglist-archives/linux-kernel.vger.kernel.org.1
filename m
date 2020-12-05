Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADB72CF9EA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 06:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgLEFzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 00:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgLEFzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 00:55:01 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5884C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 21:54:20 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id f14so4379818pju.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 21:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aTAJ7VGdeXPvoE3WM9gye5R23R2Gkok5I9/EDylvAVs=;
        b=SyBZW5nHSsLqgythoxj5cyJa5+fwWH/sRCSHw8a/pnQ1euANVU/Lx6SvFKGrcuCPnx
         IX7+Jgjzu/BFO4m3GkcKer6zgIrKv2vFBjFGcpm8Howqgp9dQ6s6fmZdCsLGtVMpNQM7
         UA524d+EmFeBSSn2ET0/NwgjAijLF+7nH+lnwY7Fe+ygDloGtueTCfoDHLpN+H38yhQY
         DwLC+JeerrFmHnAXEUHEnk0U6+uSqT6nSyjkBAF/LbGNN9Y93gwcIG8jmmzI36sNtrGd
         LEWCEoHu4dTYUFA3nwPrrB4AhULCfPMPoGsR8rprPh8bzx+Nz8Ll/aUtYdzEpPPX90o9
         oPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aTAJ7VGdeXPvoE3WM9gye5R23R2Gkok5I9/EDylvAVs=;
        b=VmrxYkgzGOIxlT85xXx7Yc2SDswc5Qq5GNcZ39gLheBFh5Te6mXhpzPZrp/awwkHTn
         Zv2vHOLniueZoD67sjQBDDOHIJZY7ObRArZHAulbmTIPQoLRuioqCgCqDpcyTotlu2wF
         tYQMsXULlvfVHJ9HN584IRlOAHOKLAoH8fmiiOn9OaqupvNecm+huL1KECKIKNxF15Ay
         iEQ7Vja5yUF5t1lYigsCdncDncuyrsr4KVVtPd4+jEdHo3PJMbimlNHxHioewEGeEkKX
         Oj1t8XHr3S9qw//xoN+y1JsAcqIwztdPd0ncA2srW1KQpsk3ABDEzdo1Ib+ueJjKxcJ+
         lPIQ==
X-Gm-Message-State: AOAM532UMsckf3c1rn07SBHBWfAiBeyjP1FEdoZ+lpAocToEl/HUn8tY
        DzSMR3qeKGcW5+B0WZrbv+/1
X-Google-Smtp-Source: ABdhPJwFwW2XujztFxjMNQfC576m5xYfYTxZlNxPg4CW44YtD2C5xqGOMnDJIFfMr5/BRdNxlSpt4w==
X-Received: by 2002:a17:902:6905:b029:d9:9114:280d with SMTP id j5-20020a1709026905b02900d99114280dmr7051711plk.74.1607147660213;
        Fri, 04 Dec 2020 21:54:20 -0800 (PST)
Received: from thinkpad ([2409:4072:648e:8bd1:74b2:a4d8:e3fe:225b])
        by smtp.gmail.com with ESMTPSA id s15sm5477913pga.43.2020.12.04.21.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 21:54:19 -0800 (PST)
Date:   Sat, 5 Dec 2020 11:24:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/18] MAINTAINERS: Add linux-actions ML for Actions
 Semi Arch
Message-ID: <20201205055414.GB2250@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <5845b7a323c65adaa1566c3bee68b5ca1f1bb17e.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128074350.GE3077@thinkpad>
 <20201129194824.GC748744@BV030612LT>
 <fed29816-561a-7187-302f-09ab37beddca@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fed29816-561a-7187-302f-09ab37beddca@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 01:54:45AM +0100, Andreas Färber wrote:
> On 29.11.20 20:48, Cristian Ciocaltea wrote:
> > On Sat, Nov 28, 2020 at 01:13:50PM +0530, Manivannan Sadhasivam wrote:
> >> On Fri, Nov 20, 2020 at 01:56:12AM +0200, Cristian Ciocaltea wrote:
> >>> Add the linux-actions mailing list for the Actions Semi architecture.
> >>>
> >>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> >>
> >> There was a patch from me for this change but I don't mind taking yours
> >> as long as we keep the list updated :)
> > 
> > Sorry about that, I often forget to manually append this mailing list
> > before submitting related patches and therefore I considered this is
> > a good opportunity to have this issue fixed once and for all.. :)
> > 
> >> I have just one comment below, with that fixed:
> >>
> >> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>
> >>> ---
> >>>  MAINTAINERS | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index a85c1881cf07..8428aba52581 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -1497,6 +1497,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
> >>>  M:	Andreas Färber <afaerber@suse.de>
> >>>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >>
> >> No need to keep the generic list, please remove.
> 
> Why? They're not mutually exclusive.
> 

Yes but why do we want to spam it? Currently we don't archive actions tree in
lore but I can do that.

Thanks,
Mani

> Regards,
> Andreas
> 
> > 
> > Done, thanks!
> > 
> >> Thanks,
> >> Mani
> >>
> >>> +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
> >>>  S:	Maintained
> >>>  F:	Documentation/devicetree/bindings/arm/actions.yaml
> >>>  F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> >>> -- 
> >>> 2.29.2
> >>>
> 
> 
> -- 
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer
> HRB 36809 (AG Nürnberg)
