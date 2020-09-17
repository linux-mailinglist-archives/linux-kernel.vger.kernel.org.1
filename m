Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2E26E3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIQRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIQRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:25:10 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB8C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:24:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id z18so1373643qvp.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qnISMbW3nm4yggbOBgqyVMEyiRIror+WZEAjWJm/K2g=;
        b=FgfHEC+paMaduo6pBiGfkE6HvXXKKjAXDfribiWG8g4jTuepijvRaEFw+U+dfXI5oo
         OJL4xOE4CizfEM/4FWvJAG4beepZ2VRh626USUpegbA0MWIvyPkWb1ogt8sXzndhQEfV
         5FV6VLMO4GQ2Zvzwu9bdBiiY9SrU1s9ehrpmJcZD8t23FjgQ61jVLKYlaXgdUBeSK/cB
         DAnDPvvilysMmI7oWRL+vD4bEodstP5lgTEHQFP/Ut0ngu0vMuhDk99Q8bVXK5rcR1tg
         0mFZeVCzJJrRJD+5LBgOQRWQKsloBbweX4HVZaSGNEPEa7phLjn0k5d3jKDAQQ0NF/r1
         3YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qnISMbW3nm4yggbOBgqyVMEyiRIror+WZEAjWJm/K2g=;
        b=nIjzTrzdmxcMqQc7dqZntogpa9t2jAQoQGtRyd+uUxMj/MKmeJGrhUujF74ZnWS1qW
         ipWd/lwy/ys7RLouFPnbx0hPZBVb+4/OSUaLK4peyMOfkLMIqRQG9/UdL5g+b5JX1Uzu
         ZsmMwl+QFPCZ199woWPv1aM/EGqmBCRCwSXJquvNXEQyis8XtcZPEpWyVat4eHLvAXvz
         0O7Lp/pSN3sBGs850ub5P2knfKBKWzb2ETBcOuOQ52SsERK24BFzWSGszJIjGUC0Vsls
         sSIyfkSYyKapYi3Zrmeb+uh5igBvVxHB1TTMB2qvggF1VQpoZXaXBEnk20UetuzWc5NV
         tEVw==
X-Gm-Message-State: AOAM530p/7+kFkruBOaW7rLqfjWf7mwLdaVQ/PN9ht6HbhYcLRqXI4AR
        6o9XRcqbFHtrDtrUDJhUUDFTfw==
X-Google-Smtp-Source: ABdhPJxT+y+sQqjzbnRyXv8mTryKXanFEp2eAHIugZuaFmBoM8WwlSxulEay3IkHrwXW7q8cM9fRDg==
X-Received: by 2002:a0c:a990:: with SMTP id a16mr12961214qvb.59.1600363493126;
        Thu, 17 Sep 2020 10:24:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o26sm254821qtb.24.2020.09.17.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 10:24:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIxeN-000akx-Ni; Thu, 17 Sep 2020 14:24:51 -0300
Date:   Thu, 17 Sep 2020 14:24:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/mlx5: fix type warning of sizeof in
 __mlx5_ib_alloc_counters()
Message-ID: <20200917172451.GK8409@ziepe.ca>
References: <20200917082926.GA869610@unreal>
 <20200917091008.2309158-1-liushixin2@huawei.com>
 <20200917090810.GB869610@unreal>
 <20200917123806.GA114613@nvidia.com>
 <20200917170511.GI869610@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917170511.GI869610@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 08:05:11PM +0300, Leon Romanovsky wrote:
> On Thu, Sep 17, 2020 at 09:38:06AM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 17, 2020 at 12:08:10PM +0300, Leon Romanovsky wrote:
> > > On Thu, Sep 17, 2020 at 05:10:08PM +0800, Liu Shixin wrote:
> > > > sizeof() when applied to a pointer typed expression should give the
> > > > size of the pointed data, even if the data is a pointer.
> > > >
> > > > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> >
> > Needs a fixes line
> >
> > > >  	if (!cnts->names)
> > > >  		return -ENOMEM;
> > > >
> > > >  	cnts->offsets = kcalloc(num_counters,
> > > > -				sizeof(cnts->offsets), GFP_KERNEL);
> > > > +				sizeof(*cnts->offsets), GFP_KERNEL);
> > >
> > > This is not.
> >
> > Why not?
> 
> cnts->offsets is array of pointers that we will set later.
> The "sizeof(*cnts->offsets)" will return the size of size_t, while we
> need to get "size_t *".

Then why isn't a pointer to size **?

Something is rotten here

Jason
