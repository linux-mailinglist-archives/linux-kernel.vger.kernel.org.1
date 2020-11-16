Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549422B49B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgKPPoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729795AbgKPPoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:44:03 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A925C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:44:02 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so25738134lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oivIdgQaz5+Gp2NLctXgWUVrml124AnA4kh8cM9g7mM=;
        b=uacpSvyg7sNcaRSGZ7Q3s8sTWe0zmTrFvRT2fZ38n++Dg/H+rJ57tNnHKW+Nn9wRY2
         xYrUSAFI9AREFZuosouqgZ9Od7ZUxEJ8dHq4guk/WYcKvzkvUDLFspZJrQhNaRVkDdLW
         1GWD1S9qA8aMOaqIZb349wy74E/CQDpFlvouD2b/tOIu5CK+5cloUZlhO6BW4sb3G/Xr
         BwhGxYp3w9yXabcKrrLw4EQC5eQhlR4F22zf6KrBG8tYkcerLZVgRRUnP7yqzFF0fdIa
         93XPaoPWr21DOOO3u3riLFklco7wH/gsEkrEsZwe8rltgtblHLC8qusqEu6duJ+CGIyS
         CUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oivIdgQaz5+Gp2NLctXgWUVrml124AnA4kh8cM9g7mM=;
        b=bzkBjm6zmvgGY3V9I6aRlifFcUYgGyg8wcF5NPUk3tace0AdShW140e/bygwEQ0D0/
         IHw/eHl69fo+B+4on8S/optErpI6WJtlve6Bn3i+7RoQ5U8j1scm02NmxWTXzIHKXhfz
         XIfq7LAbIjfqYaRhLWlXyrvB1YRD78P6wbGjAdL0u2tMP7BVIgbvy8JGhdrxmTnRynAD
         ViCMSmeSb3sFydkdch6XIZanA5qA08WJnzkeOImuGiaq0ZSef3kWfSeHG8N/rToTqDAb
         GgMAu39qDZj5114FCdk/q2IcL0R5ogl0snlnIB8wrpNsPThV9QW8FKITT70f1Kqs1Od6
         bj/A==
X-Gm-Message-State: AOAM5300KTvHpi3sru0PKsGNsknTK5mJC+BliyIv7/OLKuN9cbbyNHeR
        DK+YTdgJNwfrt16JwqfbxQHq4g==
X-Google-Smtp-Source: ABdhPJzjLRw9j/vxUGUr0fVvvk1nlQOO9whebEt/gMYFPyoxALUMhdZDkMeMEsHU7VarRhJKNWMJuA==
X-Received: by 2002:a19:98d:: with SMTP id 135mr6966522lfj.357.1605541440721;
        Mon, 16 Nov 2020 07:44:00 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l17sm2796682lfc.221.2020.11.16.07.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:44:00 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id BA192100F5E; Mon, 16 Nov 2020 18:43:57 +0300 (+03)
Date:   Mon, 16 Nov 2020 18:43:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, will@kernel.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org,
        davem@davemloft.net, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-ID: <20201116154357.bw64c5ie2kiu5l4x@box>
References: <20201113111901.743573013@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113111901.743573013@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:19:01PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> These patches provide generic infrastructure to determine TLB page size from
> page table entries alone. Perf will use this (for either data or code address)
> to aid in profiling TLB issues.

I'm not sure it's an issue, but strictly speaking, size of page according
to page table tree doesn't mean pagewalk would fill TLB entry of the size.
CPU may support 1G pages in page table tree without 1G TLB at all.

IIRC, current Intel CPU still don't have any 1G iTLB entries and fill 2M
iTLB instead.

-- 
 Kirill A. Shutemov
