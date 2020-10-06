Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE2E284F7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJFQIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgJFQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:08:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8304FC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 09:08:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so9294963pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jJv8ne5lHMZ3SN8KNlNdOlkt6VCa4NI36SX+k70xRj4=;
        b=efanPX0XrluboO2J7/a2TNE/DU9Zv2ttXRPZSm7HAtoHz7qHmWSDKU7qfILDaTXlys
         IxkHSLf432ByvWsWg08M7l8fsWWuw6fYt/q/zlXYyKMbwwTCZ0fYCHesk0UlVpPobD0Y
         ySQq9x4TlYej6ld7T5CAPmeELHrPkMPHjkDnKyHZMSdOt4JLZh90KIxniC6Q9383AFjr
         8hK08JKUlwI+raJ51tmcNfCxdijhztzF5auVJ6KgSceX0y7dfjT/vGPILp6z4jUroywO
         1mwos+eVIxvmyjb86kWfDRFlBFbxiDx7oZ3a5Gf9x6xmAr6r3Hy+4RUnj7NYdPAinPzW
         NL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jJv8ne5lHMZ3SN8KNlNdOlkt6VCa4NI36SX+k70xRj4=;
        b=VX1g4MCR3ziGpM/8gLXT4KezxVES/FNc04rrrF3ZuaiQArHvT3YnVuKTutTPiinLLg
         agAZgyi9VdBfDS/aRVzHHhbjRqOZv7pFm0Drc1OSIAo6U32f5mKWpD7qkX1AfUj4VgQw
         AnkOYISFnIemQI8DMxgqWVazT7MzBxhyCmT1EbDhjMBw2y+dkni0I5DlhnCJ2QMB6BBX
         PCCxDjdar9bTk43m2M7XyAT1k4CSGLnbD4byRxNS/c/uljd+1R61A5LmOZU2ZcLYpky+
         +xyHT7fBCUOIAWBgxc3tCycG0Qi9njPRhLkhBBsfuEGpG6uqhJo4+dN7rM5X9sRQDM0b
         o62g==
X-Gm-Message-State: AOAM532+REGTjJamNA7L2MioN8FBUCB/Oysh2jAMzyO31D3Puqo9cqjG
        wdWuwLLqt677bnkHJfwfP7w=
X-Google-Smtp-Source: ABdhPJzLN0LZrMYcJJYTHn5razWiFuaYxrciZelOK82RyIn3pJkSSnFlPZ7GRfWgw2KSgxZsmEYX+Q==
X-Received: by 2002:a62:bd05:0:b029:142:2501:3a02 with SMTP id a5-20020a62bd050000b029014225013a02mr4911104pff.81.1602000504794;
        Tue, 06 Oct 2020 09:08:24 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id d8sm3410623pjr.46.2020.10.06.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:08:23 -0700 (PDT)
Date:   Wed, 7 Oct 2020 01:08:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201006160821.GA430@jagdpanzerIV.localdomain>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006065907.GA528@jagdpanzerIV.localdomain>
 <20201006095435.GC32369@alley>
 <20201006133319.GA178176@jagdpanzerIV.localdomain>
 <7d512002-e33c-198f-52df-a89a30bc665b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d512002-e33c-198f-52df-a89a30bc665b@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/06 07:22), Guenter Roeck wrote:
> On 10/6/20 6:33 AM, Sergey Senozhatsky wrote:
> > On (20/10/06 11:54), Petr Mladek wrote:
> >> On Tue 2020-10-06 15:59:07, Sergey Senozhatsky wrote:
> >>> On (20/10/05 20:35), Guenter Roeck wrote:
> >>>> On a side note, I don't see the problem presumably fixed with this
> >>>> patch in any of my tests.
> >>>
> >>> Hmm. This is rather interesting. Empty console= certainly oops-es my laptop,
> >>
> >> Just by chance. Do you have any log with the Oops? Or does it die
> >> silently?
> > 
> > The laptop in question has fbdev and no serial. It dies with blank screen.
> > I'll try to dig it and get some backtrace or anything useful.
> > 
> 
> Some versions of systemd (and possibly other distributions) apparently
> react allergic if no console is present. See [1]. Maybe that is what
> happens with your laptop ?

Seems to be crashing before /init

> That exchange leads to the question what should be done with /dev/console
> if there is no console. On Chromebooks we see an error when trying
> to open it if I recall correctly.

A wild guess:

Devices that you test, do they have 'blah blah  console=  blah blah'
command line? If so, does anything change if you revert the patch in
question and change kernel boot command line to 'blah blah console='?

	-ss
