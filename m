Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1D2C7B07
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 20:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgK2TtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 14:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgK2TtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 14:49:08 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4B3C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 11:48:28 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so16729641ejj.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 11:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Kc7ZFdSTRNe+vKgeFRwhLswnRflQtlt3+dVYxevKBAE=;
        b=eVqYqkfCWptY03JO4+gyTrLnv85CO96dubZD4oYphS3xmgkO53/qxoTjaK9lkhUCKu
         UZsDWjFSMSTvxNxh3UqLHV0Azsfq+g//f/0fNdY/FbNx8GxeW6PCveZWtjpWwzzFq+Gx
         Alw/UUGV2n2M8gKSkTclAwXv1sBrEtRD3aLRPOeyqZ1FVHM5Xk2zu8T+prpYFHsCi15N
         7AV6Idfo6/ZjlhV4PNnEpIBDdWuK46pJonco0AlN3DjUbctSQXsa3w9kyBSmGYpx1v2X
         YRLAifIU+ZiL8oC0VcwsWeZzNoIogxebiAI6akZv3kA9ZJTdcYc6RsgmarBO+znj5hdW
         m6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Kc7ZFdSTRNe+vKgeFRwhLswnRflQtlt3+dVYxevKBAE=;
        b=PiveccdGptYImgzaVny9G9mxxPOybEvHtR7i6Me6tH8hyaPsWOhQQotg/XKkLE7otN
         iVX5R7FrCFDVlxezGTToSexJclUHXjTgQda3NRYkR7gZ2yDNR8XD8Zh/UqVcmTL4E31W
         nDTVll0Z4I+MZ/5vCotSXNkErDE2CUzaKY6+Yd1x3IMpy0JmxZJG7Y4Vu/2tWgPgfQwt
         TCmANK2awtrprBgLYlza9k+JFiTtZbsSyZMuzCgLm/6G3dMeFNGkbPL/erhuZuurP9Vq
         QgKbjKmmE06TIb9vtYzJqZ9JjN4v1tCc52zjyzurHjO1ifW36YgsbGQXB1wqspsW0lVb
         ixJw==
X-Gm-Message-State: AOAM531K4YnVM0qTfbfiOFd5O/txo3iJ9xQiKiYbT4sU/v7KeIH8+2O/
        Cz3K5GvMEm1WhLjnzBncV24=
X-Google-Smtp-Source: ABdhPJwUBaNbWG35U4agCGBzgehxGVBk+UEqomHZRQDMudmmQDf7PLCwTWvgEaIsVYXbdItSGZEYqQ==
X-Received: by 2002:a17:906:ae8d:: with SMTP id md13mr18396142ejb.300.1606679307037;
        Sun, 29 Nov 2020 11:48:27 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id w2sm7667017ejc.109.2020.11.29.11.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 11:48:26 -0800 (PST)
Date:   Sun, 29 Nov 2020 21:48:24 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/18] MAINTAINERS: Add linux-actions ML for Actions
 Semi Arch
Message-ID: <20201129194824.GC748744@BV030612LT>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <5845b7a323c65adaa1566c3bee68b5ca1f1bb17e.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128074350.GE3077@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201128074350.GE3077@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 01:13:50PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 20, 2020 at 01:56:12AM +0200, Cristian Ciocaltea wrote:
> > Add the linux-actions mailing list for the Actions Semi architecture.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> There was a patch from me for this change but I don't mind taking yours
> as long as we keep the list updated :)

Sorry about that, I often forget to manually append this mailing list
before submitting related patches and therefore I considered this is
a good opportunity to have this issue fixed once and for all.. :)

> I have just one comment below, with that fixed:
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a85c1881cf07..8428aba52581 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1497,6 +1497,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
> >  M:	Andreas Färber <afaerber@suse.de>
> >  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> 
> No need to keep the generic list, please remove.

Done, thanks!

> Thanks,
> Mani
> 
> > +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/arm/actions.yaml
> >  F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> > -- 
> > 2.29.2
> > 
