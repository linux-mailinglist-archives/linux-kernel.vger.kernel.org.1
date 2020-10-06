Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D411284681
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 08:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgJFG7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 02:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgJFG7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 02:59:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F139C061755
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 23:59:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bb1so751612plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 23:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q9cOmodfFrT5+fSRpGBDBdOT09/lFZuhORm0j5NKURo=;
        b=e3gsF++h/v9HcvaGyFuWP9pq6Zmxh9tW6PmvBRpws0Q6pUEJyS/MKU7lfJWxqf9YpL
         PgduuobI1xIeumw2vyCmjtLZCeiQyKwMczi4SMMXtrEC3yjTemPFkvKQ6/z32Hcw5Vi6
         6TVXIEul8mmVf/10Bny/Uj1v1WmNjXkUwBkLzPyi20mWLx00tnDOpN6a6u+Sh60WFI6s
         wbCrq4xxoMSqxgSmP8NykQNyszT9Vxw+qj0cruBdeNl6SRv/W6IjKvfflUqZR9ol+H1H
         tSrvZ0yC5iIUzgi0aqF0q9Ld4aC5dj/lp3S+f5fG9kXQsnUe/g/VVdC4z0TN0M7b8u2o
         Fsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9cOmodfFrT5+fSRpGBDBdOT09/lFZuhORm0j5NKURo=;
        b=IQUh/wNbnHySBAb2VHh4YlXdvlu4BVgE6X6iPBvA1RkIuSuguwTVDcAsxZI8fFjgz4
         YBc48ZjukVD+4SpapZeUYxPmBqG5r/86iPFtMyHYFTdpCipF0QH1fLYt5wcHLR7X9haa
         ZM1BLEi+1PAHbcw6MkCHaJ6tV1SN+nVZ9S9RgYdN6K/0i2sZyMd94yHUwdgUUZ0Uy9Rx
         HJqso+4M34yGVvwPt8F38nyZBfU7A36MT5yl3w7oHOqzuda88wsd3OvHrZoZgxIBZs4i
         Ufd9cpVZifC1nBkzPpJmIJ/bgAMhUfsZIJi28LzGFqenU34Xp8k2pTHDGrKcb7sWCdC5
         l4Hg==
X-Gm-Message-State: AOAM530ErOFB4nCCFA4n5GpcWkqMZEIVJvDHQWz4/dzNaNBJ+Vak88PQ
        G//sfSn14MT8i2sg9ny5Zz9YWnIHMUI=
X-Google-Smtp-Source: ABdhPJwb0YG8Y+BTGF13JA05/n2Zqfz5DSBipK8kzCzgKSrrbLBF/ST/0LX8BP4UgJey5FRoI1KMLw==
X-Received: by 2002:a17:902:9006:b029:d3:b4d2:402c with SMTP id a6-20020a1709029006b02900d3b4d2402cmr2028110plp.34.1601967551658;
        Mon, 05 Oct 2020 23:59:11 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id x3sm1681870pjf.42.2020.10.05.23.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 23:59:10 -0700 (PDT)
Date:   Tue, 6 Oct 2020 15:59:07 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201006065907.GA528@jagdpanzerIV.localdomain>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/05 20:35), Guenter Roeck wrote:
> On a side note, I don't see the problem presumably fixed with this
> patch in any of my tests.

Hmm. This is rather interesting. Empty console= certainly oops-es my laptop,
but not the cros board I just tested this on. Do we carry around any chromeos
patches that may affect the parsing of the kernel boot command line?

	-ss
