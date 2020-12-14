Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4840F2D91A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 03:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437864AbgLNCEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 21:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbgLNCEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 21:04:39 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F601C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 18:03:59 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so10949439qtp.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 18:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3joCMQEgMYTRWtwvNU8XfkRxQvl1XcPWoJqmHhlAjNg=;
        b=jIFuMyW0CXPwPbzjytq1fyl28f5h7j18cK1dq9/kuoMitNcBn2VPPr+iiAdwiyshf8
         Sass69snymAmlv2w9RPxsB1q6+LKmXCPfpDzo0XV15UccAlREbVBq+V+jHCI6ci5QwI2
         xW3KXMx8jhphyq6rezDemv6LqKppWr9EI6OjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3joCMQEgMYTRWtwvNU8XfkRxQvl1XcPWoJqmHhlAjNg=;
        b=gh1stiZl8dKKQZyEwxOwL+dKil3RmnUu5gdhjU2sgTHCBRT05fy8Qoo00AiAyATan9
         brropX+pCLdK1TmD1XVANh1qgB5L7pdOZt1CNJVbMQXb9vsq8u3PilXDDsxImDaiSLgl
         bi99EMkhsK4hHcg8IcEJtdjjvEZhoh6ARwaH8f8FnVjUR0cIf1fiD2gvJk+8fHwvlDc8
         79bKCNAmsZo4tjf2sS1yTnHO776a4kBmCRiiMAE2JNWfXy0NkXsyN//yfaA5jfUatGSA
         VLixFeeMMosj+i0pS4ZWXvbGHZ+0P8vmt1QTZUDh1vRxn+dOeamkAqdBn/cw3OxX5r/J
         +Hmg==
X-Gm-Message-State: AOAM533BfTTlusKkM2pTDX0jdRMmeGwC8Op+0Z8chInf57SY+P3wpPyo
        aExa4475c4jLIQBlDrIXDsrXvQ==
X-Google-Smtp-Source: ABdhPJyNrnChYZI79mij49ui4I23lfJGjf54I4Witq/Vsja69LURczot4O1GWdNPlqyHDHsWm5RREQ==
X-Received: by 2002:ac8:6758:: with SMTP id n24mr29731870qtp.258.1607911438765;
        Sun, 13 Dec 2020 18:03:58 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g63sm13912475qkf.80.2020.12.13.18.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 18:03:57 -0800 (PST)
Date:   Sun, 13 Dec 2020 21:03:56 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        miles.chen@mediatek.com
Subject: Re: [PATCH v12 00/31] Speculative page faults
Message-ID: <X9bIDHZbe4MB+BAg@google.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190606065129.d5s3534p23twksgp@haiyan.sh.intel.com>
 <3d3cefa2-0ebb-e86d-b060-7ba67c48a59f@linux.ibm.com>
 <1c412ebe-c213-ee67-d261-c70ddcd34b79@linux.ibm.com>
 <20190620081945.hwj6ruqddefnxg6z@haiyan.sh.intel.com>
 <1594027500.30360.32.camel@mtkswgap22>
 <490c0811-50cd-0802-2cbc-9c031ef309f6@linux.ibm.com>
 <1594099897.30360.58.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594099897.30360.58.camel@mtkswgap22>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:31:37PM +0800, Chinwen Chang wrote:
[..]
> > > Hi Laurent,
> > > 
> > > We merged SPF v11 and some patches from v12 into our platforms. After
> > > several experiments, we observed SPF has obvious improvements on the
> > > launch time of applications, especially for those high-TLP ones,
> > > 
> > > # launch time of applications(s):
> > > 
> > > package           version      w/ SPF      w/o SPF      improve(%)
> > > ------------------------------------------------------------------
> > > Baidu maps        10.13.3      0.887       0.98         9.49
> > > Taobao            8.4.0.35     1.227       1.293        5.10
> > > Meituan           9.12.401     1.107       1.543        28.26
> > > WeChat            7.0.3        2.353       2.68         12.20
> > > Honor of Kings    1.43.1.6     6.63        6.713        1.24
> > 
> > That's great news, thanks for reporting this!
> > 
> > > 
> > > By the way, we have verified our platforms with those patches and
> > > achieved the goal of mass production.
> > 
> > Another good news!
> > For my information, what is your targeted hardware?
> > 
> > Cheers,
> > Laurent.
> 
> Hi Laurent,
> 
> Our targeted hardware belongs to ARM64 multi-core series.

Hello!

I was trying to develop an intuition about why does SPF give improvement for
you on small CPU systems. This is just a high-level theory but:

1. Assume the improvement is because of elimination of "blocking" on
mmap_sem.
Could it be that the mmap_sem is acquired in write-mode unnecessarily in some
places, thus causing blocking on mmap_sem in other paths? If so, is it
feasible to convert such usages to acquiring them in read-mode?

2. Assume the improvement is because of lesser read-side contention on
mmap_sem.
On small CPU systems, I would not expect reducing cache-line bouncing to give
such a dramatic improvement in performance as you are seeing.

Thanks for any insight on this!

- Joel

