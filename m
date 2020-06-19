Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADCB20088D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 14:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbgFSMUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 08:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731254AbgFSMT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:19:57 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D02207E8;
        Fri, 19 Jun 2020 12:19:56 +0000 (UTC)
Date:   Fri, 19 Jun 2020 08:19:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ming Lei <tom.leiming@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kprobe: __blkdev_put probe is missed
Message-ID: <20200619081954.3d72a252@oasis.local.home>
In-Reply-To: <20200619072859.GA205278@T590>
References: <CACVXFVO5saamQXs0naLamTKJfXZMW+p446weeqJK=9+V34UM0g@mail.gmail.com>
        <20200618125438.GA191266@T590>
        <20200618225602.3f2cca3f0ed48427fc0a483b@kernel.org>
        <20200618231901.GA196099@T590>
        <20200619141239.56f6dda0976453b790190ff7@kernel.org>
        <20200619072859.GA205278@T590>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 15:28:59 +0800
Ming Lei <ming.lei@redhat.com> wrote:

> > 
> > OK, then let's make events (for sure)
> > 
> > root@devnote2:/sys/kernel/debug/tracing# echo p __blkdev_put >> kprobe_events 
> > root@devnote2:/sys/kernel/debug/tracing# echo r __blkdev_put >> kprobe_events 
> > root@devnote2:/sys/kernel/debug/tracing# echo p blkdev_put >> kprobe_events 

Hi Ming,

Do you have the kprobe_events file?

> > root@devnote2:/sys/kernel/debug/tracing# echo 1 > events/kprobes/enable   
> 
> I can't find 'events/kprobes' in my VM with upstream kernel, also not found
> the dir under fedora31(5.5.15-200) & rhel8(v4.18 based).

The events/kprobes directly will be created when you create a
kprobe_event. It wont exist until then.

-- Steve
