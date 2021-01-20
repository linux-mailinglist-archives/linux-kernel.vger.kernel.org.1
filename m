Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF512FCC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbhATH4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729699AbhATHzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:55:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A1C623131;
        Wed, 20 Jan 2021 07:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611129271;
        bh=IZ3xNUJOM7Y7pZR3MSGeJWjfTJwPs06jpM1oKNdi11s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xn8Lkt8oDvmmS1PqwSGGuEBwe6cVCngU/cM2JI5xiTWP4qByIpyi/JtEquo3Jyaye
         Uapp/x6+B4eoKjNKOlG6ASb82GsMT2ABwyk2mwJo4O3zu7KitHasFdcZc323d6FrYf
         y/h8TCiXEm+8SEmN3cH48VE2+GfibWbwzpubAd+U=
Date:   Wed, 20 Jan 2021 08:54:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        valentina.manea.m@gmail.com, hdanton@sina.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: =?utf-8?B?4oCcS0FTQU46IG51bGwtcHRyLWRl?=
 =?utf-8?Q?ref_Write_in_event=5Fhandler=E2=80=9D_and_=22KASAN=3A_null-ptr-?=
 =?utf-8?Q?deref_Write_i?= =?utf-8?Q?n?= vhci_shutdown_connection" should
 share the same root cause.
Message-ID: <YAfhs++HLaTsejb2@kroah.com>
References: <CAD-N9QUVDpHjSwZa+w3Zxx_Pn5ZrBKuhGhbg9PoyR=xbrMb88g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD-N9QUVDpHjSwZa+w3Zxx_Pn5ZrBKuhGhbg9PoyR=xbrMb88g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:22:11AM +0800, 慕冬亮 wrote:
> Dear kernel developers,
> 
> I found that on the syzbot dashboard, “KASAN: null-ptr-deref Write in
> event_handler”[1] and
> "KASAN: null-ptr-deref Write in vhci_shutdown_connection" () should
> share the same root cause.
> 
> 
> The reasons for the above statement:
> 1) the stack trace is the same, and this title difference is due to
> the inline property of "vhci_shutdown_connection";
> 2) their PoCs are the same as each other.
> 
> If you can have any issues with this statement or our information is
> useful to you, please let us know. Thanks very much.
> 
> [1] KASAN: null-ptr-deref Write in event_handler -
> https://syzkaller.appspot.com/bug?id=28cccdd18b4bb8670d077937fb8d4849dca96230
> [2] KASAN: null-ptr-deref Write in vhci_shutdown_connection -
> https://syzkaller.appspot.com/bug?id=c21c07f3d51769405e8efc027bdb927515dcc7d6

Great, care to create a patch for this problem?  That's the best way to
solve these things.

thanks,

greg k-h
