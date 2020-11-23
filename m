Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4072C0EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389522AbgKWPbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:31:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49500 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389471AbgKWPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:31:39 -0500
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1khDoX-0007La-AC
        for linux-kernel@vger.kernel.org; Mon, 23 Nov 2020 15:31:37 +0000
Received: by mail-ed1-f69.google.com with SMTP id d3so6753647eds.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:31:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIYmatONslBJtx0vls11e+ppVgIv/t+HfpL12twmIjk=;
        b=Fa/2Oh2bGgMTuVCcoT9MbOYFy8Wmv28zBw18Eetu8lNlFbB6STTaCcyJwuWcG9aXvA
         aRDm40AtqVhCdQhJ57Ee5zHJOTfSAuob+OmhI50JCGcdfHAFJ+wpxj+8BcJUA/VD5xn/
         UpMwrYdtt7A5Pu8yBmHOmVs441U6ZtHQDApAO+7H2F2oFd9ZzH9pxFFswCipRhDnuePs
         edT8uROZqh/FAZdRaqF5W/wcOSFPWkQwRVk0V3rTWIQOw3iYOFr9dHS3FFFywD6j3Het
         6/JGn/I1Ijq6oH4xpgaeIWU20wMUnAGRD35T2Ebp+1YoC8Td3cbZN9FIuQTuiopTGCjK
         Lnpw==
X-Gm-Message-State: AOAM531QK9i+C1pieRr0Jq5cvK0JVqUDt3aenKQ0JdDvMqFvOtRcxs92
        1N1vh+XmSxSmhO8787R1fpoYRALYFKggIeiDrYgMgV/AHtnpR9GJmCKgtGnQo5PLcflHLtVgHbw
        EWOyQwRPcxQZlpZw8hKY8aZExYWD3b/Gu1X5uPG5dz8Ve7/mseSvZZXh7mA==
X-Received: by 2002:aa7:d298:: with SMTP id w24mr5994012edq.82.1606145497009;
        Mon, 23 Nov 2020 07:31:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrWu7xVwFBmOecqSZY4ld78I3wZkqLcisWUTr1xKJt3H6E/cA0mPHuJlf+nhK7/Ew1KW1Eno+hgp66Z/wsDtc=
X-Received: by 2002:aa7:d298:: with SMTP id w24mr5993991edq.82.1606145496804;
 Mon, 23 Nov 2020 07:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20201104220804.21026-1-Ashish.Kalra@amd.com>
In-Reply-To: <20201104220804.21026-1-Ashish.Kalra@amd.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 23 Nov 2020 12:31:00 -0300
Message-ID: <CAHD1Q_ycPbd9uuEN2nuT4norwuRt04E5ZdqAVC9si1c-T=SRmA@mail.gmail.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV guests.
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com,
        ssg.sos.patches@amd.com, dave.hansen@linux-intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, luto@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashish, non-technical comment: in the subject, you might want to
s/SWIOTBL/SWIOTLB .
cheers,


Guilherme
