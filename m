Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270262A6FF3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 22:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbgKDVyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 16:54:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40182 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKDVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:54:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4LnSP0014530;
        Wed, 4 Nov 2020 21:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=E7LfL+BjDEiJ8g1WqJko8Hjx1F6AqhMq5ueKHWiv3wo=;
 b=cu2zBQDCI4VcW2q42ULWqOHmQTlCOnUia/dgjMmduuMXh6lVDfD1OgnRtAr7IxoIctZp
 ZSbnYNpahSfsw1Oa44YmVT7edKSdtNJA5csLbHYcGD8oVt2I83ta6ZLg60I9KvPP9UpZ
 xSxflsMJxNIlST5YtaQTfO+LgU6dPpudtKqcIblv3mUytdN1DbRRkrhThRwQRrIy3/52
 /ugtfeBXOWMqN30jV5e9runVI/JXvjwscX9zXzGGwduPvPaK1MEr1oNHTZWhLrzQcboW
 cbZyRPUrlIjIVXRYaS/u4jwG1u3mJkgg+C1druLQ6pTolc/NiBdZ9pYxjtwz6zI1/c8k yA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34hhvch3fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 04 Nov 2020 21:51:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4LoW8p009390;
        Wed, 4 Nov 2020 21:51:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34hw0kk303-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Nov 2020 21:51:12 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A4LomSn019106;
        Wed, 4 Nov 2020 21:50:56 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Nov 2020 13:50:48 -0800
Subject: Re: [PATCH v8 -tip 20/26] sched: Release references to the per-task
 cookie on exit
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-21-joel@joelfernandes.org>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <bc98f399-c69a-20c9-10cc-18291723eff9@oracle.com>
Date:   Wed, 4 Nov 2020 16:50:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201020014336.2076526-21-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=2 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040156
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/20 9:43 PM, Joel Fernandes (Google) wrote:
> During exit, we have to free the references to a cookie that might be shared by
> many tasks. This commit therefore ensures when the task_struct is released, any
> references to cookies that it holds are also released.
> 
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   include/linux/sched.h | 2 ++
>   kernel/fork.c         | 1 +
>   kernel/sched/core.c   | 8 ++++++++
>   3 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 4cb76575afa8..eabd96beff92 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2079,12 +2079,14 @@ void sched_core_unsafe_exit(void);
>   bool sched_core_wait_till_safe(unsigned long ti_check);
>   bool sched_core_kernel_protected(void);
>   int sched_core_share_pid(pid_t pid);
> +void sched_tsk_free(struct task_struct *tsk);
>   #else
>   #define sched_core_unsafe_enter(ignore) do { } while (0)
>   #define sched_core_unsafe_exit(ignore) do { } while (0)
>   #define sched_core_wait_till_safe(ignore) do { } while (0)
>   #define sched_core_kernel_protected(ignore) do { } while (0)
>   #define sched_core_share_pid(pid_t pid) do { } while (0)
> +#define sched_tsk_free(tsk) do { } while (0)
>   #endif
>   
>   #endif
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b9c289d0f4ef..a39248a02fdd 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -736,6 +736,7 @@ void __put_task_struct(struct task_struct *tsk)
>   	exit_creds(tsk);
>   	delayacct_tsk_free(tsk);
>   	put_signal_struct(tsk->signal);
> +	sched_tsk_free(tsk);
>   
>   	if (!profile_handoff_task(tsk))
>   		free_task(tsk);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 42aa811eab14..61e1dcf11000 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9631,6 +9631,14 @@ static int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
>   
>   	return 0;
>   }
> +
> +void sched_tsk_free(struct task_struct *tsk)
> +{
> +	if (!tsk->core_task_cookie)
> +		return;
> +	sched_core_put_task_cookie(tsk->core_task_cookie);
> +	sched_core_put();


sched_tsk_free() can be called under softirq. sched_core_put() is riddled with things that may want to sleep.

[root@chyser-vm6 bin]# [  135.349453] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:281
[  135.356381] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
[  135.364331] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G            E     5.9.0_ch_pick_task_v8_fix_4+ #15
[  135.370178] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[  135.372052] Call Trace:
[  135.372733]  <IRQ>
[  135.373162]  dump_stack+0x74/0x92
[  135.375134]  ___might_sleep.cold+0x94/0xa5
[  135.379102]  __might_sleep+0x4b/0x80
[  135.382509]  mutex_lock+0x21/0x50
[  135.385616]  sched_core_put+0x15/0x70
[  135.388981]  sched_tsk_free+0x20/0x30
[  135.389753]  __put_task_struct+0xbe/0x190
[  135.390896]  delayed_put_task_struct+0x88/0xa0
[  135.391812]  rcu_core+0x341/0x520
[  135.392580]  rcu_core_si+0xe/0x10
[  135.393281]  __do_softirq+0xe8/0x2cd
[  135.394030]  asm_call_irq_on_stack+0x12/0x20
[  135.395060]  </IRQ>
[  135.395519]  do_softirq_own_stack+0x3d/0x50
[  135.396379]  irq_exit_rcu+0xb2/0xc0
[  135.397203]  sysvec_apic_timer_interrupt+0x3d/0x90
[  135.398188]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  135.399395] RIP: 0010:native_safe_halt+0xe/0x10
[  135.400314] Code: 7b ff ff ff eb bd cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d 06 01 57 00 f4 c3 66 90 e9 07 00 00 00 
0f 00 2d f6 00 57 00 fb f4 <c3> cc 0f 1f 44 00 00 55 48 89 e5 53 e8 b1 f2 63 ff 65 8b 15 5a 5d
[  135.404484] RSP: 0018:ffffb41f4007be90 EFLAGS: 00000206
[  135.405627] RAX: ffffffff9ea9b670 RBX: 0000000000000001 RCX: ffff9d3130d2ca80
[  135.407201] RDX: 000000000001d576 RSI: ffffb41f4007be38 RDI: 0000001f839d2693
[  135.409411] RBP: ffffb41f4007be98 R08: 0000000000000001 R09: 0000000000000000
[  135.413731] R10: 0000000000000002 R11: ffff9d3130d2bd00 R12: ffff9d2e40853e80
[  135.415161] R13: ffff9d2e40853e80 R14: 0000000000000000 R15: 0000000000000000
[  135.416861]  ? __sched_text_end+0x7/0x7
[  135.417758]  ? default_idle+0xe/0x20
[  135.418505]  arch_cpu_idle+0x15/0x20
[  135.419225]  default_idle_call+0x38/0xd0
[  135.420145]  do_idle+0x1ee/0x260
[  135.421908]  cpu_startup_entry+0x20/0x30
[  135.425635]  start_secondary+0x118/0x150
[  135.429498]  secondary_startup_64_no_verify+0xb8/0xbb

I tried a number of things like replacing the mutexes in put/get with spin_lock_bh() and just kept finding things like:


[root@chyser-vm5 bin]# [ 1123.516209] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
[ 1123.517976] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/15
[ 1123.519557] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G            E     5.9.0_ch_pick_task_v8_fix_5+ #16
[ 1123.521392] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[ 1123.523039] Call Trace:
[ 1123.523546]  <IRQ>
[ 1123.523961]  dump_stack+0x74/0x92
[ 1123.524632]  ___might_sleep.cold+0x94/0xa5
[ 1123.525442]  __might_sleep+0x4b/0x80
[ 1123.526131]  ? cpumask_weight+0x20/0x20
[ 1123.526896]  cpus_read_lock+0x1c/0x60
[ 1123.527623]  stop_machine+0x1d/0x40
[ 1123.528321]  __sched_core_disable+0x19/0x40
[ 1123.529133]  sched_core_put+0x18/0x20
[ 1123.529852]  sched_tsk_free+0x20/0x30
[ 1123.530571]  __put_task_struct+0xbe/0x190
[ 1123.531361]  delayed_put_task_struct+0x88/0xa0
[ 1123.532234]  rcu_core+0x341/0x520
[ 1123.532882]  rcu_core_si+0xe/0x10
[ 1123.533554]  __do_softirq+0xe8/0x2cd
[ 1123.534281]  asm_call_irq_on_stack+0x12/0x20
[ 1123.535153]  </IRQ>
[ 1123.535584]  do_softirq_own_stack+0x3d/0x50
[ 1123.536403]  irq_exit_rcu+0xb2/0xc0
[ 1123.537080]  sysvec_apic_timer_interrupt+0x3d/0x90
[ 1123.538002]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[ 1123.539000] RIP: 0010:native_safe_halt+0xe/0x10
[ 1123.539886] Code: 7b ff ff ff eb bd cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d d6 00 57 00 f4 c3 66 90 e9 07 00 00 00 
0f 00 2d c6 00 57 00 fb f4 <c3> cc 0f 1f 44 00 00 55 48 89 e5 53 e8 91 f2 63 ff 65 8b 15 2a 5d
[ 1123.543776] RSP: 0018:ffffa830800ebe90 EFLAGS: 00000206
[ 1123.544915] RAX: ffffffffa7c9b6a0 RBX: 000000000000000f RCX: ffff99af07deca80
[ 1123.546556] RDX: 000000000048f6e6 RSI: ffffa830800ebe38 RDI: 0000010599561e7a
[ 1123.548091] RBP: ffffa830800ebe98 R08: 0000000000000001 R09: 000000000000000e
[ 1123.549453] R10: ffff9992422012c8 R11: ffff9992422012cc R12: ffff999240a59f40
[ 1123.550815] R13: ffff999240a59f40 R14: 0000000000000000 R15: 0000000000000000
[ 1123.552188]  ? __sched_text_end+0x7/0x7
[ 1123.552939]  ? default_idle+0xe/0x20
[ 1123.553635]  arch_cpu_idle+0x15/0x20
[ 1123.554341]  default_idle_call+0x38/0xd0
[ 1123.555111]  do_idle+0x1ee/0x26



The prctl() parts of the selftests pass, but all the above is caused by simply calling prctl() to "share a cookie w/ a 
task" that then dies after second.

-chrish
