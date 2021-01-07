Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ED22EE843
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbhAGWSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbhAGWSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:18:22 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174F8C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 14:17:42 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id f16so2781224uav.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zukoG2VXJaNRfxhzLYk106FjkbVbP7JOan5CINR4Tf8=;
        b=ddEW+bDtgL7Rl9tMgvT0mCAtOuvS7fZLjlKQKvMdZG9293lQ3FR2CRSRPIdUCVyBC7
         yZqP3L5DQKvONGNnrD2ipB7pz/q9ocg43Fb+jmF84+bSNpQGdnkUdeNDabSdVw9g6b6E
         wCRIuBS57NHzquv37U5k0a6DA86TVvVGl3nRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zukoG2VXJaNRfxhzLYk106FjkbVbP7JOan5CINR4Tf8=;
        b=ZbUXhsQ999YIdFRhJNAnPwtr0JmBcDeQ4sIfhBeEgXXGpDN5+yYsNF5JqMGVBAt9tv
         qLq7yggZbwQAEGJYAX9eSj7EUycJWWNANIbWe97qsmGxTVLFZioBLN57aGIVjGE8GbpT
         FnAyyr7eY2zCJH0jSMfyMsAc/0qswlE3T0T33Hy3Ohms4GMLK5CA/yxdiZtkDAn0RZdV
         1e1KdPj3alot9plpAi/2I9SmTBpDyjg7kL7thuP7NAJNZcIr2ttaJm4gVBdDusRdzkLY
         0c9+HMREztXHqG7v2pf3wjaHKTTMDx4wUKDIsOdFt+IEObNF25xDvXeCP/+eKUV8gk3o
         E39w==
X-Gm-Message-State: AOAM531FCSGMpOlKZXWNpI1ifEKIeaUf0fiv/m4je/ccTBwt1AuNKa4F
        gTu+mJRcNZfAmQ6EgKvcmJbaXBjiDGeIug==
X-Google-Smtp-Source: ABdhPJxfwPcAabbBq5cIr5xkFhf/K3Wrbbw63ne/oyZ35WRIFP+CVYakpCpkQVju8mLy8CLckAbcHQ==
X-Received: by 2002:ab0:53dd:: with SMTP id l29mr838762uaa.81.1610057860682;
        Thu, 07 Jan 2021 14:17:40 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id w15sm1027909uam.6.2021.01.07.14.17.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 14:17:39 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id h18so4438425vsg.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:17:39 -0800 (PST)
X-Received: by 2002:a67:bd01:: with SMTP id y1mr504210vsq.49.1610057858833;
 Thu, 07 Jan 2021 14:17:38 -0800 (PST)
MIME-Version: 1.0
References: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
In-Reply-To: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Jan 2021 14:17:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WJzNEf+=H2_Eyz3HRnv+0hW5swikg=hFMkHxGb569Bpw@mail.gmail.com>
Message-ID: <CAD=FV=WJzNEf+=H2_Eyz3HRnv+0hW5swikg=hFMkHxGb569Bpw@mail.gmail.com>
Subject: Re: [PATCH] fs: process fput task_work with TWA_SIGNAL
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 5, 2021 at 10:30 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Song reported a boot regression in a kvm image with 5.11-rc, and bisected
> it down to the below patch. Debugging this issue, turns out that the boot
> stalled when a task is waiting on a pipe being released. As we no longer
> run task_work from get_signal() unless it's queued with TWA_SIGNAL, the
> task goes idle without running the task_work. This prevents ->release()
> from being called on the pipe, which another boot task is waiting on.
>
> Use TWA_SIGNAL for the file fput work to ensure it's run before the task
> goes idle.
>
> Fixes: 98b89b649fce ("signal: kill JOBCTL_TASK_WORK")
> Reported-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

I just spend a bit of time bisecting and landed on commit 98b89b649fce
("signal: kill JOBCTL_TASK_WORK") causing my failure to bootup
mainline.  Your patch fixes my problem.  I haven't done any analysis
of the code--just testing, thus:

Tested-by: Douglas Anderson <dianders@chromium.org>
