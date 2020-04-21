Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967831B26F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgDUM7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 08:59:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58058 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbgDUM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:59:17 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jQsUX-000449-GM; Tue, 21 Apr 2020 12:59:09 +0000
Date:   Tue, 21 Apr 2020 14:59:08 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        Christof Meerwald <cmeerw@cmeerw.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: Avoid corrupting si_pid and si_uid in
 do_notify_parent
Message-ID: <20200421125908.ls5nwgkl4q7hjoov@wittgenstein>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
 <20200421083031.5wapruzncjkagvhf@wittgenstein>
 <20200421092846.GB6787@redhat.com>
 <20200421102104.6pt34jknxmtu5ygm@wittgenstein>
 <20200421111139.GC6787@redhat.com>
 <20200421112606.ay4cck2dphguqazb@wittgenstein>
 <20200421121722.GE6787@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421121722.GE6787@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 02:17:22PM +0200, Oleg Nesterov wrote:
> On 04/21, Christian Brauner wrote:
> >
> > process B setnses into
> > <pidnsC> which is a sibling pid namespace,
> 
> please see pidns_install(), it verifies that
> 
> 	* Only allow entering the current active pid namespace
> 	* or a child of the current active pid namespace.

I forgot about that.

Though, don't we have the same problem in:

static void do_notify_parent_cldstop(struct task_struct *tsk,
				     bool for_ptracer, int why)

at least for the for_ptrace is false case?

Christian
