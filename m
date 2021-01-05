Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901232EA938
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbhAEKw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:52:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:60328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbhAEKw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:52:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609843899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctvgyyVLZwmab3QcFSKJMVqA4L0pIOmLRRQPugBuOjA=;
        b=dOi2ZlD73n5Gj8nhG2gCLg7GfoHsZIMlE565LwSspgL27LwmpOxKFHdOMUokOc2uQrQGLH
        RdnY3l25/m5wlVlveEUJwV7JVBpJzDURvMOQcJDjiELHLWaUQz6JjIliO1FUn6QA/Y7DAW
        BQJAUcC/RKKsdfsytrTGilDfrGGHUjA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90025AD0B;
        Tue,  5 Jan 2021 10:51:39 +0000 (UTC)
Message-ID: <d09747d30bdb0a79daf9fa4bd381cc8deeb81d50.camel@suse.com>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?= KASAN: use-after-free Read in
 service_outstanding_interrupt
From:   Oliver Neukum <oneukum@suse.com>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        syzbot <syzbot+9e04e2df4a32fb661daf@syzkaller.appspotmail.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "ingrassia@epigenesys.com" <ingrassia@epigenesys.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Date:   Tue, 05 Jan 2021 11:51:31 +0100
In-Reply-To: <BYAPR11MB2632EDC88523D674D9C63E73FFD10@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <000000000000994d2a05b6b49959@google.com>
        ,<6a56df508f597d38746878e80e1f159a556d3152.camel@suse.com>
         <BYAPR11MB2632EDC88523D674D9C63E73FFD10@BYAPR11MB2632.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 05.01.2021, 04:50 +0000 schrieb Zhang, Qiang:
> 
> ________________________________________
> 发件人: Oliver Neukum <oneukum@suse.com>
> 发送时间: 2021年1月5日 0:28
> 收件人: syzbot; andreyknvl@google.com; gregkh@linuxfoundation.org; gustavoars@kernel.org; ingrassia@epigenesys.com; lee.jones@linaro.org; linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; penguin-kernel@I-love.SAKURA.ne.jp; syzkaller-bugs@googlegroups.com
> 主题: Re: KASAN: use-after-free Read in service_outstanding_interrupt
> 
> Am Donnerstag, den 17.12.2020, 19:21 -0800 schrieb syzbot:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    5e60366d Merge tag 'fallthrough-fixes-clang-5.11-rc1' of g..
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12c5b623500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea7506b7139727
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9e04e2df4a32fb661daf
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175adf07500000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1672680f500000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: >syzbot+9e04e2df4a32fb661daf@syzkaller.appspotmail.com
> > 
> > #syz test: https://github.com/google/kasan.git  5e60366d
> > 
> 
>  Hello Oliver 
>  
>  this use-after-free still exists，It can be seen from calltrace that it is 
>  usb_device's object  has been released when disconnect,
>  can add a reference count to usb_device's object to avoid this problem 

Hi,

thanks for your analysis. I think you are correct in your analysis, but
I am afraid your fix is not correct. The driver is submitting an URB
to a disconnected device. Your fix would prevent a crash, which is
definitely good, but we still cannot do that, because the device may
be owned by another driver or usbfs at that time.

	Regards
		Oliver


