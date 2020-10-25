Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE062984BA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 23:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418894AbgJYWi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 18:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbgJYWi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 18:38:27 -0400
Received: from coco.lan (ip5f5ad5d5.dynamic.kabel-deutschland.de [95.90.213.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A6FE2225E;
        Sun, 25 Oct 2020 22:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603665507;
        bh=TxuB7Fbbj70dTWmk88te4nXRxWDwqa7HJJPRXxmSVMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zCbDP4iRbmqyhlf2vbGU7TU15QIsSy8MlBrGIAxwXM8BCSHClq2NpFCS7VYcv3Ozl
         8ldGU3VJ7xuymsxjuI1CNwVFGDQTKqJY3xsDh/3XTmHcvr9flhN5hZSBgHcVfaKFAu
         B7LF3eWBl2b9KYfcrTFKqf44Ebuch4jy+4Z9AJY4=
Date:   Sun, 25 Oct 2020 23:38:20 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 51/56] audit: fix a kernel-doc markup
Message-ID: <20201025233820.7f946e1c@coco.lan>
In-Reply-To: <CAHC9VhQ88cuU-0QdpYJyJZE3FU-3graP=N9n9eiG4Kj2tDbiBQ@mail.gmail.com>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
        <8c04d5c5d0144019c2c38d7c3f31061d6b35d360.1603469755.git.mchehab+huawei@kernel.org>
        <CAHC9VhQ88cuU-0QdpYJyJZE3FU-3graP=N9n9eiG4Kj2tDbiBQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 25 Oct 2020 18:10:44 -0400
Paul Moore <paul@paul-moore.com> escreveu:

> On Fri, Oct 23, 2020 at 12:33 PM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > typo:
> >         kauditd_print_skb -> kauditd_printk_skb
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  kernel/audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> Looks good to me, nice catch.  Would you like me to pull this into the
> audit tree or are you intending this to get pulled in as part of the
> larger patchset somewhere else?

Feel free to apply it directly via audit tree.

> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks!
Mauro

> 
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 68cee3bc8cfe..0be42cac086b 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -523,7 +523,7 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
> >  }
> >
> >  /**
> > - * kauditd_print_skb - Print the audit record to the ring buffer
> > + * kauditd_printk_skb - Print the audit record to the ring buffer
> >   * @skb: audit record
> >   *
> >   * Whatever the reason, this packet may not make it to the auditd connection
> > --
> > 2.26.2  
> 



Thanks,
Mauro
