Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11E91E09A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389242AbgEYJHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 05:07:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388611AbgEYJHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:07:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7B9BCACAC;
        Mon, 25 May 2020 09:07:19 +0000 (UTC)
Date:   Mon, 25 May 2020 11:07:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] printk: Remove pr_cont_once()
Message-ID: <20200525090714.GD5300@linux-b0ei>
References: <20200524153243.11690-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200525084110.GE755@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525084110.GE755@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-05-25 17:41:10, Sergey Senozhatsky wrote:
> On (20/05/25 00:32), Tetsuo Handa wrote:
> > pr_cont_once() does not make sense; at least emitting module name using
> > pr_fmt() into middle of a line (after e.g. pr_info_once()) does not make
> > sense. Let's remove unused pr_cont_once().
> > 
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Joe Perches <joe@perches.com>
> 
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch is committed into printk/linux.git, branch for-5.8.

Best Regards,
Petr
