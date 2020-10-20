Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C30293D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407520AbgJTNiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407511AbgJTNiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:38:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C621DC061755;
        Tue, 20 Oct 2020 06:38:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w21so1200772pfc.7;
        Tue, 20 Oct 2020 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1r2t2ZYfZeKo1KiJjVc50PqCeCitnQyxUWktXHkwak0=;
        b=ExUSUiSh9X/YRPGXS/BKkjzwTyt+ujgHYdasPz1QHFtSeSxwVB2PmqQaxuK8zRBXn1
         4REQ5h/mii9wsIuM7cS2Myk7GROyQLu9hHlqNK4rjDGhXzcGtWEf2/tszKCHgk5lSrz9
         2CNxoFp8SBEwW+UdIDNnoWVBQ6rD43g9LmLmLt9rQ+KMy8J3Fp4eOne/rZQTMVqEmhCV
         33/Qew41vntIcaqn0JK7IUfTtUN3A2KoqI1t7LwzGEhEJ02ujNT8n4HpEojKfzi9I7qZ
         5PsxvzlKtt7WX7US/UgDmgoqxZe3vTQRgipfOjdNcNXABmdVGtgMrDvXGGrOOOyerLwy
         1DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1r2t2ZYfZeKo1KiJjVc50PqCeCitnQyxUWktXHkwak0=;
        b=IwlrmcH5KVEO1G72EdWRYvaLKMPc4lRPlCM10GyULiEzGCEJIsldfIO7flKG09IZuG
         KGT8QQNDE4EBoF9HQKaiSCw1EqUwCQNFqcsVZRax3x24lMqyiAs309hCHDRNquaYnkgI
         q+j7jMYsTVO0xJ0Sn/ehB05iyi6zIMMBwBXs4G0vK9VIfqtbhMNbwjWvtMeXgA4Ox1yW
         0tCl+dYYLcNYSlJSTDdm4/ImWB3GuN1GQdEa1gJBVwKpyjqRAM3rbSzeH3J1XYsbnSZu
         Ee9xC5gtzv3EJsISPYF7g5zJyyPF61us/KU7HLrpDICAIGgdB6dumBOptl0Vt79fK1V3
         zFaQ==
X-Gm-Message-State: AOAM533c46/XU7J9EgVN5c9aZjudbaxuCclwaEimiNShguJeBR5pDNG8
        1nplFE4c+BwUT80nRuHY5wo=
X-Google-Smtp-Source: ABdhPJwUQqUMbGlso9v92j3gDNX8pCMY2YnxCnI4a3YSWbFl0UL+X/lK0bLgp2Ky1swoLoxuV/XdAw==
X-Received: by 2002:a62:e104:0:b029:152:4f37:99da with SMTP id q4-20020a62e1040000b02901524f3799damr2766348pfh.17.1603201088600;
        Tue, 20 Oct 2020 06:38:08 -0700 (PDT)
Received: from localhost (23.83.240.116.16clouds.com. [23.83.240.116])
        by smtp.gmail.com with ESMTPSA id o2sm2234782pgg.3.2020.10.20.06.38.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 06:38:07 -0700 (PDT)
Date:   Tue, 20 Oct 2020 21:38:05 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sergei.shtylyov@gmail.com" <sergei.shtylyov@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: fix a issue about clear connect state
Message-ID: <20201020133805.GA14599@nuc8i5>
References: <20201019023435.5482-1-zhengdejin5@gmail.com>
 <58ce8257-422f-1e47-bc95-61262a3706f5@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58ce8257-422f-1e47-bc95-61262a3706f5@synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 10:04:41PM +0000, Thinh Nguyen wrote:
> Dejin Zheng wrote:

Hi Thinh:
> > According to Synopsys Programming Guide chapter 2.2 Register Resets,
> > it cannot reset the DCTL register by setting DCTL.CSFTRST for core soft
> > reset, if DWC3 controller as a slave device and stay connected with a usb
> > host, then, while rebooting linux, it will fail to reinitialize dwc3 as a
> > slave device when the DWC3 controller did not power off.
> 
> If you reboot the OS, wouldn't it go through the driver tear-down
> sequence and clear the run_stop bit anyway?
Yes, you are right, this is a point worth checking. and I think it might
still be necessary to reset it.

> However, I can see how this can be an issue.
>
> >  because the
> > connection status is incorrect, so we also need to clear DCTL.RUN_STOP
> > bit for disabling connect when doing core soft reset.
> >
> > Fixes: f59dcab176293b6 ("usb: dwc3: core: improve reset sequence")
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> > v1 -> v2:
> > 	* modify some commit messages by Sergei's suggest, Thanks
> > 	  very much for Sergei's help!
> >
> >  drivers/usb/dwc3/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 2eb34c8b4065..239636c454c2 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -256,6 +256,7 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
> >  
> >  	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
> >  	reg |= DWC3_DCTL_CSFTRST;
> > +	reg &= ~DWC3_DCTL_RUN_STOP;
> >  	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> >  
> >  	/*
> 
> There will still be other stale configuration in DCTL if you do this. I
> think it's better to reset the other fields of DCTL to the default
> (should be all 0s) instead of doing register read-modify-write as what
> we're doing here. If not, at least we should use
> dwc3_gadget_dctl_write_safe().
>
Thinh, thanks very much for your suggestion, I think it might be better
to reset all areas of DCTL register. I tested it on my SOC platform and
it worked.

BR,
Dejin

> Thanks,
> Thinh
> 
