Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17F82A95EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgKFME6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:04:58 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:35068 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFME5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:04:57 -0500
Received: from host-92-5-241-147.as43234.net ([92.5.241.147] helo=[192.168.1.13])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kb0U9-0000Ln-TC; Fri, 06 Nov 2020 12:04:53 +0000
Subject: Re: [linux-safety] [PATCH] taskstats: remove unneeded dead assignment
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Balbir Singh <bsingharora@gmail.com>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
References: <20201106062210.27920-1-lukas.bulwahn@gmail.com>
 <6ab2415b-0642-16ee-4be0-c909e07e7565@codethink.co.uk>
 <alpine.DEB.2.21.2011061126130.20338@felia>
From:   Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Message-ID: <aea9d12d-88ee-f262-4328-03993521668f@codethink.co.uk>
Date:   Fri, 6 Nov 2020 12:04:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2011061126130.20338@felia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 06/11/2020 10:31, Lukas Bulwahn wrote:
> 
> 
> On Fri, 6 Nov 2020, Sudip Mukherjee wrote:
> 
>> Hi Lukas,
>>

<snip>

> 
> I did not try but I bet (a beverage of your choice) that the object code
> remains the same also for your suggested patch. Try to disprove my claim 
> and possibly earn yourself a beverage when we meet...

Lets decide which beverage.. ;-)

Using gcc-7.2.0 for MIPS:

original:- ab81d3305d578c2568fbc73aad2f9e61  kernel/taskstats.o
After your change:- ab81d3305d578c2568fbc73aad2f9e61  kernel/taskstats.o
After my change:- 0acae2c8d72abd3e15bf805fccdca711  kernel/taskstats.o



-- 
Regards
Sudip
