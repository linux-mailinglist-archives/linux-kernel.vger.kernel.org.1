Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A2B2E73FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 21:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL2UsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 15:48:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:48981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2UsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 15:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609274796;
        bh=DXNgMY2gAULxd8AeqlplAUzLbTg5YqXKvx2KpWfrN5o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HH/53CbBvwzhCJ7zVldUpXaPnhFMWCOPhW9GdYgNARzl6bSg0xdnKetIW2DbmyOgG
         739hiXOZPfx0tJ+gLqqG9+X+I8MDmGLy/6N0R8u8acNH3+cdte3dIOGtai3+R1kKcq
         ms/X482SocPu58cKp5Z+GvuwiJmT+rWSMyNXe79M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.6.105.225]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDNl-1kEiKx1WLn-00qhyQ; Tue, 29
 Dec 2020 21:46:36 +0100
Subject: Re: [RFC PATCH 2/2] mm: readahead: handle LARGE input to
 get_init_ra_size()
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
References: <20201220211051.1416-1-rdunlap@infradead.org>
 <20201222173533.c9e28416835d7487b0e28cda@linux-foundation.org>
 <6a595671-20a8-e63f-f3ea-f4749a574efa@infradead.org>
 <d2edfb69-93b4-d938-faf0-5f7c0f1158b9@gmx.de>
 <1f5a6e7b-c779-861e-fde8-409ca8e2541b@infradead.org>
 <bb5d8aee-96bf-4403-6a64-27f4c1159320@infradead.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Message-ID: <0c283ea9-b446-0e40-6dc8-e9585ae171b4@gmx.de>
Date:   Tue, 29 Dec 2020 21:46:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bb5d8aee-96bf-4403-6a64-27f4c1159320@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yripnOslDXNF7S/5HaYCwP/wjPGGKJsaXiQIgRaa1et1PdgbB3w
 hRjLX2kb79Vmi2TMqaSWmU9gg0+HRi4lpnsqbGAmuk+f1D/v/wN2qXRQCSqZGzuw+s/eFyB
 xecGWpUVUfpL0rVrnV6xWiGsCKTLwZmJ3auAVD2N6/JJHDekpQplc+jhW29jATgph1w0ByQ
 OaEGsPUVd7UC9SBLmedtg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:61KuzHQwVJ8=:3aKJHiW7uqlgY9iKR3k97K
 I8zd+kjqHw5qknrqhICpFQ1fl12w1zJ39KdQWIEFxasP0N7ci/ODdrhDqBjJhg/NqZJEBTTU+
 ZXkVGIp5Fwxw6jim2Vv99zTwhSoUe0HeMUuQXPRZpdkaIFbVgmwi/Mz0aU2mSjqm8FtrTnR9s
 beqV4yWrHP34CfSQ8I+j9PYCFsvM4nd8E0NgDpCSXsfrySlpSA3TSRBHqFf3TjcofM4SskCWB
 kPn8tMPxJUEltOljrd5GwwtRWIocUNIbz13XjdechuDEfrFwu559RMSXWrdXrBHW0YQCAYXw9
 DgLGxacxROvOZj2Gv5ySgl7pEEVfmSyBZ5Jljuh0ZDeWO3HV19fHSoxyrrcCe0ea2wQgym89M
 ovxPnm0fV6B8+vuvK/ecZhE30tPvoo7or7yXqqcIDIi5z9MryLD++nXYoIX1tUOBTimahrcqm
 Pp7O4v3V4ff1WPQBwiwFi/BD+t/6sHKYzPVG9BSehodgeq081hGpmXz/oVkQI8dIKFA1ohz6M
 vZcgao5VOkgaK90qccuTYM421O2sOf5SEYgCKWL/HVBHiaUQrvkO1osHwkaeeFeVGwWVCJWfs
 Rbe8J4Or42lbSPl1bOrdzUJ+cn452trJOADkqwe7XBo1OZxOurdaUFlE8OLLEZJnFyLKqwAky
 jiXFx5ShKVl3I9YuPzlC+OiBadXcAgcw48eWX/pJu63IxrS51Asui8ZpRUJ6KyXJCoFaBbTCi
 2olDxvVQ+TXWAEdJjiZMJV8gWOBTlMe5gnMCznc+02ORbrBDcxoWL0KhFFtlYMoW4a5w/tbSN
 nu/PhO322heT06vHXcxVwIriSwHShXfGmiQR2AbpGkbr/iQDbLjwXtvRQ6gsUJe1xml8zs7Lp
 mzrfL/a5sE/5I6d4Ua2A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/20 9:00 PM, Randy Dunlap wrote:
> Hi Toralf,
>
> Do you want either or both of your
> Reported-by: and Tested-by: on the patch?
>
> thanks.
> -- ~Randy
The first is enough, for a Tested-by: was the time frame too short IMO.

=2D-
Toralf
