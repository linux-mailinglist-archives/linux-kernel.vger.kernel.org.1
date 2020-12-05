Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800792CFAE1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 10:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgLEJoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 04:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgLEJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 04:42:46 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A8BC061A4F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 01:41:08 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id f1so4490399plt.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 01:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YDD8AKO2hwLZeCjZwKKM5uCY10n51t2OVbGyoK51PNI=;
        b=fORnjR2PEjZ039a/Ekr6vs9LZSRTtrsKtY6rEDeZngNqgCeEValdj/QgzknyQw6/iX
         OT9LdPwbJ/bf5+TNagASIlfq2EtWMvBmQ/4FNtmEJZjpksnuRpslO1TLMWodtSQhcWoA
         4l2FLvlSI8c3wtsnplpJ/aNtutpJuPKuJ2U2CqW6M961XA9l+axmq9d/jfLqP+aAAiST
         8q7QwYyj64ZpWdacZuond3YK2isLpatTNEFeo8A18eVTdl3JNYw8rOSuOf/KF8QZQgAw
         DI9Lywlyn8DyfmDDrr7S5qAn9Xf8r1kZYKPKHIzJDMbeRmG/6D62UcgSOVDSuHgaqOjS
         46vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDD8AKO2hwLZeCjZwKKM5uCY10n51t2OVbGyoK51PNI=;
        b=E4A+NsyeZARf/9cx3ncQDAvQJZrUOfaL8HsXfLYKhMzsAcKtTdwCLSW8FxunBtS68S
         W62m3bL45w9fCzrwWy31WrkWHxI3jTEl2yGfvhmzqIFXE+YuIV+iBX7O3qq6S3QhTZ8L
         O+tApnlV9hKBhKU2snHO7a2dCtJ3k6nR5zb/fIOB8BkT8dl20bapTDwiTUaR6wp6jJrQ
         vjps6rwdGPz4w5PvZQswCwjvJ6q3GjJxUe/yrIiqWO592wCbzb5HscTaC5luJVeilbb1
         Ux7UphzdUABj2oPMezkaJotdYv3ZPj/aWMKYo8T2/4mM9j1Y8MBFptfJTuJ7U7nxutPI
         zaKw==
X-Gm-Message-State: AOAM53071CAyCh+gfyCKLkPwEuDM71iZYIWgtI0zu2Yc6v904ROKaIs8
        qkADdS4gyDts05ZWl+Xx0Gg=
X-Google-Smtp-Source: ABdhPJyRnIf2o+EsMHqs1wwCuTq3PA6MHw12A4vwFStZqiREykSofWcZOn+2X4R8GHnrTO4hvxUoeA==
X-Received: by 2002:a17:90a:e005:: with SMTP id u5mr7887650pjy.64.1607161268045;
        Sat, 05 Dec 2020 01:41:08 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a5sm7569714pfg.140.2020.12.05.01.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 01:41:07 -0800 (PST)
Date:   Sat, 5 Dec 2020 18:41:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: recursion handling: Re: [PATCH next v2 3/3] printk: remove
 logbuf_lock, add syslog_lock
Message-ID: <X8tVsaFUwAxsIVaO@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
 <X8pfX/qPBuY360k/@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8pfX/qPBuY360k/@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/04 17:10), Petr Mladek wrote:
> 
> One reason is the use of per-cpu variables. Alternative solution would
> be to store printk_context into task_struct.

We can keep per-CPU, disable preemption and have counters for
every context (task, soft/hard irq, NMI). Shouldn't be a problem

	vprintk_emit()
	{
		preempt_disable()
		vprintk_store()
		preempt_enable()

		preempt_disable()
		console_unlock()
		preempt_enable()
	}

vprintk_store() is a small fraction of console_unlock() time wise.

	-ss
