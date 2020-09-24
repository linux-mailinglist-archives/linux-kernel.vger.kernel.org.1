Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEBF2773E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgIXO1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgIXO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:27:55 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DB4C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:27:54 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z2so3046089qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AS48LmBNeaeY3ugN1ea6Rst5q8t14Q60XV5iNokXC3s=;
        b=a9vGeMeN57jeD7H7MvLf5AF08hOw8CluCrbRwxkG0OHngsjpKiCSU2012BiHG7rnpk
         1MVM5SqlvxPLRz9f/TL0MAcEzK4lpZIc9/gv8Sgs0t3sfae1uKm8zfBoxdr25hKZ2fIS
         IOfsLAUbcefWMeCf/E867Az4he+UHVwsX+yYP7JCRoKxexMm9/SGItbaBEDFDq+KTe0b
         OcyhrSlaQKBrXNqPyxepp+OIvt1esx16i3c45PHGKe73TrwkA9i24JvmzOsUUjfG7pLl
         UWizVQPlOQkQOdXa+ddXn61KlHg1PqD7E5gXUgKdYvDbqxrH1PrpSalvVb/p7Yglz2SJ
         WKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AS48LmBNeaeY3ugN1ea6Rst5q8t14Q60XV5iNokXC3s=;
        b=CK2UWpVeJPngYYT7p22N7X47+gvynyo0uYTPiLLSV3eMKiuYXrLo9rpKCC9ABL8Itl
         +P15B9k0LMZaxvBSr3KWzvVOoi90ebzDkkyWf/mrMpFUvR5kKakhxI4XFzZfIrhvGUWk
         6tmTbPBHid2EtF5+moQonb1klzFSs1eh0122WS3OHiCUDyd/Edk0m6wiQXIyoY7lwRFP
         uziLFi4aXSbZYFbKyN01Vm666TcjP4sN0qOg+Zt199wZRGRP9m2IY3MJb0BBnQLRY8Xb
         crzmdSGl8376pEjKCq0yucItqy7PYwld2SEpOMqvUnf1nfkguRSTbp8W13qG/vWu7rNd
         8YXg==
X-Gm-Message-State: AOAM533nD9EA3a/wG391kJJe2uv40nRr2pqyjsOpZXYaCyTe41fjRklr
        Ele4uo6WHaXAe2VgU9rlYnxJswm73bpcJA==
X-Google-Smtp-Source: ABdhPJxIDv2ykFPRVoMVfihjSBrI9G0vgRvu7MGyd0h66w21jhs8SUUv8R/hn2y7tIWU5pm5ra7ESA==
X-Received: by 2002:ac8:326b:: with SMTP id y40mr5811246qta.355.1600957673190;
        Thu, 24 Sep 2020 07:27:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3600])
        by smtp.gmail.com with ESMTPSA id l13sm2336772qtv.82.2020.09.24.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 07:27:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 24 Sep 2020 10:27:51 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: sched: rq->nr_iowait transiently going negative after the recent
 p->on_cpu optimization
Message-ID: <20200924142751.GF4268@mtj.duckdns.org>
References: <20200918172759.GA4247@mtj.thefacebook.com>
 <20200924115042.GG2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924115042.GG2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 24, 2020 at 01:50:42PM +0200, Peter Zijlstra wrote:
> Hurmph.. I suppose you're right :/ And this is an actual problem?

Yeah, this got exposed to userspace as a full 64bit number which overflowed
u32 conversion in the rust procfs library which aborted a program I was
working on multiple times over several months.

On a more theoretical side, it might also surprise nr_iowait_cpu() users.
However, a real problem that may be.

> I think the below should cure that, but blergh, not nice. If you could
> confirm, I'll try and think of something nicer.

Rik suggested that it'd be sufficient to return 0 on underflow especially
given that 0 is actually the right number to describe the state. So, maybe
that can be a nicer code-wise?

Thanks.

-- 
tejun
