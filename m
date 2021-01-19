Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926D52FAEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394185AbhASCbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:31:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbhASCbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:31:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9067822252;
        Tue, 19 Jan 2021 02:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611023457;
        bh=C+9eIgICYriHBQgEbdnewfzn9v/8qrqeGdKatvk8yHw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=s8MxORnLisAWKaAOby+VGK9r+paq6hy+E0h0BHMA7MEWZjPbnft3AC4BEf0JLsyOg
         WilTObSWZMYkfMHgG+p1F/KqCFbfPG8E5AyrpdJ3EJ96H0/MWrOr66iHHe5IH35rlm
         di/KQ19lZO2zzJLED7hvk/xPmggC2bKr2ayc/pCG9CrNGvaRSZqJicVlXH1nOSfar5
         ILvmf2kt1FO8eoUA3s8F2+GN+gdhjsemYZv9eEPoh0fgLApSrvs5rbZmQ0mHfMRj/j
         Z/OqtNAoAF8UdK+45GNfH021DZ2zX+Wa6JzRYvl9CuZqBKERBeTjBe7sUucxs/Otzk
         Q3Fr/ilp2PTeQ==
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <a4e7ca9b-232a-cfb9-c500-2375b169c7d7@kernel.org>
Date:   Mon, 18 Jan 2021 20:30:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/21 6:53 PM, Sergey Senozhatsky wrote:
> I like the idea of a more radical name, e.g. DUMP_PREFIX_RAW_POINTERS or
> something similar.

Is "raw pointer" the common term for unhashed pointers?
