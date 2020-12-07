Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD02D15F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLGQ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgLGQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:29:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5446C061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 08:28:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r7so2104024wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=naOjb45fn6EGnYDNyCppo0q0f00Y8C+bY3E9HRofE9o=;
        b=PHrmXXTof7ZQlRczNSIQOYsX9uPeHEESe5KgDkHzLcz2ZSLzH69BpOVLcqnDSiH2n1
         WQ+of896hgpPhBGx1btEMwSfXLZzYNtgrpddD9xjqUI4pwWNn8Eq8hf8Nr0ckLlCy7Pz
         S7gA+oEMhNjBIMeXZeKqKC/b4EvozaVyMA8oX60S8OVdE1eZlJyXtKnzb71CjvfGQ3iO
         d6fEGQ01s9exEnpBlJ3kbS0tNFZPkGsM/jLxsakJXcLRE5fR0x3CMcEZ6nPxX/aHT/HU
         DhGz6kXUkeHHnvBuJhZ6IaSv52cKCjyhbWe0Ywr+4MmUyEVgBkTHVVCIJeUelnFa1i9f
         SMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=naOjb45fn6EGnYDNyCppo0q0f00Y8C+bY3E9HRofE9o=;
        b=OoamyhsJFNdJgSK4Agx0/G7DG7PJ68/TkFacUS8yZ/RBwimjUF2+MY4xFEJaJriW1J
         WU6t3Rdq04WnbreOaa0RyxPEHhZSDEsJGnJh4tM5oCed+IU87ftGFTyOXeSFjAITap5Z
         cvHykIWCxEE3Lf1epO1mRyx1Gda2+IV0bY7MN2tN4jB350Op7vbH6hHZlJvN9s6RXEzr
         nXXI/emrz2kaAVWMCosgTCnm74cWGDjmJBq2ylt0E+vc13K8MyNZ2vhyJd/u8GVvK+7V
         7V1TGyZpCjgur/whZyDwfLfHoZc+9QPeby3GRioEaedlMTJs8FT3Q1Eyv0kLX0xnVoFA
         qKiA==
X-Gm-Message-State: AOAM531f0nD/cV/tH2or5JVaBLsc+4S0QmpZAqtx/sFYowvXepr0R3Zt
        MsXpsPW9DmwMxZUARxXD4Phchg==
X-Google-Smtp-Source: ABdhPJwqaoQObYX23jQT6aZvklGNX6SrNBAc+AVAgdWT4zbj2PIoTUIJwXjk5/SK+JMpYBgva2RMgg==
X-Received: by 2002:adf:f70b:: with SMTP id r11mr20549323wrp.133.1607358518245;
        Mon, 07 Dec 2020 08:28:38 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id q17sm16511792wro.36.2020.12.07.08.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:28:37 -0800 (PST)
Date:   Mon, 7 Dec 2020 17:28:31 +0100
From:   Marco Elver <elver@google.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>, Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        syzbot <syzbot+7b99aafdcc2eedea6178@syzkaller.appspotmail.com>
Subject: Re: WARNING in sk_stream_kill_queues (5)
Message-ID: <X85YL2GZHXpgZYlm@elver.google.com>
References: <000000000000b4862805b54ef573@google.com>
 <X8kLG5D+j4rT6L7A@elver.google.com>
 <CANn89iJWD5oXPLgtY47umTgo3gCGBaoy+XJfXnw1ecES_EXkCw@mail.gmail.com>
 <CANpmjNOaWbGJQ5Y=qC3cA31-R-Jy4Fbe+p=OBG5O2Amz8dLtLA@mail.gmail.com>
 <CANn89iKWf1EVZUuAHup+5ndhxvOqGopq53=vZ9yeok=DnRjggg@mail.gmail.com>
 <X8kjPIrLJUd8uQIX@elver.google.com>
 <af884a0e-5d4d-f71b-4821-b430ac196240@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af884a0e-5d4d-f71b-4821-b430ac196240@gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 07:01PM +0100, Eric Dumazet wrote:
> On 12/3/20 6:41 PM, Marco Elver wrote:
> 
> > One more experiment -- simply adding
> > 
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -207,7 +207,21 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
> >  	 */
> >  	size = SKB_DATA_ALIGN(size);
> >  	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +	size = 1 << kmalloc_index(size); /* HACK */
> >  	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
> > 
> > 
> > also got rid of the warnings. Something must be off with some value that
> > is computed in terms of ksize(). If not, I don't have any explanation
> > for why the above hides the problem.
> 
> Maybe the implementations of various macros (SKB_DATA_ALIGN and friends)
> hae some kind of assumptions, I will double check this.


Some more data; removing all uses of ksize() fixes the warnings:

| --- a/net/core/skbuff.c
| +++ b/net/core/skbuff.c
| @@ -214,7 +214,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
|  	 * Put skb_shared_info exactly at the end of allocated zone,
|  	 * to allow max possible filling before reallocation.
|  	 */
| -	size = SKB_WITH_OVERHEAD(ksize(data));
| +	size = SKB_WITH_OVERHEAD(size);
|  	prefetchw(data + size);
|  
|  	/*
| @@ -1628,7 +1628,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
|  			       gfp_mask, NUMA_NO_NODE, NULL);
|  	if (!data)
|  		goto nodata;
| -	size = SKB_WITH_OVERHEAD(ksize(data));
| +	size = SKB_WITH_OVERHEAD(size + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
^^ Reverting *only* this to 'ksize(data)' triggers the warning.
|  	/* Copy only real data... and, alas, header. This should be
|  	 * optimized for the cases when header is void.
| @@ -5901,7 +5901,7 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
|  	if (!data)
|  		return -ENOMEM;
|  
| -	size = SKB_WITH_OVERHEAD(ksize(data));
| +	size = SKB_WITH_OVERHEAD(size + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
|  
|  	/* Copy real data, and all frags */
|  	skb_copy_from_linear_data_offset(skb, off, data, new_hlen);
| @@ -6025,7 +6025,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
|  	if (!data)
|  		return -ENOMEM;
|  
| -	size = SKB_WITH_OVERHEAD(ksize(data));
| +	size = SKB_WITH_OVERHEAD(size + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
|  
|  	memcpy((struct skb_shared_info *)(data + size),
|  	       skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));


Conversely, only doing this also fixes the warnings:

| --- a/net/core/skbuff.c
| +++ b/net/core/skbuff.c
| @@ -1628,7 +1628,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
|  			       gfp_mask, NUMA_NO_NODE, NULL);
|  	if (!data)
|  		goto nodata;
| -	size = SKB_WITH_OVERHEAD(ksize(data));
| +	size = SKB_WITH_OVERHEAD(size + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
|  
|  	/* Copy only real data... and, alas, header. This should be
|  	 * optimized for the cases when header is void.

But not sure if any of this is helpful, since in the end what we want is
to make a bunch of subtractions reach precisely 0, and any deviation
somewhere might, by chance, achieve that.

Thanks,
-- Marco
