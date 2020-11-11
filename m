Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075072AE4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 01:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgKKAS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 19:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKKAS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:18:26 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0AEC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:18:25 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id y22so37321plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xX83z+sBc0MxDgbJ31haaJbdXGfe/8kIYD/48IZ9Gic=;
        b=ZPCtIKuB0wASSPRTkTxaFinLIWKcmOorldhT5b0QbF/aaHtVH6QCIfWQQpGEokobUO
         qDVLJ0z7Qw1HefqVCVBMDtp6pqPq8it9DanhWG/ZMn6mtt/4notKmRxGCD7rLGd+pV+l
         jcX2tz+VV//03/MPnqBiJREKgcPtZzjnLP/wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xX83z+sBc0MxDgbJ31haaJbdXGfe/8kIYD/48IZ9Gic=;
        b=k6EtH/k+5/pUxUEfCpOyCxxzboAFDDAc7HexpuZ7sDG2EyaGyzfG8GgIrFIlyYcAPu
         jv2+iCUjMkQMe8R9hoGPSN6eraRHYg7IUp4uha9RF/oIyW72jEJ+9FBv1MSRVCMVDiTm
         Qibjx1LPcMVm8qwd+k2zVCKUn7SmnERE2b1QFBmdk8EB2bY5CIsA0OtuRHDyhSTKiYLQ
         zGs2H1XxMUO/re+mLFg3qZGRvEsEpz1LdrLqnGx+u6JTl/kKUu7nfP9zW6c1es7GyNT4
         TRH6o5rXZTdcqxvkgCS5p1aq+Siv02vzhT4E5F77KsUZV+wRY/tpfDr+4HUcdsLQqlxG
         EXJA==
X-Gm-Message-State: AOAM53295aDyyHXArV5HAVt4c0UtTRp18Grl/u7xIc3kkpCdbgOy7udh
        ijdy82x3AVclfvGv2hydb/b1/DQ/qtJp5Q==
X-Google-Smtp-Source: ABdhPJyKkiLSSHH3vgAAkaQFP89b4D4OM/9VAJBsoa0y78vrTnR1fM7RUOqjYNYVcaZJva6+/iWs1w==
X-Received: by 2002:a17:902:7206:b029:d7:e6db:38c6 with SMTP id ba6-20020a1709027206b02900d7e6db38c6mr9848313plb.6.1605053903009;
        Tue, 10 Nov 2020 16:18:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t12sm276042pfq.79.2020.11.10.16.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 16:18:22 -0800 (PST)
Date:   Tue, 10 Nov 2020 16:18:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <202011101614.E7D880689@keescook>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <X6r7BIG8JTUOLcY0@kroah.com>
 <X6r7Vl45bgGQiAD2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6r7Vl45bgGQiAD2@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:43:02PM +0100, Greg KH wrote:
> On Tue, Nov 10, 2020 at 09:41:40PM +0100, Greg KH wrote:
> > On Tue, Nov 10, 2020 at 12:53:27PM -0700, Shuah Khan wrote:
> > > +Decrement interface
> > > +-------------------
> > > +
> > > +Decrements sequence number and doesn't return the new value. ::
> > > +
> > > +        seqnum32_dec() --> atomic_dec()
> > > +        seqnum64_dec() --> atomic64_dec()
> > 
> > Why would you need to decrement a sequence number?  Shouldn't they just
> > always go up?
> > 
> > I see you use them in your patch 12/13, but I don't think that really is
> > a sequence number there, but rather just some other odd value :)

To that end, they should likely be internally cast to u32 and u64 (and
why is seqnum64 ifdef on CONFIG_64BIT?).

> Note, other than this, I like the idea.  It makes it obvious what these
> atomic variables are being used for, and they can't be abused for other
> things.  Nice work.

Agreed: this is a clear wrapping sequence counter. It's only abuse would
be using it in a place where wrapping actually is _not_ safe. (bikeshed:
can we call it wrap_u32 and wrap_u64?)

-- 
Kees Cook
