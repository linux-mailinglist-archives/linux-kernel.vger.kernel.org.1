Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453712AF7B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKKSGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgKKSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:06:00 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D95C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:05:59 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so3075033wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=singlestore.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=65Xr2iKu/nZDVRfbHutkqqfvFgaTZi4vq99SCrkQasA=;
        b=cYaL1wImxfK+ZUKumTaHS86Ga2LYRMjNL/ZGvPIqeOmM8N5TO4gqnL2WkW3I4Kylcm
         bX2xwxCnk3/cVVE5fhO5OUwiJycNH7PpvdhTGG2gs6rVozS4ww5to/n9cuuhdI5OoDA5
         boQtHILlO0dK0JAwsWkZhd7BRbe/gh30ks/ONUSD/h+svWboPIdpE1mTLTReO3f5qym1
         9OxMv66/5OZBWn/kSJLqXGqComz01o62CN1F2OG6j2Nnqwe+YDEk3/Qj8mDKD8zeLusG
         gnzQe6Gf6oHg8oCTgtNdzKf5kJUjPodb9A+uiK+9QcoKCdzZZ4XUY1pf/jLKnwZNnCjD
         +CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=65Xr2iKu/nZDVRfbHutkqqfvFgaTZi4vq99SCrkQasA=;
        b=Huj9ZWYTlGjl+nylv9KwQ0svXHEgZgGsRDRcnvkr7Gd/GTupGy3ZqbH7e3396Zo2+p
         o8SAf1I5EVYHVrzorNTDRLcFeqeAf6eKOPeqz/h/6lxNrAgkVrCd/1FIslW0MCNjPJXi
         4GCrwjG9mjJPXjjszYJjwZma8YZmCb2rIf/EPZQb27ERlgTbvXSDhGjoX27rmtsf3C4c
         Owun+ZRu4Gw7d69BD/5+ax1taG1XXTyuY1zMVOrkW9JbQccW/yAHY4llQZBCDtLWdo58
         aNLavNoDQZtp0j8nTYkQ7qiZhSGkZnzjb0IMB6ON57BkBP+Fnq5Clus9ial4d5ofMXR4
         eE9w==
X-Gm-Message-State: AOAM530pq+0L4p3WvesjCmJvEDV7MeKz22VD3E2UIITO2CVxXi+d2I37
        ZPhBytCU8uThzMG6XIWQmBaoB53HjVU/np6yx2s=
X-Google-Smtp-Source: ABdhPJxvhcIhy52UyrtFzOPmnE/tDp9zlS1acmL8InTf4voP4NuF722ImzTufq5Qh1zJRJrVKkqOtw==
X-Received: by 2002:a05:600c:212:: with SMTP id 18mr5656371wmi.175.1605117958466;
        Wed, 11 Nov 2020 10:05:58 -0800 (PST)
Received: from rdias-suse-pc.lan (bl13-26-148.dsl.telepac.pt. [85.246.26.148])
        by smtp.gmail.com with ESMTPSA id t5sm3493034wmg.19.2020.11.11.10.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:05:57 -0800 (PST)
Date:   Wed, 11 Nov 2020 18:05:55 +0000
From:   Ricardo Dias <rdias@singlestore.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tcp: fix race condition when creating child sockets
 from syncookies
Message-ID: <20201111180555.GA1305169@rdias-suse-pc.lan>
References: <20201111073546.GA1249399@rdias-suse-pc.lan>
 <CANn89i+5PkUk5Lts+8jQR_AAhKUUDzODEAjBjRJpAs+BeKnKuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+5PkUk5Lts+8jQR_AAhKUUDzODEAjBjRJpAs+BeKnKuw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 05:05:11PM +0100, Eric Dumazet wrote:
> On Wed, Nov 11, 2020 at 8:35 AM Ricardo Dias <rdias@singlestore.com> wrote:
>
> ...
> 
> > + * If an existing socket already exists, it returns that socket
> > + * through the osk parameter.
> 
> 
> I think this deserves a third parameter, to avoid confusion.

Yes, I agree. It will make much clearer the semantics of this function.

> ...
>
> > +                                       if (unlikely(!refcount_inc_not_zero(&esk->sk_refcnt)))
> 
> Can you explain how this could happen ?
> Again, we own the lock here, finding a socket in ehash, with a zero
> refcount can not happen.
> 
> Only a true rcu lookup could see a zero refcount.

Ah! Now I understand what you are saying. Indeed we just need to
increment the ref counter. We don't need to check if it's zero.

> ...
>
> > -               inet_ehash_nolisten(sk, (struct sock *)tw);
> > +               inet_ehash_nolisten(sk, (struct sock **)&tw);
> 
> Why could not we 'find' a prior socket, and since you ignore the result,
> leave a refcount increment, and a socket leak ?
> 
> Same remark for all callers.
> 
> >         }
> >         if (tw)
> 
> See the problem here ?
> 
> If tw was initially NULL, then inet_ehash_nolisten() could have overwritten tw
> with another socket.
> 
> Surely calling inet_twsk_bind_unhash() could be disastrous.

Yes, you're right.
I adapted this call to match the new signature assuming `tw` would never
be NULL. Shame on me for not noticing the `if (tw)` statement right
below :-).

I'll check each caller code, to make sure I'm not leaking the socket.


Thanks for your reviews. I'm learning more and more with each review
iteration.

