Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD682C4DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 04:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbgKZDOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 22:14:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731106AbgKZDOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606360449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CP+P72YDkk6r+96+ukHLMOpDWmwuEuxrRgqlxfsqF6M=;
        b=cV86WqIEAGx49ylqPPO/phqvjyVUc84U9XDFL6hmB3wqLud2hITOUdGuZcTl0iZxhI5tI8
        NEfmKxtxfG9WDYt9uLsnldj6vEBDSOA6P8lGsHWzbkpLLW6AMiGRRvhgHxYEBWdu5kto1J
        aEe8n6YqUEGBhSlKZLOZkfTnGtORrz8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-W6yTRIU2N3iFnOLRs9PELQ-1; Wed, 25 Nov 2020 22:14:06 -0500
X-MC-Unique: W6yTRIU2N3iFnOLRs9PELQ-1
Received: by mail-pf1-f198.google.com with SMTP id 143so598573pfv.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 19:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CP+P72YDkk6r+96+ukHLMOpDWmwuEuxrRgqlxfsqF6M=;
        b=YT4y4uRJlk4oG8qYKiWnueEJzh+X+JzdNb89ZcdLWFPazZc5zPG/WU2IHrxlDm5mw1
         50t5TLjcfkfBhsZrCrZw/1qGmLXhi4qSyo4g8vvE6C7cqRWcOhFOCs4A3+iAkMUtQyVM
         Z00PeqPl9WAR1mj37l/3I6LFsLMETRNRv3pK7e6u5bLkgPJZzHsyMUhYz5ZvN2HK2eL0
         BRUZLGv0cJ8MJwD3n50vnt3VMCWDutmyjjuttKkrSCDuJckCR0YAdpmeA2CXFh+pg6XD
         nnKpvbmbwyjTdErNg4cfgkdRlEMMteRzzeLYMuNH24dD2EpQO5EMrwAlaHiZzMJlaVNU
         vPcg==
X-Gm-Message-State: AOAM5325u67pOFjQVAvtaL/s5sDv5eC72IrTJzm+SSvVpYJwDUKD9vVA
        Cc+5lj6fLo4fj5uqvc0iZkMDUwha6D6XjmlBD8XyYNFzQK74zZEgFLkAG4BQAnYAm78WjLWB7GT
        XV2pxKMekIGBtPYxpdzSUtTs1
X-Received: by 2002:a17:902:8209:b029:d6:d2c9:1db5 with SMTP id x9-20020a1709028209b02900d6d2c91db5mr1009625pln.54.1606360445889;
        Wed, 25 Nov 2020 19:14:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsQ7WHZSGSQfaUiSHqtqqoRw0+46vwJE9kTOPMHu6GdPqgV+5NQiGJOmlZ+cstEeAN/7Af3A==
X-Received: by 2002:a17:902:8209:b029:d6:d2c9:1db5 with SMTP id x9-20020a1709028209b02900d6d2c91db5mr1009611pln.54.1606360445702;
        Wed, 25 Nov 2020 19:14:05 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k4sm2992384pfg.174.2020.11.25.19.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 19:14:05 -0800 (PST)
Date:   Thu, 26 Nov 2020 11:13:54 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: check the return value of krealloc() in
 xfs_uuid_mount
Message-ID: <20201126031354.GA345905@xiangao.remote.csb>
References: <20201125065036.154312-1-miaoqinglang@huawei.com>
 <365b952c-7fea-3bc2-55ea-3f6b1c9f9142@sandeen.net>
 <9f998a9d-0684-6b45-009e-acf2e0ac4c85@huawei.com>
 <20201126021622.GA336866@xiangao.remote.csb>
 <5d6b6f6f-4bc3-2821-d5b1-569afba0221a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d6b6f6f-4bc3-2821-d5b1-569afba0221a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 11:05:03AM +0800, Qinglang Miao wrote:

...

> > 
> > I'm not sure if Hulk CI is completely broken or not on this, also if
> > such CI can now generate trivial patch (?) since the subject, commit
> > message and even the variable name is quite similiar to
> > https://lore.kernel.org/linux-xfs/20201124104531.561-2-thunder.leizhen@huawei.com
> > in a day.
> > 
> > And it'd be better to look into the code before sending patches...
> Yeah..  I should pay more attension.

Yeah, it'd be better to address/fix the Hulk CI false report
if possible, so it won't have such warning in the future.

Thanks,
Gao Xiang

> > 
> > Thanks,
> > Gao Xiang >
> Thanks for your advice~
> > > 
> > > Thanks for your advice！
> > > 
> > 
> > .
> > 
> 

