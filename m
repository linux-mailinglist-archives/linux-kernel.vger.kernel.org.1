Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550FE2DDAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgLQV2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgLQV2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:28:48 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8926DC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:28:07 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x20so5824lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SSIVpe7jm3PpvfvuYlK4lk4ab/L4ijmkXEeEUB0a0Fg=;
        b=UoCWImIdpfhQRjsXwp+xbm74AwS0IOdcLdhH3MC6+tEzq9GrZT3lKQE4T9c1bN8Mk3
         2w+uQFsfwV2jOrgDGDh7uteiAvFsZ+AZ+tWjt5KD3SRTFnaipLFe0MjA5JWi8GaKidxj
         sFgo2ttqOS9avGMnlFJyeanDeZLtvLoby2XHZqIhLQxkkCaxQYTpfW3WytQ8p+2+02sQ
         vZ28EdmgDC8lfu6170fIyI6yvSZiVMYNN23HPu1xVnMYkYVa37Pzslikax8l+xfnT3O2
         SGWMiM6YIUTTsPywygrfWtAb5e33c/fVz/Z4wnu14SGu5F5HbdaNbSeCK5x0bq6ihfEr
         SXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SSIVpe7jm3PpvfvuYlK4lk4ab/L4ijmkXEeEUB0a0Fg=;
        b=HGNTQlIT/Nny44NFjxUKlDXmda8o5z4RZTFO7Zq+I8/I3Gb5EzxmSDBJC/w4IC+JTy
         92Agg0eTvT5Jllv1n5Db51dyxVNNOBcFKJ9LLkCsauqx5IjBYmjTf5dHf40zuvjsu6HK
         G2l1JyM/FSChdrF6snVd+J1GF9wTu8KI6GGAhs5Qr6jEoLM4QezpoZa8WlAWcUhv6cav
         SCfGt6htD5EXEgIR16S+ZcNEl/0/C5Gg3FQDcvuNbb+Zj3OphQfz5/SRjL6FADmWuqjB
         FqODDQuCXR0TbzDb3Yl1u2IjzWzH2YCjgy7CThdGlkbnllZDa34RjBzjXkvnzuBNsUco
         DAbQ==
X-Gm-Message-State: AOAM531E6Is9tJLLQXcUSsuQTo7Fsy/OijcKn7UHSlnDJbeiXR+BGHVl
        p7Py0T3gS5bsc7mz4dHEhok=
X-Google-Smtp-Source: ABdhPJyTRHP5YK+nJ4MdLwOvBt3GnK9fuUe0ed7bMnTuDLPaPAh4GVOz5l6TpyKFFKbQaEyEj0CneA==
X-Received: by 2002:a2e:9410:: with SMTP id i16mr507980ljh.183.1608240486031;
        Thu, 17 Dec 2020 13:28:06 -0800 (PST)
Received: from grain.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id v23sm794825ljd.78.2020.12.17.13.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 13:28:04 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id E9BDB1A020F; Fri, 18 Dec 2020 00:28:03 +0300 (MSK)
Date:   Fri, 18 Dec 2020 00:28:03 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mkoutny@suse.com,
        ktkhai@virtuozzo.com, Andrey Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, CriuML <criu@openvz.org>
Subject: Re: brk checks in PR_SET_MM code
Message-ID: <20201217212803.GE14556@grain>
References: <CABV8kRwoHAAdez8k60O+AJ9E3g5_PM0F6tpbpB9dC115_FD3Eg@mail.gmail.com>
 <20201217074202.GD14556@grain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217074202.GD14556@grain>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 10:42:02AM +0300, Cyrill Gorcunov wrote:
> On Wed, Dec 16, 2020 at 08:29:30PM -0500, Keno Fischer wrote:
> > Hi all,
> > 
> > The code in prctl(PR_SET_MM, ...) performs a number of sanity checks,
> > among them
> > 
> > ```
> > /*
> >  * @brk should be after @end_data in traditional maps.
> >  */
> > if (prctl_map->start_brk <= prctl_map->end_data ||
> >     prctl_map->brk <= prctl_map->end_data)
> > goto out;
> > ```
> > 
> 
> Thanks for pointing, Keno! I don't remember the details right now,
> gimme some time and once I refresh my memory I'll reply with
> details.

Indeed, when loaded via ld directly we've got a different layout:

# /lib64/ld-linux-x86-64.so.2 ~/t

start_code	7fc25b0a4000
end_code	7fc25b0c4524
start_stack	7fffcc6b2400
start_data	7fc25b0ce4c0
end_data	7fc25b0cff98
start_brk	55555710c000
sbrk(0)		55555710c000

Note though that as far as I understand the layout is provided by
ld loader. I contrast the regular load

# ~/t

start_code	401000
end_code	401a15
start_stack	7ffce4577dd0
start_data	403e10
end_data	40408c
start_brk	b5b000
sbrk(0)		b5b000

I fear we've not been using ld's loaded programs in c/r procedure much
that's why it has not been noted earlier. Need to think how to fix it.
Using the whole memory map for verification procedure is a correct way
thus the commit you mention is doing exactly what it should but we need
to figure out how to deal with fdpic loaded files... I'll back once I
figure it out (hopefully more-less soon). Thanks a huge for report!
