Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB54F2A3A97
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgKCCuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:50:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbgKCCus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604371847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CW/ACUV2Mng49qFZGRiWeYHvjBj6rU/+vNlelQ6F/Jg=;
        b=gZt9yAkrMnyicYN6MaiNWr6LGRTtEIyIx6TEJvRBOrxHIqlR6aV3s/B5UCEv318wL8USIu
        jV92iNBCOJzNx0NHNoeKs3Yrel3kksQPHJpZ7oqa2PQB0vSVTgROpQNPkPFQIoX+29Dhl8
        bcNQVvRjZsL/Ua1eO7Zkh4O8gcAXhBk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-iIItDuDIPueZTsQB6Z0fjg-1; Mon, 02 Nov 2020 21:50:45 -0500
X-MC-Unique: iIItDuDIPueZTsQB6Z0fjg-1
Received: by mail-pl1-f198.google.com with SMTP id bc2so9762389plb.23
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 18:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CW/ACUV2Mng49qFZGRiWeYHvjBj6rU/+vNlelQ6F/Jg=;
        b=bykLVs/dhDe6gA50WXuFtnFqG286yWXBKcIXlECeqsO1UOziSTe7TIf3ME7Vl/oXwi
         dyn1w5VopneSld0WGm42WDHI7xVEWDQXLgX0An1V9VwxHf4RUNG/rbQmgDWJ4vK1+WBm
         7ATze82VoFzdZrb6szq4fxZfIxLITmTTERwbExqvXL0TmosWG2A05T8aJz5Vzkdyeg2m
         yRvjgxW7xnAdj6vQARRo883Djvt9L5NEv1jvsHif/sL/1lhxSjekOdr2BilqzwvmQmbj
         XzVhHCw71gM6b8TqQv1iWh5zg4OBkPd6Bp+dq+xl9ZmXgHb6SmQWIFAI2SzrGU843zZW
         jeVQ==
X-Gm-Message-State: AOAM533txfsOD3EciyBmV3ihGxuA7tma1n52yYRah8gzcbPORvfw0V6b
        sm0oFvkqtN43LCm6fwUOdOZe22L99uuqnfvLQ3/Njpc4ESGRI8b8mO9OVP0KJnPp+GQU1YKLngj
        Y9rYueXpcwJswU5t4vgDDRq7i
X-Received: by 2002:a17:90b:684:: with SMTP id m4mr1300026pjz.133.1604371844613;
        Mon, 02 Nov 2020 18:50:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgqZp4MURbMJ28PFb6nSGA5bU2+CHwFJgndLAIBQBWizeUfCGjfADDys+ArVZnBuIwNraXpw==
X-Received: by 2002:a17:90b:684:: with SMTP id m4mr1300005pjz.133.1604371844358;
        Mon, 02 Nov 2020 18:50:44 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v3sm830911pju.38.2020.11.02.18.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 18:50:43 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:50:33 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        nl6720 <nl6720@gmail.com>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] erofs: derive atime instead of leaving it empty
Message-ID: <20201103025033.GA788000@xiangao.remote.csb>
References: <20201031195102.21221-1-hsiangkao.ref@aol.com>
 <20201031195102.21221-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031195102.21221-1-hsiangkao@aol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Sun, Nov 01, 2020 at 03:51:02AM +0800, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> EROFS has _only one_ ondisk timestamp (ctime is currently
> documented and recorded, we might also record mtime instead
> with a new compat feature if needed) for each extended inode
> since EROFS isn't mainly for archival purposes so no need to
> keep all timestamps on disk especially for Android scenarios
> due to security concerns. Also, romfs/cramfs don't have their
> own on-disk timestamp, and squashfs only records mtime instead.
> 
> Let's also derive access time from ondisk timestamp rather than
> leaving it empty, and if mtime/atime for each file are really
> needed for specific scenarios as well, we can also use xattrs
> to record them then.
> 
> Reported-by: nl6720 <nl6720@gmail.com>
> [ Gao Xiang: It'd be better to backport for user-friendly concern. ]
> Fixes: 431339ba9042 ("staging: erofs: add inode operations")
> Cc: stable <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

May I ask for some extra free slots to review this patch plus 
[PATCH 1/4] of 
https://lore.kernel.org/r/20201022145724.27284-1-hsiangkao@aol.com

since it'd be also in linux-next for a while before sending out
to Linus. And the debugging messages may also be an annoying
thing for users.

Thanks a lot!

Thanks,
Gao Xiang

