Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE0029FA90
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgJ3B2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3B2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:28:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F72C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:28:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id 7so6455960ejm.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZZJvFd3Jma+t23vBeelS0VsdizMvz3niwNJBqNbVDU=;
        b=HbYYyALY2IJlhmq7q2jZq+pAIeQyCmcGdbPs7jwq0mGuxALYJftzdg6KZwJCHaGYl5
         FatQ9dQ1XALRrMSFfNG9pkZ4r18TNUvG6MKP72PsPml72v0089qvJeAxswRSNgDTL1HY
         ujpU/d4FGvRfHD9aG9puXduhbuhW7O7XoXQHkNeT1vQnjTlObx4FKGx0EvEx9n/d/RDe
         WHeKYZwcHmqEVPoS4U05vB8YilPdMB7UD4Uj6P/gfoM/EP1mj8eosD6M/EZXpIpet5st
         twZkHnLkKIZSfLEmIa5mqmXvC8M+p42i1UX+ASzYES9L2vKUASFZOpvJaYZQ5suS+EiM
         HdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZZJvFd3Jma+t23vBeelS0VsdizMvz3niwNJBqNbVDU=;
        b=L4pqMFuwnK3WxvJfat0sM7KnlCd0XZt2OXYdXz3EFICd5JqkjPvD7uXcsq7OVsxUWZ
         uiPEewf69KNiXKNmYTRyJCOIS4FXYbltFg4H7d0DhqriqwFMfjQOaF3dtpHdIpKclhJO
         mxRw3sW+335BGafiNaI6CuXvlG/IoMpD7hkThbvvbnoqJPvpcsq2kUT3+de6WzPmBX20
         GUTJHMQAatbCOSRdC6E72TM7ZCF6iOdaAJ6nXg+f1BjXXJ8EOZaKDsGA4sjq5kvy424m
         UwR4fNTJctvrRT5RcjnvnE+y4zojXeX+/HgMmSz+iTUfxo7InT37Z1mwvO1DzulMCopP
         tmRg==
X-Gm-Message-State: AOAM5331fohZlcmqOXoBbe3FX3HSigUZux14wkpwkQ5gNLvQPLXAo0C8
        uLfu/5ET2y6eqEnNBN7cyRLWOx0tqzSub+b41bjSiQ==
X-Google-Smtp-Source: ABdhPJw9rcdETvKOj+oguhSFDqPNC2k8vV4d+sEJMxslXgzauXgZ/vMHgiV1N9fT7rAOwdvk8P5AFkunvC9UsmUHMfU=
X-Received: by 2002:a17:906:7fd5:: with SMTP id r21mr140711ejs.418.1604021285439;
 Thu, 29 Oct 2020 18:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <87sg9wodp1.fsf@nanos.tec.linutronix.de> <CAPcyv4hBSwdDocpgFh2=qbVQN=Mc+15cW4cV5m_S-SxVCYY=mA@mail.gmail.com>
 <20201029230920.GA32559@intel.com> <d066788b-0f69-37e5-fd5c-12755f498677@infradead.org>
 <8613f74e-b774-a544-60df-b8012cc4ee14@infradead.org> <CAPcyv4g1XNrpTHmEAuXetg4uU=E4fRZ7MwqdfbUBJwkCEP+Vqw@mail.gmail.com>
In-Reply-To: <CAPcyv4g1XNrpTHmEAuXetg4uU=E4fRZ7MwqdfbUBJwkCEP+Vqw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Oct 2020 18:27:49 -0700
Message-ID: <CAPcyv4iR0HTri3Xk0LgzuN-QP3hTUB6gEvUEK0gTq4kfLaKC_Q@mail.gmail.com>
Subject: Re: [Build fail] i386 & nvdimm is unhappy
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Philip Li <philip.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 4:49 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Oct 29, 2020 at 4:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 10/29/20 4:13 PM, Randy Dunlap wrote:
> > > On 10/29/20 4:09 PM, Philip Li wrote:
> > >> On Thu, Oct 29, 2020 at 03:52:42PM -0700, Dan Williams wrote:
> > >>> On Thu, Oct 29, 2020 at 3:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >>>>
> > >>>> Dan,
> > >>>>
> > >>>> x86 32bit build fails with the config below with this:
> > >>>>
> > >>>>   ERROR: modpost: "phys_to_target_node" [drivers/nvdimm/nd_e820.ko]
> > >>>>   undefined!
> > >>>
> > >>> Acknowledged, I'm on it.
> > >>>
> > >>> Wonder how 0-day missed this or I missed the 0-day report?
> > >> Sorry about this Dan. Can you share some info like which kconfig and bad commit?
> > >> We will investigate this to provide update in earliest time.
> > >>
> > >> Thanks
> > >>
> > >>>
> > >
> > > I posted earlier today about the same failure on x86_64 & linux-next:
> > >
> > > https://lore.kernel.org/linux-next/0faac4da-a7bc-3fc7-e278-ad4f72499224@infradead.org/T/#u
> > >
> > >
> > > Thomas and I both included kernel config files.
> > >
> >
> > Here is a patch that Dan was cc-ed on.
> >
> > https://lore.kernel.org/linux-mm/aaae71a7-4846-f5cc-5acf-cf05fdb1f2dc@oracle.com/
>
> Thanks for that archaeology Randy. That was when I was out on leave
> and I apologize for missing it. I'll get that merged up.

Andrew already rolled that in for -rc1, and looking at it I don't
think it is the right fix.
