Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3223628FB69
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 01:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbgJOXGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 19:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732434AbgJOXGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 19:06:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B17C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 16:06:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a5so490502ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ySCIwp29O4ociJzzOVOKh5KY68CfkZIAay+F6Ok3yY=;
        b=e3so42TRsxuJ5mfPkYxoGNiW4GBI/Yl75Lc/i38Ex2+2KqlheN4ZFDlPXUX0UKQnhA
         JMtYEt1aWnwC1ngp0X+lLfsTMfzivxRw90SqLT+MnFlkj7RWmj4zvVQDRAi2bY9yacEZ
         UuE9J4R3Xd701mCWp6XRRasGIN1q0IKac4DUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ySCIwp29O4ociJzzOVOKh5KY68CfkZIAay+F6Ok3yY=;
        b=GliTIoR7voGqqvuzh2HXSmKlHplSoQ1Qmh4B1i7t6IeJX2ugsqTs1V1y1UFCVrpr5L
         xC9VkNkufKRb7TW6G+yQXmcTh/q2lyvS9Yzc0LIYgFXgHDf1Vi5IzhnxsffcwqF0kfjQ
         UxtAEu8MR9AkwC1jaXo/3ScYcOBDs/S2w8TGsgUSffuIv5O9tqh+wdczk7lxJ7GpZ+2X
         sKjuY87QTS5m1THEJKcEVK5h2PFYSUGm1I1oR4pOeXRlSz7fy/9dIc7FrllnVezttgWB
         7KdMm4wAEyXFk5UgPl1qvT8UMSn6zZLWhH2ddk0V7+d3nqcpJAyEUHbipCbGydaoChos
         oUEw==
X-Gm-Message-State: AOAM533D5ZhEmgo/2owltW/BlY57iHsYXzz2+mFx4y6vrt2i8sz/dyyo
        jOUInAE8Dp3NCaOI3u1acr30mCIPWSatVA==
X-Google-Smtp-Source: ABdhPJyWvGrFAmFTQtQvSt7+xDUJKD5ipTvLWMtC+Ys//PiElCOSDG2tbtBkSQGLkXZ6DUIbCk9Pvw==
X-Received: by 2002:a2e:9d93:: with SMTP id c19mr422781ljj.32.1602803182013;
        Thu, 15 Oct 2020 16:06:22 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 134sm157730lfd.101.2020.10.15.16.06.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 16:06:21 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id l2so628948lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 16:06:21 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr291703lfa.603.1602803180597;
 Thu, 15 Oct 2020 16:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
In-Reply-To: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Oct 2020 16:06:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
Message-ID: <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v5.10
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were rebased since the merge window started, for no apparent reason.

Were they in linux-next?

And if so, why was I sent some different version?

             Linus
