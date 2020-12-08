Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB2D2D268E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgLHIs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:48:59 -0500
Received: from m12-13.163.com ([220.181.12.13]:48713 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbgLHIs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=sIi2x
        BWBNIgClSTr/d1TIT0RIkjN28udFoDEyYuhqj8=; b=ZEdFC4fVyxRAJVqteDiHO
        bDXJk7GmuBFZTAdZLkwlLuhENAc05aW8A1GsjD72osyXAblYAm8+aB0MbVkyn61C
        UNUDNyWxGml2NzaOzJB5xZVBR7dXinbpFi/H1Jo+gPz36ZqixpbBDvTw+ujiXX3q
        IgJiNGSrZCUXbu4MuJe5AM=
Received: from localhost (unknown [223.104.64.139])
        by smtp9 (Coremail) with SMTP id DcCowACn9irrJ89fr7GaUw--.17570S2;
        Tue, 08 Dec 2020 15:14:52 +0800 (CST)
Date:   Tue, 8 Dec 2020 15:14:51 +0800
From:   Hui Su <sh_def@163.com>
To:     linux-kernel@vger.kernel.org, sh_def@163.com
Subject: Re: [PATCH] mm/page_alloc: simplify kmem cgroup charge/uncharge code
Message-ID: <20201208071451.GA87765@rlk>
References: <20201207142204.GA18516@rlk>
 <CALvZod45tRyx+7VagQQ=9SqabNR5Y=f0U0T0AFtOFWdzUgJbxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod45tRyx+7VagQQ=9SqabNR5Y=f0U0T0AFtOFWdzUgJbxQ@mail.gmail.com>
X-CM-TRANSID: DcCowACn9irrJ89fr7GaUw--.17570S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW5Gw15AF1kJrWrAFy7Wrg_yoWfZwbEkr
        nrJw1xA342grWSgayUuw1UX3y2qa10gFW7Arn5KFy2qa4Skrn8Ca4kAFWfuFZ5Ka97KrsI
        93s3Kr18J3sFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnsZ23UUUUU==
X-Originating-IP: [223.104.64.139]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBDgz0X1rbLWhWLgAAsV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:28:46AM -0800, Shakeel Butt wrote:
> On Mon, Dec 7, 2020 at 6:22 AM Hui Su <sh_def@163.com> wrote:
> 
> The reason to keep __memcg_kmem_[un]charge_page functions is that they
> were called in the very hot path. Can you please check the performance
> impact of your change and if the generated code is actually same or
> different.

Hi, Shakeel:

I objdump the mm/page_alloc.o and comapre them, it change the assemble code
indeed. In fact, it change some code order, which i personally think won't have
impact on performance. And i ran the ltp mm and conatiner test, it seems nothing
abnormal.

BUT i still want to check whether this change will have negative impact on
perforance due to this change code was called in the very hot path like you
said, AND saddly i did not find a way to quantify the impact on performance.
Can you give me some suggestion about how to quantify the performance or some
tool?

Thanks.

