Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9C26D3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIQGwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQGv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:51:58 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:51:57 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t18so1236031ilp.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmO3lehPU5xgp/AaU9lW0DTy2BiuALKSxjt4YpqCbPQ=;
        b=OXBVMolKXu9oHOH/RIVylOl8xeQHwn7gTVs/vMb1xmk0j8xZdei1Po6uQNaOcCi0rz
         k/Jz5O9iQZos06Ktg9342AdyYAQwGZNtt26Mwkfv0C35hYQyYctENMR8d/OqQCdpTbS4
         QBVmNA9+8VsrdPxfGbmfu219GQDfZJ9EL/j/jHq9WnPHJTfkYv+T4y1pLQUGrLNHA1yd
         Mu7KIvQVM+I6p+UhhZw2Ji0gC497GSvFD0it8TrSqlO5Fam7Zk3fnx1S3HpBdVjy6wU/
         saKkt6Ejo4b5N/r+CYf70DfONvV0JcvnKQ7ZIyaC2Sr5OoAh9KEn6JuJd1g+gpIB7kCk
         SIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmO3lehPU5xgp/AaU9lW0DTy2BiuALKSxjt4YpqCbPQ=;
        b=W3T5LmhkXXfgSRw7sz+6H7qDEcXYqSaYoxL3dXpwWMMkGDsOe8FDw37J2+QVj66IFW
         U4bdsEAof3EUKIMkmPHTpBpNvhj3Ah5WFJHrXRjedq7YdrU6qqMFL6rvnaK/x6PiYrbz
         5PGKXdGUMbE6Eo/WId47qs/vcz6s/ye3vlQgrpQdWHidFbvYgjHD1RXwsD9ls87XDrVe
         nVs0nhyjgdTLogTiZlAb/Dg24/59KQByHjVNnmf5WXtgkLlXhQAFLxglJusit1NRdTnQ
         GDPye/j+HBKtOSunAG8FqUJvdsmV/Zo+CRiXOVEMpKlmtZMQlzQUtxvxHPu3TXiKLzPQ
         iTcA==
X-Gm-Message-State: AOAM532wD1ouBr3gU9kwSwTiwC+kmzzGaGrRh7zMTIP+MM34wpJUwbQr
        mZf6ikkz0lbEjAidfxTCvXBijkzKeHK/hd8SpNgCFg==
X-Google-Smtp-Source: ABdhPJxFYzwV1YLidOSKXI1r/DxKCDAaTVJyjocue5dOmnluWfcXOUoJWW2TLVCA5K/Yy25eZFSB7+QxpoVqTOXas+8=
X-Received: by 2002:a92:d48b:: with SMTP id p11mr19958635ilg.69.1600325516756;
 Wed, 16 Sep 2020 23:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200917020021.0860995C06B9@us180.sjc.aristanetworks.com> <CA+HUmGjX4_4_UXWNn=EehQ_3QtFPZq8RJU146r-nc0nA8apx7w@mail.gmail.com>
In-Reply-To: <CA+HUmGjX4_4_UXWNn=EehQ_3QtFPZq8RJU146r-nc0nA8apx7w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 17 Sep 2020 08:51:45 +0200
Message-ID: <CANn89iJOO9cbOqCNpRK4OrZy-L6P8aJJcPMjs5=RHF=fsjEe2Q@mail.gmail.com>
Subject: Re: [PATCH] net: make netdev_wait_allrefs wake-able
To:     Francesco Ruggeri <fruggeri@arista.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 8:33 AM Francesco Ruggeri <fruggeri@arista.com> wrote:
>
> >  static inline void dev_put(struct net_device *dev)
> >  {
> > +       struct task_struct *destroy_task = dev->destroy_task;
> > +
> >         this_cpu_dec(*dev->pcpu_refcnt);
> > +       if (destroy_task)
> > +               wake_up_process(destroy_task);
> >  }
>
> I just realized that this introduces a race, if dev_put drops the last
> reference, an already running netdev_wait_allrefs runs to completion
> and then dev_put tries to wake it up.
> Any suggestions on how to avoid this without resorting to
> locking?
>

Honestly I would not touch dev_put() at all.

Simply change the msleep(250) to something better, with maybe
exponential backoff.
