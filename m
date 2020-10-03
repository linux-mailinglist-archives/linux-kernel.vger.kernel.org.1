Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21492825B4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 19:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgJCRyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 13:54:47 -0400
Received: from winds.org ([68.75.195.9]:40800 "EHLO winds.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgJCRyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 13:54:47 -0400
Received: by winds.org (Postfix, from userid 100)
        id 469B0148963F; Sat,  3 Oct 2020 13:54:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by winds.org (Postfix) with ESMTP id 444EF1486015;
        Sat,  3 Oct 2020 13:54:46 -0400 (EDT)
Date:   Sat, 3 Oct 2020 13:54:46 -0400 (EDT)
From:   Byron Stanoszek <gandalf@winds.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        "M. Vefa Bicakci" <m.v.b@runbox.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: USBIP is claiming all my USB devices - Commit 7a2f2974f265 is
 broken
In-Reply-To: <20201003172738.GA1526548@kroah.com>
Message-ID: <alpine.LNX.2.23.451.2010031353180.5043@winds.org>
References: <alpine.LNX.2.23.451.2010031259080.4257@winds.org> <20201003172738.GA1526548@kroah.com>
User-Agent: Alpine 2.23 (LNX 451 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Oct 2020, Greg Kroah-Hartman wrote:

> On Sat, Oct 03, 2020 at 01:18:36PM -0400, Byron Stanoszek wrote:
>> All,
>>
>> I was testing Linux 5.9-rc7 today when I realized that none of my USB devices
>> were responding anymore. For instance, my mouse does not respond and its usual
>> red LED is not on.
>>
>> Reverting git commit 7a2f2974f265 solved the problem for me.
>
> Can you try the patches listed here:
> 	https://lore.kernel.org/r/20201003142651.GA794077@kroah.com
>
> As this issue should be solved with them.  Hopefully :)

I confirm this also solved the problem for me.

Thanks,
  -Byron

