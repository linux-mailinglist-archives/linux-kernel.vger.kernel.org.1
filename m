Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55992B143B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 03:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKMCVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 21:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgKMCVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 21:21:12 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1E1020936;
        Fri, 13 Nov 2020 02:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605234072;
        bh=NJ1HOLpg4wa/8yhN2mfF+gAx1zfefk22egnvsrV9RmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TQEkAJNxxUtqdbFFbOJ5hl5DHuikpjM2AyIFTuR9Ipl8XDi+21YJSpuE8nVlb6P5A
         nDxgdGnTlQBavA6XmMCNjpLGI3vQIrK8fKfi9a1yD4woNUd3REmPOxzgJShEyfRDrj
         oDSxw/PoudFGG6Z6dRLI+SFkUguS8nKqyOkhI/rI=
Date:   Fri, 13 Nov 2020 11:21:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bootconfig: Extend the magic check range to the
 preceding 3 bytes
Message-Id: <20201113112108.77486a0475216ada6f8e03a0@kernel.org>
In-Reply-To: <CADjb_WSx+sbxAz=p5dCN5PXzR5Zq2Nb3kgup-r8qNM1ftUMzDw@mail.gmail.com>
References: <20201113003633.8db2b4e4c5fecf8de0adfa65@kernel.org>
        <160520205132.303174.4876760192433315429.stgit@devnote2>
        <CADjb_WSx+sbxAz=p5dCN5PXzR5Zq2Nb3kgup-r8qNM1ftUMzDw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 09:27:38 +0800
Chen Yu <yu.chen.surf@gmail.com> wrote:

> On Fri, Nov 13, 2020 at 1:27 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Since Grub may align the size of initrd to 4 if user pass
> > initrd from cpio, we have to check the preceding 3 bytes as well.
> >
> > Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
> > Reported-by: Chen Yu <yu.chen.surf@gmail.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> Works for me, thanks!
> Tested-by: Chen Yu <yu.chen.surf@gmail.com>

Thank you Chen!

Steve, could you merge this fix? 

Thank you,

> 
> Best,
> Chenyu


-- 
Masami Hiramatsu <mhiramat@kernel.org>
