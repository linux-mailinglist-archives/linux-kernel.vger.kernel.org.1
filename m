Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46309281C35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbgJBTmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:42:49 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD6DC0613D0;
        Fri,  2 Oct 2020 12:42:49 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u6so2782264iow.9;
        Fri, 02 Oct 2020 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tp0tOCwH4dQMQU1jbfVhp24TqbT0i1fDhMp/Wjobwn8=;
        b=Ap7BSOIg4OYbxFaSN2BlpmRPL+ZAkBcTZrouR4dsU30UKpICJijKJ/ZKAS6wW4oHaR
         OyP+3l6C6uMDU03Q6tpXnqhFDVFB9IR6XytRpunCtgNVyC/DAL2wSHwIIHwINrTOsmgL
         QvefHlNHwW3UDe97tfHkM5PAZ+gY/Pgs469Suewfhkcgws4I/b3tXId3xiEIk73Ka6Mj
         PHfroUsC2mTBZ4yJt1f8hgd9NEq9hYMX7smV3CUH9W3eHBrUwl5/wJDAC9tzwmVfaG5H
         Hmcrx3ygdd1ejXFkr+kAlZtS7ISHo96Xloghd5SLNeG571l9IZ3cm2WB34KnlHXP9CRz
         bseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tp0tOCwH4dQMQU1jbfVhp24TqbT0i1fDhMp/Wjobwn8=;
        b=Ygyb5BjDHCmELWBytGYlxN9GAodWCkmKi3Jqiux/WVmrPAiHDylAYHq4WdivKLC5pK
         fr4zbx1tuFa9SADc5xf0cnYglIisnvQ5eQP6dFM2mYVc6j6vgMv997lYl8pvw7SbEIa8
         pMq4LV+LNSwxIztDZ602MJ6Qxeou5emMJVDmhBXnYYbS0i0oJOMtAja2446CYqJQE+66
         /zFVUvOY8pdtzmamfmgQr2/Ob9cDL15a/hgmyXFihs6JFpQoII/Qvx+nyCvB/K4F7MJd
         eg6R+JWsLv12O24vZ7ubp1eUw4x52Rb8P+aWKYSaTQVf/cd+JgYl1806pTetg+mk7Z/f
         1TCA==
X-Gm-Message-State: AOAM533UzljD/HOaOIvA2n8p8+hAu8iXK3fFZ7KtsSPMIqjxfuc2ofzj
        MGb1OKYfOkaX2nd58mgeCwniEi3+9RVYvpbHU5k=
X-Google-Smtp-Source: ABdhPJxY2bgAHNcLjUx4s5JpdfOPAFmahzwdpqCgDX5pvJ9JC7WhorJMYbgzNc+x15ANKY9rU+GBxXmAPuGg6Uzmn14=
X-Received: by 2002:a6b:be44:: with SMTP id o65mr3195330iof.53.1601667768748;
 Fri, 02 Oct 2020 12:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200928114445.19689-1-sudeep.holla@arm.com> <20200928114445.19689-5-sudeep.holla@arm.com>
In-Reply-To: <20200928114445.19689-5-sudeep.holla@arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 2 Oct 2020 14:42:37 -0500
Message-ID: <CABb+yY11d8uS34yfE6-c_NP6n5pmxvmjs67aOKEAduhUpnU3Uw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mailbox: arm_mhu: Add ARM MHU doorbell driver
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 6:45 AM Sudeep Holla <sudeep.holla@arm.com> wrote:

> +
> +static void mhu_db_shutdown(struct mbox_chan *chan)
> +{
> +       struct mhu_db_channel *chan_info = chan->con_priv;
> +       struct mbox_controller *mbox = &chan_info->mhu->mbox;
> +       int i;
> +
> +       for (i = 0; i < mbox->num_chans; i++)
> +               if (chan == &mbox->chans[i])
> +                       break;
> +
> +       if (mbox->num_chans == i) {
> +               dev_warn(mbox->dev, "Request to free non-existent channel\n");
> +               return;
> +       }
> +
> +       /* Reset channel */
> +       mhu_db_mbox_clear_irq(chan);
> +       chan->con_priv = NULL;
>
request->free->request will fail because of this NULL assignment.
Maybe add a 'taken' flag in mhu_db_channel, which should also be
checked before calling mbox_chan_received_data because the data may
arrive for a now relinquished channel.

> +
> +static struct mbox_chan *mhu_db_mbox_xlate(struct mbox_controller *mbox,
> +                                          const struct of_phandle_args *spec)
> +{
> +       struct arm_mhu *mhu = dev_get_drvdata(mbox->dev);
> +       struct mhu_db_channel *chan_info;
> +       struct mbox_chan *chan = NULL;
> +       unsigned int pchan = spec->args[0];
> +       unsigned int doorbell = spec->args[1];
> +       int i;
> +
> +       /* Bounds checking */
> +       if (pchan >= MHU_CHANS || doorbell >= MHU_NUM_DOORBELLS) {
> +               dev_err(mbox->dev,
> +                       "Invalid channel requested pchan: %d doorbell: %d\n",
> +                       pchan, doorbell);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       for (i = 0; i < mbox->num_chans; i++) {
> +               chan_info = mbox->chans[i].con_priv;
> +
> +               /* Is requested channel free? */
> +               if (chan_info &&
> +                   mbox->dev == chan_info->mhu->dev &&
> +                   pchan == chan_info->pchan &&
> +                   doorbell == chan_info->doorbell) {
> +                       dev_err(mbox->dev, "Channel in use\n");
> +                       return ERR_PTR(-EBUSY);
> +               }
> +
You may want to reuse mhu_db_mbox_to_channel.
