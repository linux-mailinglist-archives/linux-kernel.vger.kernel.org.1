Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9A62FEB54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbhAUNP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731671AbhAUNOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:14:37 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520C7C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:13:57 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j26so1420996qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLF2LgcHZ5DDqDazshlamJH0LMkuaN2/iqWq+I3Vnnk=;
        b=cd9OxPlRA3NGn6WxwIGITPEw7+UzXHbPgSZU/5BS7jYp6BYL0OXp2IyBcPE6JlRpf1
         qWDMHdUT2jnZQnGdHaPnkc+I7eMBR9eTp3kfSzZtu055dKw9spDa2ZDP0uXoNDzFsom9
         zzc6Hre3OhsWYZwtNXkoYdBp/s8fVbH1YzQsPY0DVSabehP7mi351ECC0SCpkdOVwPZE
         C3WUKW681ZruaNvJP88MT5OHC0u9XYDSrvP/7ZCPbmzXapinmW2lOqyYpivm3NjCDcNO
         uz2swXoEDM6VgsNTwcWQRwOSHRvi8AW/zhP2z3q9LDeDUHX/NrGSDGNDkOVumnHum+U8
         I7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLF2LgcHZ5DDqDazshlamJH0LMkuaN2/iqWq+I3Vnnk=;
        b=USKb11qh0jEgHvdCZ793kDGukfymxWYNJVskpR6+uDBl0C+iofgb5OUnAqFJ9hLzD9
         RKISADg9Vbcm7RPn07JpF3/Rr6/BN0QPwAHviJ5Lnd8/8ymSFk50kVsrQu8WcjERX8Zt
         oB9Dkw+3OUhwwMus8aAUdhnp/+hVAj4hd3AloTqJXP0qH1DmLxr0fALYZWliUm0WBPCC
         BK2NZDXgjXdAcYWGxyawwunY6vzgtqqFz9oYMBV/vS+Vgle3usQcw4I+BpCOrZfJ+JKA
         VDavO/OKAXk46+WK505BmNc94RSZkmOWuUl0rqqBriC7g2uy7DH3E2Oj75Cb1LJOYIpM
         szHQ==
X-Gm-Message-State: AOAM533dL2tl5h0ps12BncFgNk40FSAoC3GioBkFP49JKF7ioeFmN+ij
        SbnTdMUZOv52ko7MzjpSASub7CeMaVk4OkMRcpMobg==
X-Google-Smtp-Source: ABdhPJwPMOyA61qAapbbCW1TPCBI3hRdcUzarAepbrG9mvi3+kAHKu7qPzTfKGToYHAPCaWHOxIKhwd47U8kAEnwwFw=
X-Received: by 2002:ac8:7111:: with SMTP id z17mr13542060qto.369.1611234836264;
 Thu, 21 Jan 2021 05:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com> <20210115130336.2520663-3-glider@google.com>
 <YAVzNrBIlp0UJKfs@alley> <CAG_fn=UmjC2LOCXRpp+vTZ6nr0M7=dCKjFYgVFVvmqftTkjGYw@mail.gmail.com>
 <YAW6wsuEYe9/Zjxv@alley>
In-Reply-To: <YAW6wsuEYe9/Zjxv@alley>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 21 Jan 2021 14:13:43 +0100
Message-ID: <CAG_fn=VxX10v=g_SyAKkRXaQYOUK1S6BzO3e1K5jusbhomRwUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] lib: add error_report_notify to collect debugging
 tools' reports
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all for the comments!

Since concerns have been raised that another error reporting system
may quickly go out of control, we've decided to not pursue this
solution any further.
Instead, we will try to rely on existing ftrace mechanisms to deliver
notifications to the userspace, and perform dmesg collection/parsing
once a notification is received.
As a result, we won't need the error_report_start tracepoint anytime
soon (I didn't rename error_report_end to something like error_report
anticipating that error_report_start may be needed in the future).
I've also dropped the error_report_notify library and the
corresponding documentation from the patchset.
