Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609CD27058C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIRT2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgIRT2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:28:51 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E6622211;
        Fri, 18 Sep 2020 19:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600457330;
        bh=BkCrOBZ51G80Rda8ju5pSzSRH8s/Uhn1PxrbXicKLD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pc8jogKZEVzTjnSoHn5W3R9ILSnKVzY4hwq5oOusgfvV1xDAGO3xkzaqrq75gu2nl
         yNbtahPwUYXw08wtaof+AP6wCKEJlcWE3oiGtBsITkjhqek66GZ0X1ojqAUtXSMmRm
         4EdYARjQxCF1KxQ9ZVs7HLP92G/DpvLeSs+rN9A4=
Date:   Fri, 18 Sep 2020 14:34:26 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
Message-ID: <20200918193426.GA15213@embeddedor>
References: <20200917204514.GA2880159@google.com>
 <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
 <20200918162305.GB25599@embeddedor>
 <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 10:23:54AM -0700, Linus Torvalds wrote:
> On Fri, Sep 18, 2020 at 9:17 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > This bug could have been prevented by either adopting better
> > coding practices or through the use[3] of the recent struct_size() helper.
> 
> Well, my unspoken point was that coding practices are just
> theoretical. Coding practices don't help - actual *checking* of them
> helps.

Yep; I agree that the best approach is to find a way to enforce such
practices. :)

> I realize that structures with flexible-array member are allowed to
> use sizeof() in standard C, but if we want to make sure this doesn't
> happen, we would need to have a stricter model than that. But a quick
> google didn't find any flag to enable such a stricter mode.
> 

OK. It seems that we are talking about two different things here. One thing
is to apply sizeof() to a structure that contains a flexible-array member.
And the other thing is to apply sizeof() to a flexible array. The former
is allowed, the latter is wrong and we already get a build error when that
occurs.

Applying sizeof() to a structure containing a flex-array member is allowed,
and the result is the size of the structure excluding the size of the
flexible-array member type. In this regard, using a zero-length array has
the same effect as using a flexible-array member.

Now, if you are trying to make the case for not allowing the application
of sizeof() to a structure that contains a flexible-array member because
that could be prone to error, then this is new and we need to think about
the implications and see if we can move in that direction.

> I guess a sparse warning would work, but sparse already has too many
> warnings and as a result most people don't care - even if they were to
> run sparse in the first place.

There are ongoing efforts to warn about the use of zero-length and one-element
arrays through the use of Coccinelle. But again, you might be talking
about a different thing...

> Is there some gcc option that I didn't find to help find any questionable cases?

If the questionable case is the application of sizeof() to a flex-array
member or a flex-array member not occuring last in the containing structure,
then yes, GCC already generates a build error for both cases. And that's
what we want, see at the bottom...

> Because if we have a coding practice that you should use
> 'struct_size()', then we should also have a way to _verify_ that.

struct_size() should be used to defend against these sorts of bugs[1] as I
explained in the last email[2], also to prevent integer overflows. It's meant
to replace the following sorts of idioms:

sizeof(struct foo) + sizeof(struct boo) * COUNT
sizeof(*foo) + sizeof(*boo) * COUNT
sizeof(*foo) + sizeof(*foo->array) * COUNT
sizeof(*foo) + sizeof(foo->array[0]) * COUNT

and all the many variations...

But struct_size() by itself is not meant to help identify any kind of array
misuses in structures. struct_size() can be used with structures that contain
any kind of arrays (zero-length/one-element/flexible array).

> The whole - and really ONLY - point of using flexible arrays was that
> it would protect against these things. And as things are now, it
> simply doesn't. It's not an actual improvement over just using a
> zero-sized array.

It protects against the cases I have explained at the top and that I elaborate
below...

> (Slightly related: copying a struct has the exact same issue. A
> flexible array is no better than a zero-sized array, and generates the
> same code and the same lack of any warnings, afaik).

An important difference is that the use of a flexible-array member allows
the compiler to generate errors when the flexible array does not occur last
in the structure, which helps to prevent some kind of undefined behavior bugs[3]
from being inadvertently introduced to the codebase. It also allows the compiler
to correctly analyze array sizes (via sizeof(), CONFIG_FORTIFY_SOURCE, and
CONFIG_UBSAN_BOUNDS). For instance, there is no mechanism that warns us that
the following application of the sizeof() operator to a zero-length array always
results in zero:

struct something {
	size_t count;
	struct foo items[0];
};

struct something *instance;

instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
instance->count = count;

size = sizeof(instance->items) * instance->count;
memcpy(instance->items, source, size);

At the last line of code above, size turns out to be zero, when one might have
thought it represents the total size in bytes of the dynamic memory recently
allocated for the trailing array items. Here are a couple examples of this
issue[4][5]. Instead, flexible array members have incomplete type, and so the
sizeof() operator may not be applied, so any misuse of such operators will be
immediately noticed at build time.

We have documented all the above and more here[6], and there is an update waiting
to land in mainline here[7].

But again, you might be more concerned about applying sizeof() to a structure
containing a flexible-array member in the first place, rather than applying it
to the member alone...?

Thanks
--
Gustavo

[1] https://git.kernel.org/linus/cffaaf0c816238c45cd2d06913476c83eb50f682
[2] https://lore.kernel.org/lkml/20200918162305.GB25599@embeddedor/
[3] https://git.kernel.org/linus/76497732932f15e7323dc805e8ea8dc11bb587cf
[4] https://git.kernel.org/linus/f2cd32a443da694ac4e28fbf4ac6f9d5cc63a539
[5] https://git.kernel.org/linus/ab91c2a89f86be2898cee208d492816ec238b2cf
[6] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays
[7] https://lore.kernel.org/lkml/20200901010949.GA21398@embeddedor/

