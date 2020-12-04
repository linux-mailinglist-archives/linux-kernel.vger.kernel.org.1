Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8772CF195
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbgLDQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:08:52 -0500
Received: from mail-db8eur06olkn2054.outbound.protection.outlook.com ([40.92.51.54]:13792
        "EHLO EUR06-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730532AbgLDQIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:08:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moBUxkPr2nkQ4NjEp+ATmvKWHhM9agTDwEw2IhJPMeisDEiXJkGcfvl+/1YniOzYDj2k9t6ZAPH+RO8HQhprFCo36GsX2ohhvjaVtXs/LNqVZNL4OuaOPbU6Uzh3FiZp5qgPFdxACk4hsB/o3hAaHgUaA8pNNt8Exv+//diOrhqYfPklYtyg2uyVKLWBi+FSH1Nc5LU/7Jx6dgxMgv4ApXgX5ypmArxJvhjqTXj3QK0k/0vVXZi1R58qoRCSllvqdpvlS3iXQq4l+H7WMaJ3jKPEfixI86ld+GmExV24zLNQIQQq5CbSPSEgQeQAwOWaFZ0FnUEjtwBQ14da/ODWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTUk1BDli+JjzNyPMc/H+fMIPFUuOVAQ4A3LidMBtyI=;
 b=OBAq6fLqCRvMSzdZO5CxCW7+03p0mGvFL7Er3G+danU4z4yuKVWV961zxLTr1ktPN8bEHop43J4LH4cYss/wfrQddRNp+vUVPvNieGDllJZPs4C9M2EtczTbAUs4m380Dk6Zvs/Vz/vlK+p5gf1+zl3/9EkWE1IwCg4UYm/lqoxE+WXEhDrzI3iajlgOT8o3puG+D61SumT9VTA8i2rONkDJ8S3EI1Is/LlK3ulanSd5EmalM6gXys+xIr/81Vp0ukzE3yijTsl/UapSnNgX8cWrcq9s/V1uHI/GLhTqsIBj0yaTI8AM/cIWSj6GcRtf4ozEYju0TLbZR7dqbp/U6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR06FT059.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc37::52) by
 VI1EUR06HT046.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc37::376)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 16:08:03 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc37::4a) by VI1EUR06FT059.mail.protection.outlook.com
 (2a01:111:e400:fc37::222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 16:08:03 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:C5EB29AE25A847C1006291EA7DA170AB67BC2A572E7291FF7E0A5362453F28FF;UpperCasedChecksum:51209F54A4F68B2BB8707D8CD2182BB5784981BE9BF218F80517DE90789CA803;SizeAsReceived:8495;Count:48
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::184e:5e8c:db8f:a596]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::184e:5e8c:db8f:a596%5]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 16:08:03 +0000
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Christopher Yeoh <cyeoh@au1.ibm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87ft4mbqen.fsf@x220.int.ebiederm.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 4 Dec 2020 17:08:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <87ft4mbqen.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [3ZC5Us1I96neFCVaLwIizV9/wAlAL/Op]
X-ClientProxiedBy: AM0PR01CA0144.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::49) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <67c6baa7-91eb-62ff-8860-67ce32e597c7@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (84.57.57.184) by AM0PR01CA0144.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 16:08:02 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 12cf4190-4f7b-4110-930f-08d8986ec738
X-MS-TrafficTypeDiagnostic: VI1EUR06HT046:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIau/NyRld0O9UD+ubm6dO4OzEsSiR6WmworwYrpJ9vH3N3pmUCVYELKvn2/8pqKqk3KXTieWPCouZr4auY2lyBZuaa07yHRUvJacRiavg9agYsgMH3WD9V5c7rG17CiGkCxlqYz6YzmH/6Y1bsW7csIyhyF1fSjt78oyq3JzluVYbK4mEuAj6CJjXTMf/6G5CZ+E+4LSnfi2UsbattAUA==
X-MS-Exchange-AntiSpam-MessageData: qo3b0IFEEKyOYrEOB8HdkMmRIXgkPArQ7bzCS3cgrdjaMO6S1yWR8r7XJetrLySmPeo6oaF7P4bEXzEuCEun5Rua9tUrbTh9WA8gcV/wk5Ji8SbVoR/lNRxZUmr9fv8ihKA1WNM4tTx8WzPFcGs/aA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cf4190-4f7b-4110-930f-08d8986ec738
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 16:08:03.2171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR06FT059.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR06HT046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

I think I remembered from a previous discussion about this topic,
that it was unclear if the rw_semaphores are working the same
in RT-Linux.  Will this fix work in RT as well?

On 12/3/20 9:12 PM, Eric W. Biederman wrote:
> --- a/kernel/kcmp.c
> +++ b/kernel/kcmp.c
> @@ -70,25 +70,25 @@ get_file_raw_ptr(struct task_struct *task, unsigned int idx)
>  	return file;
>  }
>  
> -static void kcmp_unlock(struct mutex *m1, struct mutex *m2)
> +static void kcmp_unlock(struct rw_semaphore *l1, struct rw_semaphore *l2)
>  {
> -	if (likely(m2 != m1))
> -		mutex_unlock(m2);
> -	mutex_unlock(m1);
> +	if (likely(l2 != l1))

is this still necessary ?

> +		up_read(l2);
> +	up_read(l1);
>  }
>  
> -static int kcmp_lock(struct mutex *m1, struct mutex *m2)
> +static int kcmp_lock(struct rw_semaphore *l1, struct rw_semaphore *l2)
>  {
>  	int err;
>  
> -	if (m2 > m1)
> -		swap(m1, m2);
> +	if (l2 > l1)
> +		swap(l1, l2);

and this is probably also no longer necessary?


>  
> -	err = mutex_lock_killable(m1);
> -	if (!err && likely(m1 != m2)) {
> -		err = mutex_lock_killable_nested(m2, SINGLE_DEPTH_NESTING);
> +	err = down_read_killable(l1);
> +	if (!err && likely(l1 != l2)) {

and this can now be unconditionally, right?

> +		err = down_read_killable_nested(l2, SINGLE_DEPTH_NESTING);
>  		if (err)
> -			mutex_unlock(m1);
> +			up_read(l1);
>  	}
>  
>  	return err;
> @@ -156,8 +156,8 @@ SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
>  	/*
>  	 * One should have enough rights to inspect task details.
>  	 */
> -	ret = kcmp_lock(&task1->signal->exec_update_mutex,
> -			&task2->signal->exec_update_mutex);
> +	ret = kcmp_lock(&task1->signal->exec_update_lock,
> +			&task2->signal->exec_update_lock);
>  	if (ret)
>  		goto err;
>  	if (!ptrace_may_access(task1, PTRACE_MODE_READ_REALCREDS) ||
> @@ -212,8 +212,8 @@ SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
>  	}
>  
>  err_unlock:
> -	kcmp_unlock(&task1->signal->exec_update_mutex,
> -		    &task2->signal->exec_update_mutex);
> +	kcmp_unlock(&task1->signal->exec_update_lock,
> +		    &task2->signal->exec_update_lock);
>  err:
>  	put_task_struct(task1);
>  	put_task_struct(task2);


Thanks
Bernd.
