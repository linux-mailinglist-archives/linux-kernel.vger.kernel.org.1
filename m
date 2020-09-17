Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2248926E7F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 00:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgIQWHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 18:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIQWHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:07:37 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928ABC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 15:07:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so2022850pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZbCBEdq8KnsqpsS4hwIyptSV65b1idGsJpvWf9x1kWE=;
        b=KjoJhWyxpjl6/1j5XZi1G6b1H4FHP4Jk7mq8yX/aKnzkjlTFoO0R6TTKvIJC75vWip
         cgKUWONQ39ZjHRbpEZ0RlgW28n+mUx9G4bMtuddc5U2pnvJjDC0t/kI/+vj5h5CDncA+
         n6k72TZQrlo8nUg75GwDZ97PDuacdmPKR6M9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZbCBEdq8KnsqpsS4hwIyptSV65b1idGsJpvWf9x1kWE=;
        b=jnmZRxNEvCJ5a+4t0U1cQt4wJ9ZKHb/vnbsriZ4rWMJ4N9Ofc0Xr0btVHqS/NIghq3
         QcemnVcJfIeOlZrzOA3BYFIApH3PtGm+IT8Pjye7NSRkgUY00RPd2pV9nUfYxBt9YNrr
         +Ng9ntaARl/WCLIsaWUWIASVe9zhAzpOlRH2Fho0RuyFYdj1HjDemcMJ+G3GzPLuA09A
         KItvw8vDbM18d93Gw+egHBJkXP9zwF8pNViwXoA9MLcUdsX7duuFn2YFmQXv+tpVrOAb
         ySJ/4+OuZPL46aUlUixfB+wPFqjjEBgCya+puHpf16cF3qUXUOLKvC33SfsnKgMsnVGr
         iOTw==
X-Gm-Message-State: AOAM530LdEJIvUBYtWK2ZFjr5I7Ie8QKPv/6DNGzBwx3g8MuDIi81/Ps
        ZoAeHIz52g7ofDmZFL2KrNRcIw==
X-Google-Smtp-Source: ABdhPJy++uAnXYuUHCnPvoy4kLjCn8ZQYz0aMLBOYABxGPWS3bJI6nJZQPjsSTyhj7sZqtbF4u0xcw==
X-Received: by 2002:a17:902:c20a:b029:d1:e598:400d with SMTP id 10-20020a170902c20ab02900d1e598400dmr12681703pll.71.1600380457211;
        Thu, 17 Sep 2020 15:07:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a13sm592214pgq.41.2020.09.17.15.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:07:36 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:07:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jcmvbkbc@gmail.com
Subject: Re: [PATCH] selftests/harness: Flush stdout before forking
Message-ID: <202009171506.7147F47FE@keescook>
References: <20200917041519.3284582-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917041519.3284582-1-mpe@ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 02:15:19PM +1000, Michael Ellerman wrote:
> The test harness forks() a child to run each test. Both the parent and
> the child print to stdout using libc functions. That can lead to
> duplicated (or more) output if the libc buffers are not flushed before
> forking.
> 
> It's generally not seen when running programs directly, because stdout
> will usually be line buffered when it's pointing to a terminal.
> 
> This was noticed when running the seccomp_bpf test, eg:
> 
>   $ ./seccomp_bpf | tee test.log
>   $ grep -c "TAP version 13" test.log
>   2

Oh thank you for tracking this down! I thought seccomp wasn't killing a
child or something, and hadn't found it yet. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
