Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BFC2866D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgJGSVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGSVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:21:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943BC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:21:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d6so1400422plo.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dG6Pgx/Z9y+pOCfqUIFqdfuAZFEij0fF75ctt2BQqBk=;
        b=a7iDeZjsKaTEY/BiOzObBqqX9n3Dzzfs/KHGqaicIMR3Vbh1OhdAioF5svR2RzoUKd
         nOsreW5t5/4lueFad8DoK3CGPmzEXTYEy4p9DLX1h3Lzr0AFXS2BEZa3YRX00EAAyEHq
         XyE19Vebvee8aWMkPoFILYFpR0e3zNEucAAwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dG6Pgx/Z9y+pOCfqUIFqdfuAZFEij0fF75ctt2BQqBk=;
        b=aY0nGb02hwZP1M20N5MYpnLbHY9SOIbYTzHZ1H1jTgnuj19K0LJSACD5L9gLbAWO3M
         zFL7uRsv0/31iB0SyTLrZyfnQISh4v4xI62qb2U2XDLUrxkIoM+s5QvwQSLYqy7E/FYo
         Eezzm91e5+GB+ahGjyUvD0NW8/Y9+zCjddmq0X9L+9TViRqaYVvNllUNhTU4r3zK1FTb
         SNPaOsc5/OxS7uHLVuvVE1NtWad5OmQTHbhLwsub/f6xZYgnMunTiTHEi2Wt7PxwOMSD
         gzfLsv76s12BdMwciIcz5wVArvCFt4AshMG6L0KSUM5w7e3Lf3cv1tyd38ssQILdGnx/
         h/aA==
X-Gm-Message-State: AOAM533KvhyBSxJOZu4lS+qIYVel8Mq0xBlrY0g6BMdTCCoiWZtEeWlH
        Mx22MTKuv6/RVD7LnH4DE23BrA==
X-Google-Smtp-Source: ABdhPJwx5SPC2AB77nIV2f5dVxirmq93hteJVobZaULnIUZ810ab0rDWkEpGuoPBMumBkRsJ7ak9GQ==
X-Received: by 2002:a17:902:b191:b029:d2:6277:3898 with SMTP id s17-20020a170902b191b02900d262773898mr4105693plr.10.1602094890958;
        Wed, 07 Oct 2020 11:21:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m13sm3299757pjl.45.2020.10.07.11.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:21:29 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:21:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2 09/11] drivers/char/ipmi: convert stats to use
 counter_atomic32
Message-ID: <202010071121.1BA120D@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <46fcf1d28532868abd1c2dedaab221be56736db9.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46fcf1d28532868abd1c2dedaab221be56736db9.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:40PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> atomic_t variables used for stats are atomic counters. Overflow will
> wrap around and reset the stats and no change with the conversion.
> 
> Convert them to use counter_atomic32.
> 
> Reviewed-by: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
