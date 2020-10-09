Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC177288913
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387635AbgJIMnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgJIMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:43:45 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C0FC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 05:43:45 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 33so9140189edq.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdsaQ+5hmLlCu2Re2BtPWdbinpVtOvRzC8Y1qZuR928=;
        b=CYOKNBFCMhKH8JpvnAKBDpjFKN0z1QWMAwEdWi6DkVRIMuVviaf5gvtqJYxZhwE7sO
         bnEGBkdg3EPxdGuAN5OGqVrvte0ELiQd70UDr1nVl28ifO5YZ8MIp7/iVpKpqwu0RR7n
         KaSwUvYmVhKBpUpNA0QsyAtZUrstAGHq40qMRKMOaIMI2AOvwe/scSOMmXgb2Qo/+QCu
         FJujTzivr7qL+ouOUjyhMjI7VKALiQSZjhVFJAPVTOHZx4JYa0tbyTtdXgVac1xqeexv
         pf2pnF2SHbjztlP7IDsXby8CpFnfk17PoLVBlTFm/0kNa3CQhtJhDcC14hXiSk98AtDN
         wWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdsaQ+5hmLlCu2Re2BtPWdbinpVtOvRzC8Y1qZuR928=;
        b=n+1gZ2hX4EJVmDRE/0+4uJj53pDqb+ygiYl6NczpC5NPwX8uqp9XRMpyFnxZlFK3OW
         Z2mQHEiQoWmJdoQprYbB3iuZusFBnt51tmGSAOkb5bbr9lHQBS0zb+XkJI+QQfJCjVZV
         i+Vsx9W4TX2fXEi99NvZ5Qoa0Y00vzTyqZLOci5xJHpBNqeBzLCS7v25lUbPryd6r8BU
         LGhUPsY4q9vqXAhHuyC2ejY7Ke3DrDnfxmJXIgc2lz9QgAHVbb1xESVeS3VLUGvDPyva
         bklEgyXf7t8PK7pCotdfQDA13N1fnp1vYWHgJ7IZ0S9KcsKERTuEzLFe+G4n9xKqMje0
         iKag==
X-Gm-Message-State: AOAM533aHIVXxUAdsJ0MlKOyh3f49m+MXUEIAYM0MdzG/mHRdp+hn7Gu
        TLUX8wqS4oYGkEm3PdsKPy5Pj6WlfjzuoYnphnJWkQ==
X-Google-Smtp-Source: ABdhPJyV5z/4MNRNwBKKaXulRfevKZ7kBXZE9nXLW4WsoEhDfhLaKgN9iGEs0IUm8Qm7UNgpPdygGN/u2ty40MsIuSc=
X-Received: by 2002:a50:8b62:: with SMTP id l89mr14693598edl.132.1602247423781;
 Fri, 09 Oct 2020 05:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008143722.21888-4-etienne.carriere@linaro.org> <20201008211116.l6gbym2ypb6lzlo7@bogus>
In-Reply-To: <20201008211116.l6gbym2ypb6lzlo7@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 9 Oct 2020 14:43:31 +0200
Message-ID: <CAN5uoS8tz0wXkD1dtFbAYBWHvngHG8KeUD2JkK32siPa2MwgYA@mail.gmail.com>
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

On Thu, 8 Oct 2020 at 23:11, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 08, 2020 at 04:37:21PM +0200, Etienne Carriere wrote:
> > There is no reason for the smc transport to restrict itself to a 1
> > message pool. More can be allocated, messages are copied from/to the
> > shared memory only on SMC exit/entry hence SCMI driver can play with
> > several messages.
> >
> > Use value of 20 to mimic mailbox transport implementation.
>
> What is the need to mimic ?

I had to pick a value. I can't say whether 2, 5 or 20 is better.
I looks how the mailbox transport did and used the same value
as it seemed reasonable regarding its memory cost.

>
> > Any high value could fit. This should be something configurable.
>
> Why not 10 or 100 ? I see any value other than 1 is useless as we lock
> the channel in send_message and we don't maintain a queue like mailbox.

I'll check again.
Playing with SCMI voltage domain [1], it happens that I needed several
preallocated
message buffers unless what regulators fail to be probed.

[1] https://lkml.org/lkml/2020/10/5/1341

Regards,
etienne

>
> --
> Regards,
> Sudeep
