Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AAD28F569
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389081AbgJOO7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388728AbgJOO7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:59:54 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E421C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:59:54 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l28so3935509lfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Be+an15LrnaPiOtwboSIUoBz1mYy3noplAiogE4hPMs=;
        b=FDot9ShXu39lveCF+OW0yRUdygZ3wBX/8lxlKrgEBuG5B7eTyrubDH7f7TJSQfo3RR
         iehEgRownftvmxjDluVRSdsOAElZGd2VrWbbNg8EMGZC09bbj7l3Y/gInN3kObFUKfoP
         ZwTu3g2/Aau1OV/ovEFWnibmFaOFvNmP4kJve/qVXAutw3AFCoUiWXG3yuPpiu5EMbu1
         sIqBGWwQZEgq0C9fkY/ARxBVHT+4gXTF37ZLLZ0M0XyPLW7AsgbaqFQ2GHiLrQLnUEDq
         CinoKqIzX4xb6Ucf/544zW7O4jDBJ/rBMZR/HZtPnrpA3VcMyA64SlCKHzFSRYKXl4vH
         3o+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Be+an15LrnaPiOtwboSIUoBz1mYy3noplAiogE4hPMs=;
        b=mMvY63iG0i/u5K5Vej260IDCZ+bkB0aqGscL7hYG9COrNt1SFZp0oG8Rt6ajnZUh6U
         0cdgecEFEnfTuYgRS0HD+2RUmUsL86fh0EnbGkWBqxgkColrNNviA8wSxT5czq6yqqBp
         CR6ku0TGDIwmJB+UmHXvTzIisu7aOGRcRZDhU9+TRKx6QKfDbrUvbUauGtXKJbjzhfGt
         qFsJxGEXTNSecxNiVvZNd6dXr312L+bphLpT1CNmz+QTk7MWtm79wIRRv+14c+GYZsBt
         w6EH2CBbTIIrCR+zyiVUF2EZJjWELAS9KVPNTLRXBgRPkPSdLvmFyK/HLjZBd6SrOjrS
         XeXA==
X-Gm-Message-State: AOAM531ISF46KNRgZFrEN3W/lmcoXhg8z5B+2jLUswhy9yb6EDK5wfws
        inWpkYLWhkpalBEg9qOeONkizJ2in6xhVlGABug=
X-Google-Smtp-Source: ABdhPJx4L4/CQ4jjGqYEQKoZVBxedUwEFtk0SDdes7DwZrBGrzlWTuA3aoI8E4T/46sDTPw9nu3QcwgAWBcqXgEv7L8=
X-Received: by 2002:ac2:52b7:: with SMTP id r23mr1135747lfm.30.1602773992720;
 Thu, 15 Oct 2020 07:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201014175342.152712-1-jandryuk@gmail.com> <20201014175342.152712-2-jandryuk@gmail.com>
 <b74a3f83-cd8a-34a3-b436-95141f01cb20@suse.com>
In-Reply-To: <b74a3f83-cd8a-34a3-b436-95141f01cb20@suse.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 15 Oct 2020 10:59:40 -0400
Message-ID: <CAKf6xps+mAFdfk8uBw=aMsAFNYmt4ETPkB8dwT3sTv-qPbVENw@mail.gmail.com>
Subject: Re: [PATCH 1/2] xen: Remove Xen PVH/PVHVM dependency on PCI
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 4:10 AM Jan Beulich <jbeulich@suse.com> wrote:
>
> On 14.10.2020 19:53, Jason Andryuk wrote:
> > @@ -76,7 +80,9 @@ config XEN_DEBUG_FS
> >         Enabling this option may incur a significant performance overhead.
> >
> >  config XEN_PVH
> > -     bool "Support for running as a Xen PVH guest"
> > +     bool "Xen PVH guest support"
>
> Tangential question: Is "guest" here still appropriate, i.e.
> isn't this option also controlling whether the kernel can be
> used in a PVH Dom0?

Would you like something more generic like "Xen PVH support" and
"Support for running in Xen PVH mode"?

> >       def_bool n
>
> And is this default still appropriate?

We probably want to flip it on, yes.  PVH is the future, isn't it?

Regards,
Jason
