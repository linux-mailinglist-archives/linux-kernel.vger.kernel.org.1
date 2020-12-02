Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595912CC552
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbgLBSiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbgLBSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:38:14 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A4FC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:37:34 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ek7so1183718qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jCAyA0jCI6f+1wOWuEY4R7HOx3MXmMVjxHY13v0w5DM=;
        b=cMxqrxGFgOQmnSCaGG7z1BQfaULQzrkMeykxLSnjQugPEWAScf1OgO0ifduABVlr8F
         4skrLojzBNF/FQl/4CTpC1F7lGDYF09zuMQsj0BOWrAKniXNVOVcTk+7GIsFbXS47ftg
         UDze6J/lH+cjOiEDbx30XjfzeHCkXNaG8HKzTppUOOwzKLbYultZPtGZpU9ZM1HHhfcw
         JBafZOfKMlzz5dXGyQ0wdXn6ZWvjDS4nEL5JcgPUyCPM3aFm0dpmo7nte+x6zpWEW5xU
         Hy/vP+sPYpxwi38SG5VhMcc+trnnzVBGMlujDd5J0ILWGK4XgKkhjRBrHNNBXuzqSWyX
         PR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jCAyA0jCI6f+1wOWuEY4R7HOx3MXmMVjxHY13v0w5DM=;
        b=cdCPUCcWxD0uoHhPgOhi+ajY1B5Fquvfr4ADGNnDHpNBX2wqDbQYFY2AH5DOakuqVT
         xIxSpe4JRiZnlaF5OeK0v5JwfzcNcvL0txMzXpb+rRaKtDBMy8fX4e5mZy/LRdBf+q+F
         2XZj1BVWYP/aDEWmef9sKeaq332Vy0Ir4D6Hg5qEJRGZiVRtpKJE5FIX5tkJc/a7EsoC
         9Isy9VtZnqs554VASb3upmACL7DIcIs5QKWJbhy74luJ85TQ3hojXO1qxPGNUXRf0LlL
         uxU8+RPFbcbI41T4o2mA17t3unJ17vCv324g7l5zhIEf31e7iAVrYSEw6SCH2ZaSwHTF
         D0+A==
X-Gm-Message-State: AOAM530+aJ7IUleS1m/hC8J+GAmF98Tf1yKgINkV44FeCHhX0hgsk1Wd
        qe+E8vKtM4e4L+ICnxIkw+Q=
X-Google-Smtp-Source: ABdhPJydMMzDeiYQkc6sbPiXWtNCfX19PTyKXvkVC6Yv8iyVk/TJxaqbAxNE2BbW/skjH0qYP0+Bdg==
X-Received: by 2002:a0c:9121:: with SMTP id q30mr3909008qvq.17.1606934253629;
        Wed, 02 Dec 2020 10:37:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id y44sm2888335qtb.50.2020.12.02.10.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:37:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 13:37:05 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kernfs: replace the mutex in kernfs_iop_permission
 with a rwlock
Message-ID: <X8fe0cmu+aq1gi7O@mtj.duckdns.org>
References: <20201202145837.48040-1-foxhlchen@gmail.com>
 <20201202145837.48040-2-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202145837.48040-2-foxhlchen@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:58:36PM +0800, Fox Chen wrote:
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 89f6a4214a70..545cdb39b34b 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -156,6 +156,7 @@ struct kernfs_node {
>  	unsigned short		flags;
>  	umode_t			mode;
>  	struct kernfs_iattrs	*iattr;
> +	rwlock_t		iattr_rwlock;
>  };

Also, while this might not look like much, kernfs_node is very size
sensitive. There are systems with huge number of these nodes, so I don't
think putting a per-node lock like this is a good idea. Either we can use a
shared iattr protecting lock or play some cmpxchg games when allocating and
setting ->iattr and put the lock there.

Thanks.

-- 
tejun
