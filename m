Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5504C2A76B9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 05:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgKEEzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 23:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgKEEzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 23:55:41 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFFC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 20:55:41 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 32so297194otm.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 20:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i6MGr/Kg3VZyORAXNQIPSqeLnV8zx9yqFNyMUoSyDIg=;
        b=QybcdYkGQifdwCUvS6mzcHt5x/ze6Uk+AU8hfeX5CCttAAjMJ9JixZwigksaFEM1U8
         v/okucIqFFVU7VHHDOMk+/vW3ceFa/smhEYZKI3wHU4eN5TPV25FIT14cJgS7Zp7WLmJ
         gcjWURKjGLYBgmYycdwu1V64hbzyatd/3umDLpv/6+FshkDeLD1qJ35IK7KNbXnaMmzR
         SejanBqzPKxCy15mDtB2/KqyQTFGCQD0m/3N29NgrgYBsQyTWF4c0yWAvFBLe4RG+nYD
         3jMfs8d6Njg8jo76DutCptIjzK9ankBp9i7CdLZpoN5UwGUOg/Q4j2mBtdUq8SavqrwZ
         fRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i6MGr/Kg3VZyORAXNQIPSqeLnV8zx9yqFNyMUoSyDIg=;
        b=US7gDFdDLHzr1b3aP/rRYH6vQQz9JXUzpqkHoGK1kR0D0WR8zuoXdRd1yQ/GRVfenC
         6YP6ai61Q2gR7kWgydSwt3SZO5b1XMAH8a0lQlIzD39Ph6HJk21lOslj34bQ2tVzbwdt
         qpDBtZfYOJmmT5RVow0+tR7PDVry2WjriPBWNK927BD1G6AvLUSevvZKhgAqPmxj92dd
         HWfWF6wwIqNkeV7gAXlzarAp8eix+iOPWM4vXFzEUAuAY4HTlNGPFjtv7jjNWymu9hTc
         /lAIY7O+gH4iELMatHP6b4Bpdpu2xrxWF3H8Dr5EAFyBYV05qskZBuh6TrJdH0MC3lKh
         1oXQ==
X-Gm-Message-State: AOAM533ivGaSmdWcB7yX+TE6P0iitiEVuFpv56KBxGcnWTNw11JnEtpC
        8I7k+r6KQcwVSOC8/Pfp2INrrg==
X-Google-Smtp-Source: ABdhPJx8wemuxHJ5PcafcR+3WSW0gpy0QWAV+NsA3hxjXU/Wnf4rhD2zTdNnzBM3zh6Mhoi0OJRe7g==
X-Received: by 2002:a9d:7d87:: with SMTP id j7mr510237otn.356.1604552140570;
        Wed, 04 Nov 2020 20:55:40 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l23sm95998otk.68.2020.11.04.20.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 20:55:39 -0800 (PST)
Date:   Wed, 4 Nov 2020 22:55:38 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] remoteproc/mtk_scp: surround DT device IDs with CONFIG_OF
Message-ID: <20201105045538.GA29931@builder.lan>
References: <20201102074007.299222-1-acourbot@chromium.org>
 <20201104190547.GD2893396@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104190547.GD2893396@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 Nov 13:05 CST 2020, Mathieu Poirier wrote:

> Hi Alexander,
> 
> On Mon, Nov 02, 2020 at 04:40:07PM +0900, Alexandre Courbot wrote:
> > Now that this driver can be compiled with COMPILE_TEST, we have no
> > guarantee that CONFIG_OF will also be defined. When that happens, a
> > warning about mtk_scp_of_match being defined but unused will be reported
> > so make sure this variable is only defined if of_match_ptr() actually
> > uses it.
> > 
> > Fixes: cbd2dca74926c0e4610c40923cc786b732c9e8ef remoteproc: scp: add COMPILE_TEST dependency
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> >  drivers/remoteproc/mtk_scp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> > index 577cbd5d421e..f74f22d4d1ff 100644
> > --- a/drivers/remoteproc/mtk_scp.c
> > +++ b/drivers/remoteproc/mtk_scp.c
> > @@ -772,12 +772,14 @@ static const struct mtk_scp_of_data mt8192_of_data = {
> >  	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
> >  };
> >  
> > +#if defined(CONFIG_OF)
> >  static const struct of_device_id mtk_scp_of_match[] = {
> >  	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
> >  	{ .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, mtk_scp_of_match);
> > +#endif
> 
> I think it is better to add a "depends on OF" in the Kconfig.
> 

That would reduce the efficiency of COMPILE_TEST, so I would prefer that
we drop of_match_ptr(), which will result in the pointer always being
populated and this being referenced - although unused when built without
OF.

Regards,
Bjorn
