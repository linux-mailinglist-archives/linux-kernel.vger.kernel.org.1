Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFF92150E1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 03:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgGFBVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 21:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbgGFBVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:21:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60EC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 18:21:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so17634366pgn.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8yvQ48jePvSkpNEOiKywOlcwgJYBDKGMGlLh7bQcbxY=;
        b=F4CXDtLy5SDTAqh+FkUui2v2kyxo6W8b0CK2JM9q/ZhluIHz4NdY3uuU/a39UbCpq9
         +mGWMUF4RxHkOMVo59KHhJI0O1d3+/IulpLFBNzxLysv74yl/AACzAi7ptOpuBxrIUBS
         yPa303MHMZuFP0EpmuF1Db9zI3LVAp0BCyIL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8yvQ48jePvSkpNEOiKywOlcwgJYBDKGMGlLh7bQcbxY=;
        b=WVzMdRwcZbk31m2c3g+I364f8lfNCCbwxNmDjE4ci5SGbvAQJxPgUM7adM1QZL8wRp
         8UZxB8Gt6JQvuac9/zrzA6WDKbdyLOdSl6oYFVwgdcZZlZLrJ50zyT9kMeYwNxcigjve
         RY/Xkzue8mZtGuyd/seRJ/zRMFGJJ8BkFwrq6QTWOWr/adw6KHDcszSmjJPw4KkPBxxz
         Jd5iJngR9XY1YFDFCm2Gm0JgLPpMD66SwLv9E1EEPRZCJAFIYsyBw5i32vrwlWDtQjh7
         qoOvSDhrZwUKShvR+KdFp8SkTi5cO+TXitUuV2Jv8ncZm092vtZ2AlFm0BiYUWrJicqO
         a1Eg==
X-Gm-Message-State: AOAM53371JOdBHk/rNR/y+DTZiTbwI9Nc/f1je7BT7S+obDl31M9sEal
        nipNvMSlLXtOJQiDP/pJ6Vg+ug==
X-Google-Smtp-Source: ABdhPJw2aS5EG4tZqSfuBN9OitoGgrKm2rWv1SK6aPwvfZgPjFkoOEENMcwFcvlj4KcxXQ5msr5oNg==
X-Received: by 2002:a62:7f55:: with SMTP id a82mr33627421pfd.61.1593998501873;
        Sun, 05 Jul 2020 18:21:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c15sm17344475pgb.4.2020.07.05.18.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 18:21:41 -0700 (PDT)
Date:   Sun, 5 Jul 2020 18:21:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Subject: Re: [RFC PATCH] riscv: enable per-task stack canaries
Message-ID: <202007051820.DABE7F87D7@keescook>
References: <1593958397-62466-1-git-send-email-guoren@kernel.org>
 <202007051336.C9EA0ECF65@keescook>
 <CAJF2gTR5Fc1wpjr1ZYZikS=hCP9rbjJVsH9b-z2nBxbBcfBoCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTR5Fc1wpjr1ZYZikS=hCP9rbjJVsH9b-z2nBxbBcfBoCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:01:51AM +0800, Guo Ren wrote:
> Yeah! :) I just want to show you, how about the format: use tp in gpr
> to do that. The format is similar to arm64.
> 
> tp is the task_struct point in riscv.

Sounds good to me, yes. Thanks! Is there anyone looking at the GCC and
Clang sides of this?

-- 
Kees Cook
