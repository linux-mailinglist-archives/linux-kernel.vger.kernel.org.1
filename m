Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BCC2BB867
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgKTVe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:34:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727665AbgKTVe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605908095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5aUMWdjt8NVidkZhMPjXUDGGPBhWxvoJByLecsN7Rc4=;
        b=h7mRX8Vzn0TyXCbaUePBXrvITFFqXf+zAFs+E6SUMxi+yRtwsYI7Q5eyP102oizluzMGNW
        ssdAGSzqlEFcUav+Ao4eL4zH4s9ByqJUyqxKUXFUFDcm/2MUJerK20Q6jXVT3uKFLKAEcE
        c2DQwkL9rc6Y9fKOz4BnXkxM6va40BE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-mp0kn-iTOAyyEWvCkyFF8Q-1; Fri, 20 Nov 2020 16:34:53 -0500
X-MC-Unique: mp0kn-iTOAyyEWvCkyFF8Q-1
Received: by mail-wr1-f69.google.com with SMTP id y2so3879359wrl.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5aUMWdjt8NVidkZhMPjXUDGGPBhWxvoJByLecsN7Rc4=;
        b=VMznXd1jCxufZxjsDu7b4nOhzBeeDraRS3P8yQtvaiTZS9BCSDxbzzrvNDLg5tdg+p
         fqgzK7nrqRjwK0uQhqhUIIWh42BM3iGqAA3Cxm6ynFpOgcsVEvyLSl2CfTcGEJcqcFTd
         uR7VZaRDkDfXlDMv1GvdOhzBd6WzdMuNg6sSZ7pKI0IYS9q4f9pXLJ3s50k1v5ySa+Ca
         mkC/c61gKsISDtES+YDdxmDaQxxTULaTrU5Y/W9+LeFSNmbg/RdD1pMsM8oPHFgQR0jv
         6y1E4J1MQzUa/YlJMQqTh0T6uqEWJxG5sPJgwGVjw3LjS3vSqWHaDRHOG/mNTbJfIPK3
         +uOw==
X-Gm-Message-State: AOAM532mEaJ4LzN6rJphqXcT16zNAk7Ysd7nqSG84fd4hzgpRgFbTU2+
        BKz7SuHBSxIuy+JWYlzpRxCBJsuPAq2R92jTs33aeksKItVnxWovLfskcysgEK2/TU7AyndMgik
        gQCfMJlBA43CTv62YmjpPBpfi
X-Received: by 2002:adf:ea03:: with SMTP id q3mr17402810wrm.141.1605908091752;
        Fri, 20 Nov 2020 13:34:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxecvW/iJw52Oq3XaFaHXe3IG/dsUhTmxrUXFu6xAkfe45n2PoZMFzgnGJYtxW/ezeiYRptcw==
X-Received: by 2002:adf:ea03:: with SMTP id q3mr17402796wrm.141.1605908091521;
        Fri, 20 Nov 2020 13:34:51 -0800 (PST)
Received: from [192.168.3.114] (p5b0c6104.dip0.t-ipconnect.de. [91.12.97.4])
        by smtp.gmail.com with ESMTPSA id g11sm6774100wrq.7.2020.11.20.13.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 13:34:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Pinning ZONE_MOVABLE pages
Date:   Fri, 20 Nov 2020 22:34:49 +0100
Message-Id: <9C8F0E5D-2D42-4BA5-A5B5-9E049E1BE862@redhat.com>
References: <20201120211707.GC4327@casper.infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com
In-Reply-To: <20201120211707.GC4327@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 20.11.2020 um 22:17 schrieb Matthew Wilcox <willy@infradead.org>:
>=20
> =EF=BB=BFOn Fri, Nov 20, 2020 at 09:59:24PM +0100, David Hildenbrand wrote=
:
>>=20
>>>> Am 20.11.2020 um 21:28 schrieb Pavel Tatashin <pasha.tatashin@soleen.co=
m>:
>>>=20
>>> =EF=BB=BFRecently, I encountered a hang that is happening during memory h=
ot
>>> remove operation. It turns out that the hang is caused by pinned user
>>> pages in ZONE_MOVABLE.
>>>=20
>>> Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
>>> this is not the case if a user applications such as through dpdk
>>> libraries pinned them via vfio dma map. Kernel keeps trying to
>>> hot-remove them, but refcnt never gets to zero, so we are looping
>>> until the hardware watchdog kicks in.
>>>=20
>>> We cannot do dma unmaps before hot-remove, because hot-remove is a
>>> slow operation, and we have thousands for network flows handled by
>>> dpdk that we just cannot suspend for the duration of hot-remove
>>> operation.
>>>=20
>>=20
>> Hi!
>>=20
>> It=E2=80=98s a known problem also for VMs using vfio. I thought about thi=
s some while ago an came to the same conclusion: before performing long-term=
 pinnings, we have to migrate pages off the movable zone. After that, it=E2=80=
=98s too late.
>=20
> We can't, though.  VMs using vfio pin their entire address space (right?)
> so we end up with basically all of the !MOVABLE memory used for VMs and
> the MOVABLE memory goes unused (I'm thinking about the case of a machine
> which only hosts VMs and has nothing else to do with its memory).  In
> that case, the sysadmin is going to reconfigure ZONE_MOVABLE away, and
> now we just don't have any ZONE_MOVABLE.  So what's the point?

When the guest is using an vIOMMU, it will only pin what=E2=80=98s currently=
 mapped by the guest into the vIOMMU. Otherwise: yes.

If you assume all memory will be used for VMs with vfio, then yes: no ZONE_M=
OVABLE, no memory hotunplug. If its=E2=80=98s only some VMs, it=E2=80=98s a d=
ifferent story.

>=20
> ZONE_MOVABLE can also be pinned by mlock() and other such system calls.

Mlocked pages can be migrated, no? They are simply not swappable iirc.

> The kernel needs to understand that ZONE_MOVABLE memory may not actually
> be movable, and skip the unmovable stuff.
>=20

Then you don=E2=80=98t have unplug guarantees. Memory unplug broken by desig=
n. Then there is no point in optimizing that case at all and tell customers =E2=
=80=9Evfio and memory hotunplug is incompatible=E2=80=9C. The only ugly thin=
g is the endless loop.=

