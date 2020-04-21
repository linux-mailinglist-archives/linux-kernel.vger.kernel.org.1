Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16031B2244
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 11:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgDUJEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 05:04:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52757 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbgDUJEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587459892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jiq5vxLEVOIwG9hr0wweOUq8q9Kc0ppf4k/26mm9nI0=;
        b=MKwRAESwgOjoQ/t//ugozYJo2EZUoxkRxBm3CY1KoFafEhbb/10B2ysMpaMjGREMy+3fgO
        8fmEg8tAaI45a0xsO3Dml8fbKHbKXJADgDXA6bc89Zp/X4WVjnZEPSXz8d5a3N/R7ogyYZ
        bdAHj64luipLgcu7GyDUBH+Gs4Rskkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-zvLOlh2NMJOWjtqGbie_IQ-1; Tue, 21 Apr 2020 05:04:31 -0400
X-MC-Unique: zvLOlh2NMJOWjtqGbie_IQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2198B107ACC9;
        Tue, 21 Apr 2020 09:04:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.130])
        by smtp.corp.redhat.com (Postfix) with SMTP id CC2C85DA66;
        Tue, 21 Apr 2020 09:04:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 21 Apr 2020 11:04:29 +0200 (CEST)
Date:   Tue, 21 Apr 2020 11:04:27 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Christof Meerwald <cmeerw@cmeerw.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] signal: Avoid corrupting si_pid and si_uid in
 do_notify_parent
Message-ID: <20200421090426.GA6787@redhat.com>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sggyytnh.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20, Eric W. Biederman wrote:
>
> The immediate problem is as Christof noticed that "pid_alive(current) == false".

this is slightly offtopic, but we can probably remove this "pid_alive" check,
pid_nr_ns() checks pid != NULL anyway.

> Inspecting the code it appears this problem has existed since the pid
> namespace support started handling this case

Agreed...

> @@ -1993,8 +1993,12 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
>  			sig = 0;
>  	}
> +	/*
> +	 * Bypass send_signal as the si_pid and si_uid values have
> +	 * been generated in the parent's namespaces.
> +	 */
>  	if (valid_signal(sig) && sig)
> -		__group_send_sig_info(sig, &info, tsk->parent);
> +		__send_signal(sig, &info, tsk->parent, PIDTYPE_TGID, false);

Acked-by: Oleg Nesterov <oleg@redhat.com>

