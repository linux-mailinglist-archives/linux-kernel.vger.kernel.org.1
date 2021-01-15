Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4F12F6F77
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbhAOA3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbhAOA3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:29:17 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED04C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:28:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m5so4185592pjv.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DadB4dMZfg/PLRa3chi8uXwQiVldY6EMSgs5DP9rrBo=;
        b=oXVhkH6dCM2gjm68QD6+hm1iRHcUxyvZs11zaQG/5mJgPOO8GR49OJrTw524YZnZlp
         Bl+oUUNXRkg7Xx2mWaPt057iWZOyu6k3+FDJj99pMxYxYG2ro4+oxBu6DixH9mt8A7ej
         kM+uSP6DaP8wcLBhk9vRhS/V3UGdx/E/V101DJZXFmhyGdHLkjRGzbzhXYiHZDg9uoNG
         uteInz7XDpl33zyPHiHjKP6FwbnXO6m7M6ZO3rIAh63T/KeX1cHXrk7zCNR+DqDU/yOJ
         AEVjqKHCg548bfKMuUUQPQjljnozesgvlkROwrp4GHWKWNHMXa56SwY81i00wW0f3lVF
         8Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DadB4dMZfg/PLRa3chi8uXwQiVldY6EMSgs5DP9rrBo=;
        b=Wb22nbclAHlUqV7gztegFr5fvdvdMsTEsgtj2Maa0ByukduWazqFrKVCTVxyT9yasD
         S8jl+L25eI5W3IbeJsjvC3rRYiVHD2llf+BiF+OVEHKRIQ2ZLNZyLTqB12P+mlnOKhFW
         nImqvnlvyfb8hRsP+BB+B40UjoFUdtIOBv6GW+9qOl1G3BVutNtgIwBFUl/bDSJm1uY7
         H7urB/qXqPWwGmGDsUhL/NNk93jBUI2hdMRsG8qzHyhIVivNLRNbjr8b2rp9J0ty+anO
         TGR8Q2iWOL3949xWSocuU1NZz1nrNsu2Zi/kYhKRiMeVnUgsbD7O/n49X1MOghf91P7g
         m4aA==
X-Gm-Message-State: AOAM533WJQiQSgZ1pYkysP3Ed14x1f+r3CCcvZU8MvhswmR0pnmJvyn0
        rHCMp6OwaU8iY1LF7o1gxhhN4yLDqGiiRk2Q178JxA==
X-Google-Smtp-Source: ABdhPJys+dJ+QBolCgxszC0GuoEzeOYfrtCrTYKp3dTkUKqnqu5sT8cfZ4T2ZXf8z3EY7Bil7K/cw3b3eNX5WXD7Ojw=
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id
 x7-20020a170902fe87b02900da5d3b4a84mr10049761plm.51.1610670516665; Thu, 14
 Jan 2021 16:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20201211223232.697679-1-davidgow@google.com>
In-Reply-To: <20201211223232.697679-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 16:28:25 -0800
Message-ID: <CAFd5g46UQtLeLoJYtOC=F1zhfz9FaHkYxUcqPjhC+7CQjshz_Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix spelling of "diagnostic" in kunit_parser
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 2:32 PM David Gow <davidgow@google.com> wrote:
>
> Various helper functions were misspelling "diagnostic" in their names.
> It finally got annoying, so fix it.
>
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
