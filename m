Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32DB2F9CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbhARKV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388483AbhARKJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:09:18 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0F7C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:08:37 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hs11so20529156ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qECQt3l5OEEcYku7TfMYOUTWED64ArCIIVRgQSduy+E=;
        b=uWev3XS0PCKEpZ1iTWw0EVv6pDwiRAfP+5/Ac6+DuxygGfGjiIzWLxneVSCQYfj6NF
         i+NknxUxkB7zCUZhGmzlkU8Yjfa0alZ990pFQ3Un1d8Cq654kwiprnwTaI6G/mvUQubK
         uCRNPMMAJYhKmUdRAvBR6xKSNkmPLuU9+h5IQTlvb+zMoA6b+Q+o2imcUqYrjoJI/UIw
         EVqVMX1OME+WsCxppmcz00+8F7yrtV+4uggI+uVZOUjJNFf4m0fBqQSLfiEDqDO44M87
         DxLNZB8DmxIXqpF7sRsVrpJHuPVAk/7v6zqfq50uydLxJNMx4Sh801qS63Za2Zwp9XYZ
         Gdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qECQt3l5OEEcYku7TfMYOUTWED64ArCIIVRgQSduy+E=;
        b=gv92EBeiUYh/A6SVyltRSfVVP7G6GN0Hf+e86G9A7BzOmGQYz/e8/vor+YAY6CJ/Bu
         MVFT8FOr+oT9PLuqaGfLv+49Jwr+Nj44gocQB1Q/NpWwQ134BG4LxmiVXo0pRk8TTC46
         xRCFgyxcDf39kwyVvXp3jfzD0mZQqt7ELvo1OHOpX1uxphYxE/w2M0gQJtiqOEUab/fs
         yeJwmh6Or0DsfH0pVJ1As3S5Qusd4EZCMa+zmpzg/ZQeDt1vDJlhxRqfNgLy1kd07f8E
         BgYPXcOowreqoN/kmm+NxCkjgsveeedgiVpRXkQuJwiZxWQgQyY/f84+cV4VONzJS0wh
         o3zA==
X-Gm-Message-State: AOAM5300gHiNqcRNw/hmAG5mFSQHfzbIdiR2MzFGHKFLsn3noHbgDn8d
        LPDrGCoPNd+9/TLID4A0AQXdlQ==
X-Google-Smtp-Source: ABdhPJyrwgYBnhQeuMb/RbRNmMxBdCmN47Y+UKBhEZP1a8ITTItX36PvKPTFgMWzCbD4CXwCVeBZjA==
X-Received: by 2002:a17:906:2694:: with SMTP id t20mr12118442ejc.48.1610964516484;
        Mon, 18 Jan 2021 02:08:36 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id r23sm9190014ejd.56.2021.01.18.02.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 02:08:35 -0800 (PST)
Date:   Mon, 18 Jan 2021 11:08:12 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v4 2/3] iommu/iova: Avoid double-negatives in magazine
 helpers
Message-ID: <YAVeDOiKBEKZ2Tdq@myrica>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-3-git-send-email-john.garry@huawei.com>
 <YAHRKCkcHAEUdRNT@larix.localdomain>
 <69c30e85-4a72-a0e1-1e56-4ffbd0df5aba@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c30e85-4a72-a0e1-1e56-4ffbd0df5aba@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:24:17AM +0000, John Garry wrote:
> On 15/01/2021 17:30, Jean-Philippe Brucker wrote:
> > On Thu, Dec 10, 2020 at 02:23:08AM +0800, John Garry wrote:
> > > A similar crash to the following could be observed if initial CPU rcache
> > > magazine allocations fail in init_iova_rcaches():
> > 
> 
> thanks for having a look
> 
> > Any idea why that's happening?  This fix seems ok but if we're expecting
> > allocation failures for the loaded magazine then we could easily get it
> > for cpu_rcaches too, and get a similar abort at runtime.
> 
> It's not specifically that we expect them (allocation failures for the
> loaded magazine), rather we should make safe against it.
> 
> So could you be more specific in your concern for the cpu_rcache failure?
> cpu_rcache magazine assignment comes from this logic.

If this fails:

drivers/iommu/iova.c:847: rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());

then we'll get an Oops in __iova_rcache_get(). So if we're making the
module safer against magazine allocation failure, shouldn't we also
protect against cpu_rcaches allocation failure?

Thanks,
Jean

> 
> Anyway, logic like "if not full" or "if not empty" is poor as the outcome
> for NULL is ambiguous (maybe there's a better word) and the code is not safe
> against it, and so I replace with "if space" or "if have an IOVA",
> respectively.
> 
> Thanks,
> John
> 
