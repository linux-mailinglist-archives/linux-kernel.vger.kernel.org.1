Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEAD2FE4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbhAUIWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:22:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbhAUISL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:18:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CFF42395B;
        Thu, 21 Jan 2021 08:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611217050;
        bh=rEhg2xjjN69IpbKMiBBQZQFOjm8uBG9MQ7u8pZTOCKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOHq3m0u1pYrdCTZhc7zCLIOUIUr+IdnICQnRC+MzBgfP6tooguQ4muSBJnjAm0C4
         JY2SDEdFp7Ye43KKA54bTGz1Ow9LKYoE0Y09B0NrnOsV3EUP2zPqochrbDGCKN8K6q
         15/CECQcnjATULZao2ao3ao8EeFTzhHMR7CbfaMQ=
Date:   Thu, 21 Jan 2021 09:17:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: "possible deadlock in console_lock_spinning_enable" and
 "possible deadlock in console_unlock" should be duplicate crash behaviors
Message-ID: <YAk4l+VB61V4SgVE@kroah.com>
References: <CAD-N9QV7H8cRUAbnrU9KuXvKbtwL6tLk8-p6HcGpwHn3NeqHJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD-N9QV7H8cRUAbnrU9KuXvKbtwL6tLk8-p6HcGpwHn3NeqHJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 01:37:05PM +0800, 慕冬亮 wrote:
> Dear kernel developers,
> 
> I found that on the syzbot dashboard, “possible deadlock in
> console_lock_spinning_enable”[1] and "possible deadlock in
> console_unlock"[2] should share the same root cause.
> 
> The reasons for the above statement:
> 1) the stack trace is the same, and this title difference is due to
> the inline property of "console_lock_spinning_enable";
> 2) their PoCs are the same as each other;
> 
> If you can have any issues with this statement or our information is
> useful to you, please let us know. Thanks very much.
> 
> [1] “possible deadlock in console_lock_spinning_enable” -
> https://syzkaller.appspot.com/bug?id=2820deb61d92a8d7ab17a56ced58e963e65d76d0
> [2] “possible deadlock in console_unlock” -
> https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a

Any proposed patch for these issues?

thanks,

greg k-h
