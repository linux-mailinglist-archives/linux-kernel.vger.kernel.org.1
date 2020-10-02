Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337ED280CF5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 06:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgJBEzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 00:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgJBEzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 00:55:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE2020796;
        Fri,  2 Oct 2020 04:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601614535;
        bh=FamPZ+HHgf9+DKHPvSlwIE+9cxI1vXUad3ORQVNzTHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chG3RdGcB+M1mHcCQhiqUJW87pI+x2ys1C22PDZFbOowiE1bVdONYyGqRjrBysaoN
         kSE1P0GLNBo6PlwOgWC1wbtM0bRFQc5GvGoW1DWZZKtK8SLoUlJJ5I0jG8VffrPq+/
         NyxL7aO2PwnybSkiCRWtHGB41uOcV5npEzFDtNuk=
Date:   Fri, 2 Oct 2020 06:55:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: Re: [PATCH v5 11/15] misc: bcm-vk: add BCM_VK_QSTATS
Message-ID: <20201002045531.GB34005@kroah.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
 <20201001012810.4172-12-scott.branden@broadcom.com>
 <e7b3a4b6-0662-6ead-8ddb-0cf6324a9bd2@gmail.com>
 <5d76c89d-f53a-be22-dcd7-7854a3e1e034@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d76c89d-f53a-be22-dcd7-7854a3e1e034@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 03:12:11PM -0700, Scott Branden wrote:
> 
> 
> On 2020-09-30 7:33 p.m., Florian Fainelli wrote:
> >
> >
> > On 9/30/2020 6:28 PM, Scott Branden wrote:
> >> Add BCM_VK_QSTATS Kconfig option to allow for enabling debug VK
> >> queue statistics.
> >>
> >> These statistics keep track of max, abs_max, and average for the
> >> messages queues.
> >>
> >> Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
> >> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
> >> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> >> ---
> >
> > [snip]
> >
> >> +#if defined(CONFIG_BCM_VK_QSTATS)
> >> +    /* clear qstats */
> >> +    for (i = 0; i < VK_MSGQ_MAX_NR; i++) {
> >> +        memset(&vk->to_v_msg_chan.qstats[i].qcnts, 0,
> >> +               sizeof(vk->to_v_msg_chan.qstats[i].qcnts));
> >> +        memset(&vk->to_h_msg_chan.qstats[i].qcnts, 0,
> >> +               sizeof(vk->to_h_msg_chan.qstats[i].qcnts));
> >> +    }
> >> +#endif
> >>       /* clear 4096 bits of bitmap */
> >>       bitmap_clear(vk->bmap, 0, VK_MSG_ID_BITMAP_SIZE);
> >
> > It was not clear from looking at this patch how are the statistics exposed and how does one actually get them?
> The QSTATS, since it is only for debug purpose, it will dump out periodically based on processed_num.
> Nothing fancy as we only compile it in in extreme case for recreating a scenario.
> 
> The following is the part:
> 
> +       if (++qcnts->cnt >= BCM_VK_QSTATS_ACC_CNT) {
> +               /* log average and clear counters */
> +               dev_info(&vk->pdev->dev,
> +                        "%s[%d]: Max: [%3d/%3d] Acc %d num %d, Aver %d\n",
> +                        tag, qstats->q_num,
> +                        qcnts->max_occ, qcnts->max_abs,
> +                        qcnts->acc_sum,
> +                        qcnts->cnt,
> +                        qcnts->acc_sum / qcnts->cnt);

Ah, that's not ok, don't flood the kernel log for non-error things
please.  If you need to "report" stuff, when all is going well, use the
other common interfaces for that.

Again, drivers, when all is working, are quiet.

thanks,

greg k-h
