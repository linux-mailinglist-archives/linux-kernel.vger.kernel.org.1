Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6129227B026
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1OmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1OmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:42:04 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:42:04 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h2so1460204ilo.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=F34DFOadLWUrYUexx9pZf+zYffic8Ay3o02O0h/KIN0=;
        b=JiVrBmJ1Cyz1KGIH2v91GIUY9+L+DZ69rzBdIU3pBMqJBXXKyTi0md7EeDKaf570kn
         atTuuvNtsa0TeJrzNgAI+V2wJocWnoATQzOgRHsk0HHXu95TjpK0ywXjcqSUd+N2W9VH
         Ej4YXhL7rX5X8/+G5/wI+77r9atTtnT64CtlyQ0/IPvt6GkYSikR9PVbf1UZh3Qppscu
         gX768RyIQEICelF4f8e4F4UNHSPBO1L4DHtIny0BA9jI/HLgMqjh7af3Oa3oQyHZKq3I
         YT4R2BKSECg6NpyvPNIQDjEC011f250CMZw7ZnNJgkE6pncfcc0GkFfwFZFsWOHWVs5q
         XAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F34DFOadLWUrYUexx9pZf+zYffic8Ay3o02O0h/KIN0=;
        b=qW+5cE2bz/72G1X5IM8VuhVLP8DZ8CGQ/L3ORxj1ES69gYxr7POjMDTMFr8WzMTuYY
         7SdXzAD8SX9r96zX5xF+m8xyeQIcnh8h6tGOTV4KAPriDdVAn4RxYScxPM+CjJaj4BDL
         AxBJ0QbwUFW7DLtIaTD8ZTYKVUhLH7oyT2ilhTzzamaqasQrVZCsZlNL6SBuHE2s9ZxW
         1dC05ZMS+r37ayFYpvV6LbPIQ63niGpTUL61wnVZMaBtIBU33LaWR9Ag+GZvOBBa51P3
         Ajwa5ky0ebXd2+smpW3XxmQ05X2Ie2Qi//bDsokMQWeUZ6KE8aqdR/YdKjXNjnZEzDn2
         Jz/A==
X-Gm-Message-State: AOAM530NeAVkoIz80G/9wYEzkd7eGt03Kvacweqiox5i46h7L+tqNlGA
        Z9hbaakHxsnRqv9z7ZWssf3Tffz82a8v+g==
X-Google-Smtp-Source: ABdhPJz37pKpbU4jXuYy2tGgcf5RcPJkvzjXloILoPzePX5GnpjgmEsryGJ3i2XSWGkgPWsvpWEKDQ==
X-Received: by 2002:a92:9817:: with SMTP id l23mr1532021ili.131.1601304123000;
        Mon, 28 Sep 2020 07:42:03 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v15sm704133ilg.0.2020.09.28.07.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 07:42:02 -0700 (PDT)
Subject: Re: general protection fault in io_poll_double_wake (2)
To:     syzbot <syzbot+81b3883093f772addf6d@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000478f3a05b05a7539@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <835b294f-2d2b-082b-04dd-819e12095698@kernel.dk>
Date:   Mon, 28 Sep 2020 08:42:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000478f3a05b05a7539@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.dk/linux-block io_uring-5.9

-- 
Jens Axboe

