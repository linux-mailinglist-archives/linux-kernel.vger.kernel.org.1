Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0339E285E53
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgJGLkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:40:40 -0400
Received: from foss.arm.com ([217.140.110.172]:42396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgJGLkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:40:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E2D31B;
        Wed,  7 Oct 2020 04:40:39 -0700 (PDT)
Received: from bogus (unknown [10.57.54.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2BD33F71F;
        Wed,  7 Oct 2020 04:40:36 -0700 (PDT)
Date:   Wed, 7 Oct 2020 12:40:34 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/4] mailbox: arm_mhu: Add ARM MHU doorbell driver
Message-ID: <20201007114034.rkiujybiknaedy7m@bogus>
References: <20200928114445.19689-1-sudeep.holla@arm.com>
 <20200928114445.19689-5-sudeep.holla@arm.com>
 <CABb+yY11d8uS34yfE6-c_NP6n5pmxvmjs67aOKEAduhUpnU3Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY11d8uS34yfE6-c_NP6n5pmxvmjs67aOKEAduhUpnU3Uw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 02:42:37PM -0500, Jassi Brar wrote:
> On Mon, Sep 28, 2020 at 6:45 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> > +
> > +static void mhu_db_shutdown(struct mbox_chan *chan)
> > +{
> > +       struct mhu_db_channel *chan_info = chan->con_priv;
> > +       struct mbox_controller *mbox = &chan_info->mhu->mbox;
> > +       int i;
> > +
> > +       for (i = 0; i < mbox->num_chans; i++)
> > +               if (chan == &mbox->chans[i])
> > +                       break;
> > +
> > +       if (mbox->num_chans == i) {
> > +               dev_warn(mbox->dev, "Request to free non-existent channel\n");
> > +               return;
> > +       }
> > +
> > +       /* Reset channel */
> > +       mhu_db_mbox_clear_irq(chan);
> > +       chan->con_priv = NULL;
> >
> request->free->request will fail because of this NULL assignment.
> Maybe add a 'taken' flag in mhu_db_channel, which should also be
> checked before calling mbox_chan_received_data because the data may
> arrive for a now relinquished channel.
>

Good point, but the new 'taken' flag will have the same race as con_priv.
We need a lock here and can we use chan->lock or do you prefer this
driver maintains it own for this purpose.

mbox_request_channel releases the lock before calling startup and
mbox_free_channel acquires the after shutdown returns, so technically
we can reuse the same lock.

> > +
> > +static struct mbox_chan *mhu_db_mbox_xlate(struct mbox_controller *mbox,
> > +                                          const struct of_phandle_args *spec)
> > +{
> > +       struct arm_mhu *mhu = dev_get_drvdata(mbox->dev);
> > +       struct mhu_db_channel *chan_info;
> > +       struct mbox_chan *chan = NULL;
> > +       unsigned int pchan = spec->args[0];
> > +       unsigned int doorbell = spec->args[1];
> > +       int i;
> > +
> > +       /* Bounds checking */
> > +       if (pchan >= MHU_CHANS || doorbell >= MHU_NUM_DOORBELLS) {
> > +               dev_err(mbox->dev,
> > +                       "Invalid channel requested pchan: %d doorbell: %d\n",
> > +                       pchan, doorbell);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       for (i = 0; i < mbox->num_chans; i++) {
> > +               chan_info = mbox->chans[i].con_priv;
> > +
> > +               /* Is requested channel free? */
> > +               if (chan_info &&
> > +                   mbox->dev == chan_info->mhu->dev &&
> > +                   pchan == chan_info->pchan &&
> > +                   doorbell == chan_info->doorbell) {
> > +                       dev_err(mbox->dev, "Channel in use\n");
> > +                       return ERR_PTR(-EBUSY);
> > +               }
> > +
> You may want to reuse mhu_db_mbox_to_channel.

Good point, thanks for pointing that out, will update.

-- 
Regards,
Sudeep
