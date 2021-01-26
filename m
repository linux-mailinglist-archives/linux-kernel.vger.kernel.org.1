Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598FD303C02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405298AbhAZLsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392197AbhAZLpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:45:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C831EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:45:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c12so16131296wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RskLIY79gBLBv+4cE4gzC0Zo5xZ0hs4r15nMpCvAhao=;
        b=UTtqI09J+zAudSaBIf8nOI0rNLzua1UKqXFFiG5mdAooSFLTdk0MTwJTcnzJ50lySn
         tpGMmHwpizjX5j/FcnC1CMFYisD+nV9EF3c2hJi4My5zDGuPpprGiJDoDgTgaDB2r8gH
         2Fg/ngqf4XH+FS+Y29nWH5C35ahFYoaTAra+lrTjf8fwBZfefmsFPRAztjF3kaQUUIA+
         FHECRaVwp6WwhAQJyNR1g8gKVP+v47w3Ft41dD56vK6CGrwP7DUoD3umyvaw4LpX92/9
         qWktKg5yiFt7k8gFWVfUMunKu4c49PPTnQYe2F2eUXuj71zNcEOwE3j7uTFGnoMYNGD/
         t8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RskLIY79gBLBv+4cE4gzC0Zo5xZ0hs4r15nMpCvAhao=;
        b=L2TMmuMdHALZk88l/pTEbLSLtmg4un69qLeqYmMxw4JohCuQyyadgkDZOsqiRjNGlf
         M/Fve95o4KKtQEAgpWPPaRI9nPzINv4TW0pTrPzohTf3Ae8jiZHa0KfeNBsUQx256Uno
         NI34Ioud7AlxWeBFl48JHWI1latZsSMI6qnvBdsvSGKWAAvLXfVtYhHR4o5rPVsagsND
         wF4NpX64y0co8z3eNQFCn6XCCvguwysZ+GLfSyteE2IWRcw7um2W0cIvgBc0dFuAznTi
         rYM77KbOtVYPMGB3jmqt1J788RzJl1Y9ff2EmFtNpKbXWcjd9RSL9SJ+i4Z6EzbHDLGl
         LuMw==
X-Gm-Message-State: AOAM532EoYmJsBDF9xUjYLoFDHchhiABVR7VbEVQXlndx2/UzyeDOUEL
        79b9MZsfzr+f104tRBd4qpd7wg==
X-Google-Smtp-Source: ABdhPJzvSa/GGvkP1QczVwvOVpzSr1u083sJXugoEi0Wq3OXLG7p/M0yQrYeMvnpeOQr+6MLhMyGrQ==
X-Received: by 2002:adf:f009:: with SMTP id j9mr5647691wro.35.1611661509587;
        Tue, 26 Jan 2021 03:45:09 -0800 (PST)
Received: from trex (182.red-79-146-86.dynamicip.rima-tde.net. [79.146.86.182])
        by smtp.gmail.com with ESMTPSA id n11sm30317062wra.9.2021.01.26.03.45.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jan 2021 03:45:08 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Tue, 26 Jan 2021 12:45:07 +0100
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        op-tee@lists.trustedfirmware.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] optee: simplify i2c access
Message-ID: <20210126114507.GA9282@trex>
References: <20210125113758.2430680-1-arnd@kernel.org>
 <20210126080827.GA26654@trex>
 <CAK8P3a09stVcEr9xBOLbkw7ZtzdZpP_pqE4wYRzBoC70c3h1eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a09stVcEr9xBOLbkw7ZtzdZpP_pqE4wYRzBoC70c3h1eA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/21, Arnd Bergmann wrote:
> On Tue, Jan 26, 2021 at 9:08 AM Jorge Ramirez-Ortiz, Foundries
> <jorge@foundries.io> wrote:
> >
> > On 25/01/21, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Storing a bogus i2c_client structure on the stack adds overhead and
> > > causes a compile-time warning:
> > >
> > > drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=]
> > > void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
> > >
> > > Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> > > open-code the i2c_transfer() call, which makes it easier to read
> > > and avoids the warning.
> > >
> > > Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on the i2c bus")
> >
> > does fixing stack-frame compile warnings need a 'fixes' tag?
> 
> The fixes tag only describes which commit introduced the bug, it is irrelevant
> what type of bug this is.
> 
>       Arnd

thanks Arnd.

what compiler warnings are defined as kernel bugs? is there a list
that you use when tracking these?
