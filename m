Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FC229D95B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389686AbgJ1Ww4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389676AbgJ1Www (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:52:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04783C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:52:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e7so664473pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JDYiIX5M5YN4J997d/Mh3BGKj9X3sWCSLjXLFcNLDBc=;
        b=eX60avSDqzA2bzgYLeQl527BhC+2uMYkb59k74qtgdwflOAZI5gDXtAcnAaKWs5aSZ
         2GcSfxJEOVXkxwC1dYwb/hJxhKvn4pP7gAMDH8ZUCmJXF+SXdIvksy08noG+3kj0jVFk
         vI8YmE5BP+4X98LlssotlRaptbR/EcWaTpBvD1NqzcbMpn2vq2pTaUwV5ZlczgIbEEwU
         qWdlqwE3Dzt0MLNNM6cgeToL/1rP6HnzE7z+zjj1UgU+mPIAAXfqEcTVXzxM8zQJNB0v
         pJR2sAigZTe8pHCq6uM9k9Ud4mj9GQ8/gxFExn/tS2GBPGC3siswjDsv6wwbJNotvmTy
         ShlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JDYiIX5M5YN4J997d/Mh3BGKj9X3sWCSLjXLFcNLDBc=;
        b=bsA1vOF8oYHx0EFykENcK9hHp14X/ahggVWA9gtjxWkczs5l8yfWbB+5YS8gwxTbMp
         5H8/2d4T3zkXKWycdOBQXk3mcqDrvNc5l4LtTFTdEoYx+rBM5Cxpf3S26vzG8jZcTsk2
         qtovPWi1lpSx2x/oPMqvAVyaQCoN6sIXCyqC4ELb+Y6GZc8PK5rIHuT+PBNEq9PKCOuf
         DxEDFOMKnWzpqzsfLwcJgKLqREH2eFrORPvZkdD6sEfmka7xWojq9xOG3dBJWCbyDYz8
         /WoAVw9U/rmXTGF4CMI9PleEZFjgyIA1SmmyMRJFlnz9FtmQ/hKi9DALRK/IGdoGW7gn
         p0AQ==
X-Gm-Message-State: AOAM5335uAAQfY00HLW4AWIia2qYrnsUVe7BrlPZup7MfPnzx7NovKSF
        mpAGCs2/7htniSeCMDPrHRNkR7pNDtwH2A==
X-Google-Smtp-Source: ABdhPJz36ycURoS1BevCLdRL9PyoyED0cveEb+flOFPdJRDYuvjGRASX8lhp+syOzvHxS2toS7JX4w==
X-Received: by 2002:a63:1a09:: with SMTP id a9mr5610362pga.188.1603875967506;
        Wed, 28 Oct 2020 02:06:07 -0700 (PDT)
Received: from image-900X5T-900X5U ([220.120.123.224])
        by smtp.gmail.com with ESMTPSA id b3sm5039077pfd.66.2020.10.28.02.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 02:06:07 -0700 (PDT)
Date:   Wed, 28 Oct 2020 18:06:03 +0900
From:   Jongpil Jung <jongpuls@gmail.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, jongpil19.jung@samsung.com
Subject: Re: [PATCH 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201028090603.GB599972@image-900X5T-900X5U>
References: <20201027155438.GA111754@jongpil-desktop>
 <20201027202334.GA1942708@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027202334.GA1942708@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 01:23:34PM -0700, Keith Busch wrote:
> On Wed, Oct 28, 2020 at 12:54:38AM +0900, Jongpil Jung wrote:
> > suspend.
> > 
> > When NVMe device receive D3hot from host, NVMe firmware will do
> > garbage collection. While NVMe device do Garbage collection,
> > firmware has chance to going incorrect address.
> > In that case, NVMe storage device goes to no device available state.
> > Finally, host can't access the device any more.
> > 
> > Quirk devices will not use simple suspend even if HMB is enabled.
> > In case of poweroff scenario, NVMe receive "PME turn off".
> > So garbage collection will not be happening.
> > 
> > Liteon(SSSTC) will fix the issue, that's why quirk apply on specific
> > vendor id and firmware version.
> 
> This is a concerning quirk. We use the simple suspend when HMB is
> enabled because at least some platforms disable device DMA access in the
> runtime suspend state. Many devices continue to access their HMB while
> in low power, so we can't let both conditions occur concurrently.
> Unless you know for sure this device doesn't access host memory in
> low-power, there will be at least some platform combinations where this
> quirk will fail.
I will submit another patch to check platform.
