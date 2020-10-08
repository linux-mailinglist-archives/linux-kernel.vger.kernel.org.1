Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689AA2872E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgJHK4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgJHK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:56:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0588C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 03:56:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e10so3695608pfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bdMF3YnCMlBmzM2xXFBgcl6Aa3IU9TkHu2JS2ExdDRg=;
        b=IcMvvTDsaf7TA7DU8hsV3szGUT64Ncs+BMtr0J00B8ypb+2XTZZt2XqZZtOHucSMqT
         tXZpsA06UAnJUxVGUksWBW/uT0kVfUnP8h9KcygOkss54c5G861DCUqdzkTnpTgU7qf+
         xUzkMt0Ll/+kWtdKj6QNPzBiw+BFbcg82HhJ47SYyK3fnQBr9eySks1qyR9zX2lBf2Ei
         gME9m2DR+xVIyk25c06G/7yh65zgaIWZyrtq8zj3HfQUiVFIc51UeUnTOEsC2lWhi9/e
         r4UWK2+H7rcPZ33GUEA1cfewXfy6sl8yMg7wIWQWXnQZst30RYxUeKtxL0jhE+vfK6wL
         2mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bdMF3YnCMlBmzM2xXFBgcl6Aa3IU9TkHu2JS2ExdDRg=;
        b=UTmNSarZYZPKLoavzN1eFWFjbwYo6TsQ4io5rVaSBXKIAeyq8NWrzoanGHW0NgKmO8
         Llg07HCKNIXFPVLjY+WJddRMFLyKw98P2+amY8hAm+FgunKXXvSmkG49D6ojd8vLxqLw
         fMWrGnkpiLanOIE5RSFyo4G1E3Vk3afcjzO6Lm2yEV7Z7VdYLlomx8WPn7uBuibzzJv8
         LkLi3/ZZhsMblUOgjIyqR/DK2jF0jbIgwIeELFj4En+xsQh/KpPbUlhZMd6+bhslCQkz
         JOhcLWi/UiRgjz+IY5cPxAhhxtMZLGtQ4jkiL+wQdgXNMLaqfpnaZsbD4D3dBe+rf8rf
         KByQ==
X-Gm-Message-State: AOAM532ptImV1rQnb1YwZRv1yAMWMWByzXsPKmFEiZuqTN11I6TY6dD1
        1hui+wC0bX/ljqlvoLImQC8=
X-Google-Smtp-Source: ABdhPJwc23w160Cv3J+tXXQhfoHn7uC4aovAdruoQnoCdzOfyFQTXKCa0sKn3p9oGJ2vQyqtuOoZCg==
X-Received: by 2002:a17:90a:b293:: with SMTP id c19mr7675449pjr.122.1602154566345;
        Thu, 08 Oct 2020 03:56:06 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id g13sm6737907pfu.186.2020.10.08.03.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 03:56:05 -0700 (PDT)
Date:   Thu, 8 Oct 2020 19:56:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201008105603.GB554@jagdpanzerIV.localdomain>
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
> Interesting idea. Well, it looks like yet another mess:
> 
>   + it would show the consoles in /proc/consoles
>     even thought they will be basically unusable

Which is fine, no? We already can have disables consoles in
/proc/consoles.


$ cat /proc/consoles 
tty0                 -WU ( C p  )    4:1

So tty0 is not 'E'-enabled. I see no problems with that.

These are the flags that /proc/consoles handle

	con_flags[] = {
		{ CON_ENABLED,		'E' },
		{ CON_CONSDEV,		'C' },
		{ CON_BOOT,		'B' },
		{ CON_PRINTBUFFER,	'p' },
		{ CON_BRL,		'b' },
		{ CON_ANYTIME,		'a' },
	};

Why do you think that having disabled consoles in /proc/consoles
is a mess?

> IMHO, we should try to understand why it actually crashes first.
> It might help to solve the problem some cleaner way.

Well, I guess, we have files (either regular files or devices) sitting
in fd-s 0,1,2. God knows what mount/fsck/modprobe can fprintf(), for
instance, to stdout/stderr and what they can corrupt.

	-ss
