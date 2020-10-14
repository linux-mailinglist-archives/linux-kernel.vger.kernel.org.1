Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB4828E4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgJNRCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgJNRCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:02:13 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31DAC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:02:11 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y20so6153844iod.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1FmEIkrqfL0T3fOHDc6OHU2lmhTkM3AhohF3xQ/xB7E=;
        b=nCDOAyyXhiRZZz7rZ9wEUHslojMwI/MOxw3Lqtua2iKHYhXaotVSr69c6pqSs3JDno
         rbr5GpWiK0EIzhRtNZ9JiywfQClnnP2K4YumKU0T1RM048fq9rOlrkCw/hKjK9omGufF
         b7/VGcG7jMw8dHgKIeFxZnexkgwDEQyf2fBRXWWPqLse5diN0XaK8n4ux1Jsp4OImgbF
         BUHvFyPwqLDJRpSHpQXTEi9YJw6YGFmJR3mtFhPKyQXo2ZC5l6zhLLWW7tMIWGg2kz9C
         p/q/mXzv/8HGDQfX7cD8HoderJFuPXQJXMGxpKj8yxJX58xe1QGCWilXPbbc03Dx6GRr
         VJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1FmEIkrqfL0T3fOHDc6OHU2lmhTkM3AhohF3xQ/xB7E=;
        b=XsYzNB7oJw7u4eKa3h+VE51LpxEZ+mg+Afp27guq+MdYQNBppn4r8eK6JQbsMu1P8I
         DM7sSqsB2ld8FmZXReafTLU8DO0Rvd4chze0gPmJkJK5K+4+iJovlb2or3Y5QQsCjIZs
         2Tjg27+suhgTX8CxG8uJLNmRTu/T7Kiv9eK5PFfJSrYuk8VPR2z6xXJuGJDpqfqS70WG
         a78jjS1d1MWpEZ7aiI9KjX6yXkhpV/v89C28gxwxjbF/Jc1sohr6jmGf1/MqoJnYIpNb
         WFeXlUkwz/Vwgeu+H+8tDSSzk/YEh0Cs3CiMmyqc0SHd88sghSAVEwLmZMr6NT6oRwVv
         ZqSQ==
X-Gm-Message-State: AOAM530XEj9lvyNf8OtnSJZi/MuMYnjTMFSOkTBC4m7o5SBODvLtfNkb
        zWbsFia0XEPblA1dXnhhjCubcw==
X-Google-Smtp-Source: ABdhPJzhd+/16ZvJiUYYfs9WNkd1c88ZyLGztYQfhm8605zQRwoONNTABR+sxO8FM05H4pLYKZakxg==
X-Received: by 2002:a05:6638:dcc:: with SMTP id m12mr395388jaj.30.1602694930981;
        Wed, 14 Oct 2020 10:02:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n9sm2447180ilj.74.2020.10.14.10.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 10:02:10 -0700 (PDT)
Subject: Re: general protection fault in __se_sys_io_uring_register
To:     syzbot <syzbot+4520eff3d84059553f13@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000000c3be205b1a4782f@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7fccdc0f-bcd8-505d-f0dd-672471be30f6@kernel.dk>
Date:   Wed, 14 Oct 2020 11:02:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000000c3be205b1a4782f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: general protection fault in __do_sys_io_uring_register

-- 
Jens Axboe

