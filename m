Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D5B2EF0A0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbhAHKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:24:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbhAHKYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610101356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPlcFGEh/ksvh5rQy00+1PndahkVcKk0pnC2uSmTiXA=;
        b=KgqYv6CbG8rH/skd3K9GUX4ceuf5MjXvWcR7YF6bbIzEonMTMotDJJfSnCIGbBa1N/iRUO
        iWg/CE9jFO5AQGw9kgug976QwwAEobAK3EcfWXwHGjtWRdylsFaiFn0kD6A+3JzIzSdihS
        Ut3vELFkbvUSwQ3rmnRWnFDh072eilk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-l8HwyW46Nu2chPyhXUk0JQ-1; Fri, 08 Jan 2021 05:22:32 -0500
X-MC-Unique: l8HwyW46Nu2chPyhXUk0JQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AF12612A0;
        Fri,  8 Jan 2021 10:22:31 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5B4960C5F;
        Fri,  8 Jan 2021 10:22:26 +0000 (UTC)
Date:   Fri, 8 Jan 2021 18:22:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= 
        <k-hagio-ab@nec.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lijiang@redhat.com" <lijiang@redhat.com>,
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
Message-ID: <20210108102224.GC4959@MiWiFi-R3L-srv>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
 <OSBPR01MB1991DBFA6C4BD6818947EF6BDDAE0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB1991DBFA6C4BD6818947EF6BDDAE0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/21 at 10:07am, HAGIO KAZUHITO(萩尾 一仁) wrote:
> Hi Baoquan,
> 
> -----Original Message-----
> > On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
> > > The offset of the field 'init_uts_ns.name' has changed
> > > since commit 9a56493f6942 ("uts: Use generic ns_common::count").
> > 
> > This patch is merged into 5.11-rc1, but we met the makedumpfile failure
> > of kdump test case in 5.10.0 kernel. Should affect 5.9 too since
> > commit 9a56493f6942 is merged into 5.9-rc2.
> 
> Hmm, commit 9a56493f6942 should have been merged into 5.11-rc1
> together with commit ca4a9241cc5e.

Checked on master branch of mainline kernel, commit 9a56493f6942 is in
5.9-rc1. commit ca4a9241cc5e is merged into 5.11-rc1.

commit 9a56493f6942c0e2df1579986128721da96e00d8
Author: Kirill Tkhai <ktkhai@virtuozzo.com>
Date:   Mon Aug 3 13:16:21 2020 +0300

    uts: Use generic ns_common::count


commit ca4a9241cc5e718de86a34afd41972869546a5e3
Author: Alexander Egorenkov <egorenar@linux.ibm.com>
Date:   Tue Dec 15 20:45:31 2020 -0800

    kdump: append uts_namespace.name offset to VMCOREINFO


> 
> Does your makedumpfile have the following patch?
> https://github.com/makedumpfile/makedumpfile/commit/54aec3878b3f91341e6bc735eda158cca5c54ec9

We met this issue on 5.10 kernel, the latest makedumpfile 1.6.8+ fixs
it. Makedumpfile 1.6.8+ includes the commit 54aec3878b3f. Not sure if I
got the kernel commit right in their corresponding release.

Thanks
Baoquan

