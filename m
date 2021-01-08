Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EADF2EEEC5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbhAHItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:49:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbhAHItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610095709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GrPWSJyWVgt1dzxzcidGBgsecDItxx82P05HwydS4JQ=;
        b=PRGvJEIU8+13KbiIb7yVHmQoPcVdkxmqUiYCypC/SwbWWiKTC+qtukDfP9taMa6En5A/OW
        24sMqjfwCiSIfSkExp9TEa48EGXB3uUhos2Fdr4fCovqywpb1LSTPivr6jn2USOPNfouP1
        JbnqZdu1L/YkLxg+WvCztKmBbd0QK5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-nVr29Am_NJCtW9Sxr8oV8Q-1; Fri, 08 Jan 2021 03:48:25 -0500
X-MC-Unique: nVr29Am_NJCtW9Sxr8oV8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 565D5800D55;
        Fri,  8 Jan 2021 08:48:23 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8014C60937;
        Fri,  8 Jan 2021 08:48:19 +0000 (UTC)
Date:   Fri, 8 Jan 2021 16:48:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexander Egorenkov <egorenar@linux.ibm.com>, dyoung@redhat.com,
        vgoyal@redhat.com, lijiang@redhat.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ktkhai@virtuozzo.com,
        keescook@chromium.org, christian.brauner@ubuntu.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <20210108084816.GB4959@MiWiFi-R3L-srv>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
 <X/gT6jQTaFkqqIGt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/gT6jQTaFkqqIGt@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/21 at 09:12am, Greg KH wrote:
> On Fri, Jan 08, 2021 at 11:32:48AM +0800, Baoquan He wrote:
> > On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
> > > The offset of the field 'init_uts_ns.name' has changed
> > > since commit 9a56493f6942 ("uts: Use generic ns_common::count").
> > 
> > This patch is merged into 5.11-rc1, but we met the makedumpfile failure
> > of kdump test case in 5.10.0 kernel. Should affect 5.9 too since
> > commit 9a56493f6942 is merged into 5.9-rc2.
> > 
> > Below tag and CC should have been added into patch when posted. 
> > 
> > Fixes: commit 9a56493f6942 ("uts: Use generic ns_common::count")
> > Cc: <stable@vger.kernel.org>
> > 
> > Hi Greg,
> > 
> > Do we still have chance to make it added into stable?
> 
> Sure, what is the git commit id of this patch in Linus's tree?

This commit:

ca4a9241cc5e kdump: append uts_namespace.name offset to VMCOREINFO

> 
> In the future, please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.

Sure, will do as the doc said in the future, thanks a lot for the
pointer.

Thanks
Baoquan

