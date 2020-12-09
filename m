Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FBA2D3A94
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbgLIFcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgLIFcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:32:31 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64C7C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 21:31:50 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id z12so266139pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 21:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CAhrHJujiJbnBggCaG/TM41zPrRXkpHsQ9/eIUtvdRQ=;
        b=mSxLGln7i3SR8XHeE3LQu8f7Ko85o07RN0eruILTXrx/TdrWkAGn0uHv5zihHIoTkq
         M0ac6CLtm34bkCtxMsU/tq64GjoTHp6WQvKqakkaLLUGJY2N91GZ/FtTxC601u5Sy3t7
         2t8XbyAN1sA2lhre42bzM2+9y8VRkIRrteZIBKMLhnCcb7ibJxk2gLawufqUdk8bS21G
         Yp8IWrbkAd8W/D3Vh/sYIxM+siw4OMkfk3R4OLCB6LrtwNPTjLXLvp8EMSpgI3BJqj/9
         yDcSXA0PZE8Gbx4dGAJr/a/Tcl+G5IRG82W5tum8g2JgJnWf68BFN019KCSDDEsJ2qM0
         4dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CAhrHJujiJbnBggCaG/TM41zPrRXkpHsQ9/eIUtvdRQ=;
        b=bs7w6d61TVChio+Eh3dR39P4G6FK0b6rdB984o0jyVIqn0f0Gs7FVQ1gKb/NPFIr2G
         Ihuk/8Bx5lkNWyf+kf6cPCg9nJohizN5T2An77M/uiyxlOkFMG6q57yD5XI3IYRJa674
         mmQDCdSyBBLZprQYytw9KctxGomXCILWttRps8NqIntHBSKYrVmzuKa0+tZWPTDa5xKe
         Y15fDxGJJcYIb07dkGPG05SNupLjZH6aHX0KoAQUBwXkYUuWs3tfNeRGy/jo5C6Jr/2c
         Y8fUOOo0So4fVCMbVg96JtgUVDxGhg/36bq7vK3yd5GT+H0oqde+3ZXc9yUZfC5FaxGH
         LINg==
X-Gm-Message-State: AOAM530r34cZjubsAKlpQzbdYrFLuTa2kcLGSEGmcWPFDkYplzIj9mBB
        nu2zIHdM5hSsUklcQvrzD/Q=
X-Google-Smtp-Source: ABdhPJwQTrfZ7rwbBFDTx7Ur1uv3KDPab6m0e9w8rnUyipbUm1J44m1vjt4xw14coIyrnqnkugeMhw==
X-Received: by 2002:a17:90a:c306:: with SMTP id g6mr746582pjt.104.1607491910044;
        Tue, 08 Dec 2020 21:31:50 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id r185sm731184pfc.53.2020.12.08.21.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 21:31:49 -0800 (PST)
Date:   Wed, 9 Dec 2020 14:31:46 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v4 2/2] printk: remove logbuf_lock writer-protection
 of ringbuffer
Message-ID: <X9BhQjqQLhIw2lU3@jagdpanzerIV.localdomain>
References: <20201209004453.17720-1-john.ogness@linutronix.de>
 <20201209004453.17720-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209004453.17720-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/09 01:50), John Ogness wrote:
> Since the ringbuffer is lockless, there is no need for it to be
> protected by @logbuf_lock. Remove @logbuf_lock writer-protection of
> the ringbuffer. The reader-protection is not removed because some
> some variables used by readers are using @logbuf_lock for
> synchronization: @syslog_seq, @syslog_time, @syslog_partial,
> @console_seq, struct kmsg_dumper.
> 
> For PRINTK_NMI_DIRECT_CONTEXT_MASK, @logbuf_lock usage is not removed
> because it may be used for dumper synchronization.
> 
> Without @logbuf_lock synchronization of vprintk_store() it is no
> longer possible to use the single static buffer for temporarily
> sprint'ing the message. Instead, use vsnprintf() to determine the
> length and perform the real vscnprintf() using the area reserved from
> the ringbuffer. This leads to suboptimal packing of the message data,
> but will result in less wasted storage than multiple per-cpu buffers
> to support lockless temporary sprint'ing.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
