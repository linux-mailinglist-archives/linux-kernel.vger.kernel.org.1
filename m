Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ABA29E0FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbgJ2BrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731398AbgJ2BrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:47:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E911C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:47:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l28so1251756lfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVBXOPloV3MHyOZJNF7ZS6bMYegt4BS5YsZsFXz0L7o=;
        b=fZFWZa57uJkj88i0gMBcrwcPQbIDa05ne59E5oeTlZ0Fatsxx6VTjO6FBmGEStfHoG
         CzBcwnj3hmzMpC/y6jQeaKzy5uOjci7CnqFDbHHaJYe6FWdcpQ8ilctvIZ7E/BhQQySM
         +fB16HB8EPjqHjcMS6hh9cvoL87JZUHR7zZCDrtH0B+BrPwDveoFpyYtbP4/y132rtFj
         B8W647wCwWOOlKjNKDnL66w+xtlzgf9EI8Mz1l9kasvXW/EANkMeUQclBkee9aOUZY6M
         66X3K+Y1QBMlK4WlKZk3JQ55Au+YYwQpOeQPJ5mSAP5KORcbvsEQFr6ABa6ZW1D29Gg0
         XT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVBXOPloV3MHyOZJNF7ZS6bMYegt4BS5YsZsFXz0L7o=;
        b=Jx0+nqb9ztevxKFZwevg/RXl3bBu8o01RoYaUlM1QeivkROxKxwVJUHWkY/vjxNdSF
         K3w8pxVxnxvxaQNZ7u8vE9N+GD3qecG8Myh1rQtOVq2aeP2rsKqsDEHI4AXrPThwfRi2
         2F46RS5xW4QP1FvJ9L4fE0VUliSFj0vsWO9fkikulFzKHvi6En/kJWmeSDWubASoYVu0
         F1LBWSMG2D/lHKlRHhUqVWViI+eNF0xXWu7TQWEnux0LqnTtzW6L7LWkOuE9/Ml5jSGU
         zHsXF+trr313hxRJdEOidcLBPWEh5aBqsRTa1Ea8x+IK++keSU+aMp+/w69t3MezZORQ
         rDmA==
X-Gm-Message-State: AOAM5335EmgzpPSZk2rkTJlpvMH+fFCIn2qsp+4KaYc05Mwp3JiKOpEn
        Cpuji+LBVtpdFhG7PBpByy/naTnmPzWyKxI6IosSJC0syoaQFA==
X-Google-Smtp-Source: ABdhPJyOm9LOgfKhOx0dfZcPKFbvflj3nvUGX+9YGJhueQKiIToPbzjO53CHytPzuJjOQkv9L8QNx9yAxt63pLS+UWw=
X-Received: by 2002:a19:ae04:: with SMTP id f4mr711096lfc.436.1603936029275;
 Wed, 28 Oct 2020 18:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201028174319.11817-1-rdunlap@infradead.org>
In-Reply-To: <20201028174319.11817-1-rdunlap@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 29 Oct 2020 09:46:58 +0800
Message-ID: <CABVgOSn6o0r71PPa69kGvBUU9iQojQaQo+vHv96J-iN6Qjrcow@mail.gmail.com>
Subject: Re: [PATCH] KUnit: Docs: usage: wording fixes
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 1:43 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix minor grammar and punctutation glitches.
> Hyphenate "architecture-specific" instances.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> ---

These all look sensible: thanks for catching them!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
