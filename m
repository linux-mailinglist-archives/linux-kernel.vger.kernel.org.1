Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0439268847
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgINJ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgINJ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:28:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9299C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:28:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so11061623pgd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gaHzJUlcPEUbldPLL23PBzhgpnbfzZk2ff3Q0042ANQ=;
        b=RMrHs/YsRTLaPMxh9KZMvquGOyVuaERbHk2qNFQ2h7UNy5ZwuKG1sTkpynHqJXTfzo
         TzhQKt7waU/hqtTkcg7AMTPM12SYr90UOfLT8eoC0DecT14APoXeRGhq/4080ZTQ9kfj
         fpXMLwVzSNDx+aG0gthbm+sfWtLi5aTubJjg1c6qKMHPtPL57Bkx24XWOIgExS6KCViX
         nUmUm6ufHPp1BK+mK2MGXI2K537Zqh4aMGu91xL+2VzF+k/vGEx3qA1sxhmf8h1La42q
         0mq7fLbyFfT++qbRWnDKPkqxMua4jSGa0NaH1CoM5Dbv6mDQMP5roapAyk2lVx0pUhUp
         8KXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gaHzJUlcPEUbldPLL23PBzhgpnbfzZk2ff3Q0042ANQ=;
        b=mv4lkYU77C4mKN3XBx+9cX6iERH6IzOqFRyqu00B2gAC0MkVXq14Yi64r5DgB8FtDP
         AvnYKm4Rv83O8MYArzjkpY724ahIvcVOko2433NucwDTPUqfXXxAwR99qVQZr7EQ8dYn
         j+VUaE5p2ePv8ov3M3aCt+3UrhS4vndAhMQkEHJrjv676IrIMYcsiYdRPx04OIsMJPML
         QHrsxRbnW95+9I//jN8DNH8PDdk5U7k1cL2X0DQurAGaKjiGDnNMg94gP5Qw4IRSxEo8
         /q0uzWGrIxv+Pw4oHuVHhgkr4oZ8GI6qN2+QzBDjEVpSJO7n7QsndKo7bQbG/xOHg8KV
         zfpw==
X-Gm-Message-State: AOAM533HnAHBRQ+Hfl9wZ3093ydAx66uRPTA3v3jXLAqykdJ87ErHgZS
        CxvWMBkEmU2wJbqgD+46z6A=
X-Google-Smtp-Source: ABdhPJy+7cu7XcOgIfYC7AKbqoFlh0eliFyWPXjATrkGz6IaV+Hc83cVcoJjDOOxiVdWIVUKc42mMw==
X-Received: by 2002:a63:fd11:: with SMTP id d17mr3596246pgh.213.1600075723346;
        Mon, 14 Sep 2020 02:28:43 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a27sm9775023pfk.52.2020.09.14.02.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 02:28:42 -0700 (PDT)
Date:   Mon, 14 Sep 2020 18:28:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v1] kernel.h: Move oops_in_progress to printk.h
Message-ID: <20200914092841.GC535@jagdpanzerIV.localdomain>
References: <20200911170202.8565-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911170202.8565-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/11 20:02), Andy Shevchenko wrote:
[..]
>  extern void bust_spinlocks(int yes);
> -extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
>  extern int panic_timeout;
>  extern unsigned long panic_print;
>  extern int panic_on_oops;
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 34c1a7be3e01..f749a2c2e7a5 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -12,6 +12,8 @@
>  extern const char linux_banner[];
>  extern const char linux_proc_banner[];
>  
> +extern int oops_in_progress;	/* If set, an oops, panic(), BUG() or die() is in progress */

This can also become __read_mostly, I guess.

FWIW,
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
