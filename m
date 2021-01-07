Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3D2ED41E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbhAGQOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbhAGQOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:14:50 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5FBC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 08:14:10 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 15so7908434oix.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 08:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Anp6fcD6yAwLyjbGGE1+Diuy4cW35CxE+VM2oZ10UHY=;
        b=AvMUaduH2Idk3BBoeDhZTpBAtUgjcnH7c7uOHsVrrwqAkN4oSx7ksHkHJQxLhISU9h
         w3oKnIIldfo7afa/Le8HH70sXF1bi8ro8y7BAP0cPuZ16QRNdU8KcQ/0PdokZ9hiyAij
         nDPUjeA1u+me8BOdee5+GvpiO1Zb65u1NghZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Anp6fcD6yAwLyjbGGE1+Diuy4cW35CxE+VM2oZ10UHY=;
        b=Sez7NyM/INc71oQV2d5HWLWWgbuB1FnNEsouDWCuxjMkhULPJuJosQJYt/B8Bb6w8x
         QP/nt1upCGFm0LT/sIosgzdbxQMGnUGl8tIOCwEDN/wlNpo9MCaVEe6wlRRDpv/Q+ZYd
         twSDLOLue/zLf3rcz9+wtBjvNlN0LilvVcJkkCRvM5CJyE9Ap3EmfOejpKfKP/KXaJFH
         AEtxEBwSChx8XOXeBZkKpREjcGqdXMsSqpIflgSWa8mwTrlThcJ3EEtatZ8D6kq1Cdld
         GqKJ3SnRDth3EaI8xkhtgZY3w4BGxy8frvNyKOi8h+qWjTng0Se/E3M1NxY+mL4rE8oj
         6XDw==
X-Gm-Message-State: AOAM533ohPi2RbvXhOFL7nNvYJOyVF7Spgf5Zi9jJdatfbYXiTldxacM
        cTk1Kxp71kgy9Vq0ByupyZGLadvfFSYQZuWP7XzhvQ==
X-Google-Smtp-Source: ABdhPJwcVUwVzvYEz3CXLrS619Fb79kw4VOjMd1SMRiITD1QN38C8IKP0LsZNPcOdch3JRiUfQZmyTEjNsuTTD0Nu3U=
X-Received: by 2002:aca:4e11:: with SMTP id c17mr6758170oib.14.1610036049307;
 Thu, 07 Jan 2021 08:14:09 -0800 (PST)
MIME-Version: 1.0
References: <20210107154801.1997-1-huijiexu295@gmail.com>
In-Reply-To: <20210107154801.1997-1-huijiexu295@gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 7 Jan 2021 17:13:58 +0100
Message-ID: <CAKMK7uHQqNjk=1Wv0Mgh+SCTc78wRnRfjS1qQHOb7WE36+_rdA@mail.gmail.com>
Subject: Re: [Patch] fbcon: i want fbcon soft scrollback feature come back
To:     xuhuijie <huijiexu295@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        George Kennedy <george.kennedy@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 4:48 PM xuhuijie <huijiexu295@gmail.com> wrote:
> This commit 50145474f6ef(fbcon: remove soft scrollback code) remove soft scrollback in
> fbcon. So the shift+PageDown and shift+PageUp is missing. But PageUp is a vary important
> feature when system panic or reset. I can get log by PageUp before, but now there is no
> way to get. Especially on the server system, we always use bmc to control computer.
> So I hope the community can add this feature back.

Adding Linus.

Short summary: Not going to happen without significant effort:

https://lore.kernel.org/stable/CAKMK7uEy-b_nPmoh9WYA4NCsK8AL_Jk+-+FRZsrk6NOqqrvriA@mail.gmail.com/

Cheers, Daniel




--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
