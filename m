Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859551CA5E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 10:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgEHISe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 04:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgEHISe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:18:34 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99264C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:18:32 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id b6so350579uak.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJPuuntZlyPktcvouMtEMcRXu/bHP0lxYUGNqG/wwec=;
        b=XLFb5O24UDkagdH/uOB3eXjd2JILpBfOOgDrS9QVue3xsAGnEEJkSltb7/cok3nupa
         WCySEqYIvOkec/rE7Xn2Yq/0sjXONb98Gt4Pr+edjjMKEPuXrBIjlXKLvPrljUEJnTqe
         Y0n59JOGKhYdQXxPusx44/H3xunCUZ7f74wMTOrNXGKvX4TIbKjFvnAznMMEXZf5rTXz
         eaQrLNPxNBpKjqMSEKqgudbPBKXIdysHgtzUsacjN4x2bPAyQn/ULDYxlblOE7BU8wL8
         E7HWpDnz/RjC0JINvLsDXIYp6qFT6rlRYr4HxnOzBQ2WzyImn19iVOZm7yBfT/8VnOf/
         ai7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJPuuntZlyPktcvouMtEMcRXu/bHP0lxYUGNqG/wwec=;
        b=IHBr0uTPsDOx3GgJlt151uHBdNELCpm/vYYJydZLYaN6qXEqqhyH3KkrQpuNo8ouI1
         PJrHgScyW0XLz2DuGswCRBwRyXAq7JqvKelE7xcl4SNGVkJcp79/CiTrzsoN4fHQvFV7
         3cjVPeazvh81mHlbzGhWcrKrzEHw+gficL+L0xlYuTcou4CbabfPPnZLRnI6I+msTruh
         dUBeX0TPVMBcTzeBwzqsNwFmmMa4lspwQUyQA4K2cV+sdyLZmZOeqzWVU9KxKoReJ3S6
         jwJrKUarJygGIvnIgpNDmDlP1fJMn23fOx7tSgPxa/Ir38Nxof5iieG4axqax3pt3OXV
         WfkQ==
X-Gm-Message-State: AGi0PubM8NILBVomWd+2GVAnamOP9DVNL/H2YPYQ1HBM3GG0vhbVNBI7
        YROXPdW+anMX6Jl6SaoqmEMEkKKx26JTuy5vCyiRzQ==
X-Google-Smtp-Source: APiQypKdQso64EgPEWBYjRx71h5U/5siNxu0JtIlehtPAZ8Eg05DqIqWRugC48y3iDP4vq4H+ef9bwEbxz9g+8Xi4I0=
X-Received: by 2002:ab0:544a:: with SMTP id o10mr919614uaa.15.1588925911701;
 Fri, 08 May 2020 01:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFo10JFbe7ZFnRBE2e55eGs-odAWYxU+Ep0S74003aLGpg@mail.gmail.com>
 <20200508062227.23144-1-adrian.hunter@intel.com>
In-Reply-To: <20200508062227.23144-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 May 2020 10:17:55 +0200
Message-ID: <CAPDyKFqAuxDhxpMOJSWut3YbE=p0w53KStDn1JAbizJMoWeDBQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] mmc: block: Fix request completion in the CQE
 timeout path
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sarthak Garg <sartgarg@codeaurora.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 at 08:22, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> First, it should be noted that the CQE timeout (60 seconds) is substantial
> so a CQE request that times out is really stuck, and the race between
> timeout and completion is extremely unlikely. Nevertheless this patch
> fixes an issue with it.
>
> Commit ad73d6feadbd7b ("mmc: complete requests from ->timeout")
> preserved the existing functionality, to complete the request.
> However that had only been necessary because the block layer
> timeout handler had been marking the request to prevent it from being
> completed normally. That restriction was removed at the same time, the
> result being that a request that has gone will have been completed anyway.
> That is, the completion was unnecessary.
>
> At the time, the unnecessary completion was harmless because the block
> layer would ignore it, although that changed in kernel v5.0.
>
> Note for stable, this patch will not apply cleanly without patch "mmc:
> core: Fix recursive locking issue in CQE recovery path"
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: ad73d6feadbd7b ("mmc: complete requests from ->timeout")
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/queue.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 72bef39d7011..10ea67892b5f 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -110,8 +110,7 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
>                                 mmc_cqe_recovery_notifier(mrq);
>                         return BLK_EH_RESET_TIMER;
>                 }
> -               /* No timeout (XXX: huh? comment doesn't make much sense) */
> -               blk_mq_complete_request(req);
> +               /* The request has gone already */
>                 return BLK_EH_DONE;
>         default:
>                 /* Timeout is handled by mmc core */
> --
> 2.17.1
>
