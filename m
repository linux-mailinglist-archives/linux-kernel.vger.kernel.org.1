Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77F72599B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 18:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbgIAQmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 12:42:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54665 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbgIAQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:42:39 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kD9MS-00034e-78; Tue, 01 Sep 2020 16:42:20 +0000
Date:   Tue, 1 Sep 2020 18:42:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, axboe@kernel.dk,
        ebiederm@xmission.com, madhuparnabhowmik10@gmail.com,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: clean up codestyle
Message-ID: <20200901164219.h7aqy6h7xjbj7mzc@wittgenstein>
References: <20200901115800.7916-1-linmiaohe@huawei.com>
 <20200901122047.7hzztrssvr72wb2d@wittgenstein>
 <20200901163904.GC4386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901163904.GC4386@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 06:39:05PM +0200, Oleg Nesterov wrote:
> On 09/01, Christian Brauner wrote:
> >
> > On Tue, Sep 01, 2020 at 07:58:00AM -0400, Miaohe Lin wrote:
> > > No functional change intended.
> >
> > Hey Miaohe,
> >
> > Thank you for the patch.
> > I'm sure this is well-intended but afaict the whole file has more or
> > less a consistent style already where e.g. sig-1 without spaces seems to
> > be preferred. The same for the casts where most places use a single
> > space.
> >
> > Now, I know CodingStyle.rst is on your side at least when it comes to
> > the first point:
> >
> > Use one space around (on each side of) most binary and ternary operators,
> > such as any of these::
> >
> > 	=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
> >
> > but then you'd need to change each place in kernel/signal.c where that
> > is currently not the case.
> 
> Or simply leave this code alone ;)

I was trying to imply that by pointing out that this would be
file-global change. I was likely too subtle. ;)

Christian
