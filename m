Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27D4230D29
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgG1PMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 11:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbgG1PMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:12:49 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0ECC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:12:49 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id v22so4306083edy.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WevGPH6UtqWhNNg9b/gYd5J+fviEwplRatGn7GXS2Ao=;
        b=05Buf8IOEENymgSiftCsuiNHQXzMWnwa21muz5tgZaEZ/zq5qj7bFzGugFpwNHz7MK
         mn29PhzDaYPuxb7lAHUbvpcXfqIaHb57w+2DXofA6T8A07tnWcGrHT+xOd34OT2fSeV3
         Sb9jWs3ErtMD2Kj5OLHr9UApyWu/1jBoGpAV+ITUcDpBP2SBDn8l9CFrnuTPvPU0ZYig
         84nZJI4emQpsYzgnkI9SOUZtxUfWxgzjtkyMt8jLz6UPAig4JcPqmrctBWQ13iHpaX6T
         r9voSA0dASqvzFLwTPIlPeflBVGTeqahehqdxQRsJnzpYjuQ2E0DeHxHCKzaCWNpmr+0
         Fc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WevGPH6UtqWhNNg9b/gYd5J+fviEwplRatGn7GXS2Ao=;
        b=l6GhWPQT6JCG8nMrDCAiGWid2sgIGm2TthUU7UStLi8dgeZw+YAFYJbJOuXIUpT8J6
         Kz2znGV7/unHzAxj4W3F29+s+DxsOsPK0hhnTnXjrYPIKLCIeYKSvEDwFNXlTnMKzpOi
         8FwjcQdGONmuhNUsPyrl1Q52H7VxKvYQRxLLQCVp31Pzehiq9GrcQq7EN2hpws1Sf7tu
         JaSUVwlE1bZtDK7TV/N+loZV8WJcy93mxx/sm8Bgkq1H4gcjVjtvRsC5ad+2w7ylbjwZ
         leCJ3bMut8tTrF7MLHcNVzwtcQ4wlxIeyGsZLLuSFXFsoxt/bkVBfTJftTBHOo+YGKud
         vjmg==
X-Gm-Message-State: AOAM530+LuAQ5XwVnDxbjZJ4R1J3pGrvjs9euRixWof9Ig0JrrEi1+Xr
        ACrM0LHH4Lia0suHnPd80+LAWX3Cd2yb1CNMxKrG
X-Google-Smtp-Source: ABdhPJw/CWI7u/RnyrDu3Gpfw38RpHSAZKduBDzPT9wyjkBRDsZ6AthExSyKe1EhjvNUUSN+M52Cec/x38XJ8iywCvA=
X-Received: by 2002:aa7:d6c9:: with SMTP id x9mr1918759edr.135.1595949167829;
 Tue, 28 Jul 2020 08:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com> <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
 <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com> <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com>
In-Reply-To: <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Jul 2020 11:12:36 -0400
Message-ID: <CAHC9VhT1sGSpfCKojbKR+O2Hf_h+wnKnBwwSo09CbFaCYLcOHA@mail.gmail.com>
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 8:49 AM Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
>
> Thanks for the review! I'll send a new revision of the patch with the
> %x formatter and using the TP_CONDITION macro.
>
> On adding further information to the trace event, I would prefer
> adding the strict minimum to be able to correlate the event with the
> avc message. The reason is that tracevents have a fixed size (see
> https://www.kernel.org/doc/Documentation/trace/events.txt). For
> instance, we would need to decide on a maximum size for the string
> representation of the list of permissions.

It sounds like this is no longer an issue, hopefully this changes your
thinking as I'm not sure how usable it would be in practice for users
not overly familiar with SELinux.

Perhaps it would be helpful if you provided an example of how one
would be expected to use this new tracepoint?  That would help put
things in the proper perspective.

> This would also duplicate
> the reporting done in the avc audit event. I'll simply add the pid as
> part of the printk, which should be sufficient for the correlation.

Well, to be honest, the very nature of this tracepoint is duplicating
the AVC audit record with a focus on using perf to establish a full
backtrace at the expense of reduced information.  At least that is how
it appears to me.

--=20
paul moore
www.paul-moore.com
