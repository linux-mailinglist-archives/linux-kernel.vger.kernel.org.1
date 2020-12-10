Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24822D6339
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392677AbgLJRO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:14:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392651AbgLJROv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:14:51 -0500
Date:   Thu, 10 Dec 2020 09:14:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607620450;
        bh=C8ZePt3ibAbn2SvFtGU1A5iTKaaZbj+6MMRq98SBmcU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+B6oE9CTJA941tPuIKqDfch69S2bGzwtXjWqqHxMMY1IC2xYsk21gF40MBfF0A/m
         r7JKPwAqsgKb1eZJCru3q4/vBWmoiGr/vuHh7fobGmhL65WNS5lTlQwFmz9utnmUCn
         g5q61hhlDSQG9xuMZIXHZIGwsblNfHBRtkBFSBpzNaHFF/KuOEHu5v/nBjkO2ycErx
         pnutbcVdilJl/571kXeF1BwrWCZuIgJZ3wKqgumtfs9/sU3FbGZHM/Q2sFetZbbo3G
         gadWh0H5i9gTLDl/OBCh2xi6JxIGCPFaAyzwDgFzZe86zVas2R5yunRhyAAY5OuqGp
         02eePrqdGorCw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Chao Yu <chao@kernel.org>,
        syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: fix potential shift-out-of-bounds
 error in sanity_check_raw_super()
Message-ID: <X9JXYAqaTwdtMABE@google.com>
References: <20201209181322.27932-1-anant.thazhemadam@gmail.com>
 <9e38608c-9fc3-1f94-d275-742facef3db3@huawei.com>
 <8d293b99-4414-1317-7426-79692bbaa715@gmail.com>
 <1215c353-3c3f-0a61-00a3-021f0c2f0032@huawei.com>
 <38c68ef8-4b9b-cfc1-d8ad-cfeb4c2de845@gmail.com>
 <e72ff237-9d9a-2dbe-6a31-65046db9ee64@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72ff237-9d9a-2dbe-6a31-65046db9ee64@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10, Chao Yu wrote:
> Jaegeuk,
> 
> Could you please help to add signed-off of Anant manually in
> 
> f2fs: fix shift-out-of-bounds in sanity_check_raw_super()

Done. Thank you guys. :)

> 
> Thanks,
> 
> On 2020/12/10 10:14, Anant Thazhemadam wrote:
> > 
> > On 10/12/20 7:40 am, Chao Yu wrote:
> > > On 2020/12/10 10:00, Anant Thazhemadam wrote:
> > > > 
> > > > On 10/12/20 7:16 am, Chao Yu wrote:
> > > > > Hi Anant,
> > > > > 
> > > > > I've posted a patch a little earlier. :P
> > > > > 
> > > > > https://lore.kernel.org/linux-f2fs-devel/20201209084936.31711-1-yuchao0@huawei.com/T/#u
> > > > > 
> > > > Ah well, that's alright, especially considering that your patch looks better.
> > > > Glad that bug has been fixed nonetheless. :)
> > > 
> > > Anyway, thanks a lot for taking time to fix f2fs bug. :)
> > > 
> > > I prefer to add your Signed-off-by into "f2fs: fix shift-out-of-bounds
> > > in sanity_check_raw_super()" if you don't mind.
> > > 
> > > 
> > 
> > Sure, I'd appreciate that. Thank you! :D
> > 
> > Thanks,
> > Anant
> > 
> > .
> > 
