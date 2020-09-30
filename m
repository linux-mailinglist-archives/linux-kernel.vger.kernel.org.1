Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB827EF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgI3Qub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3Qua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:50:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ECDA2076B;
        Wed, 30 Sep 2020 16:50:29 +0000 (UTC)
Date:   Wed, 30 Sep 2020 12:50:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     arnaldo.melo@gmail.com, linux-trace-devel@vger.kernel.org,
        ben@decadent.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tools lib traceevent: Hide non API functions
Message-ID: <20200930125027.7e54b71c@gandalf.local.home>
In-Reply-To: <20200930110733.280534-1-tz.stoyanov@gmail.com>
References: <20200930110733.280534-1-tz.stoyanov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 14:07:33 +0300
"Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:

> There are internal library functions, which are not declared as a static.
> They are used inside the library from different files. Hide them from
> the library users, as they are not part of the API.
> These functions are made hidden and are renamed without the prefix "tep_":
>  tep_free_plugin_paths
>  tep_peek_char
>  tep_buffer_init
>  tep_get_input_buf_ptr
>  tep_get_input_buf
>  tep_read_token
>  tep_free_token
>  tep_free_event
>  tep_free_format_field
>  __tep_parse_format
> 
> Link: https://lore.kernel.org/linux-trace-devel/e4afdd82deb5e023d53231bb13e08dca78085fb0.camel@decadent.org.uk/
> Reported-by: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> ---

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Arnaldo,

Can you pull this in?

Thanks!

-- Steve
