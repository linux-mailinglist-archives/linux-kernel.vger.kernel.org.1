Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA45D200354
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbgFSIMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgFSIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:12:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966F3C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:12:30 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z9so10426437ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5U9y+1utAvEauwTC/TQ7OSGUntNHPOui6fNXVJDwjdU=;
        b=varmxndC/3NgdlnBAMapzu8rRSMjkv6X4ceO0ee+iTecVp69vS8zaSvkuSd1YGsf4N
         BBKywTizbOVvIv1kgfnmi8n1Ea4Xt12B6c47U5WMnhufTd7xAi04JOqxIfohB+Y0Br5S
         ykNtVrTFoexx4nrOrdmADGyBwQ4JACKph8oGZXPR/8FmKQL3ai3mUrlnfx+RSYp7ng9I
         4ig9BU/WRlnN/JSf+yPGEbU9f3O12QmY0SmiUT9UI8QCo4KEbiz2NfnTxPi/ibdC9wm2
         drzcWEXEbNgi1jq8pTsY/grSJkkUMoGgKDAtopGQCx0hwhTJrUHTgsExpP9a7tcDLxvg
         Lj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5U9y+1utAvEauwTC/TQ7OSGUntNHPOui6fNXVJDwjdU=;
        b=FxuycLspsS0SYSnNRMnaImi6Uup+IhsiE+6rCX68wFYf/Z/cICpvas1wzLpRH3zM+E
         BD7mthnz0aXWEy08jLjmIcCyKmgNJQWFaTipqpsySIVCSfbdLWKHfYb4EC+yyvpsWVbr
         fQ2ZV1Bs8KIYrfjDgjy2SUipmxrbHPQlSjGj3CI9YyQHuDzfijx2qUId/zFGDw17nAQt
         sAv9dgEe39WRteQx/diP2lG3xXx5s7nFCruLG5yEMsYmW/qF5c46ONxTUh1w4xhw0FdM
         4vIJWML9vF50jTCCxUYn1VJFfsBoGoOQcZikgeQYvMA5UmAuXn9wf3jfKSTDBt2FR5y9
         eDeg==
X-Gm-Message-State: AOAM533oJOD+Zhcg6un7rCe3OrUiSet9wdgyocwDfkP6NF64hdbLty45
        jKAzgUdCg0Uwxoix4c37O6B0SZAN4Nnrp5ODOCRh5A==
X-Google-Smtp-Source: ABdhPJyjLr5WoMUQfsclz7DbaBy3pgu30u2rloF7HoxC5jPI6pSYPkkqfiyYOPmPWV9vOznR6hgk+uY87wnRvmxKWzw=
X-Received: by 2002:a2e:b04c:: with SMTP id d12mr1115848ljl.256.1592554349020;
 Fri, 19 Jun 2020 01:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org> <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com> <1592507935.15159.5.camel@HansenPartnership.com>
In-Reply-To: <1592507935.15159.5.camel@HansenPartnership.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 19 Jun 2020 13:42:17 +0530
Message-ID: <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jerome Forissier <jerome@forissier.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 at 00:49, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2020-06-18 at 10:42 +0530, Sumit Garg wrote:
> > On Thu, 18 Jun 2020 at 10:29, Sumit Garg <sumit.garg@linaro.org>
> > wrote:
> [...]
> > > > typedef struct
> > > > {
> > > >         uint32_t timeLow;
> > > >         uint16_t timeMid;
> > > >         uint16_t timeHiAndVersion;
> > > >         uint8_t clockSeqAndNode[8];
> > > > } TEE_UUID;
> > > >
> > > > (GlobalPlatform TEE Internal Core API spec v1.2.1 section 3.2.4)
> > > >
> > > > - The spec does not mandate any particular endianness and simply
> > > > warnsabout possible issues if secure and non-secure worlds differ
> > > > in endianness.
> > > > - OP-TEE uses %pUl assuming that host order is little endian
> > > > (that is true for the Arm platforms that run OP-TEE currently).
> > > > By the same logic %pUl should be fine in the kernel.
> >
> > I think Linux adheres to this RFC [1] for UUID byte order. See below
> > snippet from section: "Layout and Byte Order":
> >
> >    The fields are encoded as 16 octets, with the sizes and order of
> > the
> >    fields defined above, and with each field encoded with the Most
> >    Significant Byte first (known as network byte order).  Note that
> > the
> >    field names, particularly for multiplexed fields, follow
> > historical
> >    practice.
>
> Actually, that's not quite true.  We used to support both little and
> big endian uuids until we realised it was basically microsoft vs
> everyone else (as codified by RFC 4122).  Now we support UUIDs which
> are big endian and GUIDs which are little endian.  This was the commit
> that sorted out the confusion:
>
> commit f9727a17db9bab71ddae91f74f11a8a2f9a0ece6
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed May 17 10:02:48 2017 +0200
>
>     uuid: rename uuid types
>

Thanks for providing the background here.

> so if you're using a little endian uuid, you should probably be using
> GUID for TEE_UUID.

IMO, using GUID in kernel for TEE_UUID in OP-TEE OS will lead to
deviation from GlobalPlatform TEE client spec [1] as the spec only
references it as UUID and we would like to keep kernel TEE client
interface to be compatible with GP specs.

[1] https://globalplatform.org/specs-library/tee-client-api-specification/

-Sumit

>
> James
>
