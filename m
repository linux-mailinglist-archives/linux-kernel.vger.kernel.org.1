Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65083277555
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgIXPat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgIXPat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:30:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AF8C0613CE;
        Thu, 24 Sep 2020 08:30:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so2096513pfo.12;
        Thu, 24 Sep 2020 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yanHGoZJj/tcEI8AVG6llL0fhzRiqvwYaviiL5Ezz3E=;
        b=ezNq1DHk4aNb+MSOycaRr9VWUq1Qil3Y4UoOygCV1AX9tQN1xlt+KEI3xDsK4hm60D
         GFOugf47Qt1NC/tZueImMyAiEYCqCXEP26A9qXOgblPKBalIb6Fp+r87y8OkF24rtv2e
         1p8+WnTVov6uGi64oLAPHumRF4sskzWR3wFGEG7DiUIf0lWJQ/c9yG+61mFwp6K+kRct
         gm1ASwt/Tj9es80OzDDvf30uxyZ46OdNkhAIf6Md/MCZVpqREZu7gKj3fZk4H48JYKBB
         zbO82ZiSr+J1f1iAwv21h7zWDDL6cm1AKIL97ZEhHahS4+3ZCOZuy1sGWtGq/PVX+nZB
         nQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yanHGoZJj/tcEI8AVG6llL0fhzRiqvwYaviiL5Ezz3E=;
        b=LAu1tf09MvD7ntSV+aVlZFFy/1yRH3XKBb8zQyYXiC8BrVZF3mPmlvCqtPyaitO1IJ
         /35KGVnPymt92uCmqOO5vWx3SGa9XxUyxNewK/UqCsWx8b3dV3hMRwh6BSCIZLTTD7YZ
         HSvmmWGZUIIqKFj6nwvQRUXEY2NgwqOeGFkxHjCLHKWtXCnN9kEmN8Tw2vXNTRIgZeoQ
         xHiqQftsE47Lgmh7UfUBZ/j2GaYVY8RLaVjll0K+OUjvdFTN9pikW/FStnpyq1/PAS/J
         bfu13/mAudBtxnKQtyojWH0xdYFn1MGlLTo7gO7Zu0RJTDbeUC2oteiveVbat51UWqXH
         3U2Q==
X-Gm-Message-State: AOAM530gQuVUGdWKd7hYXV5a/DbJcxorBCr5CoC5w7UhnG5yRHnXvVaV
        xHoG5F4+s6tFJYQyf1DSyA==
X-Google-Smtp-Source: ABdhPJwqZfwiI24nj6maCQ3FVjnC1hLBovtP3quILpVSg5gXxUjuwWRHxbd90tmjpkb4DXHr/yYuNA==
X-Received: by 2002:a62:3812:0:b029:13e:d13d:a062 with SMTP id f18-20020a6238120000b029013ed13da062mr4689781pfa.40.1600961448347;
        Thu, 24 Sep 2020 08:30:48 -0700 (PDT)
Received: from PWN (n11212042027.netvigator.com. [112.120.42.27])
        by smtp.gmail.com with ESMTPSA id u2sm2825443pji.50.2020.09.24.08.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:30:47 -0700 (PDT)
Date:   Thu, 24 Sep 2020 11:30:35 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data
 buffers
Message-ID: <20200924153035.GA879703@PWN>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <20200924140937.GA749208@kroah.com>
 <394733ab6fae47488d078cb22f22a85b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <394733ab6fae47488d078cb22f22a85b@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Sep 24, 2020 at 02:42:18PM +0000, David Laight wrote:
> > On Thu, Sep 24, 2020 at 09:38:22AM -0400, Peilin Ye wrote:
> > > Hi all,
> > >
> > > syzbot has reported [1] a global out-of-bounds read issue in
> > > fbcon_get_font(). A malicious user may resize `vc_font.height` to a large
> > > value in vt_ioctl(), causing fbcon_get_font() to overflow our built-in
> > > font data buffers, declared in lib/fonts/font_*.c:
> ...
> > > (drivers/video/fbdev/core/fbcon.c)
> > >  	if (font->width <= 8) {
> > >  		j = vc->vc_font.height;
> > > +		if (font->charcount * j > FNTSIZE(fontdata))
> > > +			return -EINVAL;
> 
> Can that still go wrong because the multiply wraps?

Thank you for bringing this up!

The resizing of `vc_font.height` happened in vt_resizex():

(drivers/tty/vt/vt_ioctl.c)
	if (v.v_clin > 32)
		return -EINVAL;
	[...]
	for (i = 0; i < MAX_NR_CONSOLES; i++) {
			[...]
			if (v.v_clin)
				vcp->vc_font.height = v.v_clin;
				     ^^^^^^^^^^^^^^

It does check if `v.v_clin` is greater than 32. And, currently, all
built-in fonts have a `charcount` of 256.

Therefore, for built-in fonts and resizing happened in vt_resizex(), it
cannot cause an interger overflow.

However I am not very sure about user-provided fonts, and if there are
other functions that can resize `height` or even `charcount` to a really
huge value, but I will do more investigation and think about it.

Thank you,
Peilin Ye

