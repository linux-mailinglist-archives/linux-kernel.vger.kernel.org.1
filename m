Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97682888BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgJIMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgJIMbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:31:12 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE64C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 05:31:12 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c23so7776968qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K8oqjNwy1IItwzS5nAtnJfKoqbYdlnvHoUJ/yQIxMlE=;
        b=cdaBlGmBZL4cakXZlvJuZERmIRIX6jD7dwzimgC10KWdoWEXxqnVyCAO2D0RVxCrE3
         SiHI343vdap2cRRglH6ua6mGWuo7/fxfox6RkGqmDhIsAnKFSeohUX9VYGJSKAwhIU6B
         2TcxKC37KpT1QUH/a9OmlQtDEo327+kakIXLdXGqBOKFhRN4BS67JiDu+bvG4a5CPI+r
         pqcyhIAj+gFL2/lmzDWusy4E62ErCo67w+IagQCo+gX4l+6CaOr61WFu2i1yy0l+Wgf3
         xGuhQ4gDKh6os3wK0BjatM5g2y6nWPQvLIHBtHwaCM52uhc/sKGK0XWe8qKcZr9st8fm
         fLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K8oqjNwy1IItwzS5nAtnJfKoqbYdlnvHoUJ/yQIxMlE=;
        b=lrtVTrbvtI+Zrw+3VJwQZiuVoufZ1RruOzfgAlLaIbpEA0qzppKRe9AtUmswxiPWFV
         W4Ok9BN6Cx4iXPj3xd6kKRcAIh/pHf4mrOiYf+gbjEKaFRR9WFk8CyS61Q+AU7EZC/M7
         Bs4A13MYtrW+6Zhe+6TilwBHNGBHKJUmdMpqKfh0wGBeBZ3kEJFMu2hM4zp9AXG80Lu8
         cz8kbek1aUL3YIhK5sUZ8L6Hcfp7E6Dd/geUx3tN/w6s6jVcjMB3oEkPoVqt+MGvacca
         BOLw2gID2jYj0ezJJSWH4jjp2mXj+dpBqeEqCeNNpu+RTi74G1rZbA3aTPjFdl6LdDM4
         /Kzg==
X-Gm-Message-State: AOAM5308KGAZqqypF4hnX86JTy/CQ5OAj6eTVqDmoXI1ZApljdJ9PD6/
        goAbqM31vqI2vZTv2qMLXrdyfg==
X-Google-Smtp-Source: ABdhPJxG8zCIXDditfEGKgb8JSFeGI61awPyS7AMuV2YFh9LkEtvSTVL1XgAfKTEjxIzUEviyqvgUw==
X-Received: by 2002:ac8:d8d:: with SMTP id s13mr12568868qti.42.1602246671500;
        Fri, 09 Oct 2020 05:31:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g1sm6069368qtp.74.2020.10.09.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 05:31:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQrYD-001xsF-Sz; Fri, 09 Oct 2020 09:31:09 -0300
Date:   Fri, 9 Oct 2020 09:31:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 14/17] resource: Move devmem revoke code to resource
 framework
Message-ID: <20201009123109.GO5177@ziepe.ca>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-15-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009075934.3509076-15-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 09:59:31AM +0200, Daniel Vetter wrote:

> +struct address_space *iomem_get_mapping(void)
> +{
> +	return iomem_inode->i_mapping;

This should pair an acquire with the release below

> +	/*
> +	 * Publish /dev/mem initialized.
> +	 * Pairs with smp_load_acquire() in revoke_iomem().
> +	 */
> +	smp_store_release(&iomem_inode, inode);

However, this seems abnormal, initcalls rarely do this kind of stuff
with global data..

The kernel crashes if this fs_initcall is raced with
iomem_get_mapping() due to the unconditional dereference, so I think
it can be safely switched to a simple assignment.

Jason
