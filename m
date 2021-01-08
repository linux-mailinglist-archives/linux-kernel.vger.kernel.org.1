Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDD42EF4BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbhAHPVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbhAHPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:21:19 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30034C061381
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 07:20:39 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id 75so10566181ilv.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8zCsmPDJQdJDnkQKZejQHJWw0dwAHVEo5bCx7sWw+Us=;
        b=f3/KYLt/J0hCYtwNhNQq+jNhIOIWqktI64HygeRj75qq1fPnhgIkN6NSbXBwf3AFJV
         dpswdSOXhnqXsIrqnRhxjdPs/6B9KDV9xd/HUsY7RwiPnV9CYPDuannIRoPOfnDzmipr
         xeOl3gqtigloxFfCU2BiU5hWGcYKkMWMudttgRY1ZHmUSaZMy+ChjbBMY1DDQNlRbSOl
         N0VymzHgJ7JTmAoklloysMoGESJ+v24My6ef/zOHq7MtfKWgC6AVFaaIVpuoeFes3Lnj
         DLyhgGlXd/7LXcRJhZGRkVD9s3J6a5ix56LXsx6k4roNiMHZOp6WA911hlGnYtpbAv6f
         dgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8zCsmPDJQdJDnkQKZejQHJWw0dwAHVEo5bCx7sWw+Us=;
        b=Pp4WIntWUs2T7FEa8iL3PKz/Skpeg+XisBxc1BxH7Bw6zmI1hio4F3t+is7lTl1BXy
         zHvkKAJzteeytaUkczjhCZwj5A10Kn9hIHKplFvPfa23a6FdpcQABqtaHvaXw/2QgnAK
         +4NpkBR7Sr5+VtsYb1UgW59rzrZDJ5Lghy2v0ODIpnAqreJorahmwxDRr2/hoWkMm68P
         OQIKMHU2Qj5CFRvdcMWnp173eIobZC7EnXMg3fqY+bW8YHW8e4SoOOE2C1qJH/Q3iEhZ
         gHyESqOR806zWvHNQJpKO9//PcvBNpXvvu+uMG2+D+/k2ZKb+Bips6TukzxTcPTPTlf+
         cVzQ==
X-Gm-Message-State: AOAM530KbiMCnpVKT41w3WjT4vEA3m+WnKbmkGiaxLASXtGOr2CchrzA
        qVbaqhd7VxVeXGryT5EHAUahls0V50dXWQ==
X-Google-Smtp-Source: ABdhPJwLHghE+FJPmb5oqFCSqhecGE7My9bkts6MyHEwGH3AtUS5gKdtSmwdByWeukzwHGaxC9YDhA==
X-Received: by 2002:a92:d84a:: with SMTP id h10mr4088593ilq.77.1610119238421;
        Fri, 08 Jan 2021 07:20:38 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d1sm5364829ioh.3.2021.01.08.07.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 07:20:37 -0800 (PST)
Subject: Re: [PATCH] blk-mq-debugfs: Add decode for BLK_MQ_F_TAG_HCTX_SHARED
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1610096137-187414-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d0fa03b0-55b3-c4aa-6a8f-ac8b9afd6d13@kernel.dk>
Date:   Fri, 8 Jan 2021 08:20:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610096137-187414-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/21 1:55 AM, John Garry wrote:
> Showing the hctx flags for when BLK_MQ_F_TAG_HCTX_SHARED is set gives
> something like:
> 
> root@debian:/home/john# more /sys/kernel/debug/block/sda/hctx0/flags
> alloc_policy=FIFO SHOULD_MERGE|TAG_QUEUE_SHARED|3

Applied, thanks.

-- 
Jens Axboe

