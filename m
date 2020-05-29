Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB31E76A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 09:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgE2H2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 03:28:49 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3924 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgE2H2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:28:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed0b9550001>; Fri, 29 May 2020 00:27:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 29 May 2020 00:28:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 29 May 2020 00:28:49 -0700
Received: from [10.2.62.53] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 May
 2020 07:28:48 +0000
Subject: Re: [PATCH] drm/radeon: Convert get_user_pages() --> pin_user_pages()
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <1590526802-3008-1-git-send-email-jrdr.linux@gmail.com>
 <69a033cf-63b2-7da6-6a5e-a5bbc94b8afb@nvidia.com>
 <20200527084852.GN206103@phenom.ffwll.local>
 <20200527085117.GO206103@phenom.ffwll.local>
 <aaf62285-981e-3753-5501-07bbba98fc36@nvidia.com>
 <CAFqt6zZVAQ3LKwud85LgHe9300xVjyGYXjvdWKTdezZA1uRewg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <011353ca-39d5-a41d-477a-f67a47ebb47b@nvidia.com>
Date:   Fri, 29 May 2020 00:28:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZVAQ3LKwud85LgHe9300xVjyGYXjvdWKTdezZA1uRewg@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590737237; bh=GnjtLmALkfQs3YEwXPer78fTSzDzMUUUxr8h8lxb8WY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IWUyjwMjgVPn9XuZYZnyVZqXqMpoRdk8CFFSla0+UZhlAYPfCTboaaJUR57mPsaYP
         CLdN+LqIRXGZZUSI2ONJHhigatZ3PBB6cOYkwG+xDoPzduDVeZHgYgZ2Ld7Mn0lqv7
         U+kaQyb0PteDfWGUkUoYxEhOT+cQ+CqLdWuPvOrLOyvqa4IoAXd4qEREjDxWVwdkzI
         XUSBmtmLwITlbundeWdKpN4UmCNuu/y+vEIXl9rZG5KdABbcs/F7YCz53v1MWeluAo
         hYOyvQflPC+Pe69zh02QN4DGJ3IsY5niUK3FBNTl4PDwXIeueM+DSVuIFdiIuWIKzs
         VwKIWPotgXg9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-28 23:49, Souptick Joarder wrote:
...
>> This is what case 3 was *intended* to cover, but it looks like case 3 needs to
>> be written a little better. I'll attempt that, and Cc you on the actual patch
>> to -mm. (I think we also need a case 5 for an unrelated scenario, too, so
>> it's time.)
> 
> There were no *case 5* in the other patch posted in -mm. Do we need to add it ?
> 

Working on figuring that out [1], but it's not directly relevant to this thread.
Maybe I shouldn't have brought it up here. :)


[1] https://lore.kernel.org/r/20200529070343.GL14550@quack2.suse.cz

thanks,
John Hubbard
NVIDIA



