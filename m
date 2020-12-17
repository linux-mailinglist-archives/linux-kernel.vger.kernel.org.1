Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CDB2DD323
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgLQOkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLQOkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:40:42 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4FBC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:40:02 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 4so13347993qvh.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogKrrKV+TtPAoHoe1fNFHNXZOViO5iz6ZfC2TYW45N8=;
        b=Pl7wuENL1WXAOmI3oAr7e3G0ftZOy0UJnMXLzfBoNOITEZzYSlo7aERwxA/EeUKoMz
         ti6yCuHQjAwzdyfBChT6twoLznkaOBtJc8ujEeQcajovGNu7WTg8lAIy9Z78uqz2NNxY
         OiOV/xXpG8DPNetyLNzAEWR3RTfD/RPacp9D1TJ+Wn8NuM2vyMsMQ2oa692slXzuIGmy
         nzUIXg6Tg/LUzkwjvQHX8mIsTJ473mj4KnDzrL/IYCXQoGKlVsJO/4tdICs6pjj1IwJz
         r1qAs/UQDJWlepedS+oOkGCUKRrD34J/9oce1WJo+hnrsPPaoRbhlenp0mhm1F6CV4H0
         68BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogKrrKV+TtPAoHoe1fNFHNXZOViO5iz6ZfC2TYW45N8=;
        b=Iae2k8KjVu/brD0JQJr8N0dIQGTakgKddHFYU0Ie7Lh1Qoc4MJ75yB/SnDVaE8nGjt
         KdlQoP/C04lEzAMTyfMQgBTsmU5fI6Fsos4ceSqSAiwnC0Ywyi+KhdOXZ+IKom5OemAu
         NAm5V/tLIPCbFFvDwx7LNjJy1mxD25e1uCwTaJEDKVJIqv9WyT4jkSxFODVAz8QjZ65b
         jcNkh1CtRTHOgJ0rbTowIIUbhVtFK159/2Qdy/Ls1Qm+N7LoKz/hl4u3UKFEsyGtOCIy
         avcGu4AvtrS8Efhs5Bzi6vfxFi/COcT/s6uEiRLmsx98kq/yIgeAAUlsmNSnK36/+Pk0
         ZNCg==
X-Gm-Message-State: AOAM533gA2CrSb1kklcIjYDYR9nrppLwbhiCOgzAsVbRSEz69QQzsknd
        XAmkxCz1gNtL8Dm5LBrY2hKCwrCPavL51B/w
X-Google-Smtp-Source: ABdhPJyhCQrkFX8vgTpp80PgQQn0FKyq4tiJRCeZN0aCSqHYvGuPdcnGrVYPnsRFStx29qWurmvMgg==
X-Received: by 2002:a0c:fd89:: with SMTP id p9mr22656398qvr.8.1608216001461;
        Thu, 17 Dec 2020 06:40:01 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c28sm3248644qtv.2.2020.12.17.06.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:40:00 -0800 (PST)
Subject: Re: [PATCH] nbd: Respect max_part for all partition scans
To:     Josh Triplett <josh@joshtriplett.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <86d03378210ddac44eb07ebb78c9b0f32c56fe96.1608195087.git.josh@joshtriplett.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <33c35aa8-b698-7141-6adb-ac0b76edf758@toxicpanda.com>
Date:   Thu, 17 Dec 2020 09:39:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <86d03378210ddac44eb07ebb78c9b0f32c56fe96.1608195087.git.josh@joshtriplett.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 3:58 AM, Josh Triplett wrote:
> The creation path of the NBD device respects max_part and only scans for
> partitions if max_part is not 0. However, some other code paths ignore
> max_part, and unconditionally scan for partitions. Add a check for
> max_part on each partition scan.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
