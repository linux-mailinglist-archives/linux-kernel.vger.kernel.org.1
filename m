Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A122F81AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbhAORJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbhAORJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:09:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B0AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:02 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g1so9665231edu.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mp/1fyTsDJMlSI/FaHpM+seifJxobeX1FXsOzUnBmcI=;
        b=ITYChPW6Iqu2xwN496o9wWRHJMqAJ/jy+JZh1RM2OXrANASCpYcdnEIHDPqQJiHbab
         UpnQTdQhDEnIncF7jACA4iJzAEZiZa4HC6qrntxTmwKOw3zGTXnDuPuIp68oJMzJ86Iy
         QSHHvbv/5WrjMFuLjlJAqAH6q3N9Qro19YFwfoJV9Tx+j5LaXKRhpaixZahOuCJ+Vf6c
         dH1ySgpAAOhW0KYOLxB/MPiPUF0oLqJH0uiH5qoLoYVNuYkZuVyfz9TNmn7QKOQ/XHN8
         uKUWxBnNOWQDRjAbg7EIsU7mmvOVCwlwCIuTyjHMVWjvF0XDYOepGntkXnqxZpRUreJ5
         U51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mp/1fyTsDJMlSI/FaHpM+seifJxobeX1FXsOzUnBmcI=;
        b=PWdc2lLcdnPJ/M7CIyy/HjJehO9vRF40Y/E8sZPoO5k474S9yW48QkrKzRIuypznxK
         qlhTZSMdeEG1GIlsrGosSILaq9RxUCi8lhi4LfH443+lsmfYu5NugQNW1G8qJXMQ3kzI
         1W/ZS1PZa5A/8P+yXUqEh4yzpIHBP448d88CIbZtOYBxRh7kUDNCwZWyp65GUhCB9y8Q
         +eW/Z5qKl9C6j1mCcrlvSh2i1/KrFCF8eIbDnfqKG0ahLuUY/MxkgzGKlZ8x1EnK0T6a
         /quBQldmfYomMiZMin0DBxZVRoYljG65NY5vobSYHav/9PV3C6xhN9lWBvgJznS6cj46
         N+NA==
X-Gm-Message-State: AOAM531ZFdClW01zZQyXNYW+e6MuFsZXMQrjLabxW7K9bAnNguJoYdfF
        Rp1cHSpuwvQHb0Od/7yXWN3XBFklNSlL4YJ99E126VCBQg==
X-Google-Smtp-Source: ABdhPJyoO1QL3M4wvByKi/WWaordDVC5YXmtAdQJ4dm59pDZUzHXtm5vzSEfdB+GhAg2P04d1T8MPpgnaxA3SZUr6x4=
X-Received: by 2002:a05:6402:1bcd:: with SMTP id ch13mr9067292edb.31.1610730540970;
 Fri, 15 Jan 2021 09:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20210115001201.116832-1-dave@stgolabs.net>
In-Reply-To: <20210115001201.116832-1-dave@stgolabs.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Jan 2021 12:08:50 -0500
Message-ID: <CAHC9VhS=f93bcHQMtrpvEM=aqyKFf8gjRGpM6QkOO4r2gEpuCw@mail.gmail.com>
Subject: Re: [PATCH] audit: Remove leftover reference to the audit_tasklet
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 7:12 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> This was replaced with a kauditd_wait kthread long ago,
> back in:
>
>      b7d1125817c (AUDIT: Send netlink messages from a separate kernel thread)
>
> Update the stale comment.
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nice catch.  Merged into audit/next, thanks!

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 1ffc2e059027..8fd735190c12 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2365,7 +2365,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>   *
>   * We can not do a netlink send inside an irq context because it blocks (last
>   * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
> - * queue and a tasklet is scheduled to remove them from the queue outside the
> + * queue and a kthread is scheduled to remove them from the queue outside the
>   * irq context.  May be called in any context.
>   */
>  void audit_log_end(struct audit_buffer *ab)
> --
> 2.26.2

-- 
paul moore
www.paul-moore.com
