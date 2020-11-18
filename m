Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1BC2B7E68
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKRNiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:38:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgKRNh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:37:59 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B01C72083E;
        Wed, 18 Nov 2020 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605706678;
        bh=P+lKd6Cp9dTnNzATmRAOmmnRc5Z7Qf95WiE+ievVsdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mA5Q8hyRZabo4Ckslku4EqVouauRpY9MJQdsioWwhWscLcHOH0EoDGIElTN+Ido9Q
         jdBbn9i03BnpQnVQEcLLT7yLEpNIsf9uTDPaasO8FvUwNFCyvflYHIjbIKoS32EZFy
         Fc/ShGGS6+hqKlqDEef/j/ukZ9MxZvze4eI1Ua/Q=
Date:   Wed, 18 Nov 2020 22:37:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Luo Meng <luomeng12@huawei.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@kernel.vger.org
Subject: Re: [PATCH] fail_function: remove a redundant mutex unlock
Message-Id: <20201118223755.b8e4f8e8f72a251d670a8a2e@kernel.org>
In-Reply-To: <CAADnVQ+u0bxvAC+EpdGTsg023UtVAcXyUcV4kKWF+ia6ZxBJ5Q@mail.gmail.com>
References: <20201110084245.3067324-1-luomeng12@huawei.com>
        <20201111183129.3c58ca0c381e30d05b1392c8@kernel.org>
        <CAADnVQ+u0bxvAC+EpdGTsg023UtVAcXyUcV4kKWF+ia6ZxBJ5Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 17 Nov 2020 20:08:08 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Nov 11, 2020 at 1:31 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Luo,
> >
> > On Tue, 10 Nov 2020 16:42:45 +0800
> > Luo Meng <luomeng12@huawei.com> wrote:
> >
> > > Fix a mutex_unlock() issue where before copy_from_user() is
> > > not called mutex_locked.
> >
> > Oops, thank you for the fix.
> >
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Did anyone pick this up?
> If not, please resend cc-ing bpf@vger so it can get into patchwork and
> be processed by bpf maintainers.

OK, I'll resend this to the bpf@vger. 

Thank you,

> 
> Thanks!
> 
> > >
> > > Fixes: 4b1a29a7f542 ("error-injection: Support fault injection framework")
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Luo Meng <luomeng12@huawei.com>
> > > ---
> > >  kernel/fail_function.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> > > index 63b349168da7..b0b1ad93fa95 100644
> > > --- a/kernel/fail_function.c
> > > +++ b/kernel/fail_function.c
> > > @@ -253,7 +253,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
> > >
> > >       if (copy_from_user(buf, buffer, count)) {
> > >               ret = -EFAULT;
> > > -             goto out;
> > > +             goto out_free;
> > >       }
> > >       buf[count] = '\0';
> > >       sym = strstrip(buf);
> > > @@ -307,8 +307,9 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
> > >               ret = count;
> > >       }
> > >  out:
> > > -     kfree(buf);
> > >       mutex_unlock(&fei_lock);
> > > +out_free:
> > > +     kfree(buf);
> > >       return ret;
> > >  }
> > >
> > > --
> > > 2.25.4
> > >
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
