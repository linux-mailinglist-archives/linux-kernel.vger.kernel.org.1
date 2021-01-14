Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91B52F62EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbhANOSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbhANOSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:18:31 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13850C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:17:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b3so3433500pft.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TUqVQi96EK+dsv7ZpTs3i5ezF3CKz51Qn8A0qRMbjZg=;
        b=H5bW/HxFxvKNTnGrVgd11LyE/qj6cpA1+NqnmqkeJwnX2K12tZkxT6hH2QwC7BOoIT
         g/vDzp48OhAoQp7RCDsfwhAUuS9n7XxKVJiq7duPjJ++jgJ7nwVW3Fhl8ikBxbwB2Nsb
         lCxQqDK+wXZDnaYn6xNqNfSPlj3bDJ4fdoEREZSIxAB8T8VPlkxjnDS/Q902eLbpaORl
         uWcxxROjI1yIIKuR0zPPVcXsp91scXXIRxzq45Whnb/z4j4J4JFQIy5x+H8f1WAHGdml
         SNETZKW3iAtGxcONUerXVA8B9CkVjc/KpQmwVXMcUHYWyIBs1k7rfdzriqEGoFHwVqEP
         wFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TUqVQi96EK+dsv7ZpTs3i5ezF3CKz51Qn8A0qRMbjZg=;
        b=Eg3sFDGjesVT4w9myQ7S7sHBa5PIKtAcwdYZE57uQ5Dtd+XPPsh7wehcSOdKtkwvjw
         +OAP1j7IeZ9XyfPIvoyqdHrdvUJvCW/DZNkYL3T+ltXxerLx86I9YDXATYb478mcFj4e
         PuHtJ8h4pST8MVoPC0oCjljXTmet/jqDOcS3KIUJD17N18YcsRxJTAaxA9oLc6x/sUtu
         RHDkGfZtW6cALE8LE9GlBk1J9VuZU+hWz8Jq4bz4vtTwHJ2pt67+Hvc9XW4D3gGfifmx
         kpVbSqIS2R7vcHowUHMwuaYDkv1oi7SRiRzEONSkbJ0rru5OxcihTTD/x4a5GjFM4Kwt
         pYFA==
X-Gm-Message-State: AOAM533vCotwpBUsYWF70nQGXcix/CDupPKz/liiy9tVOX9060m6aCe4
        8AFtoci6dO1yAD0n7eeAdk0=
X-Google-Smtp-Source: ABdhPJxb/Ez6uSvU0SH2P2Sl3HDPCRi204o0Yase2SyBvrDVVutI6SHQaHnpO9rf1I5RpetxmxnUVQ==
X-Received: by 2002:a62:2606:0:b029:1a5:a755:5568 with SMTP id m6-20020a6226060000b02901a5a7555568mr7531541pfm.65.1610633870625;
        Thu, 14 Jan 2021 06:17:50 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f580:e184:1fc4:9744])
        by smtp.gmail.com with ESMTPSA id v15sm5236863pfn.217.2021.01.14.06.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 06:17:49 -0800 (PST)
Date:   Thu, 14 Jan 2021 23:17:47 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: ringbuffer: fix line counting
Message-ID: <YABSi0zOyQRm7CTZ@google.com>
References: <20210113144234.6545-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113144234.6545-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/13 15:48), John Ogness wrote:
> 
> Counting text lines in a record simply involves counting the number
> of newline characters (+1). However, it is searching the full data
> block for newline characters, even though the text data can be (and
> often is) a subset of that area. Since the extra area in the data
> block was never initialized, the result is that extra newlines may
> be seen and counted.
> 
> Restrict newline searching to the text data length.
> 
> Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
