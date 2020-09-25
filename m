Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED58E27864F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgIYLwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728147AbgIYLwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:52:46 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601034765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lFUjAv5XMbiVSgu0Jg799Tw+/D/0Z80SazXgHyAh2w=;
        b=SPllqGd33GKTU0Pcc0lqLZ6Aaqv/f4zfSjbIpDM/g+MCm4lSUPthfPU+xQ+xmY33+qmbpd
        sR6PxdJtD2yAAMXnmCwcKZ5gfcEriPaRTrNQ1XgCky5cWzjdq9pMm5+8Zr3lVWEhBKEl2u
        wGlD30UrQLnCOkIjlOSOKfaV9iu2ldw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-0qItIgiuPamLlI5cZWw7Gg-1; Fri, 25 Sep 2020 07:52:43 -0400
X-MC-Unique: 0qItIgiuPamLlI5cZWw7Gg-1
Received: by mail-oo1-f71.google.com with SMTP id i1so1153531ood.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lFUjAv5XMbiVSgu0Jg799Tw+/D/0Z80SazXgHyAh2w=;
        b=cgFhkwwx2QKKxNJvkxCWTXAu08PED20xhh1sTB+UlwdzdhzfzGbzzc8dfFb5HtI6Xx
         ur+x79I7ejnp/R+hXs3dcGjnytiryVWX0p6/W8zjNvrIQFd2Z9sifXDnGXFEA65Ai3bZ
         gzlHtEX/endb7b1gv6a+CNwDwPPZNJJJ13iKQTwfX5DXl3nys04glh5KjcjJgtif8s3z
         bn6gfw1PHfMjDYOrhOGqze0C5XT/I/wo8QvusAKGgHs9oUbTz4US7ZK/hN3T2YI2fWrx
         Ij90zRwDOGx2/rWc47lQLNM5KJUq49LAXDQ3KtG+GzhLaSd5Rdz2k7KLsq18nGZupvne
         gyhw==
X-Gm-Message-State: AOAM5335mOo4Om21U0qNaUOEEa35craFLk557Ckcs81jp9BNEQguKuxR
        t7KS1Hi14JSmxU9se3Yjc8OHJxcKTeR6ZNvJ2QmSxATj5T96gcAJxSaaXcd6P+n9kM0Y2Ee4YKB
        r4U9zvmo5lSPtrmCF1BsOMCtjhBDz+yCuv0tngVuH
X-Received: by 2002:aca:ec53:: with SMTP id k80mr1236662oih.92.1601034763122;
        Fri, 25 Sep 2020 04:52:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1drV9IRouxE5hJs4rIGJb6Xa11KayHtu5ujP+a6xTaRT0t7HlxB1xubhQw4czUWUkQULukEgHML0ejBwbHec=
X-Received: by 2002:aca:ec53:: with SMTP id k80mr1236651oih.92.1601034762945;
 Fri, 25 Sep 2020 04:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200922133731.33478-1-jarod@redhat.com> <20200922133731.33478-3-jarod@redhat.com>
 <20200922232317.jlbgpsy74q6tbx3a@lion.mk-sys.cz> <20200922.165114.402110655616716896.davem@davemloft.net>
In-Reply-To: <20200922.165114.402110655616716896.davem@davemloft.net>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Fri, 25 Sep 2020 07:52:32 -0400
Message-ID: <CAKfmpSf8B5zyk9Y-0zGEOtH-03dn7UfXd12QjkBXxhsT5SV9bQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] bonding: rename slave to link where possible
To:     David Miller <davem@davemloft.net>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 7:51 PM David Miller <davem@davemloft.net> wrote:
>
> From: Michal Kubecek <mkubecek@suse.cz>
> Date: Wed, 23 Sep 2020 01:23:17 +0200
>
> > Even if the module parameters are deprecated and extremely inconvenient
> > as a mean of bonding configuration, I would say changing their names
> > would still count as "breaking the userspace".
>
> I totally agree.
>
> Anything user facing has to be kept around for the deprecation period,
> and that includes module parameters.

Apologies, that was a definite oversight on my part, can add them back
via similar means as num_grat_arp and num_unsol_na use currently.

-- 
Jarod Wilson
jarod@redhat.com

