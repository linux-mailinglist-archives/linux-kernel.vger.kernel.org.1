Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014412F2477
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391465AbhALAYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:24:47 -0500
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46656 "EHLO
        ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390856AbhAKW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:57:16 -0500
X-Greylist: delayed 987 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2021 17:57:15 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk;
         s=20180806.ppsw; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ubJM33kU3xsjzHRYhB0tpE3AOfiw+sSQImPwRb0K+gs=; b=ZNI0ks9Vi6PIiNmfyj/RBDynqn
        m9OLvA6mceITmc8rGCX19XTWutCKIGOgfp23chcymEVgUTQt55wshs4+7Ta3StnxfFdxavjo5vq+l
        PMTXyjCvJo1yDqHyUJj9sLfrGEaBNrHOU/a8P151vuAuakF9hwhBE/tsJfEErUKExL40=;
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from 88-111-124-141.dynamic.dsl.as9105.com ([88.111.124.141]:51080 helo=[192.168.1.219])
        by ppsw-41.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:465)
        with esmtpsa (PLAIN:amc96) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        id 1kz5qn-000X0j-SK (Exim 4.92.3)
        (return-path <amc96@cam.ac.uk>); Mon, 11 Jan 2021 22:39:49 +0000
Subject: Re: [PATCH] xen/privcmd: allow fetching resource sizes
To:     boris.ostrovsky@oracle.com, Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Paul Durrant <paul.durrant@citrix.com>,
        xen-devel@lists.xenproject.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Cooper <amc96@cam.ac.uk>
References: <20210111152958.7166-1-roger.pau@citrix.com>
 <555ba53c-1b6b-6cf7-9887-52d4179f7456@oracle.com>
From:   Andrew Cooper <amc96@cam.ac.uk>
Message-ID: <ed089f3f-4950-f3e9-6df6-07ca9148e6a6@cam.ac.uk>
Date:   Mon, 11 Jan 2021 22:39:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <555ba53c-1b6b-6cf7-9887-52d4179f7456@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2021 22:09, boris.ostrovsky@oracle.com wrote:
> On 1/11/21 10:29 AM, Roger Pau Monne wrote:
>>  
>> +	xdata.domid = kdata.dom;
>> +	xdata.type = kdata.type;
>> +	xdata.id = kdata.id;
>> +
>> +	if (!kdata.addr && !kdata.num) {
>
> I think we should not allow only one of them to be zero. If it's only kdata.num then we will end up with pfns array set to ZERO_SIZE_PTR (which is 0x10). We seem to be OK in that we are not derefencing pfns (either in kernel or in hypervisor) if number of frames is zero but IMO we shouldn't be tempting the fate.
>
>
> (And if it's only kdata.addr then we will get a vma but I am not sure it will do what we want.)

Passing addr == 0 without num being 0 is already an error in Xen, and
passing num == 0 without addr being 0 is bogus and will be an error by
the time I'm finished fixing this.

FWIW, the common usecase for non-trivial examples will be:

xenforeignmem_resource_size(domid, type, id, &size);
xenforeignmem_map_resource(domid, type, id, NULL, size, ...);

which translates into:

ioctl(MAP_RESOURCE, NULL, 0) => size
mmap(NULL, size, ...) => ptr
ioctl(MAP_RESOURCE, ptr, size)

from the kernels point of view, and two hypercalls from Xen's point of
view.  The NULL's above are expected to be the common case for letting
the kernel chose the vma, but ought to be filled in by the time the
second ioctl() occurs.

See
https://lore.kernel.org/xen-devel/20200922182444.12350-1-andrew.cooper3@citrix.com/T/#u
for all the gory details.

~Andrew
