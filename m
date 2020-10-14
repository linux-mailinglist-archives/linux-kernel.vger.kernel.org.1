Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB52828E09D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgJNMim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgJNMil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602679120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqkeDSKu3ZVkwLcs3UzzlEHF4mgQLeE6ZnH74qRT2H8=;
        b=hc0/1nlfGOeriF7Sp2JwadWAUN4DbZmUb7QORly7S+wa9CGcwmArDdRRMz310P4o81xJKJ
        Eg0LiHC9gOeplUZz/HPzozbFuIXUE5xgA0Cbo/IlLHjXTTfh5rvSXT7kLO84Cu5ahKz4bk
        T1bEyiz3kFlSDLOo4OBPBDpEQBMjjvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-ny6F7mzWOEqg8ATH9qA8kw-1; Wed, 14 Oct 2020 08:38:38 -0400
X-MC-Unique: ny6F7mzWOEqg8ATH9qA8kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32E3C18A8239;
        Wed, 14 Oct 2020 12:38:37 +0000 (UTC)
Received: from [10.33.36.138] (unknown [10.33.36.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E3EA5C22D;
        Wed, 14 Oct 2020 12:38:31 +0000 (UTC)
Subject: Re: [Cluster-devel] KASAN: slab-out-of-bounds Write in
 gfs2_fill_super
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     syzbot <syzbot+af90d47a37376844e731@syzkaller.appspotmail.com>,
        agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <0000000000006903b205b0873061@google.com>
 <21b7b508-c8f2-4730-7a1d-b4376effcce0@redhat.com>
 <ceed2e5f-c03e-721f-ba2f-a581d6214e5c@gmail.com>
From:   Andrew Price <anprice@redhat.com>
Message-ID: <4d7412bf-15ba-58ee-3fa2-e6641dbca723@redhat.com>
Date:   Wed, 14 Oct 2020 13:38:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ceed2e5f-c03e-721f-ba2f-a581d6214e5c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 13:19, Anant Thazhemadam wrote:
> 
> On 30/09/20 7:52 pm, Andrew Price wrote:
>> On 30/09/2020 13:39, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    fb0155a0 Merge tag 'nfs-for-5.9-3' of git://git.linux-nfs...
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=13458c0f900000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=adebb40048274f92
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=af90d47a37376844e731

> 
> Just saw this report.
> This seems to be the same as
>      https://syzkaller.appspot.com/bug?extid=a5e2482a693e6b1e444b ,
> for which I have recently sent in a fix (https://lkml.org/lkml/2020/10/13/588).

Thanks. The gfs2 maintainers are probably busy but I'll review the patch.

> Since the "Reported-by" tag in the patch sent is for the other instance of the
> same crash, can we close this one as a duplicate?

I expect the duplicates will get closed once a fix is in the tree so 
there's no need to spend time on that.

Andy

