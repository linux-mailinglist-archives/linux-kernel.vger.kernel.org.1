Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959BC28EC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 07:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgJOFJh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Oct 2020 01:09:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52671 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgJOFJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 01:09:37 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kSvWA-00052Y-Sr
        for linux-kernel@vger.kernel.org; Thu, 15 Oct 2020 05:09:35 +0000
Received: by mail-pl1-f199.google.com with SMTP id x11so1027245plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 22:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CKMUi55uSlXTFPdNQwqvWcYtcP11uT5LRNRhx7+ShsM=;
        b=Q+jMoSqvxbGBBOkdNW76Nb+ueawMePcv4ZV6qbH9/ryMFWxTxwsyxgNQCOTGVQlzfz
         8cmrYMMmwntYtazQxSTntdtyfFuLAX18zhpW81GxOT9oq4MT85QOStiM4Oj/sB88X8AJ
         DN2ap2D3Ul8R9VA/T/AziinRL+3lsytqDI7LD3CUJ82PaV8Kgzr9FIBRV/J1oZNQlnnA
         zM/oZ9pn1PUsEam5FLlEvXTSKrkDvDr98Z47MePskMQQHYWe/tQxYurZuhrl4LE2F6vY
         TH8dXHVIs54ifPynj6O9Ie9SGms2EBUfY9NoB10msGaMul/LUML7bI5kjN1x0gTCmcPP
         8D7A==
X-Gm-Message-State: AOAM532Z6dSjB3NpEDcWRbCggzjUM7CQ7w+Rj9T7xAQvlq0dsi9iZmTl
        +KF4Es7YxA0w5FbBfGl0XNSgUNAFXBJEICItft3DcvVsloyDjKTBLxGB6Js/j675BCuDA0Jzryx
        teVhDEKINj4VxAX0q/J57QOIxMWpxZQRv5HmWJnLPlg==
X-Received: by 2002:aa7:9607:0:b029:155:2b85:93f5 with SMTP id q7-20020aa796070000b02901552b8593f5mr2556740pfg.36.1602738573540;
        Wed, 14 Oct 2020 22:09:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxTnizW2vFtpThp3YQPzh957kld1b3aOAutHHKHaqwl8BgCzLea3bc4ZkHmozWup8Of2OIrA==
X-Received: by 2002:aa7:9607:0:b029:155:2b85:93f5 with SMTP id q7-20020aa796070000b02901552b8593f5mr2556722pfg.36.1602738573267;
        Wed, 14 Oct 2020 22:09:33 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id x18sm1429145pga.49.2020.10.14.22.09.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 22:09:32 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nvme-pci: Disable Write Zeroes on Sandisk Skyhawk
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <BYAPR04MB496518A4C9FC65964C58453386050@BYAPR04MB4965.namprd04.prod.outlook.com>
Date:   Thu, 15 Oct 2020 13:09:30 +0800
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <73A03A07-05E3-40FA-991F-5B98C05B51D1@canonical.com>
References: <20200723155731.22313-1-kai.heng.feng@canonical.com>
 <20201013083445.12317-1-kai.heng.feng@canonical.com>
 <BYAPR04MB496518A4C9FC65964C58453386050@BYAPR04MB4965.namprd04.prod.outlook.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 14, 2020, at 08:20, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> wrote:
> 
> On 10/13/20 01:45, Kai-Heng Feng wrote:
>> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
>> Write Zeroes command"), Sandisk Skyhawk has the same issue:
>> [ 6305.633887] blk_update_request: operation not supported error, dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> 
>> So also disable Write Zeroes command on Sandisk Skyhawk.
>> 
>> BugLink: https://bugs.launchpad.net/bugs/1899503
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Are you sure this happens all the devices of the same model
> 
> and not a firmware bug on specific device ?
> 
> If yes then looks good.

Yes, and this is the reply from WD, requested by the user:
"These are newest WD branded drives and WD already confirmed they are
the newest firmware / no upgrades are available."

Kai-Heng

> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> 
> 

