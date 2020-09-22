Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F07273F23
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIVKC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:02:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgIVKC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:02:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600768946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RThaCP/K7i2WlK+tnesoAZh0Ej0QWixxsXP5VJ9Q2fo=;
        b=KXresjSEQ1RLkxjO/7vUtKt0PgDzifAtxmqIDGJ1OSaY6w1WvLlsqE8Tjgkpl/S6EypJzH
        ByKLv7vSmxOw1HnKzYSiNRTs8AoIjlsvShVS3UsyNNuQm/XMKJ6T9LHwtm+We2CJVuz/Pw
        pXrg0SJ5aOaiJzeexljXbOiccBaAIrk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 068A0B1AD;
        Tue, 22 Sep 2020 10:03:03 +0000 (UTC)
Date:   Tue, 22 Sep 2020 12:02:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 0/3] printk: move dictionaries to meta data
Message-ID: <20200922100225.GK14605@alley>
References: <20200918223421.21621-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918223421.21621-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-09-19 00:40:18, John Ogness wrote:
> Hello,
> 
> Here is v2 for a series to move all existing dictionary
> properties (SUBSYSTEM and DEVICE) into the meta data of a
> record, thus eliminating the need for the dict ring. This
> change affects how the dictionaries are stored, but does not
> affect how they are presented to userspace. (v1 is here [0]).
> 
> John Ogness (3):
>   printk: move printk_info into separate array
>   printk: move dictionary keys to dev_printk_info
>   printk: remove dict ring

The patchset is committed in printk/linux.git, branch printk-rework.

The 4th version of the 2nd patch is used.

Best Regards,
Petr
