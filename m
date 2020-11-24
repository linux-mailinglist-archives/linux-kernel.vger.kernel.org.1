Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74472C1A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgKXAuK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 19:50:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46447 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgKXAuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:50:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id g19so17762670otp.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iOdTCmgyt3Rw2NWUSk3IqpjqjDIXkanlk8cXx/I9Kbo=;
        b=eJkSDZrRxZBSgxdy7LWkoHbvwJZAgJQY8yfKK0U+aGviPxTGNkLyoJhrVTiTqXvGL4
         tw8mQCMdedBlWt1Oo1t2inVg6tlRV9cf6OzC2W5fm80u9f0QeoPUbBbQYYPBsEtQYzFc
         TR/1U/rhS4G1NBP3xzFPjLHfBetHTa4FQyOgiD5FH9A20rpX3p8ldn3XmsCCCZdrursm
         bUnPWWtwAMsNV12p4V6NNDUC56BpRqSU4k3Zyuw4BPNvQPtgWoXC+ZwC50nICCKwwFsj
         m50IpsPbqROhUTJ2q3N5I77d8wNNOprsa7lX2cl9bAWD7cpHfFMYtqB6/Rp1zgLJs1Y/
         JU+A==
X-Gm-Message-State: AOAM530jWtFDPbdXI/XA3weRmbqygE4lNqI9QF0cJAM30o9av55SXSI+
        YUln/UKGJ2FtcGusxu5poRDDcb3V53AbYQ==
X-Google-Smtp-Source: ABdhPJy2X7ns33nydr93LbcwWPtMSLilXV1F0b3pKruNocptpD2sRehhwJ0MspKhArknLeSs7JWdeg==
X-Received: by 2002:a9d:23e3:: with SMTP id t90mr1468839otb.51.1606179006020;
        Mon, 23 Nov 2020 16:50:06 -0800 (PST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id d10sm8147866oic.11.2020.11.23.16.50.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 16:50:05 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id l36so17798766ota.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:50:05 -0800 (PST)
X-Received: by 2002:a05:6830:160d:: with SMTP id g13mr1625578otr.74.1606179005016;
 Mon, 23 Nov 2020 16:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20201103152838.1290217-1-lee.jones@linaro.org> <20201103152838.1290217-26-lee.jones@linaro.org>
In-Reply-To: <20201103152838.1290217-26-lee.jones@linaro.org>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 23 Nov 2020 18:49:53 -0600
X-Gmail-Original-Message-ID: <CADRPPNTguTHuRVhB_4QmN4N3Jorqi8y0gzm4Ew9D=qOuXqu=4g@mail.gmail.com>
Message-ID: <CADRPPNTguTHuRVhB_4QmN4N3Jorqi8y0gzm4Ew9D=qOuXqu=4g@mail.gmail.com>
Subject: Re: [PATCH 25/25] soc: fsl: qbman: qman: Remove unused variable 'dequeue_wq'
To:     Roy Pledge <Roy.Pledge@nxp.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roy,

On Tue, Nov 3, 2020 at 9:31 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/soc/fsl/qbman/qman.c: In function ‘qman_shutdown_fq’:
>  drivers/soc/fsl/qbman/qman.c:2700:8: warning: variable ‘dequeue_wq’ set but not used [-Wunused-but-set-variable]
>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/soc/fsl/qbman/qman.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 9888a70618730..62b182c3a8b04 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -2622,7 +2622,7 @@ int qman_shutdown_fq(u32 fqid)
>         union qm_mc_command *mcc;
>         union qm_mc_result *mcr;
>         int orl_empty, drain = 0, ret = 0;
> -       u32 channel, wq, res;
> +       u32 channel, res;
>         u8 state;
>
>         p = get_affine_portal();
> @@ -2655,7 +2655,7 @@ int qman_shutdown_fq(u32 fqid)
>         DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) == QM_MCR_VERB_QUERYFQ);
>         /* Need to store these since the MCR gets reused */
>         channel = qm_fqd_get_chan(&mcr->queryfq.fqd);
> -       wq = qm_fqd_get_wq(&mcr->queryfq.fqd);
> +       qm_fqd_get_wq(&mcr->queryfq.fqd);

This probably is not needed also.

>
>         if (channel < qm_channel_pool1) {
>                 channel_portal = get_portal_for_channel(channel);
> @@ -2697,7 +2697,6 @@ int qman_shutdown_fq(u32 fqid)
>                          * to dequeue from the channel the FQ is scheduled on
>                          */
>                         int found_fqrn = 0;
> -                       u16 dequeue_wq = 0;
>
>                         /* Flag that we need to drain FQ */
>                         drain = 1;
> @@ -2705,11 +2704,8 @@ int qman_shutdown_fq(u32 fqid)
>                         if (channel >= qm_channel_pool1 &&
>                             channel < qm_channel_pool1 + 15) {
>                                 /* Pool channel, enable the bit in the portal */
> -                               dequeue_wq = (channel -
> -                                             qm_channel_pool1 + 1)<<4 | wq;
>                         } else if (channel < qm_channel_pool1) {
>                                 /* Dedicated channel */
> -                               dequeue_wq = wq;

With these gone, these if statements seem to be redundant.  Can you
propose an additional patch to further cleanup the code here?  Thanks.

>                         } else {
>                                 dev_err(dev, "Can't recover FQ 0x%x, ch: 0x%x",
>                                         fqid, channel);
> --
> 2.25.1
>
