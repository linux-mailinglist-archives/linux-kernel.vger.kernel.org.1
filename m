Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC02CAD45
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392480AbgLAU0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgLAU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:26:21 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE119C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:25:40 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id u19so5366604edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Nml5SouGNrsx3v3L6tvm73HtzygMC5aRxpjbFwAkTn8=;
        b=Hu7hl9/Quk0vCo71+yw02S6j7sx1OQY2SJwWGmUk60eDXBQjXt4sB9kMFBUchh+k0p
         nFkbFz2MfZxdCy47QbYAOh+jtkktBQiEvTPsd8yZm7Sypdds1z7DYli2jsX3R8MaVThr
         0Moj8cOe3QGmnx+tCRlYD15MMYishVpG/C808=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Nml5SouGNrsx3v3L6tvm73HtzygMC5aRxpjbFwAkTn8=;
        b=qWYhWb5cJDTMUA3Q3wo7FQVfaZelybsdmvlg+a9bxFhGPRW3LJc9EWpensdBSnxCA/
         Urt836a95qHSlxtKOW+zhaqOUUGTGjDY/LPCuXsIOM9sczu5ucVkWgooVvfPxtQkwlhu
         jluJGLTt3XIvlMKBK/AAQ3ZTNrwYYS5FgKrUSpw5OLITnVtSEj2fm8I4yvt1VdhMQMm1
         XnAlbxzsxvMi+QVDYFAMeKjcGoyWUygSmKwkPXT5ZZSBFxzltycJVzW3oOsS9lkmIKlq
         DGJPnWgpe1iZrRYkS0KRmjYWzBcSldjwNE4XWdarh3If5yNYNeYX8cMaiE9mBIkNLB40
         Vfuw==
X-Gm-Message-State: AOAM532l37rJGxXdQ/ICkIXEFS/Jx3gci7UjQmug56b3SO9KTSK4XtRn
        C+OLzHbzXwJGYzl4qIYK/rxjYg==
X-Google-Smtp-Source: ABdhPJweJP1CjgjI3f2RO/fFKTXy8q5bO8PH262D4PQ7AgHiVYH0fAxT/ZFvfIAE+aW1teDAs3HMng==
X-Received: by 2002:a05:6402:b3b:: with SMTP id bo27mr4987278edb.376.1606854339473;
        Tue, 01 Dec 2020 12:25:39 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id b20sm360419eja.30.2020.12.01.12.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:25:38 -0800 (PST)
Message-ID: <8fa6721528bbf8f7f59eb773f0cd899a32205a01.camel@chromium.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
From:   Florent Revest <revest@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 01 Dec 2020 21:25:37 +0100
In-Reply-To: <20201201024106.k2jd5nysmokbymn5@ast-mbp>
References: <20201126165748.1748417-1-revest@google.com>
         <20201129010705.7djnqmztkjhqlrdt@ast-mbp>
         <7c75919c4b05cbe5952826d67b6e57a95b544a5a.camel@chromium.org>
         <20201201024106.k2jd5nysmokbymn5@ast-mbp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-30 at 18:41 -0800, Alexei Starovoitov wrote:
> On Mon, Nov 30, 2020 at 05:23:22PM +0100, Florent Revest wrote:
> > On Sat, 2020-11-28 at 17:07 -0800, Alexei Starovoitov wrote:
> > > Looks like debug-only helper.
> > > I cannot think of a way to use in production code.
> > > What program suppose to do with that string?
> > > Do string compare? BPF side doesn't have a good way to do string
> > > manipulations.
> > > If you really need to print a symbolic name for a given address
> > > I'd rather extend bpf_trace_printk() to support %pS
> > 
> > We actually use this helper for auditing, not debugging.
> > We don't want to parse /proc/kallsyms from userspace because we
> > have no guarantee that the module will still be loaded by the time
> > the event reaches userspace (this is also faster in kernelspace).
> 
> so what are you going to do with that string?
> print it? send to user space via ring buffer?

We send our auditing events down to the userspace via a ring buffer and
then events are aggregated and looked at by security analysts. Having
the symbol and module names instead of a hex address makes these events
more meaningful.

> Where are you getting that $pc ?

I give an example in the commit description: we hook into callback
registration functions (for example, nf_register_net_hook), get the
callback address from the function arguments and log audit information
about the registered callback. For example, we want to know the name of
the module in which the callback belongs and the symbol name also helps
enrich the event.

