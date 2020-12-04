Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD42CEA87
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgLDJMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:12:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725969AbgLDJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607073072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/N3JWPWSHjuCdyfo7VgFC9Eox7LNMnKOtYh5z7qZpF8=;
        b=gcctQfqb8AVkEqNUbD2y8dyh4BUzjUXF6oFAtVQkiPeFdD26h5J4BBA/NRGuRd3C4wwFtz
        rkXGxi+Lmb1GDX+3yWzREhEI6bplJt6bSsvDNg770yiOntbNzE4agQ3l0HNTxRkI2SAuGt
        0rM5hTAappZkAfk5+Dd4PuC+cmVz2oI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-QKVokSULMzS_Ha8ORdW4Gg-1; Fri, 04 Dec 2020 04:11:09 -0500
X-MC-Unique: QKVokSULMzS_Ha8ORdW4Gg-1
Received: by mail-pj1-f69.google.com with SMTP id kk4so3004725pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 01:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/N3JWPWSHjuCdyfo7VgFC9Eox7LNMnKOtYh5z7qZpF8=;
        b=SDXhjH0wRl1S72Yc1dnGcfMZMlEZjkpDKjJQ9MlRj41RnBEgWVIbfQAMJkei6e5DNf
         ZZAXCpLtWy3BsdIfW2hNastY4h+rpKvd4XO6A9mFHj5ApJS8eqCGA2PDuymHwTqv2QoQ
         8aKiJGaL2SjrFgSkMhzcmHe7dcMlSBK+ooSdIJvBdk9S8Pqk9SGu62XDaRZH5kIyaixT
         as/i2dgnan0v4VU9hHOTjIEyJJ5OjY5WlrAan6HDEiCLykUxMQAIjwTE0KTD2C+mASPq
         y8GNkHr4+hDGqcGtfJTZYyfFafg3xd2/1XWztc7nyFRxeSuLm/p5vjyyCtSh4PYxelg+
         D0jQ==
X-Gm-Message-State: AOAM530y6UAUSytv/cWecx9ir7aBqh/4b8BI6jEMHF/5idicwKQjSk6v
        R6BW7XXfaPJ38KKgMNaBcn2Db3aEt9TPKmiSXUB1bLeN4JglhCmkD5fC+7jaNZ4raG9yNkc8cjg
        HeKqup2qQruALjvrKtZXgyPg4
X-Received: by 2002:a17:90a:6809:: with SMTP id p9mr3167714pjj.112.1607073068607;
        Fri, 04 Dec 2020 01:11:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw16vfZeKJPsf0lfqYW/K1sVXF785ufO1lPzqaoNbytT0nbs3JfJy5TYdw8Iv3Jkdo/aUYr9w==
X-Received: by 2002:a17:90a:6809:: with SMTP id p9mr3167694pjj.112.1607073068374;
        Fri, 04 Dec 2020 01:11:08 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b24sm1582460pjq.10.2020.12.04.01.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:11:08 -0800 (PST)
Date:   Fri, 4 Dec 2020 17:10:57 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
Message-ID: <20201204091057.GB2025226@xiangao.remote.csb>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com>
 <20201204003119.GA1957051@xiangao.remote.csb>
 <d713f69b-af1b-4e4a-41ad-267a3b9026ac@huawei.com>
 <20201204074323.GA2025226@xiangao.remote.csb>
 <ffca7f07-653f-1270-72d4-e66ffc8a7473@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffca7f07-653f-1270-72d4-e66ffc8a7473@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 04:50:14PM +0800, Chao Yu wrote:

...

> 
> > 
> > About the speed, I think which is also limited to storage device and other
> > conditions (I mean the CPU loading during the writeback might be different
> > between lz4 and lz4hc-9 due to many other bounds, e.g. UFS 3.0 seq
> > write is somewhat higher vs VM. lz4 may have higher bandwidth on high
> 
> Yeah, I guess my VM have been limited on its storage bandwidth, and its back-end
> could be low-end rotating disk...

Yeah, anyway that's in IO writeback path (no matter the time was working
on IO or CPU calcualation...)

> 
> > level devices since it seems some IO bound here... I guess but not sure,
> > since pure in-memory lz4 is fast according to lzbench / lz4 homepage.)
> > 
> > Anyway, it's up to f2fs folks if it's useful :) (the CR number is what
> > I expect though... I'm a bit of afraid the CPU runtime loading.)
> 
> I just have a glance at CPU usage numbers (my VM has 16 cores):
> lz4hc takes 11% in first half and downgrade to 6% at second half.
> lz4 takes 6% in whole process.
> 
> But that's not accruate...

There is some userspace lzbench [1] to benchmark lz4/lz4hc completely
in memory. So it's expected that lz4bench will consume all 100% CPU
with maximum bandwidth (but in-kernel lz4 version is lower though):

Intel Core i7-8700K
                Compression     Decompression   C/R
memcpy          10362 MB/s      10790 MB/s      100.00
lz4 1.9.2       737 MB/s        4448 MB/s       47.60
lz4hc 1.9.2 -9  33 MB/s         4378 MB/s       36.75

So adding more IO time (due to storage device difference) could make
CPU loading lower (also could make the whole process IO bound) but
the overall write bandwidth will be lower as well.

[1] https://github.com/inikep/lzbench

Thanks,
Gao Xiang

> 
> Thanks,

