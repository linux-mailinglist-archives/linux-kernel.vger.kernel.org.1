Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DDA28E114
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbgJNNQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgJNNQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:16:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8F8C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:16:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h4so1702857pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=in-reply-to:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HqH4OmL3x4PWuuqS8amqaRkrNrG5XBbpBXi9XXp9YB8=;
        b=RKYyEgPEqh398kzJaSXACYYscMG+s5g9Aa1oaYxEld2p+2orKVVgS8Rs1e+Bs0GfCz
         cmeSvbizGg6svbwUDV/TOUYbQ/PIThl8cTNLrlInKgRIIRfNQq/GNf7H3Ao6/nDjas/2
         sbyueOWeDYdxfuoCsQZ/R8hLXXt2RKXyzxCVFq8kUGx9T559sHwlX7qzDgjcOixo0BQ0
         nnWL0HkAuZDBgHoKZU4bPPZLBYUDsKlTw/R8eefWEt91Aby+enW8dPSd6xC/KL4wB1hC
         JnXAmJ4bAAbkwMWbA+nMW5KoNlEj784zqt6orgnhRsSvIh/4lyzUXio/mMUFpG/EfCCL
         mwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:in-reply-to:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=HqH4OmL3x4PWuuqS8amqaRkrNrG5XBbpBXi9XXp9YB8=;
        b=VvbF48uSfyEf3bVwRdLZYrQCm/W5o7w0CNjnEXYuwGE2Exd/PtmtlsPEVtY31rk2iw
         ETQFp+z7ciIFbAxzbpLsXmW3HxFhySUi+ejNXUXZER0Vn676ggxqdjntDfvst0pBMTvz
         M487AXCHM/q3ZyBzuOnOAGqp5Sga+RCfDZWkySRdGKDt9QD+RehVhw55oOWBtM9WMOYG
         nhWOU4M/4ETWEY8+cLPJbmqUbmuJ0cdJUM/OoPhLyuWmN87anTwUIdUdtoweedXKKx9t
         T0MNehg8cg9f5/7Fae79b7NaPEQk3Hkt6rYKRH4rTVop5vm/bb3djQvAzXUX0FgXZB2n
         cGkg==
X-Gm-Message-State: AOAM5325w7qDaXQsn6EkE+ua0/bxsGrGqtkDbgbkSE9EKO8DlUDvAOaE
        rShxdTlqYxaGoECJ/6ZZyH4=
X-Google-Smtp-Source: ABdhPJxVPkd66L2M/Ql2A6T5aFDRl/Iv0Am48+p6pt60Y4FcmJMkgwQQ4fzvbHSHbY9eB+3RptqXzg==
X-Received: by 2002:a17:902:525:b029:d1:920c:c200 with SMTP id 34-20020a1709020525b02900d1920cc200mr4236168plf.25.1602681409576;
        Wed, 14 Oct 2020 06:16:49 -0700 (PDT)
Received: from fox-laptop.local ([162.216.240.138])
        by smtp.gmail.com with ESMTPSA id y4sm3754573pgs.0.2020.10.14.06.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 06:16:48 -0700 (PDT)
In-Reply-To: <ceed2e5f-c03e-721f-ba2f-a581d6214e5c@gmail.com>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     syzbot <syzbot+af90d47a37376844e731@syzkaller.appspotmail.com>,
        agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
From:   Fox Chen <foxhlchen@gmail.com>
Subject: Re: [Cluster-devel] KASAN: slab-out-of-bounds Write
 in,gfs2_fill_super
Message-ID: <e92ee11f-f00e-3624-acff-d37d725384cb@gmail.com>
Date:   Wed, 14 Oct 2020 21:16:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it's the same bug,

https://lkml.org/lkml/2020/10/5/538 this may help


thanks,
