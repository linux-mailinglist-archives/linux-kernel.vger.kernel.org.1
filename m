Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6527F189
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgI3SpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3SpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:45:22 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8075DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:45:20 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id e5so584191vkm.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGzLtpbRpyaKc9iOQICUykGsO9umWBAinEJFBiGHtng=;
        b=dJWhnJzXxyoPQfBVXBIJ6EVktE1NPNjYtegiVBmX4eTfTGsrPOjp5EyLKMMmwl+XYz
         qCk7f27p1Y3t5oTP3QfoCu9E4CVXj1U0WvHKmU3L3AFbOX8s+yKHzILQu/C7dRI9GsW5
         riM9Yhn5kFjDJRXBflBP/Gap/RA2diJTzgevM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGzLtpbRpyaKc9iOQICUykGsO9umWBAinEJFBiGHtng=;
        b=fIUIZImh61OwSHoTOEXvu0O3ZvQiZSacM/FB4B3324wq25Kr9ni1EGLKiW9WFkvsP/
         /qEuMSv6JFsPLHeOeIAJt/uRBTCAEAUkExoJeVZZER4Kg6QI1xfwGLmFlDrx2eOH3e3b
         yX/pNogAND+Ypl6Gx0YRi4qE7Jb9zEtRHuCUmh4LuOQ8TM6tOajzabiPo8yt36kaRCWH
         RW4ySdNEvNh9a8qli5VR3d0QhaGojM3TgsmaXbW5xPBv2Olv1Hdcaa+NOijwgNMtMrYs
         6AWH1XndTX/pjokAL8el11FM79bfQfoTk3zAKI1apFjjzpF/ghz/M4C3nCb4ohvezAa7
         FUIA==
X-Gm-Message-State: AOAM533EnphlC2xg2o/2gBxNVWlbNNhCaPNH6Oye0c1ZfMKijOarrRDP
        AXM8l5/Rxk3F8fFVxvK0VnurKK1rcwnl8WrMVJllUw==
X-Google-Smtp-Source: ABdhPJx4T7kOH+8bLfRu9O7gr7DxvvWi/8nfIaGCxMLRUEsx6s1rZzg4WbdXu1inmEObaBZd5SAPkEXfL95gJGKuOiM=
X-Received: by 2002:a05:6122:45e:: with SMTP id f30mr2504191vkk.15.1601491519617;
 Wed, 30 Sep 2020 11:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200924131318.2654747-1-balsini@android.com> <20200924131318.2654747-3-balsini@android.com>
In-Reply-To: <20200924131318.2654747-3-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Sep 2020 20:45:08 +0200
Message-ID: <CAJfpegvvf4MfO4Jw5A=TJJfrxN_1xFTmwBJ2bb9UfzYBgkhzzQ@mail.gmail.com>
Subject: Re: [PATCH V9 2/4] fuse: Trace daemon creds
To:     Alessio Balsini <balsini@android.com>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:
>
> Add a reference to the FUSE daemon credentials, so that they can be used to
> temporarily raise the user credentials when accessing lower file system
> files in passthrough.

Hmm, I think it would be better to store the creds of the ioctl()
caller together with the open file.   The mounter may deliberately
have different privileges from the process doing the actual I/O.

Thanks,
Miklos
