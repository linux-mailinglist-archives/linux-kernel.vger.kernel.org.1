Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01272F2B11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392522AbhALJSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:18:17 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:28370 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389435AbhALJSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610442922;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=EpANNDf4CjUjzP+5Duuu4ccpZXLfRAhsfQONK2YZNGg=;
        b=kFHYgoyc8Omf90RF4Fo9wR/A7j+TjVYsxriggvqNG11Qq4lUGxT/lvtHODcFHnw3PP
        2SvTZ6fdzATs37dOXc55FZ9JdoWThEkPPU7iKm8wYq14ImI/4Q3klMf72meg/4aA+G+4
        LM9i4R0LFC7NSmboYwTFNBumPHznH3TWVwo6ZxzD8CC1hn/lMeUMsLc4RIBGzi0JbfeM
        +PLdAv190dHsrMo8JJD0xTIoYVj3g7Px2eBFbwkg5lkTQ+CVFuYUIuznB6Ru1ciA9Kxz
        Zxe6f2eBcRCQJgp7xbF80n9kguze31BT22GLFFdZ5wJRJk8BIKN647UGQ/VRk8/mgVpB
        GVNQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xty10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.12.1 SBL|AUTH)
        with ESMTPSA id k075acx0C9C7KTC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 12 Jan 2021 10:12:07 +0100 (CET)
Subject: Re: KMSAN: kernel-infoleak in move_addr_to_user (4)
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     syzbot <syzbot+057884e2f453e8afebc8@syzkaller.appspotmail.com>,
        Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, David Miller <davem@davemloft.net>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <00000000000019908405b8891f9d@google.com>
 <20210111113059.42de599d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAM_iQpXbARpYRxFv4g2gC1+oPfdpKx8mMD_7d6BjWr5mPn3nrg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <b8606599-22ce-85af-21df-0a1c4a8f174b@hartkopp.net>
Date:   Tue, 12 Jan 2021 10:12:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpXbARpYRxFv4g2gC1+oPfdpKx8mMD_7d6BjWr5mPn3nrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.01.21 01:17, Cong Wang wrote:
> On Mon, Jan 11, 2021 at 11:33 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> Looks like a AF_CAN socket:
>>
>> r0 = socket(0x1d, 0x2, 0x6)
>> getsockname$packet(r0, &(0x7f0000000100)={0x11, 0x0, 0x0, 0x1, 0x0, 0x6, @broadcast}, &(0x7f0000000000)=0x14)
>>
> 
> Right, it seems we need a memset(0) in isotp_getname().

Yes m(

Sent a patch to fix it:

https://lore.kernel.org/linux-can/20210112090457.11262-1-socketcan@hartkopp.net/T/#u

Many thanks!

Oliver
