Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108882AAD33
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 20:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgKHTTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 14:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgKHTTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 14:19:35 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B32FC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 11:19:34 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id p15so7464303ljj.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 11:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+7o3ZAjCMSzQzXHBwOqPMlvtl4jWylaEpfZpMKvelQ=;
        b=anYl+mWXN4SPlC7Nh2s+FUMLPtgq1HipXBWlH+pazRMGbXTtjAVVq75S6XYywvPftV
         rUcto5ujdbKc+O8ZjxpuhxZQnT20Ssds9aPTzuz3H09Imat+7UMWy90z9HEvFePjJK1D
         pcdWjG6k6f8wboQ+45Je71S0tfvqw8Wbjrjpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+7o3ZAjCMSzQzXHBwOqPMlvtl4jWylaEpfZpMKvelQ=;
        b=jrc59A+m9bPpfOyuwnAbY4S/eCLDhiVE0UYA8XVUmvsVDiM1V7NADzEmhqXvYyy3gV
         0x0bxLr9H+Znu2er+F61sK4mYxB1UR0+1fsN9b5pEfP/Jcu5BOz0HtTky1yH6H8FD9ED
         XJ0nq5IB9LxsX5M3GZdW6x9CBKQVHVZ/kj2Lnx/JFSHQqoGzFJKbD8gyjnrjim5kmNHd
         kZqvm3J0Mi08aK2J5ODa5Nc7t8H6xTKxuyI8KPUr8rFQIBZzvwlX1RPog9jyov/Z/feW
         5LdJlHm07hOomHXYOKwd/3S4VJmBV9b8LF56J5o8Sle4Wi5ZbFpbK8QcDpWI8ICGTtGF
         52zg==
X-Gm-Message-State: AOAM530DO/VxjN1Ud165fFNGZVo5l+A9s85tK3nWRgYL4P93SNi+6/io
        wSRFdCONshERF0cknyD+Xd5ra20mEqUHaA==
X-Google-Smtp-Source: ABdhPJxixJgSEnjdIhI0E/iR/TkitmJi9MI3HOqMHL/EG2RlgfKrqoP3AaLo+GN8vPGyYV8nYq8ZZQ==
X-Received: by 2002:a2e:891a:: with SMTP id d26mr4331683lji.90.1604863172145;
        Sun, 08 Nov 2020 11:19:32 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id e68sm1080381lfd.59.2020.11.08.11.19.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 11:19:31 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id l2so9200745lfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 11:19:31 -0800 (PST)
X-Received: by 2002:a19:c703:: with SMTP id x3mr4085792lff.105.1604863170727;
 Sun, 08 Nov 2020 11:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20201107064722.GA139215@arch-e3.localdomain>
In-Reply-To: <20201107064722.GA139215@arch-e3.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Nov 2020 11:19:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whjyOuO-xwov7UWidBOkWyZv84TVA18hBb01V-hiML+yg@mail.gmail.com>
Message-ID: <CAHk-=whjyOuO-xwov7UWidBOkWyZv84TVA18hBb01V-hiML+yg@mail.gmail.com>
Subject: Re: [PATCH] fork: fix copy_process(CLONE_PARENT) race with the
 exiting ->real_parent
To:     Eddy Wu <itseddy0402@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Security Officers <security@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        eddy_wu@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 10:47 PM Eddy Wu <itseddy0402@gmail.com> wrote:
>
> current->group_leader->exit_signal may change during copy_process() if
> current->real_parent exits, move the assignment inside tasklist_lock to avoid
> the race.

Applied. Thanks,

           Linus
