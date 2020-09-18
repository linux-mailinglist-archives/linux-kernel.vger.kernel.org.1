Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE92705DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIRT6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgIRT6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:58:09 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C18121D42;
        Fri, 18 Sep 2020 19:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600459088;
        bh=rwunIzOqp6GWQdQipmI6M8Piyl6p7IBW3RuEHyxgW6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVFlfThzUqvTJ1tMe1VP9QD9P1S405SJAaylRtOEHoYox0XY4c1moEauPhDU2+yo/
         koLGWU8VoLc+tg61ccvXJtL7Nc4obfYLLfraHJMQT4b9abE1wSohKu6c///CZ2dEjL
         hNG9o5seH2MwnzDYaEyVHayT7bjW/XB5zxBYlSXc=
Date:   Fri, 18 Sep 2020 15:03:45 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
Message-ID: <20200918200344.GB15213@embeddedor>
References: <20200917204514.GA2880159@google.com>
 <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
 <20200918162305.GB25599@embeddedor>
 <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
 <20200918193426.GA15213@embeddedor>
 <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:37:48PM -0700, Linus Torvalds wrote:
> On Fri, Sep 18, 2020 at 12:28 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > OK. It seems that we are talking about two different things here. One thing
> > is to apply sizeof() to a structure that contains a flexible-array member.
> > And the other thing is to apply sizeof() to a flexible array. The former
> > is allowed, the latter is wrong and we already get a build error when that
> > occurs.
> 
> The latter I'm not even interested in, it's such a pointless thing to do.
> 
> > Applying sizeof() to a structure containing a flex-array member is allowed,
> 
> Yes, and that's wrong and inconsistent, but what else is new about the
> C standard. It's what allows these kinds of bugs to slip through.
> 
> I sent Luc a couple of examples in the hope that maybe sparse could do
> better, but..
> 
> > > Is there some gcc option that I didn't find to help find any questionable cases?
> >
> > If the questionable case is the application of sizeof() to a flex-array
> > member or a flex-array member not occuring last in the containing structure,
> > then yes, GCC already generates a build error for both cases. And that's
> > what we want, see at the bottom...
> 
> No.
> 
> The questionable thing is to do "sizeof(struct-with-flex-array)".

I see now... 

> The point is, it's returning the same thing as if it was just a
> zero-sized array, which makes the whole flex array entirely pointless
> from a type safety standpoint.
> 
> The *only* thing it protects against is the "must be at the end" case,
> which is almost entirely pointless and uninteresting.
> 

But you are missing the point about CONFIG_UBSAN_BOUNDS, which doesn't
work with zero-lenght and one-element arrays. And we want to be able
to use that configuration. That's the main reason why we are replacing
those arrays with a flexible one. I should have made more emphasis on
that point in my last response.

Thanks
--
Gustavo
