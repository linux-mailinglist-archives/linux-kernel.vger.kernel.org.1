Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A974276877
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 07:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgIXFlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 01:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgIXFlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 01:41:03 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D6FC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 22:41:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so1194337pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 22:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fkoBO1FI5yRt2a1Tgu6UpQJeSf9UwhcWwaJ1Ch8iZsE=;
        b=LQUs4BYob5yA8ehvdlvrCPc4RIuR/YfXKi4uPLxU/lQ3qLGt4dW5xgYIrdga+bevV3
         Db2df7t7+tFKuAP9e54NEcqnfRvRybD/VNcmaZB3eOHby36CVtT2PiZs2K57TrTbng/K
         nWFLsJGnhysku7xw/Kb/R250ya5gBmz6QZYZbf2WwhRtHCmcPcT4cH/sVN23HTxq9Csh
         8T3Om5zDn1jrnSASWKMuSK6sLP/Nvb5NCxmzAymb7gllSA7pofqx4daVBSiyV0rWj8wH
         p7CFXRzZNrL+ovNbBRI6wfF0rkvgugvBRcIr/bJk0PgXwrovum/XbMta3U9f6k2klCok
         kuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fkoBO1FI5yRt2a1Tgu6UpQJeSf9UwhcWwaJ1Ch8iZsE=;
        b=cJdV6S4HJKDVjmz6mih7okU+FeGoc0EEoAbbYTH7xcatTTZa1BAK3X8aaRRODN3E4g
         nlnfyShiUy0YsD85UZEsLY0n4YYz92zG4wuI7VEDJNMD/HESuPvwmrG7OhjAaJRZCfCs
         wg2CbG0UhPYC1XaE+n87EpJpaFyeZXFLgHKyQjWeh5Si5/z1Sapp8owyo9DCz2y2LGi5
         Zn4LgqwyVy65nFZAhxn3PbE/ADgOQjQQx+cEGnPZwhJ+HK5Nq4N6Bklz14EFXnTXsDqw
         +gL9ncqRaQ1hxUOQl4eMRYZjTlIuWd0BE/XvnUAYYX5ar/BHzcIBdMWYNtE5y1PPsGNr
         9xqA==
X-Gm-Message-State: AOAM530q7iA/I2gVGeTQ+TuxGn66tHahmocpJ8wqNjZC6pwmRq75TwjX
        Ocuxr0q4L4/n28PK3S6Ramc=
X-Google-Smtp-Source: ABdhPJzcjoriQo3VPdrgVmaMF+FXNfZ0oQvAfB9QTVGPpyoGM5FzsLoOpZ8FB5NSoSTXKZPvRsnyXA==
X-Received: by 2002:aa7:9edb:0:b029:13e:d13d:a059 with SMTP id r27-20020aa79edb0000b029013ed13da059mr3016224pfq.31.1600926062907;
        Wed, 23 Sep 2020 22:41:02 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id mt8sm1060266pjb.17.2020.09.23.22.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 22:41:01 -0700 (PDT)
Date:   Thu, 24 Sep 2020 14:40:58 +0900
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
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200924054058.GE577@jagdpanzerIV.localdomain>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200923151129.GC6442@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923151129.GC6442@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/23 17:11), Petr Mladek wrote:
>
> AFAIK, there is one catch. We need to use va_copy() around
> the 1st call because va_format can be proceed only once.
>

Current printk() should be good enough for reporting, say, "Kernel
stack overflow" errors. Is extra pressure that va_copy() adds something
that we need to consider?

	-ss
