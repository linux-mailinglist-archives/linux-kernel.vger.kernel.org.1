Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF1E2688A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgINJke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgINJk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:40:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E99C06174A;
        Mon, 14 Sep 2020 02:40:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l9so10529898wme.3;
        Mon, 14 Sep 2020 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oa/d3xtFztG+1F7w19dQiVtlu9Ybx4E8vqCz+GkkWv0=;
        b=AGEBogUO2qjGXPbZL1EyaiB+BBFdsiMZWEuO1LtyMcB/4AwV2jHRX/lx/vkvFTCu6S
         quL/QSsqfW7UgmZaDc+s4XoJcrVFOUJXNZwCBJ5KF/3a9DTZo3RdxFVm616Jhn5/+DbW
         3ZH0279gI7YaGB03iQA5ug9qCvEeWVNrk8cNmdwNiL1AaUFzCo/OWlCgxUIH6T4D22oc
         jOYa6I4oWrVTYQ6PYtum9T8Hd9kXrCtdjWiv+wjzKcv7mzn3KbYsYHUIqOWT5duJFnAO
         JSTkurAw3D8DUKteYEqHtAvh9YMTk653PtUL6rzmKvPT2lbeU3hUN9ocdWo31K6P4BZP
         78xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oa/d3xtFztG+1F7w19dQiVtlu9Ybx4E8vqCz+GkkWv0=;
        b=LmwtGBoVQ0bhaYz42c2+GE3nDGY/wCCFMg68jElF+C6sRgscEHCMh5L+3RAmoOhKjV
         HukSmnIMN6PXUIONFSs5BHkfU2pVCeNBI6EVGlW3UmXaEHFmK29iu1RU4EdBENwXB817
         Ex/vXspUnm8Hptfpr25RJdu5nd8w8znd36UFxlhGMhaGqVub/ghqlCCv44LpUnjECnCV
         Mtzg8GTVtNERxS5/0c3dxa0u8Q/A4hvGmni2lIlPapE50wZvHNoQkJxREXDLdM4q57ol
         jHB8PJHbiycMCtM6sb6IMRRZ/wzpQHSjREGYHPMhyase1K7BHXqO8k2K2LifHwtirTfD
         8M9g==
X-Gm-Message-State: AOAM5336b5QmUGRUltvrlDkPELv6ZRWWbK6QPoERKl6mQJFLY1PA3zSd
        tkPTJ7YQdXQUb17qlbWHXuI=
X-Google-Smtp-Source: ABdhPJx3EnwiLrRH4iajYzlGQZXDgrJVsN38lzsgiKh9dSdXDiV118y36fEPOvkrSFv+GaJ0WV5JbQ==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr14294699wml.42.1600076426625;
        Mon, 14 Sep 2020 02:40:26 -0700 (PDT)
Received: from BV030612LT (oi48z9.static.otenet.gr. [79.129.51.141])
        by smtp.gmail.com with ESMTPSA id u13sm19261555wrm.77.2020.09.14.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 02:40:25 -0700 (PDT)
Date:   Mon, 14 Sep 2020 12:40:22 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        parthiban@linumiz.com, Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v6 2/3] irqchip: Add Actions Semi Owl SIRQ controller
Message-ID: <20200914094022.GA12167@BV030612LT>
References: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
 <1167b847f6fe1da3834aeaadf5710ddac54f06a0.1599552438.git.cristian.ciocaltea@gmail.com>
 <c5115d27739e1664f808ff5f1fc315e8@kernel.org>
 <20200914070227.GA4491@BV030612LT>
 <b9053e939dea2b67ba9804aec1a110f5@kernel.org>
 <20200914085154.GA8474@BV030612LT>
 <0cdd2fd4e09c7e51b8b48be914c6846f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cdd2fd4e09c7e51b8b48be914c6846f@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:19:31AM +0100, Marc Zyngier wrote:
> On 2020-09-14 09:51, Cristian Ciocaltea wrote:
> > On Mon, Sep 14, 2020 at 09:07:18AM +0100, Marc Zyngier wrote:
> > > Cristian,
> > > 
> > > On 2020-09-14 08:02, Cristian Ciocaltea wrote:
> > > > Hi Marc,
> > > >
> > > > On Fri, Sep 11, 2020 at 05:22:41PM +0100, Marc Zyngier wrote:
> > > > > On 2020-09-08 09:20, Cristian Ciocaltea wrote:
> > > > > > This interrupt controller is found in the Actions Semi Owl SoCs (S500,
> > > > > > S700 and S900) and provides support for handling up to 3 external
> > > > > > interrupt lines.
> > > > > >
> > > > > > Each line can be independently configured as interrupt and triggers on
> > > > > > either of the edges or either of the levels. Additionally, each line
> > > > > > can also be masked individually.
> > > > > >
> > > > > > The patch is based on the work started by Parthiban Nallathambi:
> > > > > > https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/
> > > > > >
> > > > > > Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> > > > > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > > > > [cristi: optimized DT, various fixes/cleanups/improvements]
> > > > > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > > >
> > > > > Who is the author of these patches? If this is a co-development,
> > > > > please
> > > > > use the relevant tags. Otherwise, the author of the patch must come as
> > > > > the first SoB.
> > > >
> > > > I took the authorship for the driver patch, as mentioned in the cover
> > > > letter. So, if I understand correctly, my SoB should be moved on top and
> > > > I assume I also need to drop the related comment line.
> > > 
> > > Not quite. Please look at
> > > Documentation/process/submitting-patches.rst.
> > 
> > Yes, I have read it, but most probably I missed the information that
> > clarifies this authorship change handling.
> > 
> > > If Parthiban and Saravanan haven't authored anything in this patch,
> > > then drop them from the SoB list.
> > 
> > Sorry I haven't properly explained this before!
> > 
> > Their contributions to the driver code stopped in 2018, when v3 of the
> > patch series has been submitted.
> > 
> > > If they have contributed to the
> > > patch (which I expect), then their SoB must be preceded by their own
> > > Co-developed-by: tag.
> > 
> > Starting with v4, the work has been done exclusively by myself.
> > 
> > > To sum it up, it probably should look like:
> > > 
> > > Co-developed-by: Parthiban Nallathambi <pn@denx.de>
> > > Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> > > Co-developed-by: Saravanan Sekar <sravanhome@gmail.com>
> > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > 
> > > This is of course an assumption, and you should check it with the
> > > individuals above.
> > 
> > I have recently contacted Parthiban and he agreed that I can take the
> > authorship. So I should proceed with the 1st approach?
> 
> The authorship of the patch is one thing, acknowledging the work done
> by others is another. As you said above, you started by contributing to
> an existing series, instead of writing it from scratch. You changed it
> to a degree where it makes sense for you to be the author of the patches,
> but it doesn't invalidate the contributions made by others before you.
> 
> Unless the two other contributors explicitly say they'd rather not be
> named, I don't see how you can avoid mentioning them.
 
I just want to do the right thing and follow the recommended procedure.
That's why I initially kept all the SoBs, but obviously I still missed
some bits and pieces, as you have pointed out.

So I will add the indicated Co-developed-by tags and resend the series.

> Thanks,
> 
>       M.
> -- 
> Jazz is not dead. It just smells funny...

Thanks a lot for all the clarifications,
Cristi
