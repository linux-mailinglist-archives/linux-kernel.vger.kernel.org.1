Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAEB2849B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJFJyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 05:54:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:37102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgJFJyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 05:54:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601978076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgfRI0vLm9FmZF/NHTnBNovQo+K9yqcqrPuLwbVvKzg=;
        b=ZbOSA9LZ3Nqmw3coR1ohp/z5OAivJ/NOQPpqCFGjQglOwptFZWCEQ5zML4WUrWHtH8NSJ8
        VbdGrilhQtEa46BV20fhybJwyADaGOLbJk5fzbALmaN784YrJuJCZYrrwSk86NKwdulZDL
        pjAghSks/BZ8akbqk+9WpT/21YpksNE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60911B1FE;
        Tue,  6 Oct 2020 09:54:36 +0000 (UTC)
Date:   Tue, 6 Oct 2020 11:54:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201006095435.GC32369@alley>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006065907.GA528@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006065907.GA528@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-10-06 15:59:07, Sergey Senozhatsky wrote:
> On (20/10/05 20:35), Guenter Roeck wrote:
> > On a side note, I don't see the problem presumably fixed with this
> > patch in any of my tests.
> 
> Hmm. This is rather interesting. Empty console= certainly oops-es my laptop,

Just by chance. Do you have any log with the Oops? Or does it die
silently?

Best Regards,
Petr
