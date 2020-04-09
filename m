Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78D41A388E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 19:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgDIRFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 13:05:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41839 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgDIRFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:05:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id n17so430612lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTzH1Bhr1hDM1qjv9jkCYGCa68nXo9HmCjXfmtTX3vU=;
        b=Or+5V8+WP93RTeSd9r7vwKWDbL50ajg+ekJ83WIjflsqZzEAZPjHAfTt8hEKToRfbK
         iU/Se9eyWg4gFlQ0PytYEYzVIQbDOvDw55/vAL3JQP3cnPRzf5ex5xCP38S9Pd+rI2Cx
         CpkaVxAdYcOmFAZVfsZg4fOGxnBT/RWf5YQGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTzH1Bhr1hDM1qjv9jkCYGCa68nXo9HmCjXfmtTX3vU=;
        b=ZSbVLBKN6WG9kdGgelsNcKONPqxs7Xz5PbuDbDGbQD09x0bGwF7AuZvH7HnsLYTG9/
         e8p1O83b6ldIVDceokovnRSF7ivATkI4OtG3iNQROUxByNzLbPIp+aO4r+o6qQWTytMa
         DSyA4LBL9HQs/f6sTgTz+AMc5AglMg0Y8B8BILlIhHOxkP0ivwfJr+a78CuVDwxCJ63z
         24ePSr7e3jGQptaAFeKULQ0Oqve/pzsGqEHvq4XM0W7+bn0lpweBT+RVe6qCKxv18AqR
         hvTu9G/HpJa23ajdla7Kg9zcklshW/q7oY+6EWktH7i5GjVYBfHuYPYSSSlyAjuNpJxJ
         BqUw==
X-Gm-Message-State: AGi0PuZ02MsEvv9YsukfLl9OuG3g+Gvm0u+2SqQ43FDJ6geBkqPHTLfV
        fZHUykgBxs4RiTEeRP2c0LhdsQgHyVE=
X-Google-Smtp-Source: APiQypL654hUlS10v2IVDNYVUNTIlKtDPksErESlDhYqVWf2qUA6GL/aoi9SZDQ6UCffQnl2C1kkww==
X-Received: by 2002:a2e:9e89:: with SMTP id f9mr486668ljk.234.1586451949031;
        Thu, 09 Apr 2020 10:05:49 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id u1sm1814227ljo.65.2020.04.09.10.05.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 10:05:48 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id q22so493855ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:05:47 -0700 (PDT)
X-Received: by 2002:a2e:870f:: with SMTP id m15mr507650lji.16.1586451947460;
 Thu, 09 Apr 2020 10:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
 <BB768A53-4A6F-4C69-8FBC-8BCAB1F4F280@lca.pw>
In-Reply-To: <BB768A53-4A6F-4C69-8FBC-8BCAB1F4F280@lca.pw>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 10:05:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfngA7nHAsie7bW_JmKBhUyV9oV7zmDbZuchkJK3sR1w@mail.gmail.com>
Message-ID: <CAHk-=wjfngA7nHAsie7bW_JmKBhUyV9oV7zmDbZuchkJK3sR1w@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Qian Cai <cai@lca.pw>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 9:58 AM Qian Cai <cai@lca.pw> wrote:
>
> On the other hand, this makes me worry who is testing on linux-next every day.

Well, probably not very many people outside of robots.

Which is fine, but is also why I'd like robot failures to then be a big deal.

           Linus
