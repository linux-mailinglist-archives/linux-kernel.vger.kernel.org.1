Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260F427F5EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbgI3XZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgI3XZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:25:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0142FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:25:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t7so817488pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xDjCTFpuAGajcYoYQRKav1NGKlBUCU2vGca1k3rNRe4=;
        b=sgW39YT7FReySKVopcfwZWvT5D3KG7q/X/vkUBbjyYyjZaTm1ko3b3NI43/SU/i5T/
         cQ0Hu06XBkfa4B19MUzK1eVU+q3uYRo44yY/8BxJXMSUkJkwd4jCtlkWLGPN6MrEjaPu
         ext7ioq0QeLDmoM8RZTAurip8rfT5zGg7QmV2SqXH7irub3qYSCqriQznx28has9tJIK
         64aePySQbIoylcADP6SkE7Ei9ydfW8qo5N0BsnLwf08gX5obKi57gSW/oGeK3uCe3bXZ
         pB8JJji6TdkrGibj/QQ91v4Zo26XHcgAhiag3LwMhAneOc7ms9/sx9vAHtgemFiPz/IU
         9EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xDjCTFpuAGajcYoYQRKav1NGKlBUCU2vGca1k3rNRe4=;
        b=fL+r4Fq6DFAM3+VJRf8X0iX86Zduqtx8eG3QkNQYVKERMWL2DK90AeeK42zhreHBDf
         +fib8c5CVYVsWkh6fEEZatf8hWe9sZe1doNLrW9hxxjiNqKe9XRvMUkn4oGnyXmroD1O
         XBWwQvQU3TClsBosQLdh49BABlllwKKfoO75v6kOYl7TnRA/VDYy5RgzEqYTJYyoLukB
         4Ja/HwN9ErieYLtUNFYxe2fInEtVdokSkCRNrh9O4roUrPVXOIOyhToFZgh7z7Op0nUY
         xQK0rdVtGe+Q8jJmh9cm9QUVIRUyttZ2vVizkUHL2A/THzwESw3bxgDrp0QRNZTBV7Wy
         FyNg==
X-Gm-Message-State: AOAM532i4FUzZUqr2dn5VJzu3hAA7wuNyL+b75LajswK3/WIo8tXM6dr
        lDd5LpBBc39Ir3CRpmcLUlM=
X-Google-Smtp-Source: ABdhPJw9UeEnHYXJrL66zl9X2vwgTC8BuwcL2zYgQuCRMNHgo1lYDWEib6u2gUH4jwyiOdSHIQj8OA==
X-Received: by 2002:a17:90a:2e89:: with SMTP id r9mr4724974pjd.82.1601508321459;
        Wed, 30 Sep 2020 16:25:21 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id c201sm3908847pfb.216.2020.09.30.16.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:25:20 -0700 (PDT)
Date:   Thu, 1 Oct 2020 08:25:18 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 1/2] printk: avoid and/or handle record truncation
Message-ID: <20200930232518.GA496@jagdpanzerIV.localdomain>
References: <20200930090134.8723-1-john.ogness@linutronix.de>
 <20200930090134.8723-2-john.ogness@linutronix.de>
 <20200930094316.GB987@jagdpanzerIV.localdomain>
 <87imbv1s0d.fsf@jogness.linutronix.de>
 <20200930112836.GC29288@alley>
 <87ft6z1oe7.fsf@jogness.linutronix.de>
 <20200930115307.GD29288@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930115307.GD29288@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/30 13:53), Petr Mladek wrote:
> 
> Anyway, please do so in a followup patch. I would like to push this
> patchset into linux-next ASAP so that the robots could continue
> finding new bugs.

ACK.

	-ss
