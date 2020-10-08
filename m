Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F592870F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgJHIuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:50:03 -0400
Received: from foss.arm.com ([217.140.110.172]:44536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbgJHIuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:50:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B2171042;
        Thu,  8 Oct 2020 01:50:02 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6E673F70D;
        Thu,  8 Oct 2020 01:50:00 -0700 (PDT)
Date:   Thu, 8 Oct 2020 09:49:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/4] mailbox: arm_mhu: Add ARM MHU doorbell driver
Message-ID: <20201008084954.f45lospaagookbwp@bogus>
References: <20200928114445.19689-1-sudeep.holla@arm.com>
 <20200928114445.19689-5-sudeep.holla@arm.com>
 <CABb+yY11d8uS34yfE6-c_NP6n5pmxvmjs67aOKEAduhUpnU3Uw@mail.gmail.com>
 <20201007114034.rkiujybiknaedy7m@bogus>
 <CABb+yY12hntCgydcTza4qBggi0aqCrt7=aZ+sJoiqEFkm11xtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY12hntCgydcTza4qBggi0aqCrt7=aZ+sJoiqEFkm11xtQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 10:43:19AM -0500, Jassi Brar wrote:
> On Wed, Oct 7, 2020 at 6:40 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Oct 02, 2020 at 02:42:37PM -0500, Jassi Brar wrote:
> > > On Mon, Sep 28, 2020 at 6:45 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > > +
> > > > +static void mhu_db_shutdown(struct mbox_chan *chan)
> > > > +{
> > > > +       struct mhu_db_channel *chan_info = chan->con_priv;
> > > > +       struct mbox_controller *mbox = &chan_info->mhu->mbox;
> > > > +       int i;
> > > > +
> > > > +       for (i = 0; i < mbox->num_chans; i++)
> > > > +               if (chan == &mbox->chans[i])
> > > > +                       break;
> > > > +
> > > > +       if (mbox->num_chans == i) {
> > > > +               dev_warn(mbox->dev, "Request to free non-existent channel\n");
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       /* Reset channel */
> > > > +       mhu_db_mbox_clear_irq(chan);
> > > > +       chan->con_priv = NULL;
> > > >
> > > request->free->request will fail because of this NULL assignment.
> > > Maybe add a 'taken' flag in mhu_db_channel, which should also be
> > > checked before calling mbox_chan_received_data because the data may
> > > arrive for a now relinquished channel.
> > >
> >
> > Good point, but the new 'taken' flag will have the same race as con_priv.
> > We need a lock here and can we use chan->lock or do you prefer this
> > driver maintains it own for this purpose.
> >
> I meant the con_priv is allocated in mhu_db_mbox_xlate and simply
> assigning it NULL leaks memory, if not a crash by some other path. At
> least free it before.
>

Ah right, sorry got confused. Too much reliance on devm_* apis and I didn't
realise it was not in probe but in xlate which is mbox_startup path. Fixed
now, will post v2 with both issues addressed.

--
Regards,
Sudeep
