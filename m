Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE3F26B28F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgIOWtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIOWtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 18:49:22 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A344E20872;
        Tue, 15 Sep 2020 22:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600210161;
        bh=dtBL7+rW0imTskXtCSKxVXNFdtcoWgaEGDDEC9VlscQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EP6/oRH/PIS7vxybNVi3sbfIUqF5gQHBLXB11MPHvmufxYsOE4lWXnzYVyX13D9pN
         NQYXCu1db1nfUiMta0hpJnWOU4u0vglIUjVRgEsQxrPHromj/JTR8oZV9QrLU8fwZj
         yVHZpcklEaSOAJPGXiPX/feAZjcmCYSJHF0BaWwI=
Received: by mail-ot1-f51.google.com with SMTP id u25so4864928otq.6;
        Tue, 15 Sep 2020 15:49:21 -0700 (PDT)
X-Gm-Message-State: AOAM533ZFW5OosFK1geuMu4CzOyem5tZbJQZde3Vpi8hwhG7o0qGgxox
        /xezK+QwXIfKnUmZbMdfawAZY/k2LfSXSfiSwg==
X-Google-Smtp-Source: ABdhPJxbXg9chTXCSCpMtYTHoLYn4L1aW91gZCQweky6eWGCWJEBDQ0MfTjZqpuVHtiRS9jg8cR5SMgoJqxUMLmUBXA=
X-Received: by 2002:a9d:6ada:: with SMTP id m26mr654200otq.192.1600210161026;
 Tue, 15 Sep 2020 15:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <7f50b23d157a97242c79bd8f2ab649a9272b9b59.1599731645.git.viresh.kumar@linaro.org>
 <20200915193510.GA2362311@bogus> <CABb+yY1yZrtzA=1uVnX7tvWrMM6UYkFkoDb_38XksOXhVRzO+g@mail.gmail.com>
In-Reply-To: <CABb+yY1yZrtzA=1uVnX7tvWrMM6UYkFkoDb_38XksOXhVRzO+g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Sep 2020 16:49:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKGpUkF4eHphtWBpw6j2DM1KSrChgpib5JrNmkOQP=bCw@mail.gmail.com>
Message-ID: <CAL_JsqKGpUkF4eHphtWBpw6j2DM1KSrChgpib5JrNmkOQP=bCw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: mailbox : arm,mhu: Convert to Json-schema
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 1:49 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Tue, Sep 15, 2020 at 2:35 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Sep 10, 2020 at 03:25:18PM +0530, Viresh Kumar wrote:
> > > Convert the DT binding over to Json-schema.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > > V3: New patch.
> > >
> > >  .../devicetree/bindings/mailbox/arm,mhu.yaml  | 86 +++++++++++++++++++
> > >  .../devicetree/bindings/mailbox/arm-mhu.txt   | 43 ----------
> > >  2 files changed, 86 insertions(+), 43 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > > new file mode 100644
> > > index 000000000000..4e840cedb2e4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > > @@ -0,0 +1,86 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mailbox/arm,mhu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ARM MHU Mailbox Controller
> > > +
> > > +maintainers:
> > > +  - Jassi Brar <jaswinder.singh@linaro.org>
> >
> > Ideally, this should be someone familiar with the h/w, not the subsystem
> > maintainer. Sudeep or you in this case?
> >
> If you are ok with the content of this file, maybe I am not as
> unfamiliar with MHU as you think :D   I wrote the original doc/binding
> that this yaml is translated from.

You're right, I'd already forgotten this comment when I checked for
licensing afterwards and saw you wrote it. It's just a common thing
I'm commenting on.

> Maybe Viresh/Sudeep should be the maintainer of the mhu doorbell bindings ?

I'm sure at this point, no one does. :)

Rob
