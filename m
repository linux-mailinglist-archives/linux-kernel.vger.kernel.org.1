Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE92E35FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 11:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgL1Kns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 05:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgL1Knr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 05:43:47 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC1AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 02:43:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b9so13696550ejy.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 02:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L4pT+67E+Io5xSonBpdSaj43aXBjDIXVmmk7JUjhYNw=;
        b=fbZ/tYFU5DXguZAU5US4amIkcd/KBgMg/+9eATHE4QYlrZYYHODL1DE+XE+ZOXTWbp
         HPPQvNppOaEOjUlq7x7jRIu6qHRY9ck4nVYnaUIC2UbWbA1S0AInXTfgIsBJQx6JxDTu
         iIrCzNnrIV+aA034SSOEspHcgNUCxrYpbhlObZVkrnBG7LAjTBjcGHJKesq/N9AcfiaC
         stY7ZKfVtk4EEk4BLuswKw1nnMtKzn0edbHDiI6IpUYHKCKjZR023F7OocXsbhmodFRc
         L9E7FPmd15ph3ESNNMckof5s3JVlOysk5HiZYj6OxmwZiP8OdYa6V5a8Ho82t+aslbNc
         JPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L4pT+67E+Io5xSonBpdSaj43aXBjDIXVmmk7JUjhYNw=;
        b=QG3SPLnIFU4cyne2ukq5nvB/upttr4JvJwZf3/TQEHTqIFr04gqgezPSREQLdpqwWH
         Qao/CkbC1+UMMypWZ3gWs56lfsCGLELB2HUUB9MtpNLONDHmKFPP7/L12eKx5X7aKffp
         fsk1WbE7XfJn/nBtIij1aKpmvpt1z6K3jLIJyERYvsAQbYOI7bhghZARHbpPgEy10vi0
         KAoSKdZGolZCZiaXTcAgRUwTo/lMMkXK8ogT+/DrPJWcHkRigStMGzYmuL153dAzQfi0
         Mrc0cG4carIYrihau53+RME4WRQgeEpKO1KxumNqX7CcIIIPt77ELK3CtvKZpsuLJmmi
         +DZw==
X-Gm-Message-State: AOAM532I7gveTeHu5o8J6zc5e0wrgHXKXYeBuBrSN7ojy+0S2Ttn0kaQ
        JApIHtLU/KjX1xJs0FFTEt0=
X-Google-Smtp-Source: ABdhPJwQAnPNwpmIfDrX1O9BBceg9jvQ3R98FHjws+3i1SsPYNl/6Q83A/m4e0hFwB0HlsTR0vGR9A==
X-Received: by 2002:a17:907:2070:: with SMTP id qp16mr40664592ejb.503.1609152185654;
        Mon, 28 Dec 2020 02:43:05 -0800 (PST)
Received: from ubuntu2004 ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id s12sm36424862edu.28.2020.12.28.02.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 02:43:04 -0800 (PST)
Date:   Mon, 28 Dec 2020 12:43:07 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/18] MAINTAINERS: Add linux-actions ML for Actions
 Semi Arch
Message-ID: <20201228104307.GA836928@ubuntu2004>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <5845b7a323c65adaa1566c3bee68b5ca1f1bb17e.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128074350.GE3077@thinkpad>
 <20201129194824.GC748744@BV030612LT>
 <fed29816-561a-7187-302f-09ab37beddca@suse.de>
 <20201205055414.GB2250@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201205055414.GB2250@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 11:24:14AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 30, 2020 at 01:54:45AM +0100, Andreas Färber wrote:
> > On 29.11.20 20:48, Cristian Ciocaltea wrote:
> > > On Sat, Nov 28, 2020 at 01:13:50PM +0530, Manivannan Sadhasivam wrote:
> > >> On Fri, Nov 20, 2020 at 01:56:12AM +0200, Cristian Ciocaltea wrote:
> > >>> Add the linux-actions mailing list for the Actions Semi architecture.
> > >>>
> > >>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > >>
> > >> There was a patch from me for this change but I don't mind taking yours
> > >> as long as we keep the list updated :)
> > > 
> > > Sorry about that, I often forget to manually append this mailing list
> > > before submitting related patches and therefore I considered this is
> > > a good opportunity to have this issue fixed once and for all.. :)
> > > 
> > >> I have just one comment below, with that fixed:
> > >>
> > >> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >>
> > >>> ---
> > >>>  MAINTAINERS | 1 +
> > >>>  1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/MAINTAINERS b/MAINTAINERS
> > >>> index a85c1881cf07..8428aba52581 100644
> > >>> --- a/MAINTAINERS
> > >>> +++ b/MAINTAINERS
> > >>> @@ -1497,6 +1497,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
> > >>>  M:	Andreas Färber <afaerber@suse.de>
> > >>>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > >>
> > >> No need to keep the generic list, please remove.
> > 
> > Why? They're not mutually exclusive.
> > 
> 
> Yes but why do we want to spam it? Currently we don't archive actions tree in
> lore but I can do that.

Hi Mani, Andreas,

I'm going to prepare a new revision of this patch series, but I'm not
really sure how should I handle this patch: keep the 'linux-arm-kernel'
list or drop it?

Thanks and regards,
Cristi

> Thanks,
> Mani
> 
> > Regards,
> > Andreas
> > 
> > > 
> > > Done, thanks!
> > > 
> > >> Thanks,
> > >> Mani
> > >>
> > >>> +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
> > >>>  S:	Maintained
> > >>>  F:	Documentation/devicetree/bindings/arm/actions.yaml
> > >>>  F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> > >>> -- 
> > >>> 2.29.2
> > >>>
> > 
> > 
> > -- 
> > SUSE Software Solutions Germany GmbH
> > Maxfeldstr. 5, 90409 Nürnberg, Germany
> > GF: Felix Imendörffer
> > HRB 36809 (AG Nürnberg)
