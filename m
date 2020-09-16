Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7731B26C58A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgIPRFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgIPRAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:00:50 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF92C004590
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:07:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f142so8178851qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=La99VFybE95ljQbGxohkbmDHsRKJC2A6ovW4ZDnoPGg=;
        b=VOJ9CnElE1tIzpvRDzSJxLQXWm/++E5FKZhGlhD2qVUn6aMIi84JEKIgO4BLKBmrP8
         08+579lu3VaATYWW4i8PGHX9Si56Ffjc2npOiCodIUUWmw/m9Buy2lOkdee413PzBJtT
         x9mYMzsldhpi7ImCKJBtzzGQ3/8cMBlG1qLA+/dMmxPgByr1NS/GqvGpDW5O/vceKxtJ
         +XQSEKzGfX7GYU0a3pfCCcvviY717MYm16mP2bE42kUhSaKvxtNvUTUwkG+cuUo+ADJz
         ftd1VkfL3CHhvcCXW38fSX0htUIapxKqapCQC8eiBeQHlHvZFfCUe4nIqG0OLueSoAQq
         4aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=La99VFybE95ljQbGxohkbmDHsRKJC2A6ovW4ZDnoPGg=;
        b=gFhzvrLfRUSGTo0ro96yAN8VQEQdersQ3E/qmZUlWy6StPfBjeVR8IApD7W0IR9s2l
         pt8cAyBHI70bFm0ecJN5f7CK9ciZwpuzpa9JLXPbLbccFG80eHy7PoCWNX9uG482QUex
         KLgEr3w8PgWrvtUyFlIvIlSv9jBiz2jrhlo1mYh8iwRoX/O7zWGdpuV2uI3vr/lJWmNk
         8puXHrE8jSyv5quFUAGqTP4YJGQf6BE4kJXg51BggkJX5vii08JHG7hOdmpHRZlr1oWb
         x4hF1L7+wSO/+Mh810TuND+jZydD43O+SBk7YcfhTqyA4KL4aEb/4r70KSnDJbc7yD5w
         b3Rg==
X-Gm-Message-State: AOAM531ueE2GmImdkyECICv1F4LOjQH092rxd6aV0IIEtHqHY879XzeC
        rezDJrzLQt13i/5hOe2sj89ayg==
X-Google-Smtp-Source: ABdhPJyGvoVtODTTRAjWRbOAqjMljnU8wALvrzaWChMgxILat6SxGUHhK0nHHjrTElsiKnfbm48/tg==
X-Received: by 2002:a37:84f:: with SMTP id 76mr22783375qki.251.1600265232291;
        Wed, 16 Sep 2020 07:07:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k48sm20623786qtk.44.2020.09.16.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 07:07:11 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIY5W-0002hp-NA; Wed, 16 Sep 2020 11:07:10 -0300
Date:   Wed, 16 Sep 2020 11:07:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     christian.koenig@amd.com, akpm@linux-foundation.org,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Changing vma->vm_file in dma_buf_mmap()
Message-ID: <20200916140710.GA8409@ziepe.ca>
References: <20200914132920.59183-1-christian.koenig@amd.com>
 <40cd26ae-b855-4627-5a13-4dcea5d622f6@gmail.com>
 <20200914140632.GD1221970@ziepe.ca>
 <9302e4e0-0ff0-8b00-ada1-85feefb49e88@gmail.com>
 <20200916095359.GD438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916095359.GD438822@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:53:59AM +0200, Daniel Vetter wrote:

> But within the driver, we generally need thousands of these, and that
> tends to bring fd exhaustion problems with it. That's why all the private
> buffer objects which aren't shared with other process or other drivers are
> handles only valid for a specific fd instance of the drm chardev (each
> open gets their own namespace), and only for ioctls done on that chardev.
> And for mmap we assign fake (but unique across all open fd on it) offsets
> within the overall chardev. Hence all the pgoff mangling and re-mangling.

Are they still unique struct files? Just without a fdno?
 
> Hence why we'd like to be able to forward aliasing mappings and adjust the
> file and pgoff, while hopefully everything keeps working. I thought this
> would work, but Christian noticed it doesn't really.

It seems reasonable to me that the dma buf should be the owner of the
VMA, otherwise like you say, there is a big mess attaching the custom
vma ops and what not to the proper dma buf.

I don't see anything obviously against this in mmap_region() - why did
Chritian notice it doesn't really work?

Jason
