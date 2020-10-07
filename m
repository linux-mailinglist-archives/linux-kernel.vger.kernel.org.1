Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6592628615C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgJGOj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgJGOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:39:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C8C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 07:39:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o8so1109708pll.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+EF1hvnFVH9Hq6Z//J+jeVNVRniEBW1qaiGSI1L+4P0=;
        b=GJiO+FFTfa/EFKTn5NwG7WZlK3amhkS4D9wopsKEfnthCdIUuwIE5rF8vvrXXWgDXM
         14g6oYxItdBjKc35ICy3JySE7cOV5Mlukla5dmpZhCk3rAfmauFTzWOfFWdyF9sE0Z+f
         5zgMLrr05W5skeV4MGp+wngDHZn5gVtTIjb2zRvaVgn0uKQsZ5wX80BqR2j6tjYcNvZJ
         H6j/0VYC4s69CFMEyQ0mCoumx53n+BbAnmeUZKkW9Xm+M+Ef2u9ZJFe860RLZTWxzuGO
         zq/kf1m41jeYII9oeITvhZ8rj9VF+nVwLyANMA0WC+82lFHYKMqxXIJiyJj0yFg54t9a
         3N+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+EF1hvnFVH9Hq6Z//J+jeVNVRniEBW1qaiGSI1L+4P0=;
        b=mT2S8DE1pVq/12EfqZKpTpYE0uX7CiOQsvdId99CSwRoW0CRoYU8FCYU5PIt1eBp9f
         3rFQjSU/pAlUwR/mzr2oL7Lk5Bj2GMy7mux336+c10fhYchvBFha35Vr3u1uoYNFyAQy
         HmfPwFzyCc6HOZuNF7NOtX1u+b8v/FRdvrFm4iQ1Q1I8bWJqXDY8Yf5JID2F1ny/CC9E
         mtMOOF7VGERoFB/HJSVr+v+vtzTSmgfmwIMLLaYEHwzafLXUvKeGht1hwWAKt5kS7gik
         fkDHzPV9ij18v+9HOA2TK65M9Pa2a1m1D24EAUAwZguVrqHn4wQ5y5XFQ9qulojdfFFa
         OlHA==
X-Gm-Message-State: AOAM532t20nH1z1ZOu31tbsYNTKE5rULO3BYJoe20DF9lc8cguqoysYJ
        v2yZ/TFOu6tSYDp8xf7hE2pZ0ePWRyU=
X-Google-Smtp-Source: ABdhPJxUfB7FtlHyE6rUqBwmLStsxIKimpPNuUUwgBihfu6D5qajrkTqt8i+rvnalxXSYC0hnKaENg==
X-Received: by 2002:a17:90a:be0e:: with SMTP id a14mr3184977pjs.57.1602081565478;
        Wed, 07 Oct 2020 07:39:25 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id b10sm3391163pgm.64.2020.10.07.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:39:24 -0700 (PDT)
Date:   Wed, 7 Oct 2020 23:39:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201007143921.GA470@jagdpanzerIV.localdomain>
References: <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
 <20201007072853.GF32369@alley>
 <20201007123044.GA509@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007123044.GA509@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/07 21:30), Sergey Senozhatsky wrote:
> On (20/10/07 09:28), Petr Mladek wrote:
> > 
> > 		/*
> > 		 * Dirty hack to prevent using any console with tty
> > 		 * binding as a fallback and adding the empty
> > 		 * name into console_cmdline array.
> > 		 */
> > 		preferred_console = MAX_CMDLINECONSOLES;
[..]
> Hint: I can crash my laptop when I remove the "console=" boot param and
> comment out init_dup(file) calls in console_on_rootfs().

My guess is that since we don't have stdin/out/err fds then,
theoretically, something like this can happen

int main()
{
...
	int fd = open(.... );
	int fd = open(..., "vfat.ko");

	//fd is 1

	fprintf(stdout, "loading vfat\n");
...
}

stdout (fd 1) is not stdout, it's fd that we got from open(vfat.ko).

Does this make sense?

	-ss
