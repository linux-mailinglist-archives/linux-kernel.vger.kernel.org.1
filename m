Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC352873CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgJHMFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:05:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F1CC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 05:05:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n9so4097454pgf.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Etf+vW4HmfaB4VG6dN4XAjgwjVTof2+FMxhPyxbqIoM=;
        b=j2jxTzW7MyBoY2yfrVH/62xdEj5wGHBaBOeiSGDIz1Km3yBkVdxPBsWoRVVhmGaeD+
         rsu19YVLi9LSSbyK3kTpiKylfkd+dMAZ8ux/1xH0rqi/IsyD8Q5AjNQrZEoo3Jb5fKsK
         zg772rCx0Tl52PHtNsw87WtpxLCKWbYd8hy/+0RlGo/HVvDcJyo4wiz9cCIoXISeB/7e
         7Aq/yuf68nJ40atlj+5wUMp4SYZtGfJ19evYg8w3jTK23TeYtF0U9t8X1Jv7DNx7Ejjl
         HAEuvCpwZyp9dehePEZG0hORClcyGqZVrC/2nUvwGaBREaYzI7OUcGiQlVZq/gCAei5B
         bPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Etf+vW4HmfaB4VG6dN4XAjgwjVTof2+FMxhPyxbqIoM=;
        b=QX5Lgtr+esT5UfF0oemZcWitpZeHI8zthWCeWUZLKFoLKEppRQsJLghC6yt0u8Wjip
         ajJmIDd1KwGMaze2OW3bessOe1fC172iZOjy0mK0yh/YhkOw3Vsg4J+ezEraGo6QHUu/
         RBGzHmIeJN/snt19ZlJnYcqRnSVawFHWmuRDJZfgcWa6hcvrW0Ozl99KuXg7ZFLKBC+0
         z0mXb3R2r+2IkEQeVCXwHyjwu+SejX0xbrztyVjIuvSO8dorBaVFlCY60g46z9aiYoCS
         8oqVne46NePj7VjHvkL7jcimUbgeU9DHCYa1nlftNHXYdk8fzIagpfJnwYTe9UQzXek/
         OL6w==
X-Gm-Message-State: AOAM532rNfrSfjfZ2aHDYdyE1CgprefVY10kvvpih7c1KjIndrI/hIK6
        NK9E0fLgfBrveIUOC6mN38Q=
X-Google-Smtp-Source: ABdhPJwev8L0Z9W/0vMCM7DnsstD+rRxxYujE8DoU4KKKJ797jm34vvWUAs2QMdLMpB9ju0sIWTNzg==
X-Received: by 2002:a17:90a:1bc3:: with SMTP id r3mr4579491pjr.196.1602158739555;
        Thu, 08 Oct 2020 05:05:39 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id i4sm15978348pjg.2.2020.10.08.05.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 05:05:38 -0700 (PDT)
Date:   Thu, 8 Oct 2020 21:05:35 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201008120535.GA127397@jagdpanzerIV.localdomain>
References: <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
 <20201007072853.GF32369@alley>
 <20201007123044.GA509@jagdpanzerIV.localdomain>
 <be66237b-e7b2-0321-c00c-cd6fba6e3b58@roeck-us.net>
 <20201007162942.GA440@jagdpanzerIV.localdomain>
 <20201008055238.GA554@jagdpanzerIV.localdomain>
 <20201008090155.GB16837@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008090155.GB16837@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/08 11:01), Petr Mladek wrote:
> 
>   + it is yet another way to affect the amount of messages
>     on console. We already have console_loglevel, ignore_loglevel.

True. Yes, there are "alternative" ways of doing this, but what we
have to face here is - console= has been used for a long time, and
it does, sometimes, bad things that can kill the system. And we,
probably, don't have that many options, we need to "fix" console=
and make it safe, while preserving the behaviour that people are
used to by now. console= is a buggy feature by now.

	-ss
