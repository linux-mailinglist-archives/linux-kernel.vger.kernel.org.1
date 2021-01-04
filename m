Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31912E9811
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbhADPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:06:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726762AbhADPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609772703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJCXspdx3i7XpaVupbHfC3QV0pRcOT5mdGPwTiDlwdE=;
        b=U/StqKtLrEY6Sy1pRG+/Q5AbUGx98iGOE4uEX4B/ydubxLeaL4VXPQgxV8fXe5sfCAeIkG
        SDRLe1vXmN42N/sz9aQYXao4hr2IMroHJkQiFr0JGZpBp67fZr1OShzSCdyK8zWaEcwEtF
        k9Fy/FPUG6qdQf2bvOznuQJOi5mKyB8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-7VnqYoeGOtyQ87mQgEWVgQ-1; Mon, 04 Jan 2021 10:05:00 -0500
X-MC-Unique: 7VnqYoeGOtyQ87mQgEWVgQ-1
Received: by mail-oo1-f70.google.com with SMTP id i16so17984568oos.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 07:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HJCXspdx3i7XpaVupbHfC3QV0pRcOT5mdGPwTiDlwdE=;
        b=JaOd3g8wAaNquBVTbrVG1r18MAnERIop9Srnu9MdvO7D5V/bYIHFz5GwkMcTWM1osf
         adQWMMfJHEMs8mVUpawgZ1Up7i1oxBGrsu7MMgXpFQC9c1FpRDSHo/wPzvMtPLO8V8aD
         XrjMMw+n4EcQfBVtCue80iwSBBLZCIbRaahA+xZQmdPHCKHXM0AsphFNom0M/JXjfXzA
         lPzICqikbwP/0jzgaLoJTys0xLf0POGidXH5hdUKk13Yq3TinNV0tN0/YiYwfYHw4oHy
         8WfZvoEC6Ebt3VwlfNaLi591ZVR9U2WunvwVvMeWfJgoNVJnAp4XGHim1kVVI4arHz0q
         oBgw==
X-Gm-Message-State: AOAM532qubOzOrxiUJMC8zZh1NfGZAQriBF4jf5Ss881CBA/HsvqkgSt
        DnO4LoY31YCt0bB0HtcF9YruxQZQPeSvnx3mLHzbQIUpIM1G1nCZnsVRALTVbPIMRRF6DzH3bQl
        EKZuxzDeqaKVX3pa+sXFdjiYa
X-Received: by 2002:a9d:64c1:: with SMTP id n1mr51855310otl.60.1609772699854;
        Mon, 04 Jan 2021 07:04:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRUyG0GxwJQKg/9AhApCUjQKPMjtQeX3Pa9tD8Ye6bDk9lTcVUwDMwWhwRkyqjr4LTotHyGQ==
X-Received: by 2002:a9d:64c1:: with SMTP id n1mr51855294otl.60.1609772699720;
        Mon, 04 Jan 2021 07:04:59 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t186sm13461368oif.1.2021.01.04.07.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 07:04:59 -0800 (PST)
Subject: Re: [PATCH] rxrpc: fix handling of an unsupported token type in
 rxrpc_read()
To:     David Howells <dhowells@redhat.com>
Cc:     davem@davemloft.net, kuba@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20201229173916.1459499-1-trix@redhat.com>
 <259549.1609764646@warthog.procyon.org.uk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c2cc898d-171a-25da-c565-48f57d407777@redhat.com>
Date:   Mon, 4 Jan 2021 07:04:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <259549.1609764646@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/21 4:50 AM, David Howells wrote:
> trix@redhat.com wrote:
>
>> -		switch (token->security_index) {
>> -		case RXRPC_SECURITY_RXKAD:
>> ...
>> -		switch (token->security_index) {
>> -		case RXRPC_SECURITY_RXKAD:
> These switches need to be kept.  There's another security type on the way.
> See:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-rxgk
>
> for example.  I'll have a look later.

Yes, looks like more stuff is coming.

Thanks!

Tom

> David
>

