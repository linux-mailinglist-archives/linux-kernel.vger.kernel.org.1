Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE28304FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhA0Dcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:32:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729485AbhAZVS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611695852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZegfSQaVgR/gl1215NTcom+C+m68vfkGvT34DFtcorI=;
        b=QHH1WrnE9RnnhCl/Jq1WsxHnH2yBTMk2QLgyYwYURdgZx/SMr53z01BXNi/Safmm3eKLwa
        wtgTVO7FCuCbDcTdft503pzTwQHVed0QohvyeTQdNw2SAkjkiywcWVbLvGl/YcSWpNycbJ
        EJmBPcIuIWKSuaY166beL7tXy1Cj9Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-sKZ4waErPguMXlXgrqyjPA-1; Tue, 26 Jan 2021 16:17:27 -0500
X-MC-Unique: sKZ4waErPguMXlXgrqyjPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 117A8A0C23;
        Tue, 26 Jan 2021 21:17:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.29])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9E4551F0;
        Tue, 26 Jan 2021 21:17:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 Jan 2021 22:17:25 +0100 (CET)
Date:   Tue, 26 Jan 2021 22:17:23 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jianlin Lv <Jianlin.Lv@arm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
Message-ID: <20210126211722.GA23645@redhat.com>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
 <20210125181926.GA10248@redhat.com>
 <20210125133840.511b1496@gandalf.local.home>
 <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
 <20210126202058.GC12469@redhat.com>
 <20210126154302.302a3bb0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126154302.302a3bb0@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26, Steven Rostedt wrote:
>
> On Tue, 26 Jan 2021 21:20:59 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > > No, not wrong. Even offset != 0, if the symbol exists in the kernel,
> > > kprobe_on_func_entry() will check it.
> >
> > Yes, but unless I am totally confused... if kprobe_on_func_entry() returns false,
> > then trace_kprobe_create() should fail with BAD_RETPROBE even if offset == 0 ?
>
> From what I understand. kprobe_on_func_entry() can return false if you pass
> in: "MOD:not_yet_loaded_module_func", but this is OK, because when the
> module is loaded, and the "not_yet_loaded_module_func" exists, the
> kretprobe will then be added.
>
> The strchr(symbol,":") check is to see if "MOD:" (or some other ":" command)
> is in the name, and we don't want it to fail if it is. Which is why we
> should have that commented.

Agreed, this matches my understanding.

But just in case... not sure I read this code correctly, but I think that
module_kallsyms_lookup_name("not_yet_loaded_module_func") should work even
without the "MOD:" prefix.

IOW, kprobe_on_func_entry("not_yet_loaded_module_func") can fail, and then
later succeed if you load the module which provides this symbol.

But even if I am right, I agree with the strchr(symbol,":") check.

Oleg.

