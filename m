Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD74C28202E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 03:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgJCBjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 21:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJCBjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 21:39:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B67C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 18:39:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h6so1332423pgk.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 18:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h+QvCgCquLIB4PMIfsSI7g6Fcy5ZKMf55mJGCk+rTuI=;
        b=BKxeBRa8DzK0YevsxBG8HJKezJXiRcmaDt5TT9fjnZd676lV9U9Kp3WYiikbZLQTCG
         MsHhzbNT12XBkeupHSevSFUkAUPZ5TV9NQQjVFwO4hNmJWhobiHKQwQ6idmD2XxRna6w
         9Ui7AD3bwIf6mHtJ6DZeoYnIvKBQihrIcHlbhh9lZWRF3p4M9wf2RW7yHoFpZAyb7gOk
         dqAWzNJZVp77PPxTDoxHcRlJ48f9OVq2F7xUKzXiVY4LSWCLRP4REQjb6f5uOWXiG9Le
         uHc8EGTYLwo75lCa/QvjlrN8WTcGEEqpiC3SYyvYfswFG/6srJqkGw/a4img/UW29Rst
         kcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h+QvCgCquLIB4PMIfsSI7g6Fcy5ZKMf55mJGCk+rTuI=;
        b=SBmq0HoWSaN7NYoLvYipO5DLcAaak4x8JFlMfRB1X5lp+ZR4Hb+LtWDIZcXG9yIn0D
         6kPcp0gGBI/tLFBDdJo7w8TXRxFaF06jahdOwPSabm9UeppsNgZ8JR5NDDxzKrbJCGlv
         IKXNul4ebwjmuCYzSr8+p1MyFTnfpmgbL+BFImET20a9/o7uSYWHw20vFNdBn1UxvDQQ
         jC2vT04y5PdOOT9tGZSuRWRxmOkLTSvLTweau2Y3ICehaQbA6eRx/KlijGUPRuCGWg2c
         KCesx42otLy8zi8dYJwFiqlolS/NCQyQRiWbrlWmzzT91sGQiDAi9pWj6uA0M2mZdpRg
         /NBg==
X-Gm-Message-State: AOAM531d+S/OfUCqtvlY58X8imnoCLR3kwD4HgKVNuBvvpwmgC0Y3BCV
        nF4Ae8FkYDlS0iOPXEArrgM=
X-Google-Smtp-Source: ABdhPJzB2sB2tGvXPYLx0+TtzBNtOp8iWqRFjcT0S9ClFoF+s1HLljVCgbIB8YKmCtZ6v2/g2UHAOw==
X-Received: by 2002:aa7:941a:0:b029:142:2501:34dc with SMTP id x26-20020aa7941a0000b0290142250134dcmr5533372pfo.53.1601689155074;
        Fri, 02 Oct 2020 18:39:15 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id ie13sm2895918pjb.5.2020.10.02.18.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 18:39:14 -0700 (PDT)
Subject: Re: [PATCH v6 11/14] misc: bcm-vk: add BCM_VK_QSTATS
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
References: <20201002212327.18393-1-scott.branden@broadcom.com>
 <20201002212327.18393-12-scott.branden@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <55f88956-48ea-08e3-c353-babb08f3a786@gmail.com>
Date:   Fri, 2 Oct 2020 18:39:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201002212327.18393-12-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/2020 2:23 PM, Scott Branden wrote:
> Add BCM_VK_QSTATS Kconfig option to allow for enabling debug VK
> queue statistics.
> 
> These statistics keep track of max, abs_max, and average for the
> messages queues.
> 
> Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

would not it make more sense to have those debug prints be trace printks 
instead? Given what you explained in the previous patch version and the 
desire to correlate with other system wide activity, that might make 
more sense. Looking at the kernel's log for debugging performance or 
utilization or just to get a glimpse of what is going on is not quite 
suited past probe.
-- 
Florian
