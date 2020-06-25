Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE017209EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404819AbgFYMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404650AbgFYMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:52:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A209C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 05:52:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w2so2440420pgg.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 05:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLpKlluK0xCTBNxUab3MgIjNtLTLogp4EiKdanHoPqo=;
        b=LaVKGeIpgQB6AcB2k7QauLya2rwFxGE0cxGYK8YnyRUcSnTUIt9ac3qq/6Vs8rJZl4
         pH5/eDXD0qr681ZEAwW1NJIIqUaRyklOsZLzlXoMwQTj6GhuLgHr8/YBlzaB8TmVYxKB
         AFXKuayvQCPMDgCsswT+soxzKkmojkzz+vK5gy6LuH6dd8wlqh5rvcNWwSCRqAiKyVGp
         K2mxL62ylVzJxdCTpNvTfiyz1qOQLGNZfUyT3G7WEXbAxTaO811xprhOBLBYff1nydql
         pxdcd5uSzzg3CtvXyCISy69c+faxyW3QnPOKtIG6vspEUxdbMegp5QoKYj+mrOA4IEgi
         C6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLpKlluK0xCTBNxUab3MgIjNtLTLogp4EiKdanHoPqo=;
        b=pCkuktSKRGqotQAMs5w4q9iz38SzGIdMzaMRJX9Hxyv70MpoJofGg5+aQ9CPIJEeMa
         b2ZAxfu5VfLhAiXYgOa6r8ChyxzoTB8nAlFyq7VvcqsPJ0RveC0w8IOeyF6d2fRu0IM6
         mTSQe7A7uyxRM16AvXKcKEFCPqIX7nKm56jmYQOoAg8Eq4mMERWZoDtcEVkf75koz5An
         9ia1bh0N+8Sf6xiYjj0AlZ0xeq8aG9ftOhJjG8vpLhZ2Er6A4acusasVrhbXrToMn1fu
         5+lJtNg8jD9oG/QBXok6mVYG37H+j+Ppm4GLxQE7kB2Tm183fBXKwJaBwQYcydbdgLTw
         6Iww==
X-Gm-Message-State: AOAM530I49x6KtYpi6x4L2MS1j1p9i8HJHXq4tyDU2vcqFlhbmGx4GUZ
        nNjgOYt4Qw8tZX1b786fc0diM2WCQBVrRDKTmavDDKfCEB0=
X-Google-Smtp-Source: ABdhPJybZI9FpKDLzQv/5XzuOhZl9DmhSYr8WeJI49d2w+bhzmvrjIAVVUzI8HTMeKWtlHkXDbfw+03v6baP+26QK1w=
X-Received: by 2002:aa7:9910:: with SMTP id z16mr32601525pff.53.1593089521686;
 Thu, 25 Jun 2020 05:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org> <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com> <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com> <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
 <1593012069.28403.11.camel@HansenPartnership.com> <3aa8705a-0342-25ea-00c4-d5370d91ddb4@forissier.org>
In-Reply-To: <3aa8705a-0342-25ea-00c4-d5370d91ddb4@forissier.org>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Thu, 25 Jun 2020 15:51:50 +0300
Message-ID: <CAD8XO3ZDv-RZ-VPv-AFMRkMD_3uW9XYLeZQf0btGVK8m7GX2Dg@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Jerome Forissier <jerome@forissier.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>,
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

On Wed, 24 Jun 2020 at 18:44, Jerome Forissier <jerome@forissier.org> wrote:
>
>
>
> On 6/24/20 5:21 PM, James Bottomley wrote:
> > On Wed, 2020-06-24 at 16:17 +0530, Sumit Garg wrote:
> >> Apologies for delay in my reply as I was busy with some other stuff.
> >>
> >> On Fri, 19 Jun 2020 at 20:30, James Bottomley
> >> <James.Bottomley@hansenpartnership.com> wrote:
> > [...]
> >>> it's about consistency with what the kernel types mean.  When some
> >>> checker detects your using little endian operations on a big endian
> >>> structure (like in the prink for instance) they're going to keep
> >>> emailing you about it.
> >>
> >> As mentioned above, using different terminology is meant to cause
> >> more confusion than just difference in endianness which is manageable
> >> inside TEE.
> >>
> >> And I think it's safe to say that the kernel implements UUID in big
> >> endian format and thus uses %pUb whereas OP-TEE implements UUID in
> >> little endian format and thus uses %pUl.
> >
> > So what I think you're saying is that if we still had uuid_be and
> > uuid_le you'd use uuid_le, because that's exactly the structure
> > described in the docs.  But because we renamed
> >
> > uuid_be -> uuid_t
> > uuid_le -> guid_t
> >
> > You can't use guid_t as a kernel type because it has the wrong name?
>
> Let me try to clear the confusion that I introduce myself I believe :-/
> IMO:
>
> - optee_register_device(const uuid_t *device_uuid) *is* the correct
> prototype.
> - device_uuid is *guaranteed* to be BE because OP-TEE makes this
> guarantee (it converts from its internal LE representation to BE when
> enumerating the devices, but it doesn't matter to the kernel).
> - Therefore %pUb is the correct format.
>
> I'm sorry for doubting the BE order initially. I am so used to OP-TEE
> using LE internally, that I missed the fact that we have an explicit
> conversion...
>
> Does this sound good?
>
> Thanks,
> --
> Jerome

I think your description is correct. But I think this problem  would
be solved outside of the current patchset.
All places should use one single format (LE):
-  internal optee representation;
-  device enumeration pta;
-  this kernel driver which creates sysfs entry and sets
uid_copy(&optee_device->id.uuid, device_uuid);
-  matching function;
-  drivers use UUID_INIT();

In that way everything will be consistent. But it will require
changing other pieces, not just the kernel. While
these patches add functionality to support current device enumeration
in optee os.
So I think this version is ok to be applied.

Regards,
Maxim.
