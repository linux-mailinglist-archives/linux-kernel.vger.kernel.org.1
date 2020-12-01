Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539832CAA44
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgLARzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:55:00 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:35406 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbgLARzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:55:00 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kk9qz-006d9m-5Z; Tue, 01 Dec 2020 10:54:17 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kk9qy-004hnJ-3X; Tue, 01 Dec 2020 10:54:16 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com,
        serge@hallyn.com,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20201126100839.381415-1-gscrivan@redhat.com>
Date:   Tue, 01 Dec 2020 11:53:45 -0600
In-Reply-To: <20201126100839.381415-1-gscrivan@redhat.com> (Giuseppe
        Scrivano's message of "Thu, 26 Nov 2020 11:08:39 +0100")
Message-ID: <87ft4pe7km.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kk9qy-004hnJ-3X;;;mid=<87ft4pe7km.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Fu0dFA+bYSGa77HVml2uWF1UtEkv3LNk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Giuseppe Scrivano <gscrivan@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 468 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (2.6%), b_tie_ro: 10 (2.2%), parse: 1.29
        (0.3%), extract_message_metadata: 6 (1.3%), get_uri_detail_list: 3.3
        (0.7%), tests_pri_-1000: 4.0 (0.9%), tests_pri_-950: 1.77 (0.4%),
        tests_pri_-900: 1.36 (0.3%), tests_pri_-90: 143 (30.6%), check_bayes:
        141 (30.1%), b_tokenize: 9 (1.8%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 4.0 (0.8%), b_tok_touch_all: 113 (24.2%), b_finish: 1.51
        (0.3%), tests_pri_0: 279 (59.6%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 1.11 (0.2%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kernel: automatically split user namespace extent
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nit: The tag should have been "userns:" rather than kernel.

Giuseppe Scrivano <gscrivan@redhat.com> writes:

> writing to the id map fails when an extent overlaps multiple mappings
> in the parent user namespace, e.g.:
>
> $ cat /proc/self/uid_map
>          0       1000          1
>          1     100000      65536
> $ unshare -U sleep 100 &
> [1] 1029703
> $ printf "0 0 100\n" | tee /proc/$!/uid_map
> 0 0 100
> tee: /proc/1029703/uid_map: Operation not permitted
>
> To prevent it from happening, automatically split an extent so that
> each portion fits in one extent in the parent user namespace.

I don't see anything fundamentally wrong with relaxing this
restriction, but more code does have more room for bugs to hide.

What is the advantage of relaxing this restriction?

> $ cat /proc/self/uid_map
>          0       1000          1
>          1     110000      65536
> $ unshare -U sleep 100 &
> [1] 1552
> $ printf "0 0 100\n" | tee /proc/$!/uid_map
> 0 0 100
> $ cat /proc/$!/uid_map
>          0          0          1
>          1          1         99
>
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  kernel/user_namespace.c | 62 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 52 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 87804e0371fe..b5542be2bd0a 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -706,6 +706,41 @@ const struct seq_operations proc_projid_seq_operations = {
>  	.show = projid_m_show,
>  };
>  
> +static void split_overlapping_mappings(struct uid_gid_map *parent_map,
> +				       struct uid_gid_extent *extent,
> +				       struct uid_gid_extent *overflow_extent)
> +{
> +	unsigned int idx;
> +
> +	overflow_extent->first = (u32) -1;
> +
> +	/* Split extent if it not fully contained in an extent from parent_map.  */
> +	for (idx = 0; idx < parent_map->nr_extents; idx++) {

Ouch!

For the larger tree we perform binary searches typically and
here you are walking every entry unconditionally.

It looks like this makes the write O(N^2) from O(NlogN)
which for a user facing function is not desirable.

I think something like insert_and_split_extent may be ok.
Incorporating your loop and the part that inserts an element.

As written this almost doubles the complexity of the code,
as well as making it perform much worse.  Which is a problem.


> +		struct uid_gid_extent *prev;
> +		u32 first, last, prev_last, size;
> +
> +		if (parent_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> +			prev = &parent_map->extent[idx];
> +		else
> +			prev = &parent_map->forward[idx];
> +
> +		first = extent->lower_first;
> +		last = extent->lower_first + extent->count - 1;
> +		prev_last = prev->first + prev->count - 1;
> +
> +		if ((first <= prev_last) && (last > prev_last)) {
> +			size = prev_last - first + 1;
> +
> +			overflow_extent->first = extent->first + size;
> +			overflow_extent->lower_first = extent->lower_first + size;
> +			overflow_extent->count = extent->count - size;
> +
> +			extent->count = size;
> +			return;
> +		}
> +	}
> +}
> +
>  static bool mappings_overlap(struct uid_gid_map *new_map,
>  			     struct uid_gid_extent *extent)
>  {
> @@ -852,6 +887,7 @@ static ssize_t map_write(struct file *file, const char __user *buf,
>  	struct uid_gid_map new_map;
>  	unsigned idx;
>  	struct uid_gid_extent extent;
> +	struct uid_gid_extent overflow_extent;
>  	char *kbuf = NULL, *pos, *next_line;
>  	ssize_t ret;
>  
> @@ -946,18 +982,24 @@ static ssize_t map_write(struct file *file, const char __user *buf,
>  		     extent.lower_first)
>  			goto out;
>  
> -		/* Do the ranges in extent overlap any previous extents? */
> -		if (mappings_overlap(&new_map, &extent))
> -			goto out;
> +		do {
> +			/* Do the ranges in extent overlap any previous extents? */
> +			if (mappings_overlap(&new_map, &extent))
> +				goto out;

Why should mappings_overlap be called in the loop?   Will splitting an
extent create the possibility for creating overlapping mappings?

> -		if ((new_map.nr_extents + 1) == UID_GID_MAP_MAX_EXTENTS &&
> -		    (next_line != NULL))
> -			goto out;
> +			if ((new_map.nr_extents + 1) == UID_GID_MAP_MAX_EXTENTS &&
> +			    (next_line != NULL))
> +				goto out;
>  
> -		ret = insert_extent(&new_map, &extent);
> -		if (ret < 0)
> -			goto out;
> -		ret = -EINVAL;
> +			split_overlapping_mappings(parent_map, &extent, &overflow_extent);
> +
> +			ret = insert_extent(&new_map, &extent);
> +			if (ret < 0)
> +				goto out;
> +			ret = -EINVAL;
> +
> +			extent = overflow_extent;
> +		} while (overflow_extent.first != (u32) -1);
>  	}
>  	/* Be very certaint the new map actually exists */
>  	if (new_map.nr_extents == 0)

Eric
