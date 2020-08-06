Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6228323D523
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 03:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHFBgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 21:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFBgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 21:36:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864D9C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 18:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=EkE504dIDh6DgjrlTkQmStpUwUgt0aoUyCrIW3ri/4A=; b=B3UqOi7/QkpLhw0oZC8mpwO1sR
        o7Vv7Cd2TAm1Ms5Q2zIayjg8Cf1XhCYqIf/WzwS2g4NPS9cQRqldJ9lYe9HG6mi2b8+dWaE0mrSQx
        4thar0fINnl18Kk04uYXkVHSbtFcY5nrVQgYNphb/l1FxjieF7Co2B2Z2dIH67QF2lZJ7cBOMs6oI
        ijsgMlQUCP5+HqvGnGWLTbppJBa5ynQD9GD9HpfihZP5olmLOtIygPeGMmDoO3S2ddLJEcnMlAb9D
        WjN62v70qIN/18ZoMdMs6NjHhulW2bmHYfFNHO+9DPr1zmzeDSQNri+PLitv8GuaQo2pv2SsEuq9U
        NSMjyWNg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3UpH-0006DN-Oa; Thu, 06 Aug 2020 01:36:14 +0000
Subject: Re: Is anyone else getting a bad signature from kernel.org's 5.8
 sources+Greg's sign?
To:     David Niklas <Hgntkwis@vfemail.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20200805205924.1f646d45@Phenom-II-x6.niklas.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a943a1f-c5ef-937f-f67e-1c59c04d63fb@infradead.org>
Date:   Wed, 5 Aug 2020 18:36:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805205924.1f646d45@Phenom-II-x6.niklas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/20 5:59 PM, David Niklas wrote:
> Hello,
> I downloaded the kernel sources from kernel.org using curl, then
> opera, and finally lynx (to rule out an html parsing bug). I did the same
> with the sign and I keep getting:
> 
> %  gpg2 --verify linux-5.8.tar.sign linux-5.8.tar.xz
> gpg: Signature made Mon Aug  3 00:19:13 2020 EDT
> gpg:                using RSA key 647F28654894E3BD457199BE38DBBDC86092693E
> gpg: BAD signature from "Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>" [unknown]
> 
> I did refresh all the keys just in case.
> I believe this is important so I'm addressing this to the signer and only
> CC'ing the list.
> 
> If I'm made some simple mistake, feel free to send SIG666 to my terminal.
> I did re-read the man page just in case.

It works successfully for me.


from https://www.kernel.org/category/signatures.html::


If you get "BAD signature"

If at any time you see "BAD signature" output from "gpg2 --verify", please first check the following first:

    Make sure that you are verifying the signature against the .tar version of the archive, not the compressed (.tar.xz) version.
    Make sure the the downloaded file is correct and not truncated or otherwise corrupted.

If you repeatedly get the same "BAD signature" output, please email helpdesk@kernel.org, so we can investigate the problem.



-- 
~Randy

