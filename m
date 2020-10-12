Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BBD28B13A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgJLJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgJLJMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:12:33 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75003C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 02:12:32 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so16179652edk.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F/Cb5OZn6krqsgtktzHrb3AfmZnuULmjHnSfGAeede8=;
        b=RIXynHgrfO1sp/Ndpd5xSeao4r7RxHE1NzQx8CzY1fMbL3HDQL17arxM3xUvIsim8S
         5gKzLZi2k1d+KBnAC5N/Yo/XT+5fEjoVywjX+amClwJAdHHVBb0XzVkbIBecIYSfVBvE
         sfvP3QT33BXnZSWvE6Gk3ZJDwBgS5IFHXW0C11hClj8v6HTxTn4OC+4L9dAu/mejqV+f
         JoFFTy+eMBByJGXu70q/ZQFDVU2MKdKGGYSSY0y+dAv7VoCp0nAWbjxen3hV2Frl0VQQ
         LfZDe02asxy66sYDV34nv/wTNVsJxXs7ZxPBpZixFfoLDH7+tpraMLDaxUEMM4TPYx2S
         GSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/Cb5OZn6krqsgtktzHrb3AfmZnuULmjHnSfGAeede8=;
        b=bwjf4azZU+QJ1RjWYSa9+sw53CQfa7KSVukXHQ8dlfqOP7UEwcDOMzTyzrA6eJ/Njh
         yAge00GQc14upHjNuiReVewdoFIzN8092Re3QINraAYv0Zvjppyyzyf2citOFuD6Asbq
         VSyBQUHwnweNHhilVsURhbNUz5r0YY6znTpa7Nk3Xb75nTkZ8XBfluKiRujXfznraYDH
         ACCc3Q7TuSvczikXAr3mZHbH7VkbBjI6lTH04Rim2d84peLAu9kYKeWwEvS0tCXlpe12
         EWclyTqHhyunWvMgEw2tGFnehyuldDA6Z72vJeVaDs9VHwBnX8oREF/UsUAb/t+4OJk5
         K28g==
X-Gm-Message-State: AOAM5338K+UwI2MguYWdZEVwSB/1ORT0TSyVaA2Zrr647qp2OmrzGzQJ
        62QNbV9M/CYzb/lm/IxtvxxcR43w7WajXFrrDdOqDZ0Imee7izou
X-Google-Smtp-Source: ABdhPJwzXOzCGUNhVl+CIyamdgg8KSu/zkil3SbgtKvtcpXuagt2+LysMP6yofebwgEf+JI8K08LSba5h07IAZsiWyA=
X-Received: by 2002:aa7:de97:: with SMTP id j23mr13142589edv.45.1602493951134;
 Mon, 12 Oct 2020 02:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008143722.21888-4-etienne.carriere@linaro.org> <20201008211116.l6gbym2ypb6lzlo7@bogus>
 <CAN5uoS8tz0wXkD1dtFbAYBWHvngHG8KeUD2JkK32siPa2MwgYA@mail.gmail.com>
 <20201009151752.fxqakqrritrgzo4r@bogus> <20201012085546.GA16519@bogus>
In-Reply-To: <20201012085546.GA16519@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Mon, 12 Oct 2020 11:12:20 +0200
Message-ID: <CAN5uoS_35=HcFSmeG=L0S6Q5XV5_bL-NoD4vgW_NdckJDytcwg@mail.gmail.com>
Subject: Re: [PATCH 4/5] firmware: arm_scmi: smc transport supports
 multi-message pool
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 at 10:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 09, 2020 at 04:17:52PM +0100, Sudeep Holla wrote:
> > On Fri, Oct 09, 2020 at 02:43:31PM +0200, Etienne Carriere wrote:
> > > On Thu, 8 Oct 2020 at 23:11, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Thu, Oct 08, 2020 at 04:37:21PM +0200, Etienne Carriere wrote:
> > > > > There is no reason for the smc transport to restrict itself to a 1
> > > > > message pool. More can be allocated, messages are copied from/to the
> > > > > shared memory only on SMC exit/entry hence SCMI driver can play with
> > > > > several messages.
> > > > >
> > > > > Use value of 20 to mimic mailbox transport implementation.
> > > >
> > > > What is the need to mimic ?
> > >
> > > I had to pick a value. I can't say whether 2, 5 or 20 is better.
> > > I looks how the mailbox transport did and used the same value
> > > as it seemed reasonable regarding its memory cost.
> > >
> > > >
> > > > > Any high value could fit. This should be something configurable.
> > > >
> > > > Why not 10 or 100 ? I see any value other than 1 is useless as we lock
> > > > the channel in send_message and we don't maintain a queue like mailbox.
> > >
> > > I'll check again.
> > > Playing with SCMI voltage domain [1], it happens that I needed several
> > > preallocated message buffers unless what regulators fail to be probed.
> >
> >
> > I may be missing something but I can't see how, we simply block in
> > send_message while mailbox has a queue of 20 which is why it has 20 there.
> >
> > The issue you are seeing could be different. Let me know if I am missing
> > something.
> >
>
> OK, I gave this some thought and realise that in-order to allow multiple
> requests simultaneously, we do need this value > 1. I will take this
> and make some tweaks to the commit log to indicate the same.
>

Thanks for the feedback.
I planned to look back which value would really make sense.
Whatever, feel free to tweak or change this proposal.

Regards,
etienne

> --
> Regards,
> Sudeep
