Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FDB2FAE35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 01:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404628AbhASAyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 19:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732447AbhASAxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 19:53:44 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8F6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 16:53:04 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j12so2014185pjy.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 16:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mg+Koq9lZ29m0hUxgegkWW5EEE3qCkZDZp3mxHRiqw0=;
        b=LGG5Y1FHLZfLmnClZaLVaul72leJkAYHoBOlxgNpn7H3uAO0oF8h10RjG7NrnnN8t1
         pjZHdijsDqNPhqMRULxkDdJBxatfrN87RkSQEG91pXHowqeIaAmBB833VpH+ykd5Pz+Y
         9xLktuphI65BgGymIt8YOIV+3hzkYkEheRmpvSAc+UN/z9/i3upgD+bQbhLvDP/v+xs1
         3g0DFS3lkDwLecyp2T8OaVp4w/QHK37lxxK7gl0/xnLJWLmQJbw/VDvaeyQpsMFUj0Oe
         aXaSb+sT7V1sMyF7JjucUGJYNuh89syuMnHR/Rl1xcl9jOxb/T5XXYAf5XqRY6fjVT9K
         Iniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mg+Koq9lZ29m0hUxgegkWW5EEE3qCkZDZp3mxHRiqw0=;
        b=ffrIGPWIsX0aGX41oMQPRE3o2NRuuJ5gWH1LGv0XMBlZ4k0pGrhT1JUKBOLR6aR/Xo
         Fl8/coyMBDnJQOB8w8KWV7N4cnCsmezXjX//uubfvk3uoBysO+h321k/ZQxhR6g4Ohbg
         VM2MgyRY/flncozlRnNPDVV03BaW4E8BQXe2+GU5Qjt3gaUX4SD04F1YxjEAhWK3axdR
         RN+FgFW4atXlyMsTKYmHJk6w3jrpSQqUDsliWu41x048jf8sYlMWumPCg1NuKT3MVvpT
         Gw9fG8Xm1wLlkY0RA6c7JDvB8OIClglLD7sg+uL57RSZtd7QCcJaFby4A2zEPGXwiESA
         BdYw==
X-Gm-Message-State: AOAM532K7ODjPKXbuDPQnWrbVFe24SDh19/cKSNplhE7hNEEUUuOFY3K
        CQricVngb9izlfdipreXQxU=
X-Google-Smtp-Source: ABdhPJy7q4KjN8lStiQNvymQ1gOiAbwpDRLg+pJL7opQQfA9UtzVt/R+aVmwwH8fDEqMpBNIezGMxg==
X-Received: by 2002:a17:90a:d990:: with SMTP id d16mr2183806pjv.16.1611017584227;
        Mon, 18 Jan 2021 16:53:04 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 5sm551318pjz.23.2021.01.18.16.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 16:53:03 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:53:01 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/18 13:03), Timur Tabi wrote:
> On 1/18/21 12:26 PM, Matthew Wilcox wrote:
> > Don't make it easy.  And don't make it look like they're doing
> > something innocent.  DUMP_PREFIX_SECURITY_HOLE would be OK
> > by me.  DUMP_PREFIX_LEAK_INFORMATION would work fine too.
> > DUMP_PREFIX_MAKE_ATTACKERS_LIFE_EASY might be a bit too far.
> 
> It's already extremely easy to replace %p with %px in your own printks, so I
> don't really understand your argument.

I like the idea of a more radical name, e.g. DUMP_PREFIX_RAW_POINTERS or
something similar.

> Seriously, this patch should not be so contentious.  If you want hashed
> addresses, then nothing changes.  If you need unhashed addresses while
> debugging, then use DUMP_PREFIX_UNHASHED.  Just like you can use %px in
> printk.  I never use %p in my printks, but then I never submit code upstream
> that prints addresses, hashed or unhashed.

So maybe DUMP_PREFIX_UNHASHED can do the unhashed dump only when
CONFIG_DEBUG_KERNEL=y and fallback to DUMP_PREFIX_ADDRESS otherwise?

	-ss
