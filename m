Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE72D9E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408617AbgLNSL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408612AbgLNSLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:11:12 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D27C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 10:10:23 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 22so6252692qkf.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=80A3v/WEjVbaiRbX2zqJ242KMRN7qmG3DpyY691VhNU=;
        b=IrTGKI/n7ayvbWMN0a7X/KHMS9wogZpz8jXczVP3WHMLZ2OioqQf8rwZllbIOzir+t
         sEehucHHdhqGg1HiD4LHnj3oQN1C+HBI6SoP8p8tqD+mZQ5fFFEKtrGaaBMzERcJdPvM
         9bIFtqhqJVo8i4kNOZFi0T7+9sY9Rwpb/0OIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=80A3v/WEjVbaiRbX2zqJ242KMRN7qmG3DpyY691VhNU=;
        b=beNyYqGPwWVGtAniyoZIYS/t7HhOup+txO5Vs/SfwIVnXXOH34BiSySG0y+pLyS23b
         1tfInfmvL8RHdc2PSey/ARQyh1UxYRVO243ZpgtNb9G91ZuDRDp+14D3K5DI9Vt1Gv2E
         O4HaZv5r28WlJMFtCIeKEb8axZU4LJc4vTNBpWkq/NxQnwV61d+VV8xG8/vxMgSe+l4c
         cx57gijB6gXDowWD31Bx8Vkt/2eTYnKmf0HmNWBUOfylqaZEUEdy2c3+SS4yhaU5BxmX
         E9Rf3uFVcVbsDNxpFXawB2/2PPRhAlAKZsHbxdih0UmLqVTXj1TcoAnwF4WGgvl2/XRw
         9bTg==
X-Gm-Message-State: AOAM5320LzaSsjfndYD8P+5HWLB6qO4ucmoGLdTdaZKZLwryJSD4JzaB
        vpFW58LzT6q5HS/2aco3gU68sQ==
X-Google-Smtp-Source: ABdhPJyfBtJ7ukfd4lWK/6JV64PA0nYgtm5rutT93yEigIeKNLOh4kyhUcVeIWDo3MK9DwEflPfRgw==
X-Received: by 2002:ae9:e10d:: with SMTP id g13mr33504576qkm.444.1607969422214;
        Mon, 14 Dec 2020 10:10:22 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id i13sm5321115qkk.83.2020.12.14.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 10:10:20 -0800 (PST)
Date:   Mon, 14 Dec 2020 13:10:20 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Chinwen Chang <chinwen.chang@mediatek.com>,
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
Message-ID: <X9eqjA8rNsQ91sg3@google.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190606065129.d5s3534p23twksgp@haiyan.sh.intel.com>
 <3d3cefa2-0ebb-e86d-b060-7ba67c48a59f@linux.ibm.com>
 <1c412ebe-c213-ee67-d261-c70ddcd34b79@linux.ibm.com>
 <20190620081945.hwj6ruqddefnxg6z@haiyan.sh.intel.com>
 <1594027500.30360.32.camel@mtkswgap22>
 <490c0811-50cd-0802-2cbc-9c031ef309f6@linux.ibm.com>
 <1594099897.30360.58.camel@mtkswgap22>
 <X9bIDHZbe4MB+BAg@google.com>
 <b256e5ed-0d4c-4baf-16a6-f32f122e344f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b256e5ed-0d4c-4baf-16a6-f32f122e344f@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:36:29AM +0100, Laurent Dufour wrote:
> Le 14/12/2020 à 03:03, Joel Fernandes a écrit :
> > On Tue, Jul 07, 2020 at 01:31:37PM +0800, Chinwen Chang wrote:
> > [..]
> > > > > Hi Laurent,
> > > > > 
> > > > > We merged SPF v11 and some patches from v12 into our platforms. After
> > > > > several experiments, we observed SPF has obvious improvements on the
> > > > > launch time of applications, especially for those high-TLP ones,
> > > > > 
> > > > > # launch time of applications(s):
> > > > > 
> > > > > package           version      w/ SPF      w/o SPF      improve(%)
> > > > > ------------------------------------------------------------------
> > > > > Baidu maps        10.13.3      0.887       0.98         9.49
> > > > > Taobao            8.4.0.35     1.227       1.293        5.10
> > > > > Meituan           9.12.401     1.107       1.543        28.26
> > > > > WeChat            7.0.3        2.353       2.68         12.20
> > > > > Honor of Kings    1.43.1.6     6.63        6.713        1.24
> > > > 
> > > > That's great news, thanks for reporting this!
> > > > 
> > > > > 
> > > > > By the way, we have verified our platforms with those patches and
> > > > > achieved the goal of mass production.
> > > > 
> > > > Another good news!
> > > > For my information, what is your targeted hardware?
> > > > 
> > > > Cheers,
> > > > Laurent.
> > > 
> > > Hi Laurent,
> > > 
> > > Our targeted hardware belongs to ARM64 multi-core series.
> > 
> > Hello!
> > 
> > I was trying to develop an intuition about why does SPF give improvement for
> > you on small CPU systems. This is just a high-level theory but:
> > 
> > 1. Assume the improvement is because of elimination of "blocking" on
> > mmap_sem.
> > Could it be that the mmap_sem is acquired in write-mode unnecessarily in some
> > places, thus causing blocking on mmap_sem in other paths? If so, is it
> > feasible to convert such usages to acquiring them in read-mode?
> 
> That's correct, and the goal of this series is to try not holding the
> mmap_sem in read mode during page fault processing.
> 
> Converting mmap_sem holder from write to read mode is not so easy and that
> work as already been done in some places. If you think there are areas where
> this could be done, you're welcome to send patches fixing that.
> 
> > 2. Assume the improvement is because of lesser read-side contention on
> > mmap_sem.
> > On small CPU systems, I would not expect reducing cache-line bouncing to give
> > such a dramatic improvement in performance as you are seeing.
> 
> I don't think cache line bouncing reduction is the main sourcec of
> performance improvement, I would rather think this is the lower part here.
> I guess this is mainly because during loading time a lot of page fault is
> occuring and thus SPF is reducing the contention on the mmap_sem.

Thanks for the reply. I think I also wrongly assumed that acquiring mmap
rwsem in write mode in a syscall makes SPF moot. Peter explained to me on IRC
that tere's still perf improvement in write mode if an unrelated VMA is
modified while another VMA is faulting.  CMIIW - not an mm expert by any
stretch.

Thanks!

 - Joel

