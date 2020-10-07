Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070882856B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 04:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgJGCkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 22:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgJGCkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 22:40:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03930C0613D3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 19:40:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u8so783162ejg.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 19:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afZ2ku0615X/vbgIsq8uZABQa+HrZmef3/cMOPPeXPE=;
        b=EPjdVqDeTinUn3xle7QkZRs1c1I777r6WwVNCzmQvuelLMEIhN7D3byY1DbMWiHRAd
         QgHw7nunbi78JiFNVYPaj+vzDaQToh84mycymDqg79odab44O2bFpy0hTFRZMk6Gq88h
         gdm22jg2FmT9PYcFKiksCpHH97YYjHNLfkRJqB+XyuOtAK7X6n9Ol7Qc3aWxyX/ubcf1
         1Dj3nT3ueZ1gSrXVBd01SuIcMxMF+W8KjeuouHZbfkVWg3QUD53z+H8ypZQCYHGiMbYk
         lCoLazlQUecuVDEtHUfRDwSsCvcaF59aNbsh9HWw6NNgsgGSQloXWj+DnfN5l7npN3En
         PmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afZ2ku0615X/vbgIsq8uZABQa+HrZmef3/cMOPPeXPE=;
        b=gMJz4H/puKKW/TgScdZ7IOOgMcdU4eRr7+aT9h+6WUGUa6sUhWUxae/CbtMkE0SHIs
         v6tkCtx/Ewwp3QRdAsc4ElwVpWe5Xql2M1rfJ6QhEXsKb8e6rLsL3jlh7jxynPOWMz44
         i2+iUTHLIT3235hNV7gx0Tz71jUurWKyS2P0/2qQJyF0urUbPjwKx58fwiO+QkPqYUPC
         Yeo2NMd1BfWDE+nN8dZFnsBdEeS72piIf2nTRVaMEiQLBZvhTG8ZeO8ae2IUITxv5IDg
         cKNtzPnEjjWTp8D90WojQKPG7L81I3MlifaUCFhxqj71JaCXqsB4JuqaUBsx0lXxFVcd
         r9Lw==
X-Gm-Message-State: AOAM532yAUtnAeotPjA+JoWLQcJ31im6I1VIoQv0s8dUcCHXpr0uv0KU
        +oU6e7eeQNF2R6QnrYLcLozK+9m9TSSxPBRdGmpwEA==
X-Google-Smtp-Source: ABdhPJyzhK0w2iAz2iCMzOOn/0AFV3bEvaxuBmF2mBxx+C4IpyFlFHdfkT/qw+BQgpUSKwf1wNdFiTZy1ImFQ33Wm94=
X-Received: by 2002:a17:906:1a0b:: with SMTP id i11mr1116582ejf.472.1602038416463;
 Tue, 06 Oct 2020 19:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201006230930.3908-1-rcampbell@nvidia.com>
In-Reply-To: <20201006230930.3908-1-rcampbell@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 6 Oct 2020 19:40:05 -0700
Message-ID: <CAPcyv4gYtCmzPOWErYOkCCfD0ZvLcrgfR8n2kG3QPMww9B0gyg@mail.gmail.com>
Subject: Re: [PATCH] ext4/xfs: add page refcount helper
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 4:09 PM Ralph Campbell <rcampbell@nvidia.com> wrote:
>
> There are several places where ZONE_DEVICE struct pages assume a reference
> count == 1 means the page is idle and free. Instead of open coding this,
> add a helper function to hide this detail.
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>
> I'm resending this as a separate patch since I think it is ready to
> merge. Originally, this was part of an RFC and is unchanged from v3:
> https://lore.kernel.org/linux-mm/20201001181715.17416-1-rcampbell@nvidia.com
>
> It applies cleanly to linux-5.9.0-rc7-mm1 but doesn't really
> depend on anything, just simple merge conflicts when applied to
> other trees.
> I'll let the various maintainers decide which tree and when to merge.
> It isn't urgent since it is a clean up patch.

Thanks Ralph, it looks good to me. Jan, or Ted care to ack? I don't
have much else pending for dax at the moment as Andrew is carrying my
dax updates for this cycle. Andrew please take this into -mm if you
get a chance. Otherwise I'll cycle back to it when some other dax
updates arrive in my queue.
