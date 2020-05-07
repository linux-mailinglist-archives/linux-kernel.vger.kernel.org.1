Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE741C9919
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEGSQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 14:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgEGSQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:16:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BEFE20735;
        Thu,  7 May 2020 18:16:18 +0000 (UTC)
Date:   Thu, 7 May 2020 14:16:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>, <linux-kernel@vger.kernel.org>,
        <hushiyuan@huawei.com>, <hewenliang4@huawei.com>
Subject: Re: [PATCH] tools/bootconfig: fix resource leak in apply_xbc()
Message-ID: <20200507141616.5fb38310@gandalf.local.home>
In-Reply-To: <20200508005805.9ae13059958e36ce9ebdd5aa@kernel.org>
References: <583a49c9-c27a-931d-e6c2-6f63a4b18bea@huawei.com>
        <20200508005647.dc6f79c0aeca041203af1d8d@kernel.org>
        <20200508005805.9ae13059958e36ce9ebdd5aa@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 00:58:05 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 8 May 2020 00:56:47 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu, 7 May 2020 17:23:36 +0800
> > Yunfeng Ye <yeyunfeng@huawei.com> wrote:
> >   
> > > The @data and @fd is leak in the error path of apply_xbc(), so this
> > > patch fix it.  
> > 
> > Good catch! Thanks for fixing!
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> >   
> 
> Hi Steve, can you pick this up?

Yeah. I can add it to my 'for-linus' queue. As it's just part of the tools
directory, I can skip the full testing I run on my patches.

-- Steve
