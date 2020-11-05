Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92982A7CB9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgKELNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:13:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726777AbgKELNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604574829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4k4SKFvZRyxZUUectJ8LVntk4jaYo6zD7QcqD9bzQo=;
        b=OwkXpKqQOpgP1/38NHLhEsilM6k6hcDSdN48mDN2WONE+3b7Tm+ZGCTGjK6Q0D7KkBCOS0
        WXZ2Zd74e4CqirCD/FDiz3PNXo+izXdH8AiB8bZCpBiXkMe5gqupugqOcJ7m8vL355A5uO
        c7U/WwmHT22iYly17lygXZ/Eg4fHEGA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-PfmTXiHVMiicrFf7Yyh18Q-1; Thu, 05 Nov 2020 06:13:47 -0500
X-MC-Unique: PfmTXiHVMiicrFf7Yyh18Q-1
Received: by mail-ed1-f72.google.com with SMTP id a73so394331edf.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=R4k4SKFvZRyxZUUectJ8LVntk4jaYo6zD7QcqD9bzQo=;
        b=VEQrLKM+39tX64uK6VaMY9VrcGK6oDgB35b9WBFtngW/bmc1ta6KqNH0smhLVjKMhv
         QWepZnWvTLY7MBhC+Xn0O07OawdXxRi4yo8TrkSbNNdDbg+UTGk+TNE21+2MpQlTI/BN
         W/+N1ht68SQ/942/dAjNGnwc5sCZSlEfz6rIAyZmEPLGYxpJ0XCKNOUSUigpTAJI6ZOj
         b3I47C8jumbWycdEFwFtEV9Iz9+LlPRBGVJyKFwD90MdonezmBVdTYMEExouXc1V+gG6
         7VDUvz+aEFvzbFvldYOw5fNu2j/qXc7fNYmk6sM9APWvjzo0g2/fOJ7LdKpl+tYZ6w7g
         hkzQ==
X-Gm-Message-State: AOAM532+MBjJjPr8R9GKCjmK+uVpTjrFsqAWlbF6Ld0MrCr7vi3/7prV
        7xEddwR8etJ9duKAxI7jLP+p97EqmBqFfrLO8GNCNlDqcTkAJlD7pY5lZLsSw8N18rbfr8JUrCX
        dTOZedMSmbdSKUfdPfzV0vYR8
X-Received: by 2002:a50:c945:: with SMTP id p5mr1928196edh.55.1604574825535;
        Thu, 05 Nov 2020 03:13:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMWEEePBbN5mYNTiJIeSojG5bngWsmvejr1D1k6BEnMf3C+wxb81JDQRgnZ9/PS9P4/dmEmw==
X-Received: by 2002:a50:c945:: with SMTP id p5mr1928180edh.55.1604574825274;
        Thu, 05 Nov 2020 03:13:45 -0800 (PST)
Received: from [10.167.228.65] (tmo-098-193.customers.d1-online.com. [80.187.98.193])
        by smtp.gmail.com with ESMTPSA id z13sm744106ejp.30.2020.11.05.03.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 03:13:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to tail in __free_pages_core()"
Date:   Thu, 5 Nov 2020 12:13:43 +0100
Message-Id: <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
References: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Pavel Procopiuc <pavel.procopiuc@gmail.com>, david@redhat.com,
        ath11k@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
In-Reply-To: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 05.11.2020 um 11:42 schrieb Vlastimil Babka <vbabka@suse.cz>:
>=20
> =EF=BB=BFOn 11/5/20 10:04 AM, Kalle Valo wrote:
>> (changing the subject, adding more lists and people)
>> Pavel Procopiuc <pavel.procopiuc@gmail.com> writes:
>>> Op 04.11.2020 om 10:12 schreef Kalle Valo:
>>>> Yeah, it is unfortunately time consuming but it is the best way to get
>>>> bottom of this.
>>>=20
>>> I have found the commit that breaks things for me, it's
>>> 7fef431be9c9ac255838a9578331567b9dba4477 mm/page_alloc: place pages to
>>> tail in __free_pages_core()
>>>=20
>>> I've reverted it on top of the 5.10-rc2 and ath11k driver loads fine
>>> and I have wifi working.
>> Oh, very interesting. Thanks a lot for the bisection, otherwise we would
>> have never found out whats causing this.
>> David & mm folks: Pavel noticed that his QCA6390 Wi-Fi 6 device (driver
>> ath11k) failed on v5.10-rc1. After bisecting he found that the commit
>> below causes the regression. I have not been able to reproduce this and
>> for me QCA6390 works fine. I don't know if this needs a specific kernel
>> configuration or what's the difference between our setups.
>> Any ideas what might cause this and how to fix it?
>> Full discussion: http://lists.infradead.org/pipermail/ath11k/2020-Novembe=
r/000501.html
>> commit 7fef431be9c9ac255838a9578331567b9dba4477
>> Author:     David Hildenbrand <david@redhat.com>
>> AuthorDate: Thu Oct 15 20:09:35 2020 -0700
>> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
>> CommitDate: Fri Oct 16 11:11:18 2020 -0700
>>     mm/page_alloc: place pages to tail in __free_pages_core()
>=20
> Let me paste from the ath11k discussion:
>=20
>> * Relevant errors from the log:
>> # journalctl -b | grep -iP '05:00|ath11k'
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class=
 0x028000
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000=
-0xd21fffff 64bit]
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3=
hot D3cold
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe=
 bandwidth, limited by 5.0 GT/s PCIe x1 link at 0000:00:1c.1 (capable of 7.8=
76 Gb/s with 8.0 GT/s PCIe x1 link)
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PC=
I support is experimental!
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [m=
em 0xd2100000-0xd21fffff 64bit]
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0=
000 -> 0002)
>> Nov 02 10:41:27 razor kernel: mhi 0000:05:00.0: Requested to power ON
>> Nov 02 10:41:27 razor kernel: mhi 0000:05:00.0: Power on setup success
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req fa=
iled, result: 1, err: 0
>=20
> This seems to be ath11k_qmi_respond_fw_mem_request(). Why is it failure wi=
th error 0? No idea.
>=20
> What would happen if all the GFP_KERNEL in the file were changed to GFP_DM=
A32?
>=20
> I'm thinking the hardware perhaps doesn't like too high physical addresses=
 or something. But if I think correctly, freeing to tail should actually mov=
e them towards head. So it's weird.

It depends in which order memory is exposed to MM, which might depend on oth=
er factors in some configurations.

This smells like it exposes an existing bug. Can you reproduce also with zon=
e shuffling enabled?=

