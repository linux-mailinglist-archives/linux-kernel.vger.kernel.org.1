Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4377027EAC8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgI3OTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730417AbgI3OTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:19:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601475552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYjbBMQ83eaNacfVtQ9f2FcgQ6pnWOwYQXbTX02y2e4=;
        b=B9QfmTcoKbneAPajkA1z8PmgemcT2sOOPrcHmtowP5gOrLpI2ohI4/NWrBbHruWqbASslW
        eZt+5ofConZiNtRVINQb1lmQSBb3169PekJq2EvZshqnmWHBwAGONT2LgUQ8Z5OCGaaqMh
        CqQj/mXE8VlEaPNfTBIzys8L9b3uebY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-tyGoVakaPwKhU6o5Vi0YtQ-1; Wed, 30 Sep 2020 10:18:55 -0400
X-MC-Unique: tyGoVakaPwKhU6o5Vi0YtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBAC118B9ECB;
        Wed, 30 Sep 2020 14:18:54 +0000 (UTC)
Received: from [10.33.36.138] (unknown [10.33.36.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB0B81002D42;
        Wed, 30 Sep 2020 14:18:49 +0000 (UTC)
Subject: Re: general protection fault in gfs2_withdraw
To:     syzbot <syzbot+50a8a9cf8127f2c6f5df@syzkaller.appspotmail.com>,
        agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <000000000000a7770405b06d21ac@google.com>
From:   Andrew Price <anprice@redhat.com>
Message-ID: <e00203bd-5ee9-d265-5c2d-9b2bca0c72ca@redhat.com>
Date:   Wed, 30 Sep 2020 15:18:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <000000000000a7770405b06d21ac@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2020 06:34, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 601ef0d52e9617588fcff3df26953592f2eb44ac
> Author: Bob Peterson <rpeterso@redhat.com>
> Date:   Tue Jan 28 19:23:45 2020 +0000
> 
>      gfs2: Force withdraw to replay journals and wait for it to finish
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151d25e3900000
> start commit:   7c7ec322 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=171d25e3900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=131d25e3900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6184b75aa6d48d66
> dashboard link: https://syzkaller.appspot.com/bug?extid=50a8a9cf8127f2c6f5df
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c6a109900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d45ed3900000
> 
> Reported-by: syzbot+50a8a9cf8127f2c6f5df@syzkaller.appspotmail.com
> Fixes: 601ef0d52e96 ("gfs2: Force withdraw to replay journals and wait for it to finish")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

Bug filed for this one:

https://bugzilla.redhat.com/show_bug.cgi?id=1883932

Andy

