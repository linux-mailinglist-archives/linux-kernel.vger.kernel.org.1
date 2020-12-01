Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654572CA6F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391821AbgLAPZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:25:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390265AbgLAPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606836233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I9sbNjqqnuhUn3pfDAQYhxdjMyqtp7UmixLKvXNQJKU=;
        b=hAPubeRsTk5n93Sssj9mP1xJW1xW6Qj1sbf2pWNjpQKMiEcwx5AfihxoQjRc8mi3Udk8U8
        IPsO2Rs8kqro0bqpQBe6F3wAnN89AGzPdMgXJuf5jYj1M8OAnH9gMMhH3pgIPVZGP/Wpw8
        Q637BpxILNrdmYADUQsZWBuxjuoWG/4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-yDBc2PHpOhCEY-jqgPWs8Q-1; Tue, 01 Dec 2020 10:23:51 -0500
X-MC-Unique: yDBc2PHpOhCEY-jqgPWs8Q-1
Received: by mail-qk1-f200.google.com with SMTP id l7so1609830qkl.16
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I9sbNjqqnuhUn3pfDAQYhxdjMyqtp7UmixLKvXNQJKU=;
        b=oFE6r1n3XNnSU1faMl6XU1cYmpfHTmPMbj7P3zRTUBrfAdO4XqaubdY1nk6LTJrWOY
         iPvH4hNybdA2vpAB+lRZzOLlAhkO4UJ+sVLZbfYN9t5/IB0F4d4DA82LWXq6SMj6qopS
         u/FRLGcnC88PfgHNHiUWu46upX8d9WD/nICFd4lLKkXr10zwZR78nJBGavKOwKzTAovi
         kBVRuPGBCcwROl2cyTIb0VK068UbCjAi9uGCY36BjJ7ETvlKo/ToktMadEQcTXzup+z1
         ECbJdkIdny4qBmJWBMpLHicGZMgMXH9iJWKIV7idOrSk2sUic0zgzUCp08PzVAswono/
         ZYEA==
X-Gm-Message-State: AOAM532rYzszKaNso+gDGvf1in8+Ta99d30pq5DqUr0y7MosJF9emuyJ
        QDTiBZaNBRvVbf+Fp9tjngaT5809WYRu0cH35kZHrFMJG3AkOXw+ckOrIoiZ9nihLAohLQ1+zoD
        PoLu6b4QlzylJ4tdGnyVGRVn9
X-Received: by 2002:ac8:5649:: with SMTP id 9mr3271704qtt.379.1606836229742;
        Tue, 01 Dec 2020 07:23:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx03KfRD1Zo4WhjgMz/x6FBH9v7n3Yqs1+bdU+xqGYVZ9+xh3PQY54TeuOSiqY4WeG4oYqJBQ==
X-Received: by 2002:ac8:5649:: with SMTP id 9mr3271622qtt.379.1606836228896;
        Tue, 01 Dec 2020 07:23:48 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id o8sm2375120qtm.9.2020.12.01.07.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 07:23:48 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 563CF182EF0; Tue,  1 Dec 2020 16:23:45 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH] fs: 9p: add generic splice_read file
 operations
In-Reply-To: <20201201151658.GA13180@nautica>
References: <20201201135409.55510-1-toke@redhat.com>
 <20201201145728.GA11144@nautica> <20201201151658.GA13180@nautica>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Dec 2020 16:23:45 +0100
Message-ID: <87mtyx1rem.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> writes:

> Dominique Martinet wrote on Tue, Dec 01, 2020:
>> > Since generic_file_splice_read() seems to just implement splice_read in
>> > terms of the read_iter operation, I simply added the generic implementation
>> > to the file operations, which fixed the error I was seeing. A quick grep
>> > indicates that this is what most other file systems do as well.
>> 
>> Good catch, might as well do that.
>> I'm surprised you didn't hit the same problem with splice_write?
>> 
>> I see iter_file_splice_write being used for it on many filesystems,
>> it's probably better to add both?
>
> Yeah, I confirm both are needed (the second for the pipe -> fs side)

Yeah, makes sense; I was only testing with a very specific use case
where a file is being passed to the kernel with sendfile().

> This made me test copy_file_range, and it works with both as well (used
> not to)
>
> interestingly on older kernels this came as default somehow? I have
> splice working on 5.4.67 :/ so this broke somewhat recently...

Huh, no idea; this is my first time digging into filesystem code, I
normally do networking and BPF :)

> I'll add an extra patch with the second and take your patch.
> Thanks!

Awesome, thanks!

-Toke

