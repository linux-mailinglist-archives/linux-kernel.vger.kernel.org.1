Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804E529108D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437496AbgJQHeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437489AbgJQHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602920047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3KAINg8BNoCuG8bCQJ62lnGK5HBs8vSXpaMWaoVlLo=;
        b=gm6LP6Md7nCAa2r5KDgxn07PlkEyfcrqJ4dQSEO16iW2PeFps4sjT7K7R0NCZimj17oZrD
        m2IvwLMheNIcgCaj4/bL6NXapPIwiugITM0uVAGL82V8248AoTOLCp4iyoi3ydZlSJuUuq
        XAPK7a8/Q8GDK+YQVP6Z+1k0Naaf5/g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-lYtzM88zOkiLBqBGXQLZRw-1; Sat, 17 Oct 2020 03:34:05 -0400
X-MC-Unique: lYtzM88zOkiLBqBGXQLZRw-1
Received: by mail-ed1-f70.google.com with SMTP id i22so2952419edu.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 00:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=P3KAINg8BNoCuG8bCQJ62lnGK5HBs8vSXpaMWaoVlLo=;
        b=pxUequZVZW6QGr0vMvC9KuKpDYCIASAHZJG4jDYslGqOO9dbGPBJqlOQ5uMQkQ75is
         ytlhhlK6ne6j9aB+T9rbSnIpyaayT6VvwYmB0JzVK9KMTLD1UQQyJRXFYWNnHcogrq1j
         jSo1xPu42SzlYt91elCf5TdVlf2hbN26bEV6lB88+04ZFPpoTgAUE/I+qnEZqMe6LlBE
         HuqHe0jp0fMiG+aau9EPKag7WW8YTBICI4qJE8tsOwOipiyKsrUQkCEn7879uyMUblnX
         TpZrHIZpmib8Pw27xgwIMcXMEt8WJ/tNjMshp9x8jEIm+HgBWoHLPUWbNfi50ePVK/5F
         kmTg==
X-Gm-Message-State: AOAM532tu1KU3IhScdlGZvaCbgmwwfJtQ/ZYNPqIHY3xknIywQpnGsYs
        CWCUXT9RPr+amx9ku0L2AZhlGfqNMyXLVGFDNtxE5DQx1GmKHWwAFNqgK4JeURjJDM8/kTZT6Wk
        wDXVa4PCiwKKDQYelcL95uwdD
X-Received: by 2002:a17:906:b0d7:: with SMTP id bk23mr7898175ejb.103.1602920044176;
        Sat, 17 Oct 2020 00:34:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw342FUQjFUP7HhPAUabllimsjaLbjdlXWUcUskiQHFdl6RF7ue37YFNOK9g8Wbuv2tXjxx7g==
X-Received: by 2002:a17:906:b0d7:: with SMTP id bk23mr7898150ejb.103.1602920044004;
        Sat, 17 Oct 2020 00:34:04 -0700 (PDT)
Received: from [192.168.3.114] (p4ff239ab.dip0.t-ipconnect.de. [79.242.57.171])
        by smtp.gmail.com with ESMTPSA id si13sm4354754ejb.49.2020.10.17.00.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 00:34:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] arm64: allow hotpluggable sections to be offlined
Date:   Sat, 17 Oct 2020 09:34:02 +0200
Message-Id: <04C5B822-70DF-47CF-9F76-2A31843B01E8@redhat.com>
References: <c5f96b483158871ff65377884955fb0106e43951.1602899443.git.sudaraja@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
In-Reply-To: <c5f96b483158871ff65377884955fb0106e43951.1602899443.git.sudaraja@codeaurora.org>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 17.10.2020 um 04:03 schrieb Sudarshan Rajagopalan <sudaraja@codeaurora.=
org>:
>=20
> =EF=BB=BFOn receiving the MEM_GOING_OFFLINE notification, we disallow offl=
ining of
> any boot memory by checking if section_early or not. With the introduction=

> of SECTION_MARK_HOTPLUGGABLE, allow boot mem sections that are marked as
> hotpluggable with this bit set to be offlined and removed. This now allows=

> certain boot mem sections to be offlined.
>=20

The check (notifier) is in arm64 code. I don=E2=80=98t see why you cannot ma=
ke such decisions completely in arm64 code? Why would you have to mark secti=
ons?

Also, I think I am missing from *where* the code that marks sections removab=
le is even called? Who makes such decisions?

This feels wrong.=20

> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> ---
> arch/arm64/mm/mmu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 75df62fea1b6..fb8878698672 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1487,7 +1487,7 @@ static int prevent_bootmem_remove_notifier(struct no=
tifier_block *nb,
>=20
>    for (; pfn < end_pfn; pfn +=3D PAGES_PER_SECTION) {
>        ms =3D __pfn_to_section(pfn);
> -        if (early_section(ms))
> +        if (early_section(ms) && !removable_section(ms))
>            return NOTIFY_BAD;
>    }
>    return NOTIFY_OK;
> --=20
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>=20

