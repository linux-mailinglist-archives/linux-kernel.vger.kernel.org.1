Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50531DCF70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 16:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgEUOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 10:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgEUOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:21:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF5FC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:21:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t8so998330pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqWT/aJMqjQS/LwwIzDw5vVtbTuX7+bbQKCciE383sc=;
        b=IubiXOXxF2nL7YfH5AF2oZumoIioFJkh2cyMRIZp0jsTtdJTU6sm5tTkN3HB9KSqpr
         BtfBrkxRHj9emgX0ItTzLqrFslEgmDV5pO1oagyiFOJUdNGqmgdWCpF92vGx8KmQIdr8
         FTDpUs3OaOO5TVWe6ABfw+7ANd0xGdrP5T9kYTlX81C50wZB5HxY+ZNlwgC4QnTvB4YM
         i1IqzwpR0hiihyC8n83UH2C42t418sA/KbyBT2urJw8cwaWySpd+n+xOxbR6Lzi9J9IL
         K8VxDTfFDp42DN/+XuQKeLell9ggOV648PoVukEpAqYDM5Peiu2huxXaw3PifSu6hRYg
         TaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqWT/aJMqjQS/LwwIzDw5vVtbTuX7+bbQKCciE383sc=;
        b=ag8cr4YtzkSn4bEOgPvjq6DmcMt7HFUhNiR5NywHt5m81mKkOEJarrzoPuqRG/pmzI
         ORSLQWfoE3Er+ncAmSL+gGSBtAcoxMwRXe+l7i/6qydj+DLP2PAUSIcakkm3oCUFF+pJ
         h6vpntnjsJP9HyoSzs/636LbpO5zUz+xnykAQTGqjMDRpNZZ8eeLAfj6jybNOCnCdH7N
         6JpSjInDYoIFi9xzUnf9S6V63FHL4O/AoH5+TOUaSxM/itcS6ll30wXreFvfIXC1o9W6
         O7NcQLJqkUQthgs6/E2KaG5zPRefUVvwY/4LoJVldsxdmyoWPwtymkyQAiEsa1Y2v6nE
         fDNw==
X-Gm-Message-State: AOAM531UFf1a6Y+jl07jX54GsJQj/hecO9y3XSbbza9B2B1ZGODofHDB
        fheAuHzLZTPoCyV5/6VAHR6RgZMKDyQ=
X-Google-Smtp-Source: ABdhPJwJWiF05G52IFW9R5Nmw5veE7Mlw/Rui0UPeykYh3HiKu3fnjOBS9uNDK1RBAVTK+i14VNZqg==
X-Received: by 2002:a17:902:7047:: with SMTP id h7mr10219648plt.9.1590070864321;
        Thu, 21 May 2020 07:21:04 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:c00a:8fd2:4246:efbe? ([2605:e000:100e:8c61:c00a:8fd2:4246:efbe])
        by smtp.gmail.com with ESMTPSA id k65sm4703876pfd.156.2020.05.21.07.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 07:21:03 -0700 (PDT)
Subject: Re: [PATCH v5 00/11] Add a new LOOP_CONFIGURE ioctl
To:     Martijn Coenen <maco@android.com>, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200513133845.244903-1-maco@android.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe0b7bf9-07b1-9025-f9d6-7ace03c89a1f@kernel.dk>
Date:   Thu, 21 May 2020 08:21:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513133845.244903-1-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/20 7:38 AM, Martijn Coenen wrote:
> This series introduces a new ioctl that makes it possible to atomically
> configure a loop device. Previously, if you wanted to set parameters
> such as the offset on a loop device, this required calling LOOP_SET_FD
> to set the backing file, and then LOOP_SET_STATUS to set the offset.
> However, in between these two calls, the loop device is available and
> would accept requests, which is generally not desirable. Similar issues
> exist around setting the block size (LOOP_SET_BLOCK_SIZE) and requesting
> direct I/O mode (LOOP_SET_DIRECT_IO).
> 
> There are also performance benefits with combining these ioctls into
> one, which are described in more detail in the last change in the
> series.

Thanks, applied for 5.8.

-- 
Jens Axboe

