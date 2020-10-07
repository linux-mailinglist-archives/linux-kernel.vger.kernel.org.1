Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36802863F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgJGQ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJGQ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:29:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD94C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 09:29:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q123so1631816pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CL4gnXJZmN9XDhtrufCMRd3kmkft5QuOZ0sUz4xoWP0=;
        b=tgw1uGYANjaQLWaqrvksQyx8zwxtOSBbGeXzYe1vovHG66jstCDGjxE5cDODCwfz3a
         LZs5gAuSQvPwIOra31ABAByC2YNCAQGDrkXS5qzSepvm8LLQfMKZfKj2bQLOfayJD+uV
         gpakVThVnyT9qdU27UgObIkIrRauHWB2Mv00+HGX2hC1uMI4y+66mjIZCTSvN9OG17iI
         yJUBxOxSivkAVsyC1tnHZGVG63W1NsoQa46H9qVIR51s2M8HQoroomH+xV1/iB9Mwyk+
         PdEwzpZpHAvYWEJ3YzXtLaax3rFF21fHePbippLGLnnMucovQeaUwCja+EsgKB5TjJeb
         84Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CL4gnXJZmN9XDhtrufCMRd3kmkft5QuOZ0sUz4xoWP0=;
        b=HhQkYdy4+iTz+XW4VocpMNqXau3YjiRcMEkQVlNIKiuf6wDKPj2OHcBPB/vNBNAZA0
         Os2V69YTsNYTfg2Y1jw4iFcXQkSgjDzx3ucSaJdc6LLC78Q/ey9fhclaCTFyjf7GHa1W
         lJRmPVW4O1evA409sgkzvRNzoYGT1aoB18/2BuIOjWns+EpNW/c0mClUahXh1XlvnbOP
         /cAIdGBAufOKPDbOSmy2T2tgUUEFBZAsQ7soXHdVSjpxV++NkGNXY5Txld3srhq8bnXX
         scKpn3toKizezV0kLtBL0crzidyEkL90z4g+XukG2HXUA8pUNnmhi4PgHTFzs+g50KMg
         Yv+w==
X-Gm-Message-State: AOAM531/od+QpSUJxJPCl5OXrywdwy3rczPmvgHwbacl++yc/JSNnrAn
        AGNLpD7vAtAavcIuIEdGAtmY+0NLriw=
X-Google-Smtp-Source: ABdhPJybl4x7DBfzosvVJaZlj0mVkfl95695bzOnG6D0jNm6aGPumqW32/rUDJ6QnQuuGs3NBFiImQ==
X-Received: by 2002:a63:c34b:: with SMTP id e11mr3815170pgd.25.1602088185816;
        Wed, 07 Oct 2020 09:29:45 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id x18sm3825885pfj.90.2020.10.07.09.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 09:29:44 -0700 (PDT)
Date:   Thu, 8 Oct 2020 01:29:42 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201007162942.GA440@jagdpanzerIV.localdomain>
References: <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
 <20201007072853.GF32369@alley>
 <20201007123044.GA509@jagdpanzerIV.localdomain>
 <be66237b-e7b2-0321-c00c-cd6fba6e3b58@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be66237b-e7b2-0321-c00c-cd6fba6e3b58@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/07 08:57), Guenter Roeck wrote:
> On 10/7/20 5:30 AM, Sergey Senozhatsky wrote:

[..]

> I can see to options: Link /dev/console to /dev/null if there is no console,
> or do something like
> 
> 	if (IS_ERR(file)) {
>                 pr_warn("Warning: unable to open an initial console.\n");
>                 file = filp_open("/dev/null", O_RDWR, 0);
> 		if (IS_ERR(file))
>                 	return;
>         }

As far as I can tell, /dev/null does not exist yet on this stage
(at least not in my system). But generally the idea looks interesting.

	-ss
