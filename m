Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28ACE284C95
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJFNdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:33:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D17C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 06:33:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 144so9044612pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vm1qg5tFM/go3uZ+IFi1ZY4Ibsza7VdedxtPshUR0wA=;
        b=SBSdKX6/2NAGUgBAXq+UB2ZJMH7fmjLJhOIhMKAOF26PXkpGxgg4lfSi/6WXVBo72G
         5DXxSuMVgntF9ApClATEoRCpHukGPkhqPTvb5f5xdxXZaq2gw7o2GJBDJUYXHx1T9QnV
         i/2h/JDWbXHNwKRKT8zkVsG51wFmakNlkuto5NxL+00tKr7CTRDd8lXbAUuLpzDNVY8b
         RCmCc2S27hc+0F+CCE8Z5SNXMLxskJjznMPLmXK/nSqB6uietnMhq4cR6vfMzblRzZpR
         lG4VavePWJze81z/6OVaLMdVqjfoE6J3jfc3DDCZvlOYm9IeHL8Ma81WkkKOy1pZXu0v
         dUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vm1qg5tFM/go3uZ+IFi1ZY4Ibsza7VdedxtPshUR0wA=;
        b=JVe2ELZhzBC3qUgxwa5Tb9CKyhA4xBF7jq/x1NvumA4SwJhkDTnNwVsmtYgPZeueRO
         FuhfcX8xX+/JvtNFNgyMGATapnvBtSgJ2cm/X7PtJihkKO0sNoCaHblXs5RdD1eKaG51
         WnpfbsHoL+Nif8ku/OzpWKW/zFlLiMvdNk4BxYefk+j0kSsq/sYJcpcFPCObhBesqrxh
         CfzyeJtJlH5z/gMN9GMNMDQ8eImMcQCX8vGHPNhVLU/KyS/HlLpa4iwftrNGXmtbLaIv
         qNvabx+ZDby2h8tYc9Fp+X8rsZSGb5XRDQEzAcwFvJMKgjfyAi+WHlU/XnrqD5FGXBUz
         Lliw==
X-Gm-Message-State: AOAM5315k1MVM1A6+MSAwxI34YafShviqLH7+mCglsv8tFObW2VyV7WP
        xf0x72Fn43+JOnrVruWvqlA=
X-Google-Smtp-Source: ABdhPJykmUpJZjbW3TXNR0HlZqdGk1+eN6n3FA+FALID62Wf2jiP3bwcEQSalwp4zPrtaQCp1zp4Sg==
X-Received: by 2002:a63:cd48:: with SMTP id a8mr3877058pgj.83.1601991202854;
        Tue, 06 Oct 2020 06:33:22 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id s8sm2808255pjn.10.2020.10.06.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 06:33:21 -0700 (PDT)
Date:   Tue, 6 Oct 2020 22:33:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201006133319.GA178176@jagdpanzerIV.localdomain>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006065907.GA528@jagdpanzerIV.localdomain>
 <20201006095435.GC32369@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006095435.GC32369@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/06 11:54), Petr Mladek wrote:
> On Tue 2020-10-06 15:59:07, Sergey Senozhatsky wrote:
> > On (20/10/05 20:35), Guenter Roeck wrote:
> > > On a side note, I don't see the problem presumably fixed with this
> > > patch in any of my tests.
> > 
> > Hmm. This is rather interesting. Empty console= certainly oops-es my laptop,
> 
> Just by chance. Do you have any log with the Oops? Or does it die
> silently?

The laptop in question has fbdev and no serial. It dies with blank screen.
I'll try to dig it and get some backtrace or anything useful.

	-ss
