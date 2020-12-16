Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D22DB9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgLPDdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgLPDdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:33:35 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26842C061793
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 19:32:55 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x15so21327346ilq.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 19:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzUvpf/Z4+FDnMTNimcxjYoQv25zdWhrv/P0OheMKxk=;
        b=CjzbLgtmPDr4yrhKahPogRQ2Q5No07mGF4SeIOt8wvvBduTyqAPlF/rkCx+9KkRHby
         VANTYgnjWpcc6L0mcI+AlaekGllzEblFqTrJpURu7Vm5ubJngkHN5S/bsasX5Rz9ILvQ
         IfHDxdwoZB54Cwa9C/YSGsz2faDj2fAWHUkUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzUvpf/Z4+FDnMTNimcxjYoQv25zdWhrv/P0OheMKxk=;
        b=JKGFQfJZe2bS+8L7vqD+jHSu2ewCv0rofr+iM6yLzOBgEv9K/bnfdP9VAdAyhH8OP2
         gm+mpC5qNbaJoLytlvYapf0k1F8MSno50yZkDVJhutFJQfmQRmwT8MIMjsNxW9c7sjt0
         /Zef3fMb74PPfuSlySNICZDOo1LG0rOpL9+kctWQMT2nbidema5SEBBv/mnUlyqP4ut7
         qvlI8JYgsBwydxESIBi2tC2QbgF2+mLzpvwNVOfUS/X6jzRFtwcL7voRbAP0K6LyWFFA
         WMiE872iWR5DXnN5Gbgjc0CqQQ8dsiK1lVWV05kR0NkotmoVTbYOWcOYMG6ck8YPhm3n
         FZyQ==
X-Gm-Message-State: AOAM530TiJGR1A+10DimSaSWdv00Wxw2WbyijJHdGm1a5NE2DyAMk3Wx
        loNX58vBBsjs1cuFOtVR+98xXjqV/s13Og==
X-Google-Smtp-Source: ABdhPJzfYEHheHkjfAQtNHbiOA/FcFCPkYXvxTmEOtzN1uPLj7RhxQn7YwQKeRQyFrqPdxyW78JXug==
X-Received: by 2002:a92:6b05:: with SMTP id g5mr42628511ilc.289.1608089574500;
        Tue, 15 Dec 2020 19:32:54 -0800 (PST)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id c15sm286250ils.87.2020.12.15.19.32.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 19:32:53 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id n4so22651199iow.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 19:32:53 -0800 (PST)
X-Received: by 2002:a02:9107:: with SMTP id a7mr15972769jag.12.1608089573545;
 Tue, 15 Dec 2020 19:32:53 -0800 (PST)
MIME-Version: 1.0
References: <871rfqad5g.fsf@x220.int.ebiederm.org>
In-Reply-To: <871rfqad5g.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 19:32:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijn40PoFccpQZExuyWnz2i+wmBx+9gw5nKJPVQVmzb5g@mail.gmail.com>
Message-ID: <CAHk-=wijn40PoFccpQZExuyWnz2i+wmBx+9gw5nKJPVQVmzb5g@mail.gmail.com>
Subject: Re: [GIT PULL] exec fixes for v5.11-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 3:00 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> There is a minor conflict with parallel changes to the bpf task_iter
> code.  The changes don't fundamentally conflict but both are removing
> code from same areas of the same function.

Ok, that was somewhat confusing.

I think I got it right, but I'd appreciate you giving my resolution a
second look. Just to be safe.

              Linus
