Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54532C9499
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389247AbgLABVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgLABVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:21:11 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C30C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:20:30 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id m19so403816ejj.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=J+1U/f8XUIfRYcLWaEg2HuJO67e2bBkfXtfCPlsTd8I=;
        b=Uzmqq/O0H8LGO8ruL15nzggaqZT5+d2foYv3eXaSR9eNZIPcQwx9us0q6mHObu0lyZ
         STWaZymD2WDC9z8lUYjT6RDWe1Ek+qgPxfgjzFBmxAcXmnljtAO2Mp2JikFtTsCMyjDT
         FEfHk5WXXH6X6iRsgt740Uon3v/4GujWFcy2/3bL6AoDnJ52xj42AUomdmC1EJjzSPIs
         kkItq0ZgVFlnfGJKJBxKCBA/GwhW9MWHoBpnNLJd1T6y2Tf++ePuwgljIAv++/AM0lLr
         0MyMazwANlgRfgSOINEXOXXHdCDaT2uZHLQTJ8BL2UXzVOErHpCDaktgGpRQ7qV0omJl
         B3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=J+1U/f8XUIfRYcLWaEg2HuJO67e2bBkfXtfCPlsTd8I=;
        b=dKk2LN7rRuSx9MNmix8aj29AIC6mDfS0goW5+bQXgNkOo/S8LFiYcJVBAz5xIJugva
         lc6epzPkoXKiD/ktHqWeQoHplEBz/YT1fcWhioicN3k7y/QuAAXbW8y7Em7d4CLIt/za
         yEo/TpoXPx7lx1ayUFeAJ+qyZvy+ib1btlna2cHLOgFqpj7Uw8tlJ45EVlVRYSKsg1RX
         EPMKShU92Dr4MWivDjaRj7APkCoA2W4fm80V62bdB1xuHRjRm7hvKFqvTTXM47vX7CGC
         iWrylRSG3qm3iwnqjx1y+vlii+yYnoqsRgo4zuN3Bq2k7f4Cz4yiEnqzOpcB1kKjkoek
         eO5Q==
X-Gm-Message-State: AOAM531TnrXkMzQ98a7Ga0XVeNzAm9Mgh3tewr2xNqNoliNirM/1cH7A
        /RuckGFRF8oNJ8Lf4v/neZpyNRTJXNqztq65HQkb/sF+VvERCA==
X-Google-Smtp-Source: ABdhPJwQsKZvZIvFtzYz5SKLhjU9W4cEeglvDwkZ9WlyzschrlmmfuQnvhrsnqHbTMw6vrio/DD/YMY3EUD2jcR43as=
X-Received: by 2002:a17:906:6bc9:: with SMTP id t9mr641225ejs.472.1606785629524;
 Mon, 30 Nov 2020 17:20:29 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 30 Nov 2020 17:20:25 -0800
Message-ID: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
Subject: mapcount corruption regression
To:     "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill, Willy, compound page experts,

I am seeking some debug ideas about the following splat:

BUG: Bad page state in process lt-pmem-ns  pfn:121a12
page:0000000051ef73f7 refcount:0 mapcount:-1024
mapping:0000000000000000 index:0x0 pfn:0x121a12
flags: 0x2ffff800000000()
raw: 002ffff800000000 dead000000000100 0000000000000000 0000000000000000
raw: 0000000000000000 ffff8a6914886b48 00000000fffffbff 0000000000000000
page dumped because: nonzero mapcount
[..]
CPU: 26 PID: 6127 Comm: lt-pmem-ns Tainted: G           OE     5.10.0-rc4+ #450
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
Call Trace:
 dump_stack+0x8b/0xb0
 bad_page.cold+0x63/0x94
 free_pcp_prepare+0x224/0x270
 free_unref_page+0x18/0xd0
 pud_free_pmd_page+0x146/0x160
 ioremap_pud_range+0xe3/0x350
 ioremap_page_range+0x108/0x160
 __ioremap_caller.constprop.0+0x174/0x2b0
 ? memremap+0x7a/0x110
 memremap+0x7a/0x110
 devm_memremap+0x53/0xa0
 pmem_attach_disk+0x4ed/0x530 [nd_pmem]

It triggers on v5.10-rc4 not on v5.9, but the bisect comes up with an
ambiguous result. I've run the bisect 3 times and landed on:

032c7ed95817 Merge tag 'arm64-upstream' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux

...which does not touch anything near _mapcount. I suspect there is
something unique about the build that lines up the corruption to
happen or not happen.

The test is a simple namespace creation test that results in an
memremap() / ioremap() over several gigabytes of memory capacity. The
-1024 was interesting because that's the GUP_PIN_COUNTING_BIAS, but
that's the _refcount, I did not see any questionable changes to how
_mapcount is manipulated post v5.9. Problem should be reproducible by
running:

make -j TESTS="pmem-ns" check

...in qemu-kvm with some virtual pmem defined:

-object memory-backend-file,id=mem1,share,mem-path=${mem}1,size=$((mem_size+label_size))
-device nvdimm,memdev=mem1,id=nv1,label-size=${label_size}

...where ${mem}1 is a 128GB sparse file $mem_size is 127GB and
$label_size is 128KB.
