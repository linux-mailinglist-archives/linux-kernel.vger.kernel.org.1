Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B22C72D1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbgK1WIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 17:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgK1WIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 17:08:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F301C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 14:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=20Wo5Ne62+uG5sbk7c01si6DBIGmDhfLJZqbzAeZaXI=; b=TEmQd2IZIrZfKNzR9VUIikkfmk
        ahaMYnWc9+aBLen08OnAe8UowAAOfs7+1TESO/mGiRHqP+0zYcBSQVJ1U/707WrGFuRYZScLgWtEJ
        iyt1q7qGsSQ0tSrC/QDqMvDmsv61LRjWeQmk5uoA+09lPIy1Y+jbvXh6LQZ0S62e11c67g6yBiCKa
        o9jnDms98PKEA/MeneohhLdS4eu6TrCYa2ZaQiF4d+xyoLmQ3QHxjfpQGfsYi0OkQ8HqxX5pP4Y6z
        E7olW5cAKJbxDQq06wiXUjuifeQ0YgzJuHnOIInV92wbJx4qmD1bNYvOEoqa5TYsYrvBl6pwAhMYK
        Z63x0UjA==;
Received: from [2601:1c0:6280:3f0::cc1f]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kj8NQ-0006QP-D6; Sat, 28 Nov 2020 22:07:32 +0000
Subject: Re: [GIT PULL] USB/PHY driver fixes for 5.10-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <X8JBIBWUEgxr1lSY@kroah.com>
 <CAHk-=wiEDfZyekjsHMvxwQGKt7BhjXuX77vaihn6SB59qyW1cg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <39c8838b-b321-b91e-d29d-92cf43a09c16@infradead.org>
Date:   Sat, 28 Nov 2020 14:07:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiEDfZyekjsHMvxwQGKt7BhjXuX77vaihn6SB59qyW1cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/20 11:30 AM, Linus Torvalds wrote:
> pr-tracker-bot seems a bit under the weather.
> 
> But this has been pulled.
> 
> I'm not sure why pt-tracker-bot did react to the Kbuild one, but not
> the ones by Greg and Arnaldo. The pull requests all look good to me,
> and seem to have all the required markers..
> 
> Konstantin?
> 
>           Linus
> 
> On Sat, Nov 28, 2020 at 4:21 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc6

Could it just be a vger issue?  vger has been acting ill today...

-- 
~Randy

