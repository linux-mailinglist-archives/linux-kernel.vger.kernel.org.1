Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE7B2F0FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbhAKKF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:05:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728754AbhAKKF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610359441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7QQYGswX7kOdwMrRwlbQJJSbB43WaV6ZjRmr7/9tm4=;
        b=YfE4K/kbiLZdS1nwvx8ObJevhUjVY/cWPPdPoPr5fRm7vnx1aM9MiI8jG103uEQ3kA/MyP
        2F0uHGcrkaQ+c+6d1XSRWL14JXUK1adt10X4Sp6veXWrfccZXR8VMh7NOAxyD8VosqDtJP
        vSm9EIAWFsa26wRmOMEC3Afs1pI+2Mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-rkno6TyNMZysEf2hgfUxKg-1; Mon, 11 Jan 2021 05:03:53 -0500
X-MC-Unique: rkno6TyNMZysEf2hgfUxKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20D138042B7;
        Mon, 11 Jan 2021 10:03:51 +0000 (UTC)
Received: from localhost (ovpn-12-233.pek2.redhat.com [10.72.12.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0F2519D9D;
        Mon, 11 Jan 2021 10:03:46 +0000 (UTC)
Date:   Mon, 11 Jan 2021 18:03:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= 
        <k-hagio-ab@nec.com>
Cc:     "lijiang@redhat.com" <lijiang@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <20210111100344.GF4959@MiWiFi-R3L-srv>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
 <OSBPR01MB1991DBFA6C4BD6818947EF6BDDAE0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <20210108102224.GC4959@MiWiFi-R3L-srv>
 <X/wXU9G/+AJhb4HP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X/wXU9G/+AJhb4HP@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/21 at 10:16am, gregkh@linuxfoundation.org wrote:
> On Fri, Jan 08, 2021 at 06:22:24PM +0800, Baoquan He wrote:
> > On 01/08/21 at 10:07am, HAGIO KAZUHITO(萩尾 一仁) wrote:
> > > Hi Baoquan,
> > > 
> > > -----Original Message-----
> > > > On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
> > > > > The offset of the field 'init_uts_ns.name' has changed
> > > > > since commit 9a56493f6942 ("uts: Use generic ns_common::count").
> > > > 
> > > > This patch is merged into 5.11-rc1, but we met the makedumpfile failure
> > > > of kdump test case in 5.10.0 kernel. Should affect 5.9 too since
> > > > commit 9a56493f6942 is merged into 5.9-rc2.
> > > 
> > > Hmm, commit 9a56493f6942 should have been merged into 5.11-rc1
> > > together with commit ca4a9241cc5e.
> > 
> > Checked on master branch of mainline kernel, commit 9a56493f6942 is in
> > 5.9-rc1.
> 
> 
> No, that commit is in 5.11-rc1, not 5.9-rc1:
> 	$ git describe --contains 9a56493f6942
> 	v5.11-rc1~182^2~9

Oh, then I was wrong about it. I add linux-next repo in my linux kernel
folder, so I can't get it with the above command on master branch of
mainline kernel:

[bhe@~ linux]$ git describe --contains 9a56493f6942
next-20200820~107^2~8

I just use 'git log --oneline' and found out commit 9a56493f6942 is
added before 5.9-rc1. Seems this is not right way to get the kernel
release. So please ignore the back porting request of stable tree.
Sorry about the confusion.

Thanks
Baoquan

> 
> > commit ca4a9241cc5e is merged into 5.11-rc1.
> > 
> > commit 9a56493f6942c0e2df1579986128721da96e00d8
> > Author: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Date:   Mon Aug 3 13:16:21 2020 +0300
> > 
> >     uts: Use generic ns_common::count
> > 
> > 
> > commit ca4a9241cc5e718de86a34afd41972869546a5e3
> > Author: Alexander Egorenkov <egorenar@linux.ibm.com>
> > Date:   Tue Dec 15 20:45:31 2020 -0800
> > 
> >     kdump: append uts_namespace.name offset to VMCOREINFO
> 
> 
> Are you all sure this is needed in 5.10.y?
> 
> thanks,
> 
> greg k-h
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

