Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84D2FF5A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbhAUUQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbhAUUPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:15:19 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5B9C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:14:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o19so4374473lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=23k0OdaqlMZR9+StYgacjZCVa/NASCQobMyVqdEPt5Q=;
        b=lSHnSE5X+q1rYx4ppmRXr3net5bl/nTH8aN1CcgXwORRMr/2lpSA/UeSWsXOqA7bFF
         7ROMB6R/o4xwf5lPEyhU+WH60c9u+oc7qAEclPGqRhsF25b+jpTLqKVr/B9skXK4/PXn
         Gxk7kRJpPp1eA0FynqetuE8Cghm3NPQcpYQY4rzT6J2qmRl6fwZNLdvwhA848pOZe4fP
         ACW7lfR8HSLsgsngXoChqe/6SV2ji7vllOzA870xCjDfCkmhFn5IXsBk1LJzpgJ2Rn7l
         DauV4tWiWD+XA8GxuBx6eMIRMO6NsQ9U533LN9tTTqoIH3hKoxCAT1YGSu5v8MUOGSEI
         s2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=23k0OdaqlMZR9+StYgacjZCVa/NASCQobMyVqdEPt5Q=;
        b=krORsRgM69mzjilWKl+VqMJcdpnVT5rHqTFxl8zuy9sOd7/klNgcyP8Uw22f+y60Ag
         Kev5RePDsBiv/jllqz8tsBmYnaZV1c4bZmApSxdAtWOIuJNX4KSw8NxKMdTGTLrluiZ7
         YHEnYPgdC/dROmQEnB3Mqq8QeyxeUr5ogWoqu332Dw1pWsslGUxZ6wLBzFAigl42C9M6
         7ge5Ulnz6OsajqDQTVdiLtDIkHeqjeuM4o4nIy3+jVpKjnTalSS6S6L4zDCzqijqpGwj
         GwNzhnnDbjIifo/QbAfKKxYcBPDpaea517uaL4J1ckNSEiBt3awA8Zae8wRlmUtfagIi
         lbVw==
X-Gm-Message-State: AOAM530ff7FD9fJVIhThkfAvux74vYuvBY6hmEgDLaqKkfufZIgoFNsa
        B7npTRg4j6my/reIimyRCTSHWIlzoG+QGA==
X-Google-Smtp-Source: ABdhPJyQ4UpfgRAEZf2+f0lKSZGJt2sN8lAcx8Q7HdK8mUi5r+ZFCsFtrVhP2rwA4lhMjlLuXK7CvA==
X-Received: by 2002:ac2:4d0f:: with SMTP id r15mr431437lfi.587.1611260076807;
        Thu, 21 Jan 2021 12:14:36 -0800 (PST)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id t2sm94750lfk.28.2021.01.21.12.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 12:14:36 -0800 (PST)
Subject: Re: [PATCH] lightnvm: fix memory leak when submit fails
To:     Heiner Litz <hlitz@ucsc.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, Pan Bian <bianpan2016@163.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210121072202.120810-1-bianpan2016@163.com>
 <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
 <474055ad-978a-4da5-d7f0-e2dc862b781c@lightnvm.io>
 <CAJbgVnWxmwfmdgk-e290kcMfhUNAjP9uO2k45rx7R=x8jBdJcw@mail.gmail.com>
 <59a735f0-9fef-5e6d-f7eb-851e14a2883e@lightnvm.io>
 <CAJbgVnW40qrYBdsM6dC5uhDFZJJDc9kwvCWtK24Rg5GWCHpb2g@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <586510be-5a56-5e99-6ee6-ee20031f166b@lightnvm.io>
Date:   Thu, 21 Jan 2021 21:14:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAJbgVnW40qrYBdsM6dC5uhDFZJJDc9kwvCWtK24Rg5GWCHpb2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2021 20.49, Heiner Litz wrote:
> there are a couple more, but again I would understand if those are
> deemed not important enough to keep it.
>
> device emulation of (non-ZNS) SSD block device

That'll soon be available. We will be open-sourcing a new device mapper 
(dm-zap), which implements an indirection layer that enables ZNS SSDs to 
be exposed as a conventional block device.

> die control: yes endurance groups would help but I am not aware of any
> vendor supporting it
It is out there. Although, is this still important in 2021? OCSSD was 
made back in the days where media program/erase suspend wasn't commonly 
available and SSD controller were more simple. With today's media and 
SSD controllers, it is hard to compete without leaving media throughput 
on the table. If needed, splitting a drive into a few partitions should 
be sufficient for many many types of workloads.
> finer-grained control: 1000's of open blocks vs. a handful of
> concurrently open zones

It is dependent on the implementation - ZNS SSDs also supports 1000's of 
open zones.

Wrt to available OCSSD hardware - there isn't, to my knowledge, proper 
implementations available, where media reliability is taken into account.

Generally for the OCSSD hardware implementations, their UBER is 
extremely low, and as such RAID or similar schemes must be implemented 
on the host. pblk does not implement this, so at best, one should not 
store data if one wants to get it back at some point. It also makes for 
an unfair SSD comparison, as there is much more to an SSD than what 
OCSSD + pblk implements. At worst, it'll lead to false understanding of 
the challenges of making SSDs, and at best, work can be used as the 
foundation for doing an actual SSD implementation.

> OOB area: helpful for L2P recovery

It is known as LBA metadata in NVMe. It is commonly available in many of 
today's SSD.

I understand your point that there is a lot of flexibility, but my 
counter point is that there isn't anything in OCSSD, that is not 
implementable or commonly available using today's NVMe concepts. 
Furthermore, the known OCSSD research platforms can easily be updated to 
expose the OCSSD characteristics through standardized NVMe concepts. 
That would probably make for a good research paper.


