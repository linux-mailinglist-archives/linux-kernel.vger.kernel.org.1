Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EF72D5DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390838AbgLJOez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389258AbgLJOdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:33:05 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D34DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:32:25 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id d9so5713954iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GLuO3/YF/ztUP4hSerp+MbDD1oFAgQfIDqkkImYbuE=;
        b=B8C45ADLDKqh3FinLWWa/DLqK4+AXYkFPySxyz59YTPrmBxvySdHQxEFNczsKrM0HQ
         q9KXvp9oQH4LqWdUAfSLEkd/29pSX7Sao2c5jFQOGMk166LyFuUl8EuqhIGZ8Z+z5yv2
         BZoIf0WSWk/3gYGCxtXlJ7gJXAY3JFoCdqBdNZf6/Hawq3eodQrxM2djg4sCkj7wV4CD
         6Hul5SVuBEhTzip2BrcAzy55yelxpF/fEkRHgevKApyhBEBnRLcf/Q8PTpLSAbp6aI01
         1JLpP66GxI/W1UnMJ3K/QYWh1rmfL2o1KhvuEQXbAOpyrVa7aM180SU+tvC394T9jelx
         m0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GLuO3/YF/ztUP4hSerp+MbDD1oFAgQfIDqkkImYbuE=;
        b=LcPqjPTnFtnF7l7RE7ASjtIF2imiwdHQj1TQPiKBNDWk3fQfAEAM3oLCMToh+rPgau
         Bks+D1HtOFD+iLRWxvDebP7ZRbykvlj9QsweXXVOwHvjpdNOVXto6xfeS3s/YuPczG+t
         rHYh+lCmQ//xiSnLPoX/r3kED7zqzILXlvLDnYYf6K5+6Y8qWJGhLesXlWsh02qjv3o3
         W+qk50BjNA12WjmEfkP12bkGiZh7KTMGkG7gAnny2oU3bcq31oIus+H4mcx9Mcob/MtQ
         WXp3YgpGgIkN44SOR4dZRePgWJNUJBgQNFxwosH6cYYfWMikIU/3WG9PmpS5CKxBbsBD
         h1lQ==
X-Gm-Message-State: AOAM531tymrCyNxyu3URG4KXBKV9B5Dbj9Sw2ftNkAzmh1nE2MsjtDW6
        GLw5DM+IaC+ETErhyaQ0B/uQrWjEkMvfT+R4vkGfe08uBHu4Fw==
X-Google-Smtp-Source: ABdhPJz02WeH46QaDv/uOYhVV0lbqu7ydIPUCKksT+NrxRyqX9VnA7/PspVrOBowr3kcKLa2FibFfe74w2ogKHlqEAQ=
X-Received: by 2002:a6b:928b:: with SMTP id u133mr8641678iod.145.1607610744422;
 Thu, 10 Dec 2020 06:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20201210142600.887734129@linuxfoundation.org> <20201210142601.652963609@linuxfoundation.org>
In-Reply-To: <20201210142601.652963609@linuxfoundation.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 10 Dec 2020 15:32:12 +0100
Message-ID: <CANn89iK=kMSkT771iL0dybnWisXr9FWW-bffa5KB+McBYrxx4g@mail.gmail.com>
Subject: Re: [PATCH 4.4 15/39] geneve: pull IP header before ECN decapsulation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 3:26 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> IP_ECN_decapsulate() and IP6_ECN_decapsulate() assume
> IP header is already pulled.
>
> geneve does not ensure this yet.
>
> Fixing this generically in IP_ECN_decapsulate() and
> IP6_ECN_decapsulate() is not possible, since callers
> pass a pointer that might be freed by pskb_may_pull()
>
> syzbot reported :
>

Note that we had to revert this patch, so you can either scratp this
backport, or make sure to backport the revert.

Thanks !
