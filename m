Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF43274EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgIWCYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgIWCYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:24:01 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEDFC061755;
        Tue, 22 Sep 2020 19:24:01 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d15so20266761lfq.11;
        Tue, 22 Sep 2020 19:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9LU5w6fa7ONs9PekqKna6MHo9YAMzPnq1B9vrPjWys=;
        b=SvrXxeEMlXGicliLluSILIgHO9SLoNWVppaCYORjdLErxdUwjxcovuqTYm3Yqx6x9C
         D6jIcc06H6Jq3UWXTVNLxAy0HHnuf7S5xFQ3tty+Kh7zMSGKES+4dhmJYsJiDgjhBENp
         /kl93638rgxXhZj/Vqb1rv80gXOtgc5O3EgDWShOVxFyooLxLNapF2OvIcdIt0aY9Yvc
         S/cmot85pGZASwxj7cHEAAH2qJpyVriD36sgoKxLFCqHcnxcIJf29e36XkdZ3O73vBR/
         F7surslPsdRCJyvOx9HZLslJgkFPajvPbTu/W6g9JS7aigsgWgyybBkVvHwvEujKYVH9
         z0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9LU5w6fa7ONs9PekqKna6MHo9YAMzPnq1B9vrPjWys=;
        b=DfxCTRLgUMwe5iSBZ7qsyuQ8FAOv58cDHSBQJH8EjKtLLT1qM/Fd7tgVxDNpINX98W
         Af1Vna8d/zQZyUZ9qB8lz6KZqGFgrBeZP+Fd0ehxv7L6yPbCN2sq4lVLrw60qS7p0drH
         7JMB0LjlOFzkjxauBZtwIA31gy76OY8rH/qSQ+FdqC9wqzm7qjkSjeCDFnhHTgjXaCTA
         XCPGKO6D3HdqEgw/6Ik8cKuHzWrG6ozjOVSFN+ED/ogHwwTLVXYpPsl6ey7SFmzWC+Fo
         CIzZZBOlNztsz5nnf605w/vKvB0YdmXS09Z1CuBODRwZAw7FaC+kYd4dzbfvT4YsVNi4
         0cJQ==
X-Gm-Message-State: AOAM533h6cOQaQI7J/9TyMnF652k7CAn5KDXIuTi9vyNZU+nJnEOxymU
        DN43eh7BpbD0Anh/iCwGICNHCDPx6EdjrZ7xvto=
X-Google-Smtp-Source: ABdhPJz7p6U4Wlpmlx3gUrn4on99CoqmGgste+QNH2TQ6NTphWZAQpIJF9C165CsvFSyA5D7nQWhYPNqEFCAPIaKyek=
X-Received: by 2002:ac2:523a:: with SMTP id i26mr2556687lfl.577.1600827839659;
 Tue, 22 Sep 2020 19:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200922091505.471-1-zhenzhong.duan@gmail.com> <20200922162901.GA3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200922162901.GA3421308@ZenIV.linux.org.uk>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Wed, 23 Sep 2020 10:23:48 +0800
Message-ID: <CAFH1YnMci+OKpw82oVeqwNxH7CVcYDYYGFWZqDqroY5M1J7TeQ@mail.gmail.com>
Subject: Re: [PATCH] csky: Fix a size determination in gpr_get()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, oleg@redhat.com, guoren@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:29 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Sep 22, 2020 at 05:15:05PM +0800, Zhenzhong Duan wrote:
> > "*" is missed  in size determination as we are passing register set
> > rather than a pointer.
>
> Ack.  I can push it to Linus today, unless you want it to go through
> csky tree.  Preferences?

I prefer pushing to linus.

Regards
Zhenzhong
