Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB02940B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394786AbgJTQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387937AbgJTQmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:42:19 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC075C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:42:17 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v19so2534054edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0Me8GLYPnUizRcS83SCdg5n9DP3MyuxXWUGsX9kdwo=;
        b=tfuJ2Gp25HcoLn6vQzFg/FlpBDVrTJM4WZSgfzcc71/zuwb0Z8cOnvVDcVg7AvWetz
         GCQc0hSrAqL9XyYGWEdE/WHErNG5NwiM5gYRiS/Dma7YyZ/uKKX0UQEqHNOvUsToYLEz
         gKcG3ooORmkHxsVLC8HexjR4k1Iznz7r+NHxCur1rf47A9/IRfzPLMW3d2G8bvCcT2ua
         LC6mV4VONnO5tXddBXbeMhC7r6Dkb5arC6K3ULSyW0F38DmQpJCAKkbfL8iqCrcvV/Ow
         nKYxKk27OmxwFsD/yIPmnbHjMCB59eESmtQhAD9oGOfpAr11KUzuq5JDZ3PzBnCnMGHt
         HqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0Me8GLYPnUizRcS83SCdg5n9DP3MyuxXWUGsX9kdwo=;
        b=RUdMlJ+LrvbI2lTIas+gLksPaKY3SSL0U5UKFSoCTh/3bfpSdmdWvpTspxTCPBrDCk
         CECjdNYK5QVYpZePkk4lcFZbXpHl+bJ/AjpHTVvFVua8MVJnltwRWM0dCCbZ0IHtd/br
         iQT51JHVgnVUCEt7rplR8SIGFcT3+nvKyL7c7kRZVHQZ7jt6QR08RhtyvY+e2WYUV+PI
         x7fJZN8rjABfJGsV13Jv+/JRPqUk6Ajm4O9VwBYFr+4mPN49khJb6lDrW7F6ou4wfFiS
         /+JaQieXcvdh3aNT7hd3N43234GVMhW4MfMVxt910Wv6knWLsAkcSZIzoFqNO4tY198s
         8TcQ==
X-Gm-Message-State: AOAM532tveCj0GGaACSIBuKZj6jG/VGKsIhw1ETbJHBcs/LjjyzBvF5/
        bWa8BLyI4liEvFIDC7KjzlFcKzzWyfs7ZawSTAoG9w==
X-Google-Smtp-Source: ABdhPJwmj1gLFyiZCwLnUyczZ5AtIrV1PckIn++9ZnSSTXEbEsuDOOrXLOt8ass9IoAu0owy+lwv/OR68pPkcbeDkWE=
X-Received: by 2002:aa7:c390:: with SMTP id k16mr3866300edq.40.1603212136160;
 Tue, 20 Oct 2020 09:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-14-samitolvanen@google.com> <202010141548.47CB1BC@keescook>
In-Reply-To: <202010141548.47CB1BC@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 20 Oct 2020 09:42:05 -0700
Message-ID: <CABCJKuf8=2A5fAY0rEZAWBw7q-PO8iFvmubGy4bj6GLZ7k8c9g@mail.gmail.com>
Subject: Re: [PATCH v6 13/25] kbuild: lto: merge module sections
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 3:49 PM Kees Cook <keescook@chromium.org> wrote:
> In looking at this again -- is this ifdef needed? Couldn't this be done
> unconditionally? (Which would make it an independent change...)

No, I suppose it's not needed. I can drop the ifdef from the next version.

Sami
