Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434DF23DF04
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHFRgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbgHFRfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:35:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3559DC008698
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 08:16:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so8168615pgi.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lkmeDFCb+vAIp5A4XwAMAJW588/NOgnU33kU5Ds2q8U=;
        b=wi4dRPNxYEFgOvGpsjjRxtDn2I9IamqHuFJzrb9/BuBRChg/enUxUB6jKiVJyf6FSn
         OEQMb2RXR2Ht+C6Ju/CpXw+3C8IXjLBhGdgnDRc+0mD42UF2fgmfGBI+NDEQDfVS+FPg
         8Yte0Alz1AaaMd1lh6L2ptLcnhrBzWalCQR42JDJeAyQD1H9NJDT0b18q5zQqirTk5sw
         MQTa65RVxamAwTEOlvLR1qATaDfFMPrdnpkmrZ75l2JmkJ2Zy9MPxE1hZyGlCwG5lUWc
         dMIBO4mmLkijKg2CX5kvhARvLNuj4R+a6FF2AhYbKN6g85KDBnPw2HmOoO1VsmzJJPBe
         6lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lkmeDFCb+vAIp5A4XwAMAJW588/NOgnU33kU5Ds2q8U=;
        b=oPzGrZc8I2FvFWNUw3Vpv8Qn+G8hHlMu7wIJudj2mkscblt7Nn50GJaBn6w+/meHGn
         +1kSHbFzEpUr1YB3uTYqceRAfOd9E8qnLqKdnPjBIY8VTG2HDDaq/gQ++gkXYLd2R0co
         71v519fZ7rojepVX8cnEim4E4evE4jbIJ6rDqkP7VRV/V9WfYU3VG+JNnB1O9utiMQuh
         LCgM5qBIp5f0mheutLK++h1p4Nr7ynxbI0Ul4BzYQOKBx0PZhRsJPMHGo6JgQiNmus6R
         XGJoNQH26NPJw+qEPX6cdVUWlfPIMQePNXw67kiBdv9zWzIAUXpy6uUsCgbAc32igEBy
         +VKg==
X-Gm-Message-State: AOAM532/cOIlN0NasApgR8X8M30ceGVWveaYquxtccVRD3hj/G4aep4i
        2YMKqCb3BtHwH1FmdjMsjPJBrwdiP0Q=
X-Google-Smtp-Source: ABdhPJw12jZ3DwVtFWJem2DsB0Vuvxs5W1jsJdh1xkbPJ6eXu/HRB7XOi58ujieN7nBfCOicKddtyw==
X-Received: by 2002:a63:fd41:: with SMTP id m1mr1061769pgj.12.1596726996234;
        Thu, 06 Aug 2020 08:16:36 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b15sm7241610pjo.48.2020.08.06.08.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 08:16:35 -0700 (PDT)
Subject: Re: [PATCH] blkcg: add plugging support for punt bio
To:     Xianting Tian <xianting_tian@126.com>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1596722082-31817-1-git-send-email-xianting_tian@126.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8f84e1fe-9fa5-b7e7-1f2f-b0c4a40614e2@kernel.dk>
Date:   Thu, 6 Aug 2020 09:16:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596722082-31817-1-git-send-email-xianting_tian@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/20 7:54 AM, Xianting Tian wrote:
> Try to merge continuous bio to current task's plug fisrt.

The patch looks fine to me, but I'd really like to see a bit more
changelog here. The commit message should explain why the change
is made, rather it's a very brief explanation of what it does.

If the bio list is contiguous, then we do the plugging to improve
merging at the lower level. You probably ran into a case where
you saw sub-optimal merging? And now the performance is better
with the patch? How much?


-- 
Jens Axboe

