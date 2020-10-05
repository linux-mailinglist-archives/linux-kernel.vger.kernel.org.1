Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48A9283C83
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgJEQa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbgJEQa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601915426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uq+a3B+bkO2xvEqsx4wXSkU0/eyO48zjxe+68lsMqAc=;
        b=Ozfn8/0scOP6P224xayJY7056AadcNcDcFB2qzdYIktROnuGJDvb40HVNfocqmcHNhhrLS
        P6hkaxzKffM5Yk/BzYClWDD5AX7siDasR3/EVtGxAmI5D42e8lqhhnsnmbTNr3hnSXN3HW
        lJah4IOg+l6bpBPwbhcrZfFx7ARKpUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-Uczr-nElM5ieY4bm9-r0XQ-1; Mon, 05 Oct 2020 12:30:22 -0400
X-MC-Unique: Uczr-nElM5ieY4bm9-r0XQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED1CB191F540;
        Mon,  5 Oct 2020 16:30:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.132])
        by smtp.corp.redhat.com (Postfix) with SMTP id B29475C1BD;
        Mon,  5 Oct 2020 16:30:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  5 Oct 2020 18:30:20 +0200 (CEST)
Date:   Mon, 5 Oct 2020 18:30:17 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com>,
        axboe@kernel.dk, christian@brauner.io,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        syzkaller-bugs@googlegroups.com, Tejun Heo <tj@kernel.org>
Subject: Re: WARNING in get_signal
Message-ID: <20201005163016.GB9995@redhat.com>
References: <000000000000da06e405b0b20f1e@google.com>
 <87zh54bp0n.fsf@x220.int.ebiederm.org>
 <20201005134923.GA9995@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005134923.GA9995@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05, Oleg Nesterov wrote:
>
> > It looks like this code was introduced in commit 73ddff2bee15 ("job
> > control: introduce JOBCTL_TRAP_STOP and use it for group stop trap").
>
> Yes, but I bet this was broken later, _may be_ by 924de3b8c9410c4.

No, it seems this bug is really old. I'll try to make the fix tomorrow.

Oleg.

