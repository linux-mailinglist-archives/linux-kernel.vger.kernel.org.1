Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1938929600E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900144AbgJVNcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443424AbgJVNcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:32:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DA7C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:32:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v22so945778ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gnF1P3sA4Hd6GneuxlfbrmwcHsIi+cF2IGQfZ4BK0Cg=;
        b=GSwwHYXTNViLl47wUHv3Jt/BWD+3bdbyi3N2T+spIY6omvMAP98KM+Pj833+RyX3Sg
         NeABqGnEMht0y9cLy38uzI+zm8aD1wy2o+O8pTB2kbgRkpKJfQO4EixnlqrFC/W+x6X2
         xo5UccvZok/YPlYqfhDKVg9IwSbh4dXCLHjQ/ugVArdoEL0rj96VPiaerF7zCTO/ZVAf
         +dFJQfzpukqltGitPVaDZQQtL9+8DMVbq4XiRYTkKeNCbMdUbn20u7C+Iva6rVX7U0zD
         R6+fcKuvc2ACbECIP1qZVSbTQmkcUzzDdqoUtFKsBdzEIzmdKXyl5Axzcyyv6W2VTPc2
         vrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gnF1P3sA4Hd6GneuxlfbrmwcHsIi+cF2IGQfZ4BK0Cg=;
        b=nxDnm0T7QMM4SW45I8KNfaOwqYuoTY5dMVag5SD+ZXyf+m1KTxs8ToAEIhLW035bzS
         PpKjZWy9OYacsv/3W771zVHcCyFzLi5QLwOLw8pB9/axCK2oIflmpA8vLE9DvrX2GqAH
         hocz2AOJSPN6BiyuiEoqzw0H9mEmzbEqV7M1a/dYV+APOiqyOBCPBt59sW5nbcMK9xVp
         QNjAZKyeXNz2n6CET/KzZq625DdvvRUZR1HZCQ4x9G4NrU3pCf3sgZKQ5w6rflebUeCJ
         YDn+7lSyvtoOcsIvBGYFutIhP9WyjoF+6Jzl90v86Q4KW/R4bNF/BOTxKMjDFxw97BXU
         8nWQ==
X-Gm-Message-State: AOAM531OvEvXsGnA38pZ5uAeoZW1KuIT8VaHSPuviIVM7Qjl54/85Xxb
        ZlRCTeGL2luMHhkA+8ieGBc=
X-Google-Smtp-Source: ABdhPJw0UZ19K2AGYwQr5z8syawKUp/HbazlyzLpAtnxOPMyiKFvJHgbiGSeTSk0MoTrm7XKJ4GrTg==
X-Received: by 2002:a17:90b:1c0d:: with SMTP id oc13mr2511335pjb.192.1603373551847;
        Thu, 22 Oct 2020 06:32:31 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id k9sm2491028pgt.72.2020.10.22.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 06:32:30 -0700 (PDT)
Date:   Thu, 22 Oct 2020 22:32:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201022133228.GA160085@jagdpanzerIV.localdomain>
References: <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
 <20201007072853.GF32369@alley>
 <20201007123044.GA509@jagdpanzerIV.localdomain>
 <be66237b-e7b2-0321-c00c-cd6fba6e3b58@roeck-us.net>
 <20201007162942.GA440@jagdpanzerIV.localdomain>
 <20201008055238.GA554@jagdpanzerIV.localdomain>
 <20201022113805.GA32486@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022113805.GA32486@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/22 13:38), Petr Mladek wrote:
> > Hmm. How about this. console= is undocumented and unspecified - it
> > may work sometimes or it may kill the system (and theoretically even
> > corrupt some files, depending on what fd 1 and fd 2 point to). So
> > maybe we can document console= and handle it in printk, rather than
> > somewhere deep in init/main.c
> 
> I have dig more into it. If I get it correctly, /dev/console is really
> used as stdin, stdout, and stderr for the init process. It has been
> like this from the very beginning.
> 
> In theory, it might be possible to fallback into /dev/null. But it
> would not solve the problem when anyone tries to use /dev/console
> later.
> 
> IMHO, creating /dev/console really _should not_ fail. It means
> that we should register some console.

Yes, I didn't find out exactly why the kernel panics yet. Got
interrupted. What I did notice (when we don't have stdin/out/err)
was init process installing "/" as fd 0, and then doing things
like fprintf(stderr, "running early hook"), perhaps some of those
fprintf()-s end up in the wrong place.

> > IOW add one more flag (yeah, I know) and set it when console_setup()
> > sees console= boot param. The idea is allow console registration,
> > but all consoles should be disabled (cleared CON_ENABLED bit). This
> > would be easier to document, at least.
> 
> It seems that introducing a new option/flag is the best solution
> after all. All other flags are manipulated on different situations
> and it would not be easy to define a sane behavior.
> 
> I like the proposed "mute_consoles". Well, I have it associated rather
> with CONSOLE_LOGLEVEL_SILENT than with disabled console.
> 
> I have played with it and am going to send two patches as RFC.

Cool, thanks. I'll reply to that RFC patch set; there are some
more ideas, that we can discuss.

	-ss
