Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9610E2CC1D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgLBQOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:14:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728079AbgLBQOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606925553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bAQZJi/RrInzz1owaoShDGjHWxcR9Hen4gXOOVnOH+Q=;
        b=fyg2aF0zHBvWcig+kH9LgHml2Yz1wFaS9Tb00dEFtFCb1TlYZf+NXb5ln2xk21+uSYNA6f
        dGhi/8sZv7YCXy/e5WcNR65RhfYYVO6ASFmfJXyj+5LVlgU0UnkVmCoXpYry5mN2pubc3U
        HlRGWITTgy8e7aOeGSss2SyIK/0QsRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-svKMnCgTPhmkOFkTAuKO0w-1; Wed, 02 Dec 2020 11:12:31 -0500
X-MC-Unique: svKMnCgTPhmkOFkTAuKO0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48622185E48B;
        Wed,  2 Dec 2020 16:12:30 +0000 (UTC)
Received: from localhost (ovpn-114-104.ams2.redhat.com [10.36.114.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB5D15D6AC;
        Wed,  2 Dec 2020 16:12:29 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com,
        serge@hallyn.com,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] kernel: automatically split user namespace extent
References: <20201126100839.381415-1-gscrivan@redhat.com>
        <87ft4pe7km.fsf@x220.int.ebiederm.org>
Date:   Wed, 02 Dec 2020 17:12:27 +0100
In-Reply-To: <87ft4pe7km.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 01 Dec 2020 11:53:45 -0600")
Message-ID: <87pn3schlg.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

ebiederm@xmission.com (Eric W. Biederman) writes:

> Nit: The tag should have been "userns:" rather than kernel.
>
> Giuseppe Scrivano <gscrivan@redhat.com> writes:
>
>> writing to the id map fails when an extent overlaps multiple mappings
>> in the parent user namespace, e.g.:
>>
>> $ cat /proc/self/uid_map
>>          0       1000          1
>>          1     100000      65536
>> $ unshare -U sleep 100 &
>> [1] 1029703
>> $ printf "0 0 100\n" | tee /proc/$!/uid_map
>> 0 0 100
>> tee: /proc/1029703/uid_map: Operation not permitted
>>
>> To prevent it from happening, automatically split an extent so that
>> each portion fits in one extent in the parent user namespace.
>
> I don't see anything fundamentally wrong with relaxing this
> restriction, but more code does have more room for bugs to hide.
>
> What is the advantage of relaxing this restriction?

we are running rootless containers in a namespace created with
newuidmap/newgidmap where the mappings look like:

$ cat /proc/self/uid_map
0       1000          1
1     110000      65536

users are allowed to create child user namespaces and specify the
mappings to use.  Doing so, they often hit the issue that the mappings
cannot overlap multiple extents in the parent user namespace.

The issue could be completely addressed in user space, but to me it
looks like an implementation detail that user space should not know
about.
In addition, it would also be slower (additional read of the current
uid_map and gid_map files) and must be implemented separately in each
container runtime.

>> $ cat /proc/self/uid_map
>>          0       1000          1
>>          1     110000      65536
>> $ unshare -U sleep 100 &
>> [1] 1552
>> $ printf "0 0 100\n" | tee /proc/$!/uid_map
>> 0 0 100
>> $ cat /proc/$!/uid_map
>>          0          0          1
>>          1          1         99
>>
>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>> ---
>>  kernel/user_namespace.c | 62 ++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 52 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>> index 87804e0371fe..b5542be2bd0a 100644
>> --- a/kernel/user_namespace.c
>> +++ b/kernel/user_namespace.c
>> @@ -706,6 +706,41 @@ const struct seq_operations proc_projid_seq_operations = {
>>  	.show = projid_m_show,
>>  };
>>  
>> +static void split_overlapping_mappings(struct uid_gid_map *parent_map,
>> +				       struct uid_gid_extent *extent,
>> +				       struct uid_gid_extent *overflow_extent)
>> +{
>> +	unsigned int idx;
>> +
>> +	overflow_extent->first = (u32) -1;
>> +
>> +	/* Split extent if it not fully contained in an extent from parent_map.  */
>> +	for (idx = 0; idx < parent_map->nr_extents; idx++) {
>
> Ouch!
>
> For the larger tree we perform binary searches typically and
> here you are walking every entry unconditionally.
>
> It looks like this makes the write O(N^2) from O(NlogN)
> which for a user facing function is not desirable.
>
> I think something like insert_and_split_extent may be ok.
> Incorporating your loop and the part that inserts an element.
>
> As written this almost doubles the complexity of the code,
> as well as making it perform much worse.  Which is a problem.

I've attempted to implement the new functionality at input validation
time to not touch the existing security checks.

I've thought the pattern for iterating the extents was fine as I've
taken it from mappings_overlap (even if it is used differently on an
unsorted array).

Thanks for the hint, I'll move the new logic when map_id_range_down() is
used and I'll send a v2.

Thanks,
Giuseppe

