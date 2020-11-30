Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD56D2C8D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgK3S4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:56:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729822AbgK3S4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606762513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UJa4+nJnAblt3hEvp+SYFJg8d4mfG8f2+fFVNZQWsaA=;
        b=A2x2n5xACs4P3anGbM3r9qO8JY8Ni+I6km71IKLZvFfA8DlOI17Ziqmo7ifiXlVh+3Em46
        MfkBJCh1rOICEkK7J57Z8eAiVG2glOS1alG0nhgXthxqxmPFU1TfE+WUrmtBe3Y7bmU67y
        wnmL6Mz+tiYjW4yfu8ppLdR0E/ZT3+Q=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-BVu9cTPyNsWNmx_6xmQU-w-1; Mon, 30 Nov 2020 13:55:09 -0500
X-MC-Unique: BVu9cTPyNsWNmx_6xmQU-w-1
Received: by mail-pf1-f198.google.com with SMTP id x26so9684788pfo.23
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UJa4+nJnAblt3hEvp+SYFJg8d4mfG8f2+fFVNZQWsaA=;
        b=C34S1wmYnqrJoKQdfpB7AXz10IZTHU9suiMRibBXtaWus9XGhX0c9oLRouNLB5jVBq
         zanFDPdIAaq0HsY04CW/+OJOEP6YfroSZg7O7GlkLdnOK3Un8k4TfoVN48Zdovqth35C
         Voon5u45l/sWo7rAhR/1oxM1hLPX3h/P8orkwoK/ItbA4saUIFNCGJKv5varg9lfmGi5
         /0Udv0PCa09c+1ywCCge2NFajwiXRS0D2acTz4/lfUEIFWrR0MixDuWXnf7jKZ6To0SW
         9jPmJ8OyqYwrX7SQ3E49YxvyYDfQ0TQrHedpqAnQlQPe+EUscyVZBEDwS0AbhhEptTM6
         73Qg==
X-Gm-Message-State: AOAM530iw+p3qV/wjsn2pZMspDRUxvzMQ08ZUcRTUpLQPZEiD1BMZThc
        U+oIaYMFET0lRzbH7e7cNA/2+6YJSjshtexj1oI2Z3OuQg2r6epdCKo4O/iFLKP6UbrsjK93eXx
        rQAc53NCv+Pq1lf2g+S8z9I8W
X-Received: by 2002:a17:90a:9e5:: with SMTP id 92mr266215pjo.176.1606762508414;
        Mon, 30 Nov 2020 10:55:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5XFm0e2WR2j2Oq/bqCs2+nYMpHE7WhzMfpV9dzDeIzdQJd1QvcKUNaxxdTuILeH2k+sDZ1w==
X-Received: by 2002:a17:90a:9e5:: with SMTP id 92mr266195pjo.176.1606762508227;
        Mon, 30 Nov 2020 10:55:08 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z11sm187039pjn.5.2020.11.30.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:55:07 -0800 (PST)
Date:   Tue, 1 Dec 2020 02:54:55 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        Yann Collet <yann.collet.73@gmail.com>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v2] lib/lz4: explicitly support in-place decompression
Message-ID: <20201130185455.GA1181636@xiangao.remote.csb>
References: <20201121191024.2631523-1-hsiangkao@redhat.com>
 <20201122030749.2698994-1-hsiangkao@redhat.com>
 <73E0BBBC-434D-4877-8E43-F995F8F4FE25@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73E0BBBC-434D-4877-8E43-F995F8F4FE25@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 06:19:34PM +0000, Nick Terrell wrote:
> 

<too long snip>

> 
> Looks good to me! You can add:
> 
> Reviewed-by: Nick Terrell <terrelln@fb.com>

Thanks for reviewing this!

Thanks,
Gao Xiang

> 

