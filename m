Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E51AD1F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 23:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgDPVfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 17:35:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40604 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDPVfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:35:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id t199so280711oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 14:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tWpSGNBaMFU18t4G42eRf7uq/0lzKZgYkGx4emWEElE=;
        b=d7LzzVb7CUXUt3GsKldUvJ5iIlUb4vEWGm/dXrnJrf7ub1c8BMwy17U1qKe6pPiiJ3
         DTtoxxAzUPmbuZlrL3eerCMFNc8c+JvvvcpO46fni75xMp3MndUtwjVWaRmb63lfe7qx
         hL3mz9D/ooRSVNWq3kh8JavPiBaQ855WcFFAJJBYlSiGgZmq3YMUSCCBb3Rn6RAa+joZ
         uycAJj0Lbhn24vHTNqRTStVy6S3IAZcmZrLfJMuUrWYCFCL/MhuSzzjD576ZrBU5TOlD
         zAdfSND9hbzpYF3NfO38EUPVAJCxJhjJ/VFDTVnrQWSAwLINbBsKGHisJhY4zR1i/VC5
         y3pQ==
X-Gm-Message-State: AGi0PuZTtxmXey442HmJsmCQBrU9raxE4EKpk/Iuo7ooEDtH40yUX6AA
        oArjpJs6tikwZ5Pt6XvcacFZYEc=
X-Google-Smtp-Source: APiQypKwYD7vKsXxEYld0OsFN+djRcK121t4H9hMJPGsYoVvteuXNznqBneMLgwV2X7+/OOLNhe9gQ==
X-Received: by 2002:aca:c385:: with SMTP id t127mr112809oif.49.1587072937377;
        Thu, 16 Apr 2020 14:35:37 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a131sm7440469oii.30.2020.04.16.14.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:35:36 -0700 (PDT)
Received: (nullmailer pid 7336 invoked by uid 1000);
        Thu, 16 Apr 2020 21:35:35 -0000
Date:   Thu, 16 Apr 2020 16:35:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Scott Wood <oss@buserror.net>
Cc:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, kernel@vivo.com
Subject: Re: [PATCH v4,4/4] drivers: uio: new driver for fsl_85xx_cache_sram
Message-ID: <20200416213535.GA2511@bogus>
References: <20200416153537.23736-1-wenhu.wang@vivo.com>
 <20200416153537.23736-5-wenhu.wang@vivo.com>
 <16f8fa2d26d88f22ed05e9870709c2fd5c3960cf.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16f8fa2d26d88f22ed05e9870709c2fd5c3960cf.camel@buserror.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 02:59:36PM -0500, Scott Wood wrote:
> On Thu, 2020-04-16 at 08:35 -0700, Wang Wenhu wrote:
> > +#define UIO_INFO_VER	"devicetree,pseudo"
> 
> What does this mean?  Changing a number into a non-obvious string (Why
> "pseudo"?  Why does the UIO user care that the config came from the device
> tree?) just to avoid setting off Greg's version number autoresponse isn't
> really helping anything.
> 
> > +static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> > +	{	.compatible = "uio,mpc85xx-cache-sram",	},

Form is <vendor>,<device> and "uio" is not a vendor (and never will be).

> > +	{},
> > +};
> > +
> > +static struct platform_driver uio_fsl_85xx_cache_sram = {
> > +	.probe = uio_fsl_85xx_cache_sram_probe,
> > +	.remove = uio_fsl_85xx_cache_sram_remove,
> > +	.driver = {
> > +		.name = DRIVER_NAME,
> > +		.owner = THIS_MODULE,
> > +		.of_match_table	= uio_mpc85xx_l2ctlr_of_match,
> > +	},
> > +};
> 
> Greg's comment notwithstanding, I really don't think this belongs in the
> device tree (and if I do get overruled on that point, it at least needs a
> binding document).  Let me try to come up with a patch for dynamic allocation.

Agreed. "UIO" bindings have long been rejected.

Rob
