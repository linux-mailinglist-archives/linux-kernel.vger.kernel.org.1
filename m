Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFBE2F70F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 04:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbhAODa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 22:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhAODa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 22:30:56 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497BAC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:30:16 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id t15so2480181ual.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FHB4fMBtfKDMwN9w9JdCzRXoxbs4xAQTsyrkwH5WUSA=;
        b=lDrTqRAmOyTHtKoQN7FBr4FOu44a9JPSGOR2jxU/vvAjs9jeZEuc3W9V1xmt0FAm4y
         G3WfA1n3aOtX9mKjEyYCUE9VZvpMTwtfiavn88Q54AVQBMCOk4GxxmAx0wRtpBNgE8LI
         CNjQlmVzWn/1JBrMal5k5hg0tW75iDYVZkUvyyZaHMq3XN6AjcHx6mItzPIGzZPNP67f
         1hPE2etZ+TDNEhxST75xYY4AOig8aHBAlXo+TLIBGxLhLdeE3Yfq3YbI3D21GxKKu8mq
         owD8bmtfQS+SXbQ29f9xwZhF0rqqr1SUtUldetYwhZi23VWOkr4IDKLISV5KeyuRlTNN
         /M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FHB4fMBtfKDMwN9w9JdCzRXoxbs4xAQTsyrkwH5WUSA=;
        b=nfxtmq01zZMizs0OUpJxgqSbULT4AB/FfNoxYOqZFJgwZhSSt2U7bYpVH3rhiCD5t8
         On1g7fTte96GfSesaR9Dz5OoxRGtz+qoQOnDiDfIqavRn82fjzo/RCIzOt61t4gIGRFF
         UpnjBrglekOvnVW/VdO+/feNtVK7qXozuGOQNwQiXT1nMoQl5p8QUrhgZtScPBLxmVWM
         R9qWcl4mS7orn14bZHqLR3PO1WSoC54/lGIlr8yHhSGW5GI2BID4+bm9qnq4STJgAf/b
         4Z62LEFvlQpDanwJOQOXDZcDac6zanCSD+dAiff/WVcWcesunMIVmnlGSG6TFDKk/2ml
         PyNQ==
X-Gm-Message-State: AOAM532Vb+L+VX/lh7kTyeRNipuU1VWXsaNOMgFCboHm4AtEyR7dtBHz
        RDbDju6A5r0CNo4A5i0//GssL9CmcNgHUPtHDxSdyQQyRcEupi/PrU8=
X-Google-Smtp-Source: ABdhPJyN0jpln82clSMDqfYY3n10nf1X2e7qZe1UJ0WGM+Ui1KmCf7Lp56vWBEt8DjaamTchOWz/xXi4HwyQ+m5Jmg0=
X-Received: by 2002:ab0:2388:: with SMTP id b8mr8290397uan.122.1610681415412;
 Thu, 14 Jan 2021 19:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20210113160621.98615-1-fengli@smartx.com> <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me> <20210114174311.GB31188@lst.de>
In-Reply-To: <20210114174311.GB31188@lst.de>
From:   Li Feng <fengli@smartx.com>
Date:   Fri, 15 Jan 2021 11:30:06 +0800
Message-ID: <CAHckoCzhJVAWFSYeCAMHZ+fVqzv_1XxvM97QmvCESnEcc5AQuQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller than a sector
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lifeng1519@gmail.com" <lifeng1519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> =E4=BA=8E2021=E5=B9=B41=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jan 13, 2021 at 02:12:59PM -0800, Sagi Grimberg wrote:
> >> But this only catches a physical block size < 512 for NVMe, not any ot=
her block device.
> >>
> >> Please fix it for the general case in blk_queue_physical_block_size().
> >
> > We actually call that later and would probably be better to check here.=
.
>
> We had a series for that a short while ago that got lost.
Where is the series? Or could you advise on how to fix this issue is accept=
able?
This issue will generate an oops, check it here:
https://lkml.org/lkml/2021/1/12/1064

Thanks,
Feng Li
