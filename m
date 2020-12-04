Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FBC2CE5F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgLDCt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:49:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgLDCt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607050080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBVcwXe0Xot4zj8M7WdfrfXxsjan5Uxa2ACFxEEuvJA=;
        b=aKapiidk5kP/nc2Ii3lQmDJQFb6xc1wS/QCMCIe2ExNjG20/bnn0R9WCBilH99lnEPhVqZ
        ruvYmG0dpVsLYlc6+sOdUqunqcPJaHyek5ucIGM61IimToBxkZ4f/bCzYSfCjWL5Q1a8oC
        T33bARStHj8zTc6Oamin4ZNX4CxwO5c=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-kNj5Dp8vNquDt1v67hC1qQ-1; Thu, 03 Dec 2020 21:47:58 -0500
X-MC-Unique: kNj5Dp8vNquDt1v67hC1qQ-1
Received: by mail-pg1-f200.google.com with SMTP id j14so531176pgs.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 18:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VBVcwXe0Xot4zj8M7WdfrfXxsjan5Uxa2ACFxEEuvJA=;
        b=uG/trizOjB01dw79cw0IcF7UQjDDoBChWUDzDvqdLrqn15oWQhRZ0rH8i07gCA98Wp
         WMMlkTGOFs3LWMRe6ripCPCDydtmlJ96DAsk2rWLO2FEC9a3NW/R87t6qSe9AfoUZNVi
         rj1xAkClujL3ISIKpy2HCfgYlyAuYIqv8e0rTHmq7fVdrjvYC4wkJ0nchX3mxJUY0Iym
         TX1irc2AYf4dLiolnOrSOBDyjofbpg+i9NubglrysxKtmFyYuPz2ibScD1HLOGG5m1q+
         8ZHVXlYfZFwNQ+ibEDEJTZZAGhtIkm/RI2Pu5ey+CmSZWpOJikxQgpF2oHqaA6eevvlb
         hM2Q==
X-Gm-Message-State: AOAM533PVOiSkcAnRNAipZi+gMCb64XH9WlXQmDybCwNv+aeztzOOmuO
        5yKsYTyfv6bCTzmAvOUz8lRNCaDxEaOwkHh9GV+xlH0PF2Kl4CepIAo8s/rttaNDpSMI5SHZLGx
        cVCBUF/bP+NzuCdZHnbcaiyKC
X-Received: by 2002:a17:90a:a786:: with SMTP id f6mr2105581pjq.104.1607050077569;
        Thu, 03 Dec 2020 18:47:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxafF8YpV/xVIGGfNk00Gd3HTJHR0we7Pr5oZCjxJlSwb7P1KQx5BTk0Tq/APvl6dYzc7sp5w==
X-Received: by 2002:a17:90a:a786:: with SMTP id f6mr2105568pjq.104.1607050077367;
        Thu, 03 Dec 2020 18:47:57 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 22sm584280pjw.56.2020.12.03.18.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:47:56 -0800 (PST)
Date:   Fri, 4 Dec 2020 10:47:46 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
Message-ID: <20201204024746.GC1963435@xiangao.remote.csb>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com>
 <20201204003119.GA1957051@xiangao.remote.csb>
 <7b975d1a-a06c-4e14-067e-064afc200934@huawei.com>
 <20201204020659.GB1963435@xiangao.remote.csb>
 <3041968d-87d0-d2dc-822b-0bb4a94a365b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3041968d-87d0-d2dc-822b-0bb4a94a365b@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 10:38:08AM +0800, Chao Yu wrote:
> On 2020/12/4 10:06, Gao Xiang wrote:
> > On Fri, Dec 04, 2020 at 09:56:27AM +0800, Chao Yu wrote:

...

> 
> > 
> > Keep lz4hc dirty data under writeback could block writeback, make kswapd
> > busy, and direct memory reclaim path, I guess that's why rare online
> > compression chooses it. My own premature suggestion is that it'd better
> > to show the CR or performance benefits in advance, and prevent unprivileged
> > users from using high-level lz4hc algorithm (to avoid potential system attack.)
> > either from mount options or ioctl.
> 
> Yes, I guess you are worry about destop/server scenario, as for android scenario,
> all compression related flow can be customized, and I don't think we will use
> online lz4hc compress; for other scenario, except the numbers, I need to add the
> risk of using lz4hc algorithm in document.

Yes, I was saying the general scenario. My overall premature thought is that
before releasing some brand new algorithm, it may be better to evaluate first
it'd benefit to some scenarios first (either on CR or performance side, or
why adding this?), or it would might cause lzo-rle likewise situation in the
future (and add more dependency to algorithms, you might see BWT-based bzip2
removal patch
https://lore.kernel.org/r/20201117223253.65920-1-alex_y_xu@yahoo.ca
(since I personally don't think BWT is a good algorithm as well)... Just FYI
... If i'm wrong, kindly ignore me :)

Thanks,
Gao Xiang

> 
> Thanks,

