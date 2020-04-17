Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0661AD4A0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 04:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgDQCzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 22:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgDQCzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:55:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C885C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:55:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a81so1369030wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DibPFFhioacuiAlJY3PMsjdrjXFMiXNDUjStb6tKak=;
        b=eDmuq3YRYdXSRscLvXyn8vUlhMUSyz7Te4LydPmgbbUKHLm+qk0PQHeIzhB4n4Ig3g
         6odFjxYoe30guB6JQChzldUuA18w/rA7cXfSsVEsMWyxeRPHzGiBhVMyqimhUZmnRjBo
         NBChvvzlDGzHzwcxdJbtG3IWFqc/F0+czJ4Up+1IgZUKj+RKhAIix67B0uH9vKMDg5Y6
         RvJcg8dgReOsBhlNciVqliEJ5NsHZOeHKNJJa0yrMSnU+J766LTUS6thr4ooVAKjC1W/
         s1EzOVP4B6I2wQQsIYAmB2mm259xXGB4ilXEfdW8XLviJUMAh+Wq9DhxMA6zJ72C462j
         atnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DibPFFhioacuiAlJY3PMsjdrjXFMiXNDUjStb6tKak=;
        b=mXDaMEPCUTIJ81lp3NpoZ977aDzvkgzW+hHfla3kI5On003o3St9IXnSLRRe6LLwgs
         4lwlkI9qgj5ziWjAmRkPDZAI0ooLHLMbcYrjJN2NpUTtKmA2Lxe3ZCWmqOBZROXo0JpT
         VnucZbbIsAIX5ckjUZ8V80JugH7XQyUWGvpEISEV8ZuvsRWVwFFRx/jAfA2q52o/Ry8I
         cn3iKlIKBexD6zS4YRBz0CJW2V5arIiiO1B3ZkENnBVLwigpouwp9opmYlBGY2/KhMuC
         wwNXFhOZ3XD4Ux8LOidhREug0l+8pGsQVSn+lSxysLGw4QT8B/qyFDuRhpcx696EpYOJ
         Ex/Q==
X-Gm-Message-State: AGi0PuZTInnCEMcL0ItllKGB/YE2iTZ9gv2KaeasrOo2WldtawDHQnS1
        QaPTTZwPamD64vexYcIooClRFw3F2ubHKOKnqsgc67JyVZr9BmuE
X-Google-Smtp-Source: APiQypJgPv2/C5+rAeThaQuCvauiAhxBD3c0FGqHKmy6F9qUYcHVGK2/1/0T3pR3cey6mxaJDGqS3F8P10mjk+JFk7g=
X-Received: by 2002:a05:600c:4096:: with SMTP id k22mr877991wmh.99.1587092145594;
 Thu, 16 Apr 2020 19:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200416114256.226329-1-elver@google.com>
In-Reply-To: <20200416114256.226329-1-elver@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 17 Apr 2020 10:55:34 +0800
Message-ID: <CABVgOSniuRdx1KjMLTZCJ3gWJo7rsrotpy0yfDhRCLqbjmgp-w@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add missing newline in summary message
To:     Marco Elver <elver@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Alan Maguire <alan.maguire@oracle.com>, frank.rowand@sony.com,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 7:43 PM 'Marco Elver' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Add missing newline, as otherwise flushing of the final summary message
> to the console log can be delayed.
>
> Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
> Signed-off-by: Marco Elver <elver@google.com>

Tested-by: David Gow <davidgow@google.com>

Thanks a lot: this issue was starting to get annoying, and I can
confirm this patch fixes it for me!

-- David
