Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919A4304F97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhA0DQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405451AbhAZUNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:13:44 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E7AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:13:04 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o16so2557951pgg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MZYb3kMF2SoGhQLq5uahaotIljLrCGTAaVi1yzZyu+E=;
        b=rQtBBq+7DEn/8UuWrdJpmlK6c2JgXMWkSZxkTYfBFywMyAgDmZ3D6kVk1XD7N4TpHG
         PvdaUbNm1FtCjSsxSNKYb21sZWE+FesWDmaqZJe1fIRIN+d01oQOLKWNmEyBCUWpaCnA
         tyRSF3dTrqreqh7gLq8WNVhIakPsxJvlRMGDbiZtfBMgQlpRubYNmTs8aqj5jPNuw3MZ
         Qj+oYMuu64b3BBGRK2XStdfjft74djPS0nsShYhxMadKUIDsyoYSXbU0KgSCFJ86cr48
         BFU4RksGcs+cVjZ/WsOGHyS5w5Ho7RdcZn2+1Xj63/rQ81KjK+iAQW+PBT70u49bbumo
         if8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=MZYb3kMF2SoGhQLq5uahaotIljLrCGTAaVi1yzZyu+E=;
        b=E1K+eeTdYAERoZQ5T7U20wj6Z/uglGLthqRlKJLESd5io2Eg7bTH55MA0gTq6IB4lK
         HOR8HMwKYB8iSyoNVORWx/OauiphX+qXelgoSWHhel5CQyt4vdpoiW3FcZwYdt1CXje2
         pPaAwNSbTwwfFbQ8xTIRU4tyLcy3z7GQMOoCz6nr/lAIc5QYa9VjwZgEEJzGsAZxom+b
         ITES7dHBkTHyV6ktZlQSeeMXBlxDHs6AdLKD2QjOWAMCB0QwZ/NDEeFefROeQ63XZCN6
         zHEhi/0vjw63Vh0E8XECJATWUTeTGf6n9MCKcpltIsyVWuTGXI4jcHO1SIoqNqZp2AnP
         3Tjw==
X-Gm-Message-State: AOAM530MYmCARQoYVdFG//i8tO0255xSfOmLHgOZ//NkIV4vAZ7SyEx5
        /LQAP4jTh8lIUk906R+peiIK+Q==
X-Google-Smtp-Source: ABdhPJwZygl3THYUBXlV0yKqnpk9E6JCOBrWWpJo/lOob6A1GtjpuoLMvN5gWCLSRVFfbY7V4Hp60A==
X-Received: by 2002:aa7:8f13:0:b029:1bd:f965:66d8 with SMTP id x19-20020aa78f130000b02901bdf96566d8mr6613362pfr.80.1611691983496;
        Tue, 26 Jan 2021 12:13:03 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id 124sm19455216pfd.59.2021.01.26.12.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 12:13:01 -0800 (PST)
Date:   Tue, 26 Jan 2021 12:13:00 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Muchun Song <songmuchun@bytedance.com>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?Q?HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3_=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v13 02/12] mm: hugetlb: introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
In-Reply-To: <CAMZfGtWCy-krzL1ejOOq2rZQ3mPbBUSNqmQd-svABMKxE0FcsA@mail.gmail.com>
Message-ID: <4ab7e425-711f-dad9-6a43-e480d5a92b8a@google.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com> <20210117151053.24600-3-songmuchun@bytedance.com> <472a58b9-12cb-3c3-d132-13dbae5174f0@google.com> <CAMZfGtUGT6UP3aBEGmMvahOu5akvqoVoiXQqQvAdY82P6VGiTg@mail.gmail.com> <eef4ff8b-f3e3-6ae0-bae8-243bd0c8add0@infradead.org>
 <CAMZfGtV5rcCq6EGFAG4joRfWht0=1WE6Oik7LgNUPr-_iNX4Xg@mail.gmail.com> <2d9bfd8d-a77f-6470-807c-1a71ffeac3ff@google.com> <CAMZfGtWCy-krzL1ejOOq2rZQ3mPbBUSNqmQd-svABMKxE0FcsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021, Muchun Song wrote:

> > I'm not sure that Kconfig is the right place to document functional
> > behavior of the kernel, especially for non-configurable options.  Seems
> > like this is already served by existing comments added by this patch
> > series in the files where the description is helpful.
> 
> OK. So do you mean just remove the help text here?
> 

Yeah, I'd suggest removing the help text from a non-configurable Kconfig 
option and double checking that its substance is available elsewhere (like 
the giant comment in mm/hugetlb_vmemmap.c).
