Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23211A168B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 22:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgDGUJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 16:09:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41829 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgDGUJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:09:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id n17so5158808lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sghJldqMMjWeerVBLUfhc/cQuHU1aQm4qS6KijAW8Q=;
        b=LIs7mHA3OXPjMsaXtYIk07UvtJnPGY4OLuhw5yUdciWXo/7JrrEmPqgnrwGk7LYTDy
         rq/7n66O3MT27zCaMgmAZUsQHre2pHLQbaKY/YARTqgYJVheydI5BKhcTlTAQdZtVZZq
         45bOqqTdfPd9zcZUW/Ki0gAVMMNSm+WBI9Bqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sghJldqMMjWeerVBLUfhc/cQuHU1aQm4qS6KijAW8Q=;
        b=mbi3pkYkrRrssiHeC2azZZSfuZVLZQDO6AQFEOlfw+BFLTqjyH2UqhRsqxJb5iUlY0
         CcefXYk7C8ypPQdCRw6KOS2hTfJTA35SNDcuBfTkeYpcvHB1it5alR/99hhi/ZN8MIHL
         KpxI0Azdqk9aIvsEeToffxaQBF52JjaL0cZo+bY6h8MkI1mLov8yjWThiokg8JbSm0G/
         g7EW4PsfGZHTOVycxm8XBWc4xTo5Q5hKamcV37Dxa0i4GRKtl3UikvZaF+foZEpHJjaK
         fCXJVCO0gjfV26IT5TQCKIA9QdAt7tHTdT+QxjgtJyyM3bZgwRa+fP3KMoc3VcEiuia8
         fgoQ==
X-Gm-Message-State: AGi0PuZzwNI9YTkAVP4IZ4tSj2qIpah6ni6ECW/BYglkuNiPUIvAYmlj
        5I32O6OjQJXbNPk9e88dLroeWSDqr3c=
X-Google-Smtp-Source: APiQypLYg6kLrEV1mmwd0kUorwiyt6sMZRNKEmXfsuLqjMiJ5OsQCpFhOY0ayCA6svg0kDhB6dWZTA==
X-Received: by 2002:a2e:87cc:: with SMTP id v12mr2777717ljj.127.1586290168746;
        Tue, 07 Apr 2020 13:09:28 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u7sm2140400lfi.0.2020.04.07.13.09.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:09:27 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 142so627409ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:09:27 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr2856344lji.16.1586290167180;
 Tue, 07 Apr 2020 13:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200407200318.11711-1-longman@redhat.com>
In-Reply-To: <20200407200318.11711-1-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 13:09:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4YYef26dFX2o9iAKts6vuPceUNg7Bdq32REnvfOWiog@mail.gmail.com>
Message-ID: <CAHk-=wh4YYef26dFX2o9iAKts6vuPceUNg7Bdq32REnvfOWiog@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 1:03 PM Waiman Long <longman@redhat.com> wrote:
>
> For kvmalloc'ed data object that contains sensitive information like
> cryptographic key, we need to make sure that the buffer is always
> cleared before freeing it. Using memset() alone for buffer clearing may
> not provide certainty as the compiler may compile it away. To be sure,
> the special memzero_explicit() has to be used.

Ack. Since this isn't exactly high-priority, I'm assuming it will go
through the usual channels (ie Andrew).

             Linus
