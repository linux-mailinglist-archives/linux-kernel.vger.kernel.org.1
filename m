Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946FD1DCE8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgEUNt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 09:49:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:51032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgEUNt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:49:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6CADAAC40;
        Thu, 21 May 2020 13:50:00 +0000 (UTC)
Date:   Thu, 21 May 2020 15:49:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] printk: Move and rename maximum printk output
 line length defines
Message-ID: <20200521134956.GF8397@linux-b0ei>
References: <cover.1589916689.git.joe@perches.com>
 <f37c12c0df59b876236827fcd05b518e28d11a6c.1589916689.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f37c12c0df59b876236827fcd05b518e28d11a6c.1589916689.git.joe@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-05-19 12:42:34, Joe Perches wrote:
> Make the printk maximum line length globally available.

Please, mention the reason that it will be used to split too long
kernel command lines.

> Miscellanea:
> 
> o Prefix the defines with PRINTK_
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Otherwise, I am fine with it:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
