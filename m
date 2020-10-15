Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5947128F42C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbgJON7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbgJON7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:59:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF7C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:59:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 144so2093066pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B5Z9U2pjRXxai+O0+8qnC4hYUBYk+Ovi1UIah8Pfnh8=;
        b=CCyQ2Mo6dpE2+RmxGQxeccV6AlyBWoZI6Lq6uNkpxoWR9D9cI6Y5dkJXyvcMLAiEBe
         dakR222fVaFj5mqczTSyfR6uuiLlWJPwXGZSY2PxkKGWjrFdZnNBLYia4tgMeyhHypPo
         BFwiuJvXQQygBBWXEqxKboTvzYowEUOdT9TQ7pu/mn1dnhFOvOM6zuovDAIuRAEeXgra
         /ZdPUwb2YZQNT855W5RnEB+2OL5ymNOvQXBzsc7vZr90ikZETaVScvnBU9DbwnPvmxji
         Vhw0jBpG/whOwYXBxKseCd1LZXm6jGf4mXc0UWyBvrOgnNfmyDZyIXiuc3C18d+RLK5C
         9ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B5Z9U2pjRXxai+O0+8qnC4hYUBYk+Ovi1UIah8Pfnh8=;
        b=R8MvdO0a9t2o0mfKfCoiL8kBp7Mla5pGQBLnR/hl5e7aHq1smBp+4hchOTJXbU1oyn
         dxCPb0SCR43klJGR/5Py+x/h+oklD+09brnrCnuSb5amT4DRvUNtCIGK/8BrAiTZ7z/o
         ZzPGAkm0icv/8DGYyLfR+1DKPUJKmGV5bEaWv/gZbklWNJeFaFgqsA8pdmpOdG9Cw+yR
         0GDH5bRS2ZIuCxN70o+K4gmAt2PfHExWzZLJ3+b7xOPhDqkkzuaxEZ+gYv9tYB0GxtKp
         LCNc+sv5omehMY9k6q3oRRlJQ273C0RqvjwmWP3dnFM5uEHjmaY/RM07U8rRHyY5VpjJ
         9s7g==
X-Gm-Message-State: AOAM530CGtsGgjFqW072cAzrlTLug5akmuQNiMGIPYW4nsLQVSNjScpd
        AlrMP5z2GoYTTcLqSjj6DA==
X-Google-Smtp-Source: ABdhPJwyTXpHfxsilAoNRd9tAuXwfTWvujzOuugI6N3cwWPzkHFYNRg3sPIArZQVG8JNU1oXcT3Mhg==
X-Received: by 2002:aa7:8492:0:b029:155:79b1:437a with SMTP id u18-20020aa784920000b029015579b1437amr4281640pfn.26.1602770380792;
        Thu, 15 Oct 2020 06:59:40 -0700 (PDT)
Received: from PWN ([161.117.80.159])
        by smtp.gmail.com with ESMTPSA id x25sm3654736pfr.132.2020.10.15.06.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 06:59:40 -0700 (PDT)
Date:   Thu, 15 Oct 2020 09:59:32 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm next pull for 5.10-rc1
Message-ID: <20201015135932.GA277152@PWN>
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Thu, Oct 15, 2020 at 11:33:08AM +1000, Dave Airlie wrote:
> Peilin Ye (1):
>       drm/amdgpu: Prevent kernel-infoleak in amdgpu_info_ioctl()

This patch is already in mainline:

commit 543e8669ed9bfb30545fd52bc0e047ca4df7fb31
Author: Peilin Ye <yepeilin.cs@gmail.com>
Date:   Tue Jul 28 15:29:24 2020 -0400

    drm/amdgpu: Prevent kernel-infoleak in amdgpu_info_ioctl()

It has been applied to linux-next twice, for unknown reasons. Thank you!

Peilin Ye

