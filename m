Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8E2FC1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbhASVAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390364AbhASUvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611089376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2zkZ60nc0oYz+Jw0v4vLWfZnUOJXoKUEdPKsKZO6hc=;
        b=LX3FqauqG9dOQaTjtRVt36xmUn5SPbsNdinTHfXJzrDgstIq3axuntoihACTijC/XH4FtU
        /7625S1+wzX6dDg9/dGDwzmANwSWnriNPkNrY5Tc/0x5yMk1A8AWT4RzCAtMxhUIaX0Dmr
        xUOR371U1nEJ3nb5VKWAGolrJrxvN64=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-eGqSDM2FMru6TYFp7UNk5A-1; Tue, 19 Jan 2021 15:49:32 -0500
X-MC-Unique: eGqSDM2FMru6TYFp7UNk5A-1
Received: by mail-qv1-f71.google.com with SMTP id h1so20808555qvr.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C2zkZ60nc0oYz+Jw0v4vLWfZnUOJXoKUEdPKsKZO6hc=;
        b=WTte1qcXCrYF/YEJJeRnhFxEQyun+Nt6CLhVuoC5wbNEZbE/Nsq1LSKHdZfOKx/UFX
         N7f1f9vNIXDehn+SzqjGO7XHBsQYcStrXqP8d8Fflu8oRbg44eZ5s3fJvbI/czmTuMv5
         0ELG92SMt2E2oigFwUs6z0U8oKPlN8I3YExNyo2AKcYkaz9joiuhMXn0y3LlQwbrvADn
         /1tT2K3PLSublW7XXOJPmYbvhdzhwUtpZJz+T4v+SwovM6iMK306W62CaZJ+nf4PSg/r
         u6XzahqoLzYGZO/9xXK4k91c/5726yeWJ1tC9SoJtyuXJQoW1DQRzFCmAL9xFPQ8w5+h
         Soww==
X-Gm-Message-State: AOAM532hPjC31iqv0CvFZ1p4Zdp4ZAAbKuLCTUJKLr1+1f/4QlmJWgJN
        WJDc9ho8ferexW9+PW6kDcaxJKUKv6Vc/YZiZzi1GyH6Tb+fl8qQw5r6X/GRg8Cc0Ib/XiZFkUR
        4LzPZcqV37w/a6rDmT+gPZOS9
X-Received: by 2002:ac8:564e:: with SMTP id 14mr6045340qtt.286.1611089371704;
        Tue, 19 Jan 2021 12:49:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7yWKQXou9HBpzcYqZ8RsXxZxxAaFbMWaMbqqtjcbkVrqtnKwMsT4xtWYjmXVeEV11IyPkcQ==
X-Received: by 2002:ac8:564e:: with SMTP id 14mr6045326qtt.286.1611089371485;
        Tue, 19 Jan 2021 12:49:31 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 38sm11016784qtb.67.2021.01.19.12.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 12:49:30 -0800 (PST)
Subject: Re: [PATCH v7 0/6] Intel MAX10 BMC Secure Update Driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210105230855.15019-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b13a487f-7437-0278-6a9e-f10a5273065b@redhat.com>
Date:   Tue, 19 Jan 2021 12:49:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105230855.15019-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/21 3:08 PM, Russ Weight wrote:

...

>  .../testing/sysfs-driver-intel-m10-bmc-secure |  61 ++
>  MAINTAINERS                                   |   2 +
>  drivers/fpga/Kconfig                          |  11 +
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/intel-m10-bmc-secure.c           | 543 ++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h             |  85 +++

I am having trouble pulling this into my testing branch where i am tracking some other changes to intel-m10-bmc.h

https://lore.kernel.org/lkml/20210114231648.199685-1-russell.h.weight@intel.com/

https://lore.kernel.org/lkml/1609999628-12748-3-git-send-email-yilun.xu@intel.com/

so I am wondering if it makes sense to split the intel-m10-bmc.h change out of this patchset and sent as a single patch to mfd subsystem ?  The change is a bunch of #defines that don't do anything on their own, but will conflict with other similar additions to the h file.

Tom

>  6 files changed, 705 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>

