Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065952792E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgIYVDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgIYVDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:03:35 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045EFC0613A5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:26:41 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y13so4113508iow.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JF4yPnp4JTi+/MHrKogyuI7nkofHddgH0FgyoYHlHs=;
        b=XOq9Hu0z7Nxjy9g8sQ2fSc81MwUTKAUr3ZzhcXAWaeHtwyEvMCnbKn72/LcWYkQcfe
         WsFKuG5/1Btxz1BOkSskKM2EUzlfjsIZputb/hZzGyVMUGFjsufth7k91D5pYMbn+jgm
         rmzwLTK5Jq05XvjHfLhpwPNgIBlxUoKEWE82cvI+MjdA8BhKcOBFUg/GTFcLnMtIjJVz
         KLW2QrDkW0SZaY9fsSZ8StcvjR+jBxLmcL22m0n1KoSRIgwQ50TsN4w9mBEjqh8toatD
         JqiOLsaSCa+2cQGBWWCUtsuRQEI73oolekAdIVvtXNdXC+HJIooD+ctlAkc12y5KcaUH
         o5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JF4yPnp4JTi+/MHrKogyuI7nkofHddgH0FgyoYHlHs=;
        b=M007k0btQy8eT7ezfmgFPnVzfwX8ftTys4rgYh9bAv0Q9tN9YnLcGC4v+/3ewd04rF
         sg/KLmIrxw7mueT+FvgPiI59JaurKbllbvrnjkotV8G+63vEfnde3yHvkbPsStT0644V
         wTFyinwBOF0ZWKsfup2B8H3EAybZMjQA8bKkosxrZJDbUUJ1Eq2kx5Fe/LFqLnH1xudb
         DY6ny+6d4BWloAihM7ysHtfoIbavUyY0/GiEQxAAqHgC9xXApQ6ND82f2AGGGTBdfKTh
         G8QhEAqnXc9OHqXZPC+2fTc3UXNQH1J8rS2CGlMpI2bwoMAuP7XzWC2yU0QsPhWOmZg4
         KUQQ==
X-Gm-Message-State: AOAM530dV11gHaAEjSuH8ctHbvKq8uXI3bITd0TOWSAD03df4kX7AJ3O
        2tnRMFqn6MDSHHPy8IbN6oY6NluOsQYjazi8Ff8=
X-Google-Smtp-Source: ABdhPJzpRwmQRavL4njMYs0WOTaLb65+LcLZkmI03ChwKy2LzOKgq6PH8fEOmz9DcHCpU4EuCEjuKXrZvBAe0feRlL8=
X-Received: by 2002:a02:b199:: with SMTP id t25mr494691jah.124.1601062000321;
 Fri, 25 Sep 2020 12:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <1601027469-221812-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1601027469-221812-1-git-send-email-john.garry@huawei.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 25 Sep 2020 12:26:28 -0700
Message-ID: <CAM_iQpUowPbuqx7-LsZTZ71KxTPpXAUqYU5+aWPy+qv0U2BqTg@mail.gmail.com>
Subject: Re: [PATCH 0/2] iommu/iova: Solve longterm IOVA issue
To:     John Garry <john.garry@huawei.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>, linuxarm@huawei.com,
        thunder.leizhen@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 2:56 AM John Garry <john.garry@huawei.com> wrote:
>
> This series contains a patch to solve the longterm IOVA issue which
> leizhen originally tried to address at [0].
>
> I also included the small optimisation from Cong Wang, which never seems
> to be have been accepted [1]. There was some debate of the other patches
> in that series, but this one is quite straightforward.
>
> @Cong Wang, Please resend your series if prefer I didn't upstream your
> patch.

Thanks for letting me know. But I still don't think it is worth any effort,
given it is hard to work with Robin. Users who care about latency here
should just disable IOMMU, it is really hard to optimize IOVA cache
performance to catch up with !IOMMU case.

So, please feel free to carry it on your own, I have no problem with it.

Thanks.
