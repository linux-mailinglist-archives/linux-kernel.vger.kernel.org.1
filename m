Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9439E2CECC6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgLDLJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729952AbgLDLJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607080107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51Ta8qG1IJwa9FMhdW7Zn/PZ+B+58uhGmZ7f+I3PgHQ=;
        b=EjUc/CbXtdWNeg7XJxGzQScTIrCNrU5Vbv0vtnGiOxKdQ9854hZuYha6PHhaIfD+sKgJjT
        fbRn5CmO9YyyX+g//W5qtXd7kFGJdJ28UQoDE/kjofHtUUk6n8cVdrGWX2EnRHsk5sVlxN
        UzsBqRZvKHa/k3SWfAVUn4VtIWuPE/0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-55L2Kjo-OzelB0tHjqjSmg-1; Fri, 04 Dec 2020 06:08:23 -0500
X-MC-Unique: 55L2Kjo-OzelB0tHjqjSmg-1
Received: by mail-wr1-f70.google.com with SMTP id g5so2416692wrp.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 03:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=51Ta8qG1IJwa9FMhdW7Zn/PZ+B+58uhGmZ7f+I3PgHQ=;
        b=OXGV2EcJweq0sdXLGc7VG6WzIlnyBLL+o8EnapYzIzoESd6mZ08X4qVIAPLDQL8X2e
         qxtXRiCVt7QZX67kXfZoi2Gh4hefFFIFypxLtLP8ynEdE/+f887qvC7dlfop/xTSW7NW
         zhO0PidhTfAhkyCoKiG2dbrJ2KIqSy9eYko7MwydtJ/GobDWaOZ+1ZjDkqs19DB2f+5q
         4WUp0Tc1hQCpQnBPnDX7qBUqnMn/6fmihvEoXkStFV3JrmBds8/67MmzE8emzrvRFw81
         0DBDMN1BT0sC3O0VTgchs3huO6BBTMmOFDazWrGHRWkwy27q4loSSdYeET/qp+CTFv2F
         rmcw==
X-Gm-Message-State: AOAM532KpwTK1mg5Xo43hnYeSxXVtO8jTsaOjaIKUxPBtaiQhyPFBGHY
        SdizpTz0zW+IxRfWCiEdn3dMHh9edLxorvWIGDZ+4MzpZHchqVeo9MQ8FohhjQnzwCFZ5W99dmD
        W7UXpe39Bof4WPU4Q1CDji+Dq
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr3540693wmi.75.1607080102592;
        Fri, 04 Dec 2020 03:08:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaSpQbJ4PCf7tY/VAwGU9ugjT37tjEuse2PP6trdypYVGMkqe9JgB5jOkELb4bTR9auHQTnQ==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr3540670wmi.75.1607080102413;
        Fri, 04 Dec 2020 03:08:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b17sm2245212wrv.10.2020.12.04.03.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 03:08:21 -0800 (PST)
Subject: Re: [PATCH v8 12/18] KVM: SVM: Add support for static allocation of
 unified Page Encryption Bitmap.
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        joro@8bytes.org, bp@suse.de, Thomas.Lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, rientjes@google.com,
        venu.busireddy@oracle.com, brijesh.singh@amd.com
References: <cover.1588711355.git.ashish.kalra@amd.com>
 <17c14245a404ff679253313ffe899c5f4e966717.1588711355.git.ashish.kalra@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <617d3cba-cbe0-0f18-bdf2-e73a70e472d6@redhat.com>
Date:   Fri, 4 Dec 2020 12:08:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <17c14245a404ff679253313ffe899c5f4e966717.1588711355.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 23:18, Ashish Kalra wrote:
> Add support for static 
> allocation of the unified Page encryption bitmap by extending 
> kvm_arch_commit_memory_region() callack to add svm specific x86_ops 
> which can read the userspace provided memory region/memslots and 
> calculate the amount of guest RAM managed by the KVM and grow the bitmap 
> based on that information, i.e. the highest guest PA that is mapped by a 
> memslot.

Hi Ashish,

the commit message should explain why this is needed or useful.

Paolo

