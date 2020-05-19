Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884131DA0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 21:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgESTSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 15:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:18:37 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F6AC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:18:36 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e2so229315eje.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwDvf5G6HSaQ20Oxj0p6X54Wu/x0ouoEho2X1JQouNk=;
        b=aL74m/akDHaUWo5DAGjBl2jfoa794VKfiSki1M36FYTwo9YSo59CMBv/99InzLpL/G
         +7bB/+sII5PnN82+4x8MI41VhKSZRJhRKIyl/uZjJXfGPM6l4GX1/QJlMHeYVcsSpXFl
         wiuYrMgqIe5WbM6vXOjKN+fQ7jY/sLkvgVzU6w7BZO+qrL+9RS5hQ4oPfUUjw/jBJiWT
         lgKeV6RdJcYPdZ1ikTnTr1qiSAXLJsrWc0aSIGhxLYqdbKPeNy74eMNqRrcxX539grw1
         vi3Z5ac6eRp6dL45/+2koWyZBj74tbhta40NiTnV4/SUaSRQ02x4RWgnFS6TjaTj8ffw
         u2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwDvf5G6HSaQ20Oxj0p6X54Wu/x0ouoEho2X1JQouNk=;
        b=A7VCL29K5nCvkT4fm6yMjY58EASaZ01lqAhICGhNgckBLiye0Dr3gUvgKJtcdlr+nI
         teusS6kN5SNLoOX8If1nXNrzjsDNrvXCAuuzMmyrhrQOJFuD10bKE7dbA8bu5MCuZKCH
         GGXL8tHx6m2to7XIF5awKBPApTGbnFEXH3xaHTHhBYOecbR/gIsPRHljCwosfHrFL/QK
         /npCvZRI5QkujO0TcwIYmQcxfy9MghPwz85mNCtJEEtHtOKBAyBhTYK3QGD7abPv65ex
         BUnup+MI6ds4J5qbqQoKAQhHWsEY7dEGiXqY6BJp61fglX6zmqtegTswO7FCxfuCAaj0
         0seg==
X-Gm-Message-State: AOAM530K763+QBhpA+MsyQWXqrwO1R/q0uGLgAkzpHKN4TpIEcmvEG8/
        qMbPitnN0XJnqvbDyCL9NXJ4wXUIqBQ/ubzOV7+4ryo=
X-Google-Smtp-Source: ABdhPJwIXuucs0DGivH6PwCdg07KxPMElgAI2ADtY9VUQAv/qt4fe3j2mqb2tBpIQWZ5V2ksbjrenTScUT/dJ6h48BY=
X-Received: by 2002:a17:907:40f1:: with SMTP id no1mr689589ejb.178.1589915914530;
 Tue, 19 May 2020 12:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <2794b22c0b88637a4270b346e52aeb8db7f59457.1589853445.git.rgb@redhat.com>
In-Reply-To: <2794b22c0b88637a4270b346e52aeb8db7f59457.1589853445.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 May 2020 15:18:23 -0400
Message-ID: <CAHC9VhQYUooJbZ9tcOOwb=48LTjtnfo0g11vQuyLzoxdetaxnw@mail.gmail.com>
Subject: Re: [PATCH ghak25 v5] audit: add subj creds to NETFILTER_CFG record
 to cover async unregister
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, sgrubb@redhat.com,
        Ondrej Mosnacek <omosnace@redhat.com>, fw@strlen.de,
        twoerner@redhat.com, Eric Paris <eparis@parisplace.org>,
        tgraf@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:31 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Some table unregister actions seem to be initiated by the kernel to
> garbage collect unused tables that are not initiated by any userspace
> actions.  It was found to be necessary to add the subject credentials to
> cover this case to reveal the source of these actions.  A sample record:
>
> The tty, ses and exe fields have not been included since they are in the
> SYSCALL record and contain nothing useful in the non-user context.
>
>   type=NETFILTER_CFG msg=audit(2020-03-11 21:25:21.491:269) : table=nat family=bridge entries=0 op=unregister pid=153 uid=root auid=unset subj=system_u:system_r:kernel_t:s0 comm=kworker/u4:2

Based on where things were left in the discussion on the previous
draft, I think it would be good if you could explain a bit why the uid
and auid fields are useful here.

-- 
paul moore
www.paul-moore.com
