Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55381C79A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 20:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgEFSp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbgEFSp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:45:29 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE46C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 11:45:27 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g16so2384066qtp.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Xp4PtIWSbFjNlCqFouJe0yrPGUY2LlWC8culMqw4W34=;
        b=R7lsSWur/AS2+mWO7IfggMu+O6gDIpHb5fsBvc2LXsH3PmDGNjMK0zpysOcb4Eb+cz
         mf1+TNibVmiOreGgMt3vNl0KRwbfkShNrsiJbn/DxYcbSmXH5gNZ2gXIH9fCOUIYt2rx
         uufl1oq3YEnO5fNw5YpjjaxL6Z++oij1nCST3wT/cti8pRbhvx/M4SzbZD4RgxRFb8j/
         a+zbity4CLj+uAm+lxJ1UlFhn4tfneJczLNr2kYjP8d52NCpunCB2utDdguPKw1NtyIw
         xRCnoJJk0pa86wmw4nQiE5mnB14UQ13vcfrECf72UWGBC29459PJrqkAuJYkcOi1aUv5
         XJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Xp4PtIWSbFjNlCqFouJe0yrPGUY2LlWC8culMqw4W34=;
        b=rA8iTDAiOu7S7ZyZZ9aZisVyZMiSDchK7btvpEEy7CFJpPnkB65IdO1VvXh9br7tMe
         +mUpMq0mEbUKkvAL5ov77P1Ap7xqzc0zFT5pg6s340gRaxjyl/zX9hayFF9SfP6J/ZO6
         lUmz2c4UyEOdhHPrOa//RTAOLsxvwgSTRJMZKIzATQ9+Xx+r+tUhfmh0oFjpqRTrpopY
         rcfpgkPzlezCw7Ammc2zEtlMTlU9nO5iAZDsQO/FfYMPRTmCCBvZUAgonaS4QN901Tcm
         xQjqcdo0r2whTrYXLKdGxNwTn5WXXdXVlxYryWvsAN9uYCXGDoVSbjZUbLxIkZN8batw
         uK3w==
X-Gm-Message-State: AGi0PuZDrz6BwiZbI9jcFr9F6rZVTl+Qt3ILVfOQdq+1VFU6AC6/atyJ
        /L7FFDhYz/qeq5DhVmyFgEorYA==
X-Google-Smtp-Source: APiQypL616xxVLy7sIJ2gUjjzq8FfTN3eeP1TOOdrppMGZHDTaCWu7Efs5+lgJDGx3ZLUW9Bw/3rtw==
X-Received: by 2002:ac8:4d06:: with SMTP id w6mr9559957qtv.180.1588790727109;
        Wed, 06 May 2020 11:45:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x5sm715097qtx.35.2020.05.06.11.45.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 11:45:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWP2s-0002GJ-3V; Wed, 06 May 2020 15:45:26 -0300
Date:   Wed, 6 May 2020 15:45:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH hmm v2 0/5] Adjust hmm_range_fault() API
Message-ID: <20200506184526.GA8668@ziepe.ca>
References: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 03:20:43PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> The API is a bit complicated for the uses we actually have, and
> disucssions for simplifying have come up a number of times.
> 
> This small series removes the customizable pfn format and simplifies the
> return code of hmm_range_fault()
> 
> All the drivers are adjusted to process in the simplified format.
> I would appreciated tested-by's for the two drivers, thanks!
> 
> v2:
>  - Move call chain to commit message
>  - Fix typo of HMM_PFN_REQ_FAULT
>  - Move nouveau_hmm_convert_pfn() to nouveau_svm.c
>  - Add acks and tested-bys
> v1: https://lore.kernel.org/r/0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> To: Ralph Campbell <rcampbell@nvidia.com>
> Cc: nouveau@lists.freedesktop.org
> Cc: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: "Yang, Philip" <Philip.Yang@amd.com>
> To: linux-mm@kvack.org
> 
> Jason Gunthorpe (5):
>   mm/hmm: make CONFIG_DEVICE_PRIVATE into a select
>   mm/hmm: make hmm_range_fault return 0 or -1
>   drm/amdgpu: remove dead code after hmm_range_fault()
>   mm/hmm: remove HMM_PFN_SPECIAL
>   mm/hmm: remove the customizable pfn format from hmm_range_fault

Applied to hmm.git, thanks

Jason
