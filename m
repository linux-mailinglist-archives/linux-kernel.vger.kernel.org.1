Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA928F5B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389658AbgJOPSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388357AbgJOPSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:18:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680FE2222E;
        Thu, 15 Oct 2020 15:18:54 +0000 (UTC)
Date:   Thu, 15 Oct 2020 11:18:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Walter Harms <wharms@bfs.de>
Cc:     Fedor Tokarev <ftokarev@gmail.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] tools: net: traceevent: Fix 'snprintf' return value
 check in 'tep_filter_strerror'
Message-ID: <20201015111852.355049b1@gandalf.local.home>
In-Reply-To: <d489b145997147fd961050321b17d85d@bfs.de>
References: <20201015142959.GA18281@laptop>
        <d489b145997147fd961050321b17d85d@bfs.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 15:12:53 +0000
Walter Harms <wharms@bfs.de> wrote:

> i guess the whole thing can be made more simple 
> 
> we have len and buflen
> 
> len=strlen(filter->error_buffer);
> if (len >= buflen )
>   return -1;
> 
> strcpy(buf, filter->error_buffer);
>

Either is fine, but we are moving libtraceevent into it's own library,
which is located here:

  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/

-- Steve
