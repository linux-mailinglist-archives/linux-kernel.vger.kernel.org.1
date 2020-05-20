Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056941DB2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgETMKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 08:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:10:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CD3C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:10:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d3so1254483pln.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7s0+LV72ub/a+786F9odlZ55dRyq5sEXo2G9RCgt8/I=;
        b=ddIf/cCurXvxmYq3gMSu1w93t13vVkRKqKC401hPmZ2fdF5ZqfyWLYaGkEw2tuhfJs
         loefqdYAzxiT00WBLy9ijMDRMkrrUlkQRu6bk1Nh95QCjgGDuM6JKkMJGEzpHjn4TYTW
         goT8f+uvMpJ8t164pzWkOAKeKZzh60BUfc3qySCQL8jsWj6YHJLK8U8K+qxu2MoYAPHB
         SyJtWVTZum4LaR0ayDyCrArDkfbtNF1V+9lUnNEc9aVkiJGwrjyBLlVsoq74mHj1Ph3L
         mOg1CjywCtsT2/EW1zIg9I/Os7nbWs94907hBCNUOqq2Fip4I723VbSWTyjFNDw8EKba
         rsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7s0+LV72ub/a+786F9odlZ55dRyq5sEXo2G9RCgt8/I=;
        b=pxKqfuQ6NvqWsHQRfZjrfY1SHqaXjaV3VgekFZpijMy1JS5srYVxHDjmrUc4p0K798
         juB5kqOo/71FnwiAg86HWFuzVBTITpWzNUK5kbVrhq5OqExA833zdw5wo7Gz7ZQC84u1
         4cKrQf098oaacZcJVx7mNdsquia6u+6+z6wPTQU9jq364V6Elu6rldsm867u8B6NrXRJ
         AVwm81wtJbAI8Lr3N1gVsnpZ4FxxdXI8EfAxeQbNLCjpGr5FTGMYuQcYZsXA7sIQR6o8
         bwlacs9E0q8e8Svn+bT9jAtpERWv/h0sd+wAKg0e9X6oxHmYcpdwjYHTrFhBALXy0BiP
         ktrQ==
X-Gm-Message-State: AOAM5300l/XnVg/W21b5/IS7Cya76AZ5SfNytL5vGoLsWyJcGejEAH/T
        1PLeEYqFetleYQkMhpXhUTg=
X-Google-Smtp-Source: ABdhPJzi2bBmc8YGAITrH/1XYI3jcl6BANyQRxyQmioxkQNJWm7A4uip33O3jSynTRNaEIMB75dVZA==
X-Received: by 2002:a17:90a:2305:: with SMTP id f5mr5087883pje.57.1589976602794;
        Wed, 20 May 2020 05:10:02 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id n23sm1952562pjq.18.2020.05.20.05.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 05:10:02 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 20 May 2020 21:10:00 +0900
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
Message-ID: <20200520121000.GF520@jagdpanzerIV.localdomain>
References: <cover.1589916689.git.joe@perches.com>
 <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
 <20200520044127.GB938@jagdpanzerIV.localdomain>
 <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/19 21:58), Joe Perches wrote:
[..]
> >  Maybe we can
> > use here something rather random and much shorter instead. E.g.
> > 256 chars. Hmm. How 
> 
> 	min(some_max like 132/256, PRINTK_LOG_LINE_MAX)
> 
> would work.

An alternative approach would be to do what we do in the
print_modules() (the list of modules which can definitely
be longer than 1K chars).

We can split command line in a loop - memchr(pos, ' ') - and
pr_cont() parts of the command line. pr_cont() has overflow
control and it flushes cont buffer before it overflows, so
we should not lose anything.

	-ss
