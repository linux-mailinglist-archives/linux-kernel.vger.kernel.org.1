Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD66286265
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgJGPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgJGPnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:43:31 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0743EC0613D2;
        Wed,  7 Oct 2020 08:43:31 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id o18so2716408ill.2;
        Wed, 07 Oct 2020 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLErf/pxRiqNYirhZZuvmNaePRdLyo9kzRk5xrxoNiI=;
        b=F/1PO7iFtNNGiOo3iYB+K5B7xcDy2INnmOBSZYzckiMBh17YWO0eKjV4ZbAmaF+PJG
         lmIDh+tYXMQBO7uIbPfhsLtN4dKK73NvU+BBV2UmF4/MLzSM7WtBqxZlaFDCR3tT9wij
         QGiE5hcGAzgoPc2nlqOBlIWw2kNy0dOHOetnz1ElQL0C1ePUHMvK/+BTae7SA6VkZLh3
         ztKtPEH6QmFohzNxF8DCntb4fq6YjmzO37mXUVxjiDC8vKH0pkzn9rwqm2S+C0X3MKUR
         nrCR9lKmPNRIKUTeZslyyuAH2deKfGRDPfJudrF+RFjHaoSxMME2+rYXXQs63clGchXl
         1PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLErf/pxRiqNYirhZZuvmNaePRdLyo9kzRk5xrxoNiI=;
        b=WUqBItBCgVuU0qpVM/FdfpBRQH0tAIpYgEtHvc1c1/47Oozg5M2yZImPuAKGx39Nhc
         DholGHfKH9zJpNsHssV9id5nPXxnEZ2VE0Z6aYQ/ttSi2AgMkarH+2yDtY27Iv1LMDaW
         tKaBg9B7sMexDIXvyP4Lxp5TCt2Df4wPE6b5+LdM332uwZStgTt3dkjXGeFD2ksq5b+k
         lATZtSJDUB2h7ES23S9HxRyZ1s8oXtP/CWrWCkePmh71ayD3Xk9+xg8ZZGmz3kgh+j52
         rSiUlviYN9qbZ3URDElKWjaaSYf5mUEg94bsjTd7YyDD9T7zHqTJ6lRagSKXb1pNg0NS
         0pAw==
X-Gm-Message-State: AOAM5319gmHiKuZHpqZDfZtkp41A/Kpq2utCKNQi1VwmvcgN07CwzToK
        1KSUdh7fmagKjJjPPwoZ33zI1k9tj0X1AVGg6gg=
X-Google-Smtp-Source: ABdhPJzYG90VRk4VCTsbGZMwSv6suXz1iFPnQuwpl76x3sjHbZu6JHgGEJ9Uxe3HE95st0zaTrE2TVDgocp+nbNvCUc=
X-Received: by 2002:a92:8910:: with SMTP id n16mr3335377ild.239.1602085410239;
 Wed, 07 Oct 2020 08:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200928114445.19689-1-sudeep.holla@arm.com> <20200928114445.19689-5-sudeep.holla@arm.com>
 <CABb+yY11d8uS34yfE6-c_NP6n5pmxvmjs67aOKEAduhUpnU3Uw@mail.gmail.com> <20201007114034.rkiujybiknaedy7m@bogus>
In-Reply-To: <20201007114034.rkiujybiknaedy7m@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 7 Oct 2020 10:43:19 -0500
Message-ID: <CABb+yY12hntCgydcTza4qBggi0aqCrt7=aZ+sJoiqEFkm11xtQ@mail.gmail.com>
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

On Wed, Oct 7, 2020 at 6:40 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 02, 2020 at 02:42:37PM -0500, Jassi Brar wrote:
> > On Mon, Sep 28, 2020 at 6:45 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > > +
> > > +static void mhu_db_shutdown(struct mbox_chan *chan)
> > > +{
> > > +       struct mhu_db_channel *chan_info = chan->con_priv;
> > > +       struct mbox_controller *mbox = &chan_info->mhu->mbox;
> > > +       int i;
> > > +
> > > +       for (i = 0; i < mbox->num_chans; i++)
> > > +               if (chan == &mbox->chans[i])
> > > +                       break;
> > > +
> > > +       if (mbox->num_chans == i) {
> > > +               dev_warn(mbox->dev, "Request to free non-existent channel\n");
> > > +               return;
> > > +       }
> > > +
> > > +       /* Reset channel */
> > > +       mhu_db_mbox_clear_irq(chan);
> > > +       chan->con_priv = NULL;
> > >
> > request->free->request will fail because of this NULL assignment.
> > Maybe add a 'taken' flag in mhu_db_channel, which should also be
> > checked before calling mbox_chan_received_data because the data may
> > arrive for a now relinquished channel.
> >
>
> Good point, but the new 'taken' flag will have the same race as con_priv.
> We need a lock here and can we use chan->lock or do you prefer this
> driver maintains it own for this purpose.
>
I meant the con_priv is allocated in mhu_db_mbox_xlate and simply
assigning it NULL leaks memory, if not a crash by some other path. At
least free it before.

-j
