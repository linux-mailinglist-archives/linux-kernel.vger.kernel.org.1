Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDBE2CE8C7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgLDHpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:45:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgLDHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607067818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqdvRnOhlGCkzmVPkbqMAXPRan58Ybj/VKoMtVNtTfs=;
        b=CdVrY4ecpc/+MPMoUVfzLT4NSn7yCgVRgBq9eC2LegaXQ2bkS6ztR7HODmJfi9jn1HDloR
        dwgAajzbljZ5fmPXrKObWJ30cMGrZ+XeaYrbsMVXbj1ys1Ffo3/WG6KK4FzmIgT7E6n1un
        VHtyeGaEBzLlJsVB1gMHT8XO0xo6jBA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-knqDL7SmOF6U5pbhtvkWkg-1; Fri, 04 Dec 2020 02:43:36 -0500
X-MC-Unique: knqDL7SmOF6U5pbhtvkWkg-1
Received: by mail-pj1-f71.google.com with SMTP id d7so2793449pjr.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 23:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IqdvRnOhlGCkzmVPkbqMAXPRan58Ybj/VKoMtVNtTfs=;
        b=iK+NDQOv5sTNoayF4n5Y4gnAVsbVnoQjO+YHjrxVIOImN6r1pC3kI+RqaYX8/KLmQP
         Wf3OricY1d6PMOurv+eGg4UyODAqHs5LsLk954WHJa3m37xjNjCIfbqGNvTyxQf0gaMM
         mW9eZt736xLVrcz9dNMayh20vkZOmB+5xlw28tqIB1Kn4p9blGAfI6cK0+wu8YA3Lbc8
         1mRXQn5pSOtIUGoFWMyfpZA54eG3w1YQlJTJadFHx1fo+6+bXHk1yp0+/4uPmK2I7WJL
         /L3YE7honIRL182Rq0ib+8fzmUIQMjKsxtbh2dm8cN9kzdNMrzpKaKhNaA4KAW+PooWm
         A8KA==
X-Gm-Message-State: AOAM531FZALe/T31J/YrwdPvguRdrbA7ULaB0LuRdAgSeheLUX+zZ5zs
        YIdf+vBinW75/SDeeEZiDqfxcDrmApmnDqKeYTiG+YlWQ8/2QNF7faD78e29s7C3g6LqIF/w48C
        NEgjTIM96QHNc3bFqCQflDSVc
X-Received: by 2002:aa7:9606:0:b029:19d:c837:d69b with SMTP id q6-20020aa796060000b029019dc837d69bmr197054pfg.46.1607067815419;
        Thu, 03 Dec 2020 23:43:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytbhugDS4EGhOvmv/brSip62BEJbJvunGvWe/PL9YPtQTR/GAbXuWKNgU2/lPJSgfSDozNJA==
X-Received: by 2002:aa7:9606:0:b029:19d:c837:d69b with SMTP id q6-20020aa796060000b029019dc837d69bmr197039pfg.46.1607067815150;
        Thu, 03 Dec 2020 23:43:35 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x16sm1315706pjh.39.2020.12.03.23.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 23:43:34 -0800 (PST)
Date:   Fri, 4 Dec 2020 15:43:23 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
Message-ID: <20201204074323.GA2025226@xiangao.remote.csb>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com>
 <20201204003119.GA1957051@xiangao.remote.csb>
 <d713f69b-af1b-4e4a-41ad-267a3b9026ac@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d713f69b-af1b-4e4a-41ad-267a3b9026ac@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Fri, Dec 04, 2020 at 03:09:20PM +0800, Chao Yu wrote:
> On 2020/12/4 8:31, Gao Xiang wrote:
> > could make more sense), could you leave some CR numbers about these
> > algorithms on typical datasets (enwik9, silisia.tar or else.) with 16k
> > cluster size?
> 
> Just from a quick test with enwik9 on vm:
> 
> Original blocks:	244382
> 
> 			lz4			lz4hc-9
> compressed blocks	170647			163270
> compress ratio		69.8%			66.8%
> speed			16.4207 s, 60.9 MB/s	26.7299 s, 37.4 MB/s
> 
> compress ratio = after / before

Thanks for the confirmation. it'd be better to add this to commit message
if needed when adding a new algorithm to show the benefits.

About the speed, I think which is also limited to storage device and other
conditions (I mean the CPU loading during the writeback might be different
between lz4 and lz4hc-9 due to many other bounds, e.g. UFS 3.0 seq
write is somewhat higher vs VM. lz4 may have higher bandwidth on high
level devices since it seems some IO bound here... I guess but not sure,
since pure in-memory lz4 is fast according to lzbench / lz4 homepage.)

Anyway, it's up to f2fs folks if it's useful :) (the CR number is what
I expect though... I'm a bit of afraid the CPU runtime loading.)
Thanks for your time!

Thanks,
Gao Xiang

> 
> Thanks,
> 

