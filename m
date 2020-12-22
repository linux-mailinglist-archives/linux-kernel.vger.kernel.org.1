Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D3F2E0F08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 20:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgLVTkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 14:40:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgLVTkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 14:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608665955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tsCMd9Nfdq9n0ayDvsC2lk0uNSEwrw9mxvuZSf1qkQ=;
        b=cIt9xSgztQF42RsjQiBEtvGn9H2C9QcEByLQVXIPsH32b3wg8jjFUGC8087xcL95EeRzEs
        Jasu72grbDD7+3orD5anvbdDdUHTsxxfaB7NDWaCKCjVaPND+yF1V8ZpfqzkFQYQf2nyjU
        49pM5ekSnKOjm8LZNkUYjb1csvoGFoc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-yw9uQnqcOJaoVPnHOiD1DA-1; Tue, 22 Dec 2020 14:39:13 -0500
X-MC-Unique: yw9uQnqcOJaoVPnHOiD1DA-1
Received: by mail-pf1-f200.google.com with SMTP id l11so7326820pfc.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 11:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5tsCMd9Nfdq9n0ayDvsC2lk0uNSEwrw9mxvuZSf1qkQ=;
        b=QHny63oIq3Tx2SSHMdHNZkfQJw4BkNAHeIVYJdvHuhCc+iEVHfHL1MK4DRJMHu5qz4
         ie/99y0V3mWmzUfcHbqadXCQbYhvjqF8oaRrk1oo4R0PCWllFTys/PMCKSxr1Dwcdvme
         5Dh8q9SEZTkypg4nTW/3s1JPcvU6UIvOH+rYzu+CghxVZxXC0590EvloGGi7rQgiyGZO
         Qra2CvpS+wEXWUO1gSomJAOBGoF4FI0GfdQnPeaJMcFCjfWKuO0vNulbzgRqlOXj25ik
         dp/MgezBarghGVbR0/BhbggD5KK0y2rah209EQYnZjBro7sQL1JO0BFy7gNzJQkpKV1b
         a2Ag==
X-Gm-Message-State: AOAM5300XzOiq6TWEicEgg3y6TdA6P1bYu7AC3CqIRhIWDaYY9iFspQv
        zTCk1MLjuWVlgEK4cHPlqoklTwjZ6gXybpbumdP+ycS/9iwdksMGxMYWbahKlWtRgLpaxM11cI4
        dF0WggPnMYEBCQOiXYneeMkvn
X-Received: by 2002:a62:7857:0:b029:19d:fe6a:3069 with SMTP id t84-20020a6278570000b029019dfe6a3069mr21223284pfc.3.1608665952719;
        Tue, 22 Dec 2020 11:39:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiytS6W//zDGdZqsS2j37qTS3snbiPRUfNBd0oZl7T0AOd+Z8EYMV0Xj4leWnaUJxCM0pRgQ==
X-Received: by 2002:a62:7857:0:b029:19d:fe6a:3069 with SMTP id t84-20020a6278570000b029019dfe6a3069mr21223273pfc.3.1608665952512;
        Tue, 22 Dec 2020 11:39:12 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 7sm21372646pfh.142.2020.12.22.11.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 11:39:12 -0800 (PST)
Date:   Wed, 23 Dec 2020 03:39:01 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Huang Jianan <huangjianan@oppo.com>, guoweichao@oppo.com,
        linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
Message-ID: <20201222193901.GA1892159@xiangao.remote.csb>
References: <20201214140428.44944-1-huangjianan@oppo.com>
 <20201222142234.GB17056@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201222142234.GB17056@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, Dec 22, 2020 at 02:22:34PM +0000, Christoph Hellwig wrote:
> Please do not add new callers of __blockdev_direct_IO and use the modern
> iomap variant instead.

We've talked about this topic before. The current status is that iomap
doesn't support tail-packing inline data yet (Chao once sent out a version),
and erofs only cares about read intrastructure for now (So we don't think
more about how to deal with tail-packing inline write path). Plus, the
original patch was once lack of inline data regression test from gfs2 folks.

The main use case I know so far is to enable direct I/O and leave loop images
uncompressed for loop devices. And making the content of the loop images
compressed to avoid double caching.

Personally, I'd like to convert it to iomap infrastructure as well. So if it
has some concern for __blockdev_direct_IO as an interim solution, hope that
Jianan could pick this work up. That would be better.

Thanks,
Gao Xiang

> 

