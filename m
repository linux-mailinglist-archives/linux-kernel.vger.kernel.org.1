Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAA5278CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgIYPfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYPfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:35:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B7C0613CE;
        Fri, 25 Sep 2020 08:35:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x16so2110316pgj.3;
        Fri, 25 Sep 2020 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H/9+qYXF9GN9bRK/C5H5FmZN11jhXx2ehr1k98ass28=;
        b=bQGnqsi9trU4rchmHNT+IDgA2k6+MHytIahgg3FdvAvXLkOqo3HSiPipNaPY6tzrU0
         saZMEvvp18hb5cctMiXbAwwdqEtAcLz7sPvZhAyVhlZpBF4LYs/hKpLIA5BlM5T20YeV
         tPTDEoH1GxEm2CV8U0/mJ2mOBJ9L7PUKyJbQqCPOnpyX8ohd15TlgMC+DsiZGV26XGE+
         2z1CA7TU+0K7gKWYNUiZQKGUlLyMebr9WRQx81Q6djTGlGxLXvfJaDgaOcnN1p4Ru3Hc
         IRA49OvXD0yIN8n62rf0CT17tM4MRnhc4nUc9FKLj1sZrJjcK+wxUdsUOgzFdSL/g+p4
         fzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H/9+qYXF9GN9bRK/C5H5FmZN11jhXx2ehr1k98ass28=;
        b=SHIVpHzOYLnbYvNc/Y/rhGHcxdmPJ52KM7Gss0amO2fRARLO0eGVIjShinIzBfmnLo
         LKU0IefsUmtsyXM80wKUuxtNcjW4c9fTKntZrHjGrUI+mQf3DoNAW3JZmSvNmelwmyj4
         iemIlve27H10HdY7DGz6FBYQ7XVB9iH0w+CVmKqwpbfzyOGB8QFo7wiFH70iWugLtx/H
         9yYUm2GWV9T1W0RFDxrvDeS6I06Yl9TIAIboHyklRX/62rKSNqmpmhVa1epTzLKKDjhj
         b8FErzvEc4R0HyXgfdyO1C6JbLV6/6B7cGs/7Ovqo9X4n56Mkc5Jc5B+WkUtDYn8vVs9
         QYXQ==
X-Gm-Message-State: AOAM533y5mREOHNm7GNEwXZHUjXvnIhpQCX+QNXqYvyTbYDfmC0IR54t
        SeL7V+1BrM63+U557q+s8g==
X-Google-Smtp-Source: ABdhPJypCGDd/spbzL267gES6OYRMPR4S4hEJjiFO5vQCn8uHug/BJxwZZg36Chf8IEvIzbCNPLsJw==
X-Received: by 2002:a62:7c43:0:b029:139:858b:8033 with SMTP id x64-20020a627c430000b0290139858b8033mr4515529pfc.3.1601048117493;
        Fri, 25 Sep 2020 08:35:17 -0700 (PDT)
Received: from PWN (n11212042027.netvigator.com. [112.120.42.27])
        by smtp.gmail.com with ESMTPSA id 123sm2680229pgd.83.2020.09.25.08.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 08:35:16 -0700 (PDT)
Date:   Fri, 25 Sep 2020 11:35:09 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data
 buffers
Message-ID: <20200925153509.GA895804@PWN>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925132551.GF438822@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 03:25:51PM +0200, Daniel Vetter wrote:
> I think the only way to make this work is that we have one place which
> takes in the userspace uapi struct, and then converts it once into a
> kernel_console_font. With all the error checking.

Ah, I didn't think of that! When trying to introduce
`kernel_console_font` I ended up using the uapi version and the kernel
version in parallel...

> Then all internal code deals in terms of kernel_console_font, with
> properly typed and named struct members and helper functions and
> everything. And we might need a gradual conversion for this, so that first
> we can convert over invidual console drivers, then subsystems, until at
> the end we've pushed the conversion from uapi array to kernel_console_font
> all the way to the ioctl entry points.
> 
> But that's indeed a huge pile of work, and fair warning: fbcon is
> semi-orphaned, so by doing this you'll pretty much volunteer for
> maintainership :-)
>
> But I'd be very happy to help get this done and throw some maintainership
> credentials at you in the proces ...

Sounds exciting, I will be glad to do this! I'm just a beginner, but I
will try to do what I can do.

Thank you,
Peilin Ye

