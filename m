Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02D42CF339
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgLDRkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:40:32 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:58566 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgLDRka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:40:30 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1klF3a-009PFt-D2; Fri, 04 Dec 2020 10:39:46 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1klF3Z-0002bV-IP; Fri, 04 Dec 2020 10:39:46 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 04 Dec 2020 11:39:11 -0600
In-Reply-To: <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
        (Bernd Edlinger's message of "Fri, 4 Dec 2020 17:08:01 +0100")
Message-ID: <87y2id8o8w.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1klF3Z-0002bV-IP;;;mid=<87y2id8o8w.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18/dyuJ2QBuiFTXqQirv4qseGVz19j5qeg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_SB_Phish,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels,XMSubLong,XMSubPhish11 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.5 XMSubPhish11 Phishy Language Subject
        *  0.0 TR_XM_SB_Phish Phishing flag in subject of message
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Bernd Edlinger <bernd.edlinger@hotmail.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 475 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.2%), b_tie_ro: 9 (1.9%), parse: 0.91 (0.2%),
         extract_message_metadata: 12 (2.5%), get_uri_detail_list: 2.0 (0.4%),
        tests_pri_-1000: 5 (1.1%), tests_pri_-950: 1.23 (0.3%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 90 (19.0%), check_bayes:
        89 (18.7%), b_tokenize: 10 (2.0%), b_tok_get_all: 16 (3.3%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 58 (12.2%), b_finish: 0.84
        (0.2%), tests_pri_0: 342 (71.9%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Edlinger <bernd.edlinger@hotmail.de> writes:

> Hi Eric,
>
> I think I remembered from a previous discussion about this topic,
> that it was unclear if the rw_semaphores are working the same
> in RT-Linux.  Will this fix work in RT as well?

The locks should work close enough to the same that correct code is also
correct code on RT-linux.  If not it is an RT-linux bug.

An rw_semaphore may be less than optimal on RT-linux.  I do remember
that mutexes are prefered.  But this change is more about correctness
than anything else.

> On 12/3/20 9:12 PM, Eric W. Biederman wrote:
>> --- a/kernel/kcmp.c
>> +++ b/kernel/kcmp.c
>> @@ -70,25 +70,25 @@ get_file_raw_ptr(struct task_struct *task, unsigned int idx)
>>  	return file;
>>  }
>>  
>> -static void kcmp_unlock(struct mutex *m1, struct mutex *m2)
>> +static void kcmp_unlock(struct rw_semaphore *l1, struct rw_semaphore *l2)
>>  {
>> -	if (likely(m2 != m1))
>> -		mutex_unlock(m2);
>> -	mutex_unlock(m1);
>> +	if (likely(l2 != l1))
>
> is this still necessary ?

Yes.  Both pids could be threads of the same process or even the same
value so yes this is definitely necessary.  rw_semaphores don't nest on
the same cpu.

>
>> +		up_read(l2);
>> +	up_read(l1);
>>  }
>>  
>> -static int kcmp_lock(struct mutex *m1, struct mutex *m2)
>> +static int kcmp_lock(struct rw_semaphore *l1, struct rw_semaphore *l2)
>>  {
>>  	int err;
>>  
>> -	if (m2 > m1)
>> -		swap(m1, m2);
>> +	if (l2 > l1)
>> +		swap(l1, l2);
>
> and this is probably also no longer necessary?

I think lockdep needs this, so it can be certain the same rw_semaphore
is not nesting on the cpu.   Otherwise we will have inconsitencies about
which is the nested lock.  It won't matter in practice, but I am not
certain lockdep knows enough to tell the difference.

If anything removing the swap is a candidate for a follow up patch
where it can be considered separately from other concerns.  For this
patch keeping the logic unchanged makes it trivial to verify that
the conversion from one lock to another is correct.

>>  
>> -	err = mutex_lock_killable(m1);
>> -	if (!err && likely(m1 != m2)) {
>> -		err = mutex_lock_killable_nested(m2, SINGLE_DEPTH_NESTING);
>> +	err = down_read_killable(l1);
>> +	if (!err && likely(l1 != l2)) {
>
> and this can now be unconditionally, right?

Nope.  The two locks can be the same lock, and they don't nest on a
single cpu.  I tested and verified that lockdep complains bitterly
if down_read_killable_nested is replaced with a simple
down_read_killable.


>> +		err = down_read_killable_nested(l2, SINGLE_DEPTH_NESTING);
>>  		if (err)
>> -			mutex_unlock(m1);
>> +			up_read(l1);
>>  	}
>>  
>>  	return err;
>> @@ -156,8 +156,8 @@ SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
>>  	/*
>>  	 * One should have enough rights to inspect task details.
>>  	 */
>> -	ret = kcmp_lock(&task1->signal->exec_update_mutex,
>> -			&task2->signal->exec_update_mutex);
>> +	ret = kcmp_lock(&task1->signal->exec_update_lock,
>> +			&task2->signal->exec_update_lock);
>>  	if (ret)
>>  		goto err;
>>  	if (!ptrace_may_access(task1, PTRACE_MODE_READ_REALCREDS) ||
>> @@ -212,8 +212,8 @@ SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
>>  	}
>>  
>>  err_unlock:
>> -	kcmp_unlock(&task1->signal->exec_update_mutex,
>> -		    &task2->signal->exec_update_mutex);
>> +	kcmp_unlock(&task1->signal->exec_update_lock,
>> +		    &task2->signal->exec_update_lock);
>>  err:
>>  	put_task_struct(task1);
>>  	put_task_struct(task2);
>
>
> Thanks
> Bernd.
