Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EB22F0ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbhAKJPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:15:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbhAKJPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:15:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 316362063A;
        Mon, 11 Jan 2021 09:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610356491;
        bh=LMS7ht4z1I4PScZJj3KRqljIkMoNyPpVmKLwHDqk64U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUG98atK6vuBjwmZXWb0Jc6e+GnUPPLdLHQek2OEaooAjgFJboybvbTaAPwi0fjhp
         jVjfcqLVutvoBgcvLRBpuvqjggm6GOuWSsAQTnyPHLSBX2rGPXiQtMeSxyosTrsaYY
         j1ZEYyJrcAQi/IaIIjeVfcm2PPQhhA8xuosyPUWA=
Date:   Mon, 11 Jan 2021 10:16:03 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= 
        <k-hagio-ab@nec.com>, "lijiang@redhat.com" <lijiang@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <X/wXU9G/+AJhb4HP@kroah.com>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
 <OSBPR01MB1991DBFA6C4BD6818947EF6BDDAE0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <20210108102224.GC4959@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210108102224.GC4959@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 06:22:24PM +0800, Baoquan He wrote:
> On 01/08/21 at 10:07am, HAGIO KAZUHITO(萩尾 一仁) wrote:
> > Hi Baoquan,
> > 
> > -----Original Message-----
> > > On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
> > > > The offset of the field 'init_uts_ns.name' has changed
> > > > since commit 9a56493f6942 ("uts: Use generic ns_common::count").
> > > 
> > > This patch is merged into 5.11-rc1, but we met the makedumpfile failure
> > > of kdump test case in 5.10.0 kernel. Should affect 5.9 too since
> > > commit 9a56493f6942 is merged into 5.9-rc2.
> > 
> > Hmm, commit 9a56493f6942 should have been merged into 5.11-rc1
> > together with commit ca4a9241cc5e.
> 
> Checked on master branch of mainline kernel, commit 9a56493f6942 is in
> 5.9-rc1.


No, that commit is in 5.11-rc1, not 5.9-rc1:
	$ git describe --contains 9a56493f6942
	v5.11-rc1~182^2~9

> commit ca4a9241cc5e is merged into 5.11-rc1.
> 
> commit 9a56493f6942c0e2df1579986128721da96e00d8
> Author: Kirill Tkhai <ktkhai@virtuozzo.com>
> Date:   Mon Aug 3 13:16:21 2020 +0300
> 
>     uts: Use generic ns_common::count
> 
> 
> commit ca4a9241cc5e718de86a34afd41972869546a5e3
> Author: Alexander Egorenkov <egorenar@linux.ibm.com>
> Date:   Tue Dec 15 20:45:31 2020 -0800
> 
>     kdump: append uts_namespace.name offset to VMCOREINFO


Are you all sure this is needed in 5.10.y?

thanks,

greg k-h
