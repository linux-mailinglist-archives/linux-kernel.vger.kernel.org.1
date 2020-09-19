Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7A9270A6A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 05:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgISDhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 23:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISDhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 23:37:07 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E72AC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 20:37:07 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z18so4096653qvp.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 20:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=toq7L4SsqCXQkGluRvxqWyOqRcCx3zVe/9m6BQKiNj4=;
        b=NKq5xsKRFFkUHwl4DGXnrrp/G1OqQNLCxeoEYtd0u6KVQvJmo60LvKkqWkoHSPwTLn
         yoXHS+ZksyW9w16cWLkyQEfj2mXUgNvLBZKqwBMNgqve+HPqpOpMlDzoGY1755W2snyE
         uEJB2ArbcoEQNqUZ/2DLQ5c8nCp62P0YxMuC97EAt+ieVfbz4dgTAiU7jW1yZcWwTkB3
         D5D20Q1EyxEpHzusUSIguH2YPeHLUTsB2i6cJOsIiwToNshBr1vfj2AYZb9y8Lo6kCrH
         W8UfBkshddz5zOINqaZSJOr7haVapA5LWMu+Kc70uES3L03qSJG4ZTqeuQUMwUBxXlJA
         m/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=toq7L4SsqCXQkGluRvxqWyOqRcCx3zVe/9m6BQKiNj4=;
        b=ctDkpa97oP02hm/EDGsU9HVajscn+TCJ9A1ze3S60Afid4ZqJiWdadPW3aSWkinKxb
         h8N7QZIDC3ezpZ1z29sI/BSK5gZxuPmT0Si1vaWJltGk+1vm6+z1fVbjrxBPV5e6u9Qp
         B+KtiCPX7KNcExjd6wn89O1MJBX5mtG5f7+oVh5qgZA8iNipMMMMFleTBpIvnlgmdA1A
         slT7CnJBshpCOhStD9ii1V1gt8MfSAlRFgG5x7U4OQWlqUI0bXtcfJ+D5IYbYEk1svZH
         6ZKqkNIbLXhnN79yXxW7Ld774Rqk+RI2ZyCPpLEsSLI+19TUHqQ73MRQEApWrI48njxV
         5xFg==
X-Gm-Message-State: AOAM533oZRxA5Va1mI0a0mlvj+TpeZ/FeEB68qf1M5tl7r7drJlN4RVg
        f6ZsyhrEiBWytrcislzw6ws=
X-Google-Smtp-Source: ABdhPJwEvd5oJAbcEssSmMyzVbLa0P+JOVCKw+dATnM3nOQC1r/DN9pd7rf1itdoheKAEa3WaO+1Ug==
X-Received: by 2002:a05:6214:601:: with SMTP id z1mr36881818qvw.0.1600486626503;
        Fri, 18 Sep 2020 20:37:06 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w194sm3400318qkb.130.2020.09.18.20.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 20:37:05 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 18 Sep 2020 23:37:04 -0400
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
Message-ID: <20200919033704.GA3014163@rani.riverdale.lan>
References: <20200918193426.GA15213@embeddedor>
 <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org>
 <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
 <20200918202909.GA2946008@rani.riverdale.lan>
 <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
 <20200918210050.GA2953017@rani.riverdale.lan>
 <CAHk-=wgyKF9vnac3mw6v-Bo5D8X-rcrkF=BsZ2jX+OveGkGgBw@mail.gmail.com>
 <20200918223957.GA2964553@rani.riverdale.lan>
 <20200919024556.GJ32101@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200919024556.GJ32101@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 03:45:56AM +0100, Matthew Wilcox wrote:
> On Fri, Sep 18, 2020 at 06:39:57PM -0400, Arvind Sankar wrote:
> > On Fri, Sep 18, 2020 at 02:18:20PM -0700, Linus Torvalds wrote:
> > > On Fri, Sep 18, 2020 at 2:00 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > You could just assert that offsetof(typeof(s),flex) == sizeof(s), no?
> > > 
> > > No, because the whole point is that I want that "sizeof(s)" to *WARN*.
> > 
> > Ouch, offsetof() and sizeof() will give different results in the
> > presence of alignment padding.
> > 
> > https://godbolt.org/z/rqnxTK
> 
> We really should be using offsetof() then.  It's harmless because we're
> currently overallocating, not underallocating.  The test case I did was:
> 

I wonder if there are cases where we know the total size, and are
working out the number of elements in the flexible array by doing
size - sizeof(s).

Would a macro to do the inverse of struct_size(), i.e. get the count
knowing the total size be useful?
