Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933BB254C65
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 19:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgH0Rue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 13:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH0Rud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:50:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72D3C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:50:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so242526pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b/SqgsWTsXb0lAU8siKr5ztfJwzAssbL+oJi/YbwiHA=;
        b=EqsgqqAct0LzsIgirTyObWdj5tHI8+KgB9NSPeSYMO10Ye/pXUa8Eiui0nReAip/gw
         8gTsgoiPhgewoZFInWgvSHQrixdPD3vIaeQptrt6UzPV61WxLq9AjRK5rhN3uJKoocWK
         8Zflarg0F905B8wAM0GXvkpo47/VJdSMsYxJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b/SqgsWTsXb0lAU8siKr5ztfJwzAssbL+oJi/YbwiHA=;
        b=QKgnk6h38cV8Z7Q79Yu/9ZL/JmMsCHUhp3yd8NeBjPbnjS12Fm3VmRpw6yKuoXAl+/
         NFLlPRhK9K8109UwNmK7lK3vz4UIPK4vFe9hWaP01jvlgFCzq9jD4nh5jatCERIXqlcr
         AFW0dmFMi2e9m9LCynBu2pmHMniLc0WRC9veX90T9wHmgPP5mBgRQ9DW2pwu7KBuGI+b
         7Fe/SVka9kwYd+ewEcIDjE3wzP0TxUO7I46y/iwmAReJCsouIsYU9hp6gO81WvlISxgN
         7VTPg2aMjoH+ucPjQx9MZsMLEmc6TE6J3Q0vU26mwB/jiytOwc0fD79ZkznBXMaPms3g
         U8Ew==
X-Gm-Message-State: AOAM533VYGfkA5M+Aj/4JNfATtEU7Mah13tnHbQgXomywVQ4T+gwChHw
        NYrUP1SqwWPCwjOr6mLiN0qx0w==
X-Google-Smtp-Source: ABdhPJwfJOfwKwO/2EvFZ4qXgPksM9GHGJeDgFs1QiCo+e8nten38UbbDx7ppa3qyPKqi4hM2YfLKQ==
X-Received: by 2002:aa7:850b:: with SMTP id v11mr17467146pfn.240.1598550632247;
        Thu, 27 Aug 2020 10:50:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17sm2676168pjl.30.2020.08.27.10.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:50:31 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:50:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Allen Pais <allen.lkml@gmail.com>, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
Message-ID: <202008271050.009BE3795@keescook>
References: <20200827013636.149307-1-allen.lkml@gmail.com>
 <202008261929.A50D0DB3E8@keescook>
 <20200827121941.GC420527@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827121941.GC420527@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 02:19:41PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 26, 2020 at 07:31:40PM -0700, Kees Cook wrote:
> > On Thu, Aug 27, 2020 at 07:06:36AM +0530, Allen Pais wrote:
> > > Introduce container_from() as a generic helper instead of
> > > sub-systems defining a private from_* API
> > > (Eg: from_tasklets recently introduced in
> > > 12cc923f1ccc: Tasklet: Introduce new initialization API)
> > > 
> > > The helper is similar to container_of() in argument order
> > > with the difference of naming the containing structure instead
> > > of having to specify its type.
> > > 
> > > Suggested-by: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Suggested-by: Jens Axboe <axboe@kernel.dk>
> > > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> > 
> > Acked-by: Kees Cook <keescook@chromium.org>
> > 
> > Who can carry this so it can get used by multiple trees? Should I keep a
> > git branch folks should merge when taking Allen's conversion patches?
> 
> I can put it in my driver core tree, and give everyone a stable, signed,
> tag to pull it from so that it can get propagated everywhere, if that
> makes it easy for others to use it now.

Thank you; that would be lovely. :)

-- 
Kees Cook
