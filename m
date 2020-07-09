Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AFE21A3F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGIPrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 11:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIPrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:47:16 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA5CC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 08:47:16 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dg28so2231236edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsxgMEOvyOIleo5nx+Z/u0swN2p6R8hs+S+pjCKL50I=;
        b=AslfFO8fVFGP9YQxQPQtZ1lx7oCax+DtysbIeuDbh/O/gylusrlOBwCBYEaLzS7Jk9
         e9bSRehpMeURgHpk67UIXgXJPTxkiv5Z9D/jfQAg5rzh2Wv7qsfsiJlZOt6LLza8x0kX
         dhN2PXe1ODbESM35YTnNSE4990dJEj/ZWb50mmbZz9MXK6NoWCeLcJHx8VCqo0CCKZdy
         JcUkrfYY1aZ6v4j8KKYun3R5Kir5QJWWXulr/MfJhbILFOjn4k+sp5TsoWUYMtakeiFi
         TWJKKaSYCI9ZdT2Fz7eh4t1Vr1xIuZILG+t9QSYJX/lMM2GodEmyQyyCGbD96V1ApE6b
         +CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsxgMEOvyOIleo5nx+Z/u0swN2p6R8hs+S+pjCKL50I=;
        b=ZrN8sN+YRl6tEBFxTLA4+0pWV4hTMjK6SwlNVs4UiQtvmGMcDq7ErxGFAqlvTxtoSo
         kp2NI6XHIio6mLPi/dT8cE2SEZxmsbj12llVNxQzBUrZBzPY7t+JX7BsQyI8B1TOb+pc
         BVmx636sr+iiVCrx+9bkr3TNaiXFLMJosEIbSSaCzyZGGBgRDU9rRiKeArALNIMv+GRC
         CO1n8XfAJMipqHY+CiuO7jGuCmtyKIRsY4099FBs2w3waE3GLxajBiMpmy+rNJAeTVUH
         ArKyqVYjkLiUcbGhNqR1tGvMSLKiUPQKrhKjfH0je2B75XlWWEQazzd5+uhg8SHQ9J5A
         TyfA==
X-Gm-Message-State: AOAM531wTOAHvC2a00u+fpu49HcSc4mcHqBdhlOCmHSJOb2PidnfdatL
        qfwAL00ruOkh1JXT60rjYte8HianpNivwiHGg5hr4w==
X-Google-Smtp-Source: ABdhPJz/v+1l0sIJAcLdXdEngxJHh98+g/FsncCIvnDz8xpK/eFai2qhvlm/mACLnKYJR5a4nGf9b+IdhUb54UKJjhA=
X-Received: by 2002:a50:c355:: with SMTP id q21mr70106802edb.121.1594309633800;
 Thu, 09 Jul 2020 08:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200708231253.3831497-1-surenb@google.com> <20200709081820.GB13487@kroah.com>
In-Reply-To: <20200709081820.GB13487@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 9 Jul 2020 08:47:01 -0700
Message-ID: <CAHRSSEwz4jOWT3Ds8ESNZUcxOYyQkbMy=NoU4=cdb6tYd3BUtw@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: add Hridya and myself into Android
 driver maintainers list
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 1:18 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 08, 2020 at 04:12:53PM -0700, Suren Baghdasaryan wrote:
> > Add new maintainers for ashmem driver to handle related issues.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

>
> Can I get an ack/reviewed-by/something by the existing maintainers to
> verify this?  :)
>
> And I thought we were deleting ashmem soon?
>
> thanks,
>
> greg k-h
