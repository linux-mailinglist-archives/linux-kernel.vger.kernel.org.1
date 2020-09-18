Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB01B270916
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 01:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRXNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 19:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRXNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 19:13:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3A3C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 16:13:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t7so3955054pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 16:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s7PXdt2kMEYDe4HDLKhBUhtN3g8fguL1/b90XNuCWWE=;
        b=tM2VWi/a53wSnklq0Ml+EfOEwzsS1kvhwnUEVm/hESztj83CgH3UpsozwvNrEYcEiq
         F2v5Ir5px4xOF5bJugXxJrNr2KiU3SfuwG80wnjo4lu4U+JQ1h1a57SYJjxDly4wRJtt
         s9296WYgSB5XGORipaMzy7NiPJShrohCm9fVV7GdlRcsvwrmB7EhbrE9p6CEYWV7uw7m
         5pqw1EkxdCkeNOvK0fISqtxYMu/ETw74A/gckmIzbSvGYkNNVib01R916lyN7B6FMnyf
         bnT/I8GLBfnVzmKJ13xGIwsLzwHmJ/6UK/ONLIqWd33PDCy/+qNSwb+eOHOymwjpzUa4
         rTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s7PXdt2kMEYDe4HDLKhBUhtN3g8fguL1/b90XNuCWWE=;
        b=MSdS7kMnJWioOprJdTcVpMLrz4CoSNTjDNoLM3J+rc7BKERO8v1rAlkbRnHElTKtsf
         JA5ZBbIh2RPxUMLF1vvyrFLuaUg28cjkYBeads/7tOrVT6LOTQWxpux3ZW3neeVaL4LF
         X0QBfzjcbRk1RVz54o9MyGKSNzZEMEuQ9pGWsAhzoXWjhkpkpVa0JqYMmkYkOCCpR1Mo
         CPZ4CYvOQiGF0PHTHf3qtRHOapNAC0BdhkeGEiVZsTrtBqzKgD38b6G6eBs84Stk8vmQ
         L5UOwBml9G10/ukQPnb0EYzoyhWl2A7F90odKdhDSXFwv6AUImg5piLbSvDVeWfKmsq/
         i7xQ==
X-Gm-Message-State: AOAM5301iTKeyJUiD6T6qClCB1RUtDDIclpE4DHv/qWNwD/4/RV8PF6C
        sRE3oZp87XSWGf4qMrCGC8E=
X-Google-Smtp-Source: ABdhPJxTHekRd2qpelsTmXR0LALte6YsbAw+W6ZakLzKsIAiVPO6pZ4tZbKK108Bgt4iEN8oz1FJqw==
X-Received: by 2002:a17:90a:e10:: with SMTP id v16mr15045769pje.84.1600470802152;
        Fri, 18 Sep 2020 16:13:22 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id y4sm4237418pfq.215.2020.09.18.16.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 16:13:20 -0700 (PDT)
Date:   Sat, 19 Sep 2020 08:13:18 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ipi_teardown() should depend on HOTPLUG_CPU
Message-ID: <20200918231318.GA598@jagdpanzerIV.localdomain>
References: <20200918153548.836986-1-sergey.senozhatsky@gmail.com>
 <20200918154125.GB31676@willie-the-truck>
 <bcd145134c399f10baf6d51d77133026@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd145134c399f10baf6d51d77133026@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/18 17:07), Marc Zyngier wrote:
> On 2020-09-18 16:41, Will Deacon wrote:
> > On Sat, Sep 19, 2020 at 12:35:48AM +0900, Sergey Senozhatsky wrote:
> > > ipi_teardown() is used only when CONFIG_HOTPLUG_CPU is set.
> > > 
> > > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > ---
> > >  arch/arm64/kernel/smp.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > I think this is a duplicate of:
> > 
> > https://lore.kernel.org/r/20200918123318.23764-1-yuehaibing@huawei.com
> > 
> > which Marc is aware of (and I'm assuming he'll fix it in his series).
> 
> Indeed. Applied and pushed out. Thanks though!

Oh, cool. Thanks.

	-ss
