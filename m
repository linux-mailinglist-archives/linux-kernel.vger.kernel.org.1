Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676E124E908
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 19:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgHVRau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgHVRas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 13:30:48 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C48C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 10:30:48 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e187so2817408ybc.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDk1uTkzBrobW1w/NKB0oMWkQcelQXY/S6aVRrAX0ZA=;
        b=dyCpYQrxZN93H1AZy0Svu15URVWoPeG7t+Bjh405njPSC+q6aqdkS/8H/dJChB+kxX
         whnTVWTCOFzgZGQ3lqwsivukNlwOwYS10yIBa2iCcpKlqlifHV+hF3o+tpuxP8m1Vez9
         tt2xfKXXvTYFk6sNGaCwM5y/XWvyLTsrrXwfBQjtWT2euwkPyLLi2XzVljG7somyHg44
         HI4vV/ZXhA6msoH0Uj0HOQdA7SivMo2hPfjMRFq12ND1Qd6I9YI8uPsCTsct6dD1MlSN
         PSAQdI1+dqSmrDRRhWgDkOkGdCsVYXynn3H1xBiKuC3dsVM5FN/yeh0g7yU6lnIbIa5y
         YV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDk1uTkzBrobW1w/NKB0oMWkQcelQXY/S6aVRrAX0ZA=;
        b=Zc+7x2zw7Ifl3F5AsCz3Zd6YTc0wQVdJYMzy/GMqI5w/U82XsNNqamvjD69dz0D9Vs
         oxSRw3n7+Uypo88idakH+K7NKmPodoTxF/EB1B9QWcmWQfYJxVwOaW/4sy9gGe2qVc3P
         5ZkzVqBI7HwZGdPJsOTS7hytEwNm8RJNNeAsc9fZOykQneFgATMjcpoKHP1KZrUnqN6z
         j+sn7coct3bitGq7p/k91Sq3WErMiY+M49kQGJqgPKGzrkUG2JLu51EnyWg4sSwXQ1um
         GNwYj4UWFn9HlUaNEVw/wkYgTo6Qb4dqcjULZ7Z7hzBnP+hZaSAHmCBsBnzX3+Csrsnx
         e2ww==
X-Gm-Message-State: AOAM530DFcU3AKB6XH52FhbvTYmmntpOebKavoPE/SplRAt1OmH5gU4E
        f6sYae/EojoqNHHBDzzvaigtGcmdMctFtlnavRA3Aw==
X-Google-Smtp-Source: ABdhPJx6OI5qEcfI3wAi2qnLIinIWm8ZhOM7frPW9ne8dpaYB3ssb0hlJOW/CYwILyYDgT8yZDdMqrVimTKgGB+5hAo=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr10605839ybf.162.1598117446875;
 Sat, 22 Aug 2020 10:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <CANN689HMLC4uKCjztqfZsDO7pPbsvViOQQ_HDWWYU4=8cZbKvQ@mail.gmail.com>
In-Reply-To: <CANN689HMLC4uKCjztqfZsDO7pPbsvViOQQ_HDWWYU4=8cZbKvQ@mail.gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Sat, 22 Aug 2020 10:30:34 -0700
Message-ID: <CANN689EscUK7_ZaiUbCdt5K-=PYPFgVdeE_GFem0A7WZVfQH-A@mail.gmail.com>
Subject: Re: Lockdep question regarding two-level locks
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 9:04 AM Michel Lespinasse <walken@google.com> wrote:
> - B's implementation could, when lockdep is enabled, always release
> lock A before acquiring lock B. This is not ideal though, since this
> would hinder testing of the not-blocked code path in the acquire
> sequence.

Actually, this may be an acceptable way to handle my issue. In the
non-blocking case, B's implementation does not have to actually
release A, but it could tell lockdep that it's released A, acquired B
and acquired A again. Kinda ugly but should work...

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
