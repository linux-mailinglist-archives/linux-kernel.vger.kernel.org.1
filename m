Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B36B281147
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbgJBLdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgJBLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601638413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=8vZo2mFm2ciX2DzJCWZZBr9gunYPcmiUmQLtKIWCGwU=;
        b=QV9PmqlOTuHUvicOWnAFsrUOBUc0ssGW9DBqcb8BNM6STyBH4NOIVjXl8Y5wJLfjNUjtQc
        OA+AMD1JCdbDWTVd/9agn5Q7O9plwg+OhyPyzUn333NN+BiDAz65NfIDSIzNrndgK7kqMM
        nZ74zBoaRNoPNl/jv0P0lu4WggDD4zI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-AD91f9nfMkemL8cn1D9ziw-1; Fri, 02 Oct 2020 07:33:31 -0400
X-MC-Unique: AD91f9nfMkemL8cn1D9ziw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 267B0100C636;
        Fri,  2 Oct 2020 11:33:29 +0000 (UTC)
Received: from [10.36.114.142] (ovpn-114-142.ams2.redhat.com [10.36.114.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBF8C55792;
        Fri,  2 Oct 2020 11:33:24 +0000 (UTC)
Subject: Re: linux tooling mailing list
To:     David Miller <davem@davemloft.net>, ndesaulniers@google.com
Cc:     sedat.dilek@gmail.com, maskray@google.com,
        segher@kernel.crashing.org, linux@rasmusvillemoes.dk,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        postmaster@vger.kernel.org, peterz@infradead.org,
        behanw@converseincode.com
References: <CAKwvOdmFm9-FPrqt42NsusWRbDzNx6NF1GeSJhz_9kaAGV8eOA@mail.gmail.com>
 <20200930173719.GE2628@hirez.programming.kicks-ass.net>
 <CAKwvOdk+Rp0QGJmX07XxD8L7WVgco98LHFTu-R_2R22+UMVerQ@mail.gmail.com>
 <20200930.152652.1530458864962753844.davem@davemloft.net>
From:   Nick Clifton <nickc@redhat.com>
Autocrypt: addr=nickc@redhat.com; prefer-encrypt=mutual; keydata=
 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
 6susi2ReUyNJEJaSnjO5z13TQ1U=
Organization: Red Hat
Message-ID: <fcbb4bf9-9a7a-bfe0-7f3b-088273c3ff51@redhat.com>
Date:   Fri, 2 Oct 2020 12:33:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200930.152652.1530458864962753844.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

>> linux-toolchains@vger.kernel.org
> Created.

I have been able to subscribe to this list, so it looks like thunderbirds are go...

Cheers
  Nick


