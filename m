Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F3E2AC119
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgKIQkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:40:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729776AbgKIQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604940001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8CRsTblhXHqnxALqI5jnaNHHWl8AWCLUwL4KBhVIVIk=;
        b=Ah2db9x/H1Dze+zHPSh9GHbOWl6i6eciUPRkQGDy5aTJf8Ey4c1QbphhKk48uvnxvT3W76
        ZAZaeYn4Gn++EyOKJDGeRcHWNuWpaeJbdDC68qZZUfVlRQuwuLhOUCzi02dw3yJQn/MyTV
        XXLjzorR+bBfQE8QI0dIbu3eeuBNEXA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-JXCFNUelNzG983UlqUMbZA-1; Mon, 09 Nov 2020 11:39:59 -0500
X-MC-Unique: JXCFNUelNzG983UlqUMbZA-1
Received: by mail-qv1-f72.google.com with SMTP id m17so4427355qvg.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8CRsTblhXHqnxALqI5jnaNHHWl8AWCLUwL4KBhVIVIk=;
        b=gAt6hQkpf56hhAU83+6qawY/kXhqUT7fq68s482J/vv4PGP0FkOV9RPliXengAIqXY
         pGNVICavBSlNvlkuKOIgklUQcIfjbhQVPaZX0k3YXzdXdZdC4FbjXgivVdA+R73zaUBf
         Batx76PX9m64UxVmHcw1VILTDuvw8oGQOT/tdgK7uGFjNZzFpkv4Fjmkl6wZNs5YWOCl
         7d0J9BmFyZOnqDO1TN+u3ME7Q+l0Fi7nD7TiQjA7vS+HdW0wR7mY/ci79fmmLou9ZpyT
         B+rB852t1twieNwnjh7WVRWnfwZsYVfAPpdOBnlmqKTIvkxgKWFFwYxEamkIt5/hmx49
         /uZQ==
X-Gm-Message-State: AOAM5302d2sc70ZIW92rkXxmthXCOIWhXWU88yyqjEpMaR/ylA8AOTwr
        LxUUXgWl+w8xsIqt65CPZ5dGB3RsmLsKarotDcWa3mkD/3pYEQ9WW+XGJ6FFIC8MTvUZfdZN9+p
        sj5Q4IizZ1znRAuGss5vV8XHg
X-Received: by 2002:a05:620a:140d:: with SMTP id d13mr15079352qkj.470.1604939999322;
        Mon, 09 Nov 2020 08:39:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0Wfp4N7gEbWoeZTjAELrh99BqnYeP+F1Ei5ILbbUA+oDIw4oxWG2LrTgptljXZG7JoQIuww==
X-Received: by 2002:a05:620a:140d:: with SMTP id d13mr15079320qkj.470.1604939999037;
        Mon, 09 Nov 2020 08:39:59 -0800 (PST)
Received: from x1.bristot.me (host-95-246-207-183.retail.telecomitalia.it. [95.246.207.183])
        by smtp.gmail.com with ESMTPSA id 8sm6704830qkb.98.2020.11.09.08.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 08:39:58 -0800 (PST)
Subject: Re: [PATCH v4 00/19] sched: Migrate disable support
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
References: <20201023101158.088940906@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <8defae53-c6b4-241a-da79-16719138baf3@redhat.com>
Date:   Mon, 9 Nov 2020 17:39:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201023101158.088940906@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/20 12:11 PM, Peter Zijlstra wrote:
> Hi,
> 
> The fourth version of migrate_disable() for PREEMPT_RT.
> 
> Two changes since last time:
> 
>  - fixes !SMP builds (bigeasy)
>  - TLA+ validation of migrate_disable() vs sched_setaffinity() (valsch)
> 
> Esp. that latter resulted in significant changes to patch #10. Huge thanks to
> Valentin.

While I will still work on this, testing more and trying to
analyze the effects from the (rt) scheduling perspective, I
do not see any other issues (kudos to Valentin, impressive
review).

Feel free to add:

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

