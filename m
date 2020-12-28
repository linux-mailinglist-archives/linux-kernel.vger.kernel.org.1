Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C158C2E3624
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 12:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgL1LA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 06:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgL1LA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 06:00:29 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C9EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 02:59:48 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n7so7160203pgg.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 02:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sFoKCUDz1JxP+F0ek43ef1dtvFISDc7wAusfSKesoRg=;
        b=dx7t0PPLiodk+fTJDEO9DEGLFsx/oMbz5u1mP1YnQ1Ed7oKyeI/ZfcL3jcAXyjoh/i
         rpnrHnVSxFAKfo9OaPH5fNAFXBzhywxHRR7mNjiilOH/w7ghudzkHZUbComsMb/EufnE
         d91AhNlPnlZQ9LXqHexTGivTZzN6PLJNzCy25b9WMfShuqN22g6PDx0u/XHosnMAaA7n
         kLh6eESeANN4JNwjwWPLMYSJXyFMx+s5MWQ8sh2smVkStb3ltMG/N10XVaPV9cy/XSLa
         xCJ2zBu0HanlqVWWbdHbNlz5bQOj32Ne+XwpijxGRU0McS8V4nsYUfGUV7afYzKIyRL/
         drEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sFoKCUDz1JxP+F0ek43ef1dtvFISDc7wAusfSKesoRg=;
        b=l4Z0icw4QylryE/nut3Ev6rX5bdI+TDB+dbith0ThnkG3krMmTkg0nPg12G0ATGG6J
         1vBvRI0IhTXRlsrWkUWQwgUwkzJdK74NAH4r+/eCN/vekxgv2/wZl08BdOmWKsTXogAI
         YyHS1rnOmIKm9nHUwBMzOQUk5cQijWxYBTpmLlGJT4bZKhubJWZH5shJHhwciOSNcaRO
         sxHrqfa1bNdCOQRKFuV9f2xQ1UfVaXl9OjH/1O62B2f26q6OWkB5V9coz5qxEOgx4C+/
         9eqhAUpyPyg6xXhziqIMA7kK29W+XeH5cZX85C7NObMVHSCpdTW6Aut1cxd3D8AB1RZ3
         dvLw==
X-Gm-Message-State: AOAM5327uad+zI98f5icW10tDKhwhMrS4O1bBYsBRBdXGzR88OPSyY0F
        JsQlaHox1cBXKZDgKjsKUAT+
X-Google-Smtp-Source: ABdhPJwZt+/6HjVdIyyLvNw+WAsY35y1gMpXrTR7S4Cd57vMdIyoirpprkPdNo4P1HrQHw/poNrSGA==
X-Received: by 2002:a62:145:0:b029:19e:a395:bd3d with SMTP id 66-20020a6201450000b029019ea395bd3dmr39544120pfb.13.1609153187872;
        Mon, 28 Dec 2020 02:59:47 -0800 (PST)
Received: from thinkpad ([2409:4072:386:a7b4:f938:76e5:9a02:c8e8])
        by smtp.gmail.com with ESMTPSA id x12sm37161397pgf.13.2020.12.28.02.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 02:59:47 -0800 (PST)
Date:   Mon, 28 Dec 2020 16:29:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/18] MAINTAINERS: Add linux-actions ML for Actions
 Semi Arch
Message-ID: <20201228105941.GA24394@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <5845b7a323c65adaa1566c3bee68b5ca1f1bb17e.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128074350.GE3077@thinkpad>
 <20201129194824.GC748744@BV030612LT>
 <fed29816-561a-7187-302f-09ab37beddca@suse.de>
 <20201205055414.GB2250@thinkpad>
 <20201228104307.GA836928@ubuntu2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201228104307.GA836928@ubuntu2004>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 12:43:07PM +0200, Cristian Ciocaltea wrote:
> On Sat, Dec 05, 2020 at 11:24:14AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Nov 30, 2020 at 01:54:45AM +0100, Andreas Färber wrote:
> > > On 29.11.20 20:48, Cristian Ciocaltea wrote:
> > > > On Sat, Nov 28, 2020 at 01:13:50PM +0530, Manivannan Sadhasivam wrote:
> > > >> On Fri, Nov 20, 2020 at 01:56:12AM +0200, Cristian Ciocaltea wrote:
> > > >>> Add the linux-actions mailing list for the Actions Semi architecture.
> > > >>>
> > > >>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > >>
> > > >> There was a patch from me for this change but I don't mind taking yours
> > > >> as long as we keep the list updated :)
> > > > 
> > > > Sorry about that, I often forget to manually append this mailing list
> > > > before submitting related patches and therefore I considered this is
> > > > a good opportunity to have this issue fixed once and for all.. :)
> > > > 
> > > >> I have just one comment below, with that fixed:
> > > >>
> > > >> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >>
> > > >>> ---
> > > >>>  MAINTAINERS | 1 +
> > > >>>  1 file changed, 1 insertion(+)
> > > >>>
> > > >>> diff --git a/MAINTAINERS b/MAINTAINERS
> > > >>> index a85c1881cf07..8428aba52581 100644
> > > >>> --- a/MAINTAINERS
> > > >>> +++ b/MAINTAINERS
> > > >>> @@ -1497,6 +1497,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
> > > >>>  M:	Andreas Färber <afaerber@suse.de>
> > > >>>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > >>
> > > >> No need to keep the generic list, please remove.
> > > 
> > > Why? They're not mutually exclusive.
> > > 
> > 
> > Yes but why do we want to spam it? Currently we don't archive actions tree in
> > lore but I can do that.
> 
> Hi Mani, Andreas,
> 
> I'm going to prepare a new revision of this patch series, but I'm not
> really sure how should I handle this patch: keep the 'linux-arm-kernel'
> list or drop it?
> 

Since Andreas seems to be in favour of keeping it, I don't object.

Thanks,
Mani

> Thanks and regards,
> Cristi
> 
> > Thanks,
> > Mani
> > 
> > > Regards,
> > > Andreas
> > > 
> > > > 
> > > > Done, thanks!
> > > > 
> > > >> Thanks,
> > > >> Mani
> > > >>
> > > >>> +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
> > > >>>  S:	Maintained
> > > >>>  F:	Documentation/devicetree/bindings/arm/actions.yaml
> > > >>>  F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> > > >>> -- 
> > > >>> 2.29.2
> > > >>>
> > > 
> > > 
> > > -- 
> > > SUSE Software Solutions Germany GmbH
> > > Maxfeldstr. 5, 90409 Nürnberg, Germany
> > > GF: Felix Imendörffer
> > > HRB 36809 (AG Nürnberg)
