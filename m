Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16A1275658
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWK3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgIWK3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:29:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F51C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:29:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s19so875211plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JI/zqwqxLAG9o9M3uwdlp+Q2ESbf1KLswdxq+phSMss=;
        b=u6yJI32vRYyXSnq/EAHe1ycM5E/UH402GHw9uEHyjFqkwGjw4LxgSg5iLS+DiRQ4+r
         o7Oeyl6s40YgiEk5lLE815dRP47+HbnUA46uteNZkALAUaMU9icgkCx5V4xe0cnUQ99d
         71b4vGj6t937JuPHgrem0dQTIRFdtBXZomoi7lc8431D0L6a2Xeqc82fbvp82Orpl5Yv
         xJIV4wAoYiWMAXCsvj6cDs5aD51aFHi5y24p9NIRSNDyHU6AwnltjuqaIfChy9ZiQVJy
         XtBQWuz11V6nG0xekQREIqGo0xJovNXYI4Yy9cD1YOtH3Im1aHFRg2HZUJVsiXtR8gBT
         EISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JI/zqwqxLAG9o9M3uwdlp+Q2ESbf1KLswdxq+phSMss=;
        b=D7HjI9r/mFVvpc9XdAJn9S6juR6D0JsqkX6SoIeH1pPrpF0gd9reVBN2Dkcq0Z/rUO
         tNu/ABM83KLBIVfrGyqYXYv1depPgYtbc4ItikU1AYLbqTsHMQQVWgt0Q7A7WqjyevNo
         vdbpXgj4Xx1m8LMvP3L3/iDlXhJjZKrXhhEzc7QJgcOuqW0bD5uCMkcjQRBtZxc61C1Z
         PqBuwECt+kHdCnKppQz7ENBXjOIIYRWa7OU19yMwAyGtq3FLmP2Adud/2D6i5wUbKj+2
         B2KElx2b3oQMn8Ks64mWCEzPWWclIhEk4yP7P8NU6nlCPywsqfwBgjObYW02c/Yv4zK0
         bcuw==
X-Gm-Message-State: AOAM531GCnge/Bi5r2EKo7ccLsVKmOBpBCntT6Fn6b++gDt8ohtsqFXQ
        9McWaKEwGfAVPrDdVXxFvQ==
X-Google-Smtp-Source: ABdhPJwkJ17OXMhXTjQk3IyAhB+j/BlL4pmBt9igviElaN0XRW+WDlr9Yxgy9/m+2VJRbrio0D/iMQ==
X-Received: by 2002:a17:90b:46c4:: with SMTP id jx4mr2931642pjb.190.1600856971629;
        Wed, 23 Sep 2020 03:29:31 -0700 (PDT)
Received: from PWN (n11212042027.netvigator.com. [112.120.42.27])
        by smtp.gmail.com with ESMTPSA id x27sm18118583pfp.128.2020.09.23.03.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 03:29:30 -0700 (PDT)
Date:   Wed, 23 Sep 2020 06:29:25 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] udf: Fix memory leak in
 udf_process_sequence()
Message-ID: <20200923102925.GA288879@PWN>
References: <0000000000004c1f4d05afcff2f4@google.com>
 <20200922154531.153922-1-yepeilin.cs@gmail.com>
 <20200923100405.GD6719@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923100405.GD6719@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 23, 2020 at 12:04:05PM +0200, Jan Kara wrote:
> On Tue 22-09-20 11:45:31, Peilin Ye wrote:
> > udf_process_sequence() is leaking memory. Free `data.part_descs_loc`
> > before returning.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 7b78fd02fb19 ("udf: Fix handling of Partition Descriptors")
> > Reported-and-tested-by: syzbot+128f4dd6e796c98b3760@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?id=c5ec4e6f5d818f3c4afd4d59342468eec08a38da
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> 
> Thanks for the patch but I've just yesterday written exactly the same patch
> and merged it to my tree...

Ah, no worries, happy to see the bug gets fixed!

Peilin Ye
