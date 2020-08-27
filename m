Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95469253AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 02:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgH0ALx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 20:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgH0ALw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 20:11:52 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CA0C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 17:11:52 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so4392546qka.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 17:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dCluAD0PN3QnKR1L6av9Yix65gTIcPBWE23e5ipBNOg=;
        b=I5RpbHbZ5XZ0XXivHFDSvP9p51uLPnb2qMfaIj6qSSTCE44kBPxf49wchi5i5rnAtA
         flQwe1O1YWroNoYZ/A/7x02aUgY0R1fVX5XS/WhQU2ulTznktJCKGXfA0uAdhi3xaFdj
         ET2jbPehovlan8l5E5xP2wbiclhcTNH50AA4vWGKGvPyX+TkhXSmiXAO/kQ2kSaGnJvx
         IGO9hOw+LJc/LYyjj96ErRhif1HMub9xLf/0cI5pqI9nDiYjohXBAQPUPV6JdQR3es15
         4y9+oY2ftEBBKByZ3YjZ7PUEEYFeJUwbhi2xowJG0t1Y3J8rVj7uxvyeIapT8WLmDCkz
         Wbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dCluAD0PN3QnKR1L6av9Yix65gTIcPBWE23e5ipBNOg=;
        b=ARa7Hbeu4ahFpUYqEnCweekGE7fVKD2JUTypPqzr4D1SdQ3MjGvfdlJMYKx045qfC2
         VJ4SbGQkFwF2iwqRRE3mVcXlUhrw4Q1ra5Chdo05vrhcuTRdvl549JviXZZd5yWiNijE
         IxfJuj37d87foPkiZfIGczMxKcuIF2KO1tyt1MK6d+FWebtf87dkYsQNN3uk33pm9M4p
         bG1Wi26Z6NQgcbILG0Noco1cmVO+6VAb/bIIwrId5tZusTSvMIwrCqvRHk/KlzyVqImY
         RqVjWgQEpHG/L0oWCkYOXbuLfnfdwEkmXcWnOex1zQCCht3x64KgnBnhaP0eTvJZpmss
         04Uw==
X-Gm-Message-State: AOAM530cU5peZD0f983gvEQjWABHrVGhzrvLRqfpnsneIT1nosI5mNZ1
        XhRh4hDssR+AUafhyPfkZwuFbA==
X-Google-Smtp-Source: ABdhPJwUgyahGD12NG/wuD8f/tDKHjQNftvGasarmXg0H7l1YwOsJ3yIFu35ruJvTzEHD3OfrLI91A==
X-Received: by 2002:ae9:e102:: with SMTP id g2mr15816477qkm.134.1598487111253;
        Wed, 26 Aug 2020 17:11:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y22sm558789qkj.114.2020.08.26.17.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 17:11:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kB5W9-00GRHE-Lq; Wed, 26 Aug 2020 21:11:49 -0300
Date:   Wed, 26 Aug 2020 21:11:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Alex Dewar <alex.dewar90@gmail.com>, dennis.dalessandro@intel.com,
        dledford@redhat.com, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mike.marciniszyn@intel.com, roland@purestorage.com
Subject: Re: [PATCH v2 1/2] IB/qib: remove superfluous fallthrough statements
Message-ID: <20200827001149.GK24045@ziepe.ca>
References: <64d7e1c9-9c6a-93f3-ce0a-c24b1c236071@gmail.com>
 <20200825171242.448447-1-alex.dewar90@gmail.com>
 <20200825193327.GA5504@embeddedor>
 <20200826191859.GB2671@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826191859.GB2671@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 02:18:59PM -0500, Gustavo A. R. Silva wrote:
> Hi,
> 
> On Tue, Aug 25, 2020 at 02:33:27PM -0500, Gustavo A. R. Silva wrote:
> > On Tue, Aug 25, 2020 at 06:12:42PM +0100, Alex Dewar wrote:
> > > Commit 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
> > > erroneously marked a couple of switch cases as /* FALLTHROUGH */, which
> > > were later converted to fallthrough statements by commit df561f6688fe
> > > ("treewide: Use fallthrough pseudo-keyword"). This triggered a Coverity
> > > warning about unreachable code.
> > >
> > 
> > It's worth mentioning that this warning is triggered only by compilers
> > that don't support __attribute__((__fallthrough__)), which has been
> > supported since GCC 7.1.
> > 
> > > Remove the fallthrough statements.
> > > 
> > > Addresses-Coverity: ("Unreachable code")
> > > Fixes: 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
> > > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > 
> > Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > 
> 
> I can take this in my tree for 5.9-rc3.

That would make conflicts for the 2nd patch, lets just send them all
through the rdma tree please. Is there a reason this is -rc material?

Jason
