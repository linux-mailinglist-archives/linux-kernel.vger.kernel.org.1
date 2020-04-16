Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A651ABBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 11:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502967AbgDPI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503036AbgDPI4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:56:01 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE216C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:56:00 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k21so2465842otl.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCt/25bZqDvJVBbS2T/nSkaf4i35Ayu5fc8C9w+DSHs=;
        b=ZB0SB3T3b/D2aou2Jlt1WAGRUEG6DPFL8ORrU5aJDGvS4RRldCBtGq2u7ipF43i5+e
         m/n8V+goLmrO0pw+8cjm6JNzoJXnwPETMIFcZ+HOgQKONpKf2OP/Px6JmiJdtlW6Sikt
         E3E3/GJMs9fYI7obYF+mrWBKiHyFnQ20T5a6caWaCncQ5gNuRPc+kBFKK/F10B5w47KA
         XAe6XDI71mypF0rmtCrEAH5exDprf+LakqHYHxw/kMhdR3F1XHquGELfQY2VnTq3M5x/
         f0+zXtyA5UD23Mhql3kdSSsqXZ4unrLQGx8xVdKvGxAjOycZ13qziMAOsaemXu4l2ASR
         QbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCt/25bZqDvJVBbS2T/nSkaf4i35Ayu5fc8C9w+DSHs=;
        b=F/LzjCRQUeKRob1oTxVw3fplOLqRCD8+2dO6D48wrc66BpokSQ4dDGJbYwrjpWcN9S
         9qS5Ux1AasfpamQ47lW+siG3ibPeoEzPcmv/mYqxv3C0TPcSUnKBcGXAmf1CJA5+V7mm
         hruFltiNHWNQvA0XDB2LjuElbW69T1hv3ENvi3i5JUXP4XxrcP3p/XFA/2BxBkUBn3/C
         haGvCbKZgRPcsiHTy5J819wuiPXmbmDWCKabcJ9+AMasGfVtbrtwkrX93z47YkaLZCF6
         Iaq91gMEAm3PDJkDSk0oF2B4GZq/vndLkHAOq8KHW4vGz4HvDxc149IRP71RfFCjJUJZ
         e5Cw==
X-Gm-Message-State: AGi0PuaU+GxaQ9vXOeZoNhGFcvDYcLgkwOgyolqUnl+MPF0n+XI/5Ae6
        w4odyQLACE+WYBASeDa0cfDxJLAqpJgdOoTuKz5wTw==
X-Google-Smtp-Source: APiQypL2lhwIWiAZBB0Q4t1XxMP5gwqrnEPMEO5qsx7kwPdeLMRsCyvcU6J1wF1QmqGUwY3+rdRxCitBqx9DG5FCrOM=
X-Received: by 2002:a05:6830:1f39:: with SMTP id e25mr26276595oth.135.1587027360244;
 Thu, 16 Apr 2020 01:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200414143743.32677-1-peter.maydell@linaro.org> <20200415151132.03cad507@lwn.net>
In-Reply-To: <20200415151132.03cad507@lwn.net>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 16 Apr 2020 09:55:49 +0100
Message-ID: <CAFEAcA8igL7L8D16shd6KoVH8Yvu0SwyxcShKoGFgLmDhnSrNA@mail.gmail.com>
Subject: Re: [PATCH] scripts/kernel-doc: Add missing close-paren in c:function directives
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 at 22:11, Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Tue, 14 Apr 2020 15:37:43 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > When kernel-doc generates a 'c:function' directive for a function
> > one of whose arguments is a function pointer, it fails to print
> > the close-paren after the argument list of the function pointer
> > argument. For instance:
> >
> >  long work_on_cpu(int cpu, long (*fn) (void *, void * arg)

> Interesting.  This appears to have affected well over 100 function
> definitions in the docs, and nobody ever noticed.  Good to know we're all
> reading it closely :)

Heh; I think my conclusion is "function signatures for APIs which
don't provide and use a typedef for function-pointer-arguments are
sufficiently hard to read that people don't notice simple errors
in them", but then I prefer the with-typedef style to start with :-)

thanks
-- PMM
