Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1985E2705E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIRUDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:02:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921F0C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xGwao8W6Uh+2rz99Rk5ZogOss14+f87cMDqltiuFbyA=; b=JWTlVyai9cSyuWGzgCK8U0WxG7
        YewTIiBUM+pKgO7t0SZ8C2yxUmESMFGW7ofkYIjBweRXZkz3D8NfQwCKQ0smVPmY+DrQuVuLLgewr
        WMzxjNADRLMMIdNXElEP9kij2vxKlAiEED8IhRFcJIWD7H6ewh5RrOoB+YrjwDJpc/eeRa/zRMMhZ
        DhzXA9bLNVgejnciV2+5lo4EnigrQzg/Ntxm91q62rpBjVemhDca6xzmLlgb76aI7CoOeQF1fMjqZ
        tbqZ7Sq/k1VR4WrNjlWAaFbmGy4XA8LUgWhkAw6ysFryVk4EblRNuKWOzejr2ovjhA73QKtca7bJt
        OxFSyOvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJMaq-0003h2-GQ; Fri, 18 Sep 2020 20:02:52 +0000
Date:   Fri, 18 Sep 2020 21:02:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
Message-ID: <20200918200252.GH32101@casper.infradead.org>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:37:48PM -0700, Linus Torvalds wrote:
> > Applying sizeof() to a structure containing a flex-array member is allowed,
> 
> Yes, and that's wrong and inconsistent, but what else is new about the
> C standard. It's what allows these kinds of bugs to slip through.

Hmm.  We actually do that in our implementation of struct_size()

#define struct_size(p, member, count)                                   \
        __ab_c_size(count,                                              \
                    sizeof(*(p)->member) + __must_be_array((p)->member),\
                    sizeof(*(p)))

I suppose it's not really necessary, we could do offsetof here, right?

#define struct_size(p, member, count)                                   \
        __ab_c_size(count,                                              \
                    sizeof(*(p)->member) + __must_be_array((p)->member),\
                    offsetof(typeof(*(p)), member))

