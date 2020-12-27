Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B682E32A5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgL0UBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 15:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgL0UBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 15:01:11 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B514C061795
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 12:00:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id hk16so5360032pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 12:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCyTtxeQ/2wD8VxKgYKuPRRB6ZhCqK8ijOpnQMPS1DI=;
        b=cvqQ5l2UZ7Nt2IS50m3j7Q0YL/BSipq714qbez8/6cZoo9FZa/R2sL3+j5LA5md+8q
         HCX6enAqtGIq3uD4Jhjq5Vsp5gkPRBwKJVpwQgHLPbxp4PZrf0zcYChSNfXqEfmTK7Ho
         LG6GmKmzMDo7BMZvQfawWf1yLCbk5PTIeNJLfvQIMyc58W2PYsRz70iOG21Fv0iryyAV
         ZUxpYGE0ydnwyc55l5hyGKKWibqR8psUdELb0feIJGKtR0+dc5Sdhsgofs3nmsLUEwrR
         p1aBri+jaR/r/IeJmM0Q0D1rdUVgl19E4+DLPF/6E6oaKBhcEqrCyXBDpbRHu7t4Fs6U
         s4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCyTtxeQ/2wD8VxKgYKuPRRB6ZhCqK8ijOpnQMPS1DI=;
        b=jgSU1blMHz/0arAc+2UnbCUrdFDj2ZLM7NGbg6ggq3xFPC6a90h/eZlDCDvkP5ShGZ
         vqfQrHBvnsZlFqA0qIJPoegqSiEnQio3NlGf5dc0CGxUq0wLiGfRjoeKnpWcuFEhj2C/
         J7czB8/DFCJ6Gc4clJ9fp2wIYEOUP9n0/fXE9j9HLe3TY/cEppIFwcpEIxQ7cFp42IIN
         Q7KlE+Py6b07PLw13U99Ha8aIefFCkAygSLixU+oARy2pw9HXoa5PuQzOueE6FleESMK
         NxaLLkw7ylDiGxYGok6WdgIR0eMx4bdxMga1c+8C256OlyyzSYMfdUZctoZrvhb6cIWH
         cTAw==
X-Gm-Message-State: AOAM532yYIX8nhHXgU3NV3g+Y5+Mp3RK8ibzpI+uEKQczdjAxscg3gyT
        iTl2gZ1TvE/FYuYcxZydimYpaSBcAHwFifzcUoSXkw==
X-Google-Smtp-Source: ABdhPJyYBl0iV8pdPVZtEVH/YOfuteMorhbLBFfcQ5BRBSId/DsaO6b6KEQynz8zit1oDdXra/faGuZIlGRAm1aq1LY=
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id
 x7-20020a170902fe87b02900da5d3b4a84mr42465536plm.51.1609099230919; Sun, 27
 Dec 2020 12:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20201222073900.3490607-1-davidgow@google.com>
In-Reply-To: <20201222073900.3490607-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sun, 27 Dec 2020 12:00:19 -0800
Message-ID: <CAFd5g45i-x5itqnLQe1tikSVsycF8HZcJiiKiJ-SRo4D7b9dxQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
To:     David Gow <davidgow@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:39 PM David Gow <davidgow@google.com> wrote:
>
> kunit_tool relies on the UML console outputting printk() output to the
> tty in order to get results. Since the default console driver could
> change, pass 'console=tty' to the kernel.
>
> This is triggered by a change[1] to use ttynull as a fallback console
> driver which -- by chance or by design -- seems to have changed the
> default console output on UML, breaking kunit_tool. While this may be
> fixed, we should be less fragile to such changes in the default.
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e
>
> Signed-off-by: David Gow <davidgow@google.com>
> Fixes: 757055ae8ded ("init/console: Use ttynull as a fallback when there is no console")

Acked-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for taking care of this!
