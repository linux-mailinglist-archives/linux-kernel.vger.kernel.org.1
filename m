Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6500826A9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgIOQ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 12:26:38 -0400
Received: from mail.efficios.com ([167.114.26.124]:59376 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgIOPkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:40:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 614C829C581;
        Tue, 15 Sep 2020 11:39:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ml2W45TkLYr8; Tue, 15 Sep 2020 11:39:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D3DE529C50B;
        Tue, 15 Sep 2020 11:39:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D3DE529C50B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600184387;
        bh=qDTO28HunFyVjFWL6x+EVTg+Tl6g4hTKpsIz9y4Vr6Q=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=koiMR+G7yOeqLjUFLJH+p306FUWEzInqGdmBHLNsokfIZ4K80iJQv1eAg46trOZFp
         gTzxrYihRkKqLgbOsSPcf1wGtfvs625mS7ANBHVSdhtmdAezmCckSF0rlpZewD6k6G
         OmLhJSeejjPBe/0n1Yd02wbsWq9McuDmSlMk+ExJPf93HNuP7MgXb3aXwdcS1LFpYy
         sAXRRS3c0nnNHOAtzzhQKWjIZtKWjw3qt44Chv59FZvVhQx8TTHABjiTTArjKG3hfT
         UL7gamtFy39OvHYBTs+Ofhrp5pSkSMUM8I2eeS1ZEvpAe0gt7HEtYyKptreDyAN3Y4
         KxFlkXDAJhtgA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B9fVMRJnEwXN; Tue, 15 Sep 2020 11:39:47 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B918529C3AF;
        Tue, 15 Sep 2020 11:39:47 -0400 (EDT)
Date:   Tue, 15 Sep 2020 11:39:47 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Message-ID: <1071966201.11729.1600184387644.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51WPjmEk2nQaxPAgOLN+3E7rfCVQ_=Q6PwD7dS2wyAKu5w@mail.gmail.com>
References: <20200831225810.2287294-1-posk@google.com> <CAFTs51WPjmEk2nQaxPAgOLN+3E7rfCVQ_=Q6PwD7dS2wyAKu5w@mail.gmail.com>
Subject: Re: [PATCH 1/2 v6] rseq/membarrier: add
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Thread-Index: lcEn8j0646tNX8azIBD9pm2+RugSRg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 15, 2020, at 2:12 AM, Peter Oskolkov posk@posk.io wrote:

> Any comments here? Should I change anything?

See below,

>> diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
>> index 5891d7614c8c..98c2b0e7c0d8 100644
>> --- a/include/uapi/linux/membarrier.h
>> +++ b/include/uapi/linux/membarrier.h
>> @@ -114,6 +114,29 @@
>>   *                          If this command is not implemented by an
>>   *                          architecture, -EINVAL is returned.
>>   *                          Returns 0 on success.
>> + * @MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
>> + *                          In addition to provide memory ordering
>> + *                          guarantees described in
>> + *                          MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,

^ is the above still true ? I see from the code that the rseq membarrier
only issues rseq_preempt, not any (documented) explicit core serialization nor
memory barrier.

>> + *                          ensure the caller thread, upon return from
>> + *                          system call, that all its running thread
>> + *                          siblings have any currently running rseq
>> + *                          critical sections restarted if @flags
>> + *                          parameter is 0; if @flags parameter is
>> + *                          MEMBARRIER_CMD_FLAG_CPU,
>> + *                          then this operation is performed only
>> + *                          on CPU indicated by @cpu_id. If this command is
>> + *                          not implemented by an architecture, -EINVAL
>> + *                          is returned. A process needs to register its
>> + *                          intent to use the private expedited rseq
>> + *                          command prior to using it, otherwise
>> + *                          this command returns -EPERM.
>> + * @MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
>> + *                          Register the process intent to use
>> + *                          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
>> + *                          If this command is not implemented by an
>> + *                          architecture, -EINVAL is returned.
>> + *                          Returns 0 on success.
>>   * @MEMBARRIER_CMD_SHARED:
>>   *                          Alias to MEMBARRIER_CMD_GLOBAL. Provided for
>>   *                          header backward compatibility.
>> @@ -131,9 +154,15 @@ enum membarrier_cmd {
>>         MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED               = (1 << 4),
>>         MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE              = (1 << 5),
>>         MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE     = (1 << 6),
>> +       MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ                   = (1 << 7),
>> +       MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ          = (1 << 8),
>>
>>         /* Alias for header backward compatibility. */
>>         MEMBARRIER_CMD_SHARED                   = MEMBARRIER_CMD_GLOBAL,
>>  };
>>
>> +enum membarrier_cmd_flag {
>> +       MEMBARRIER_CMD_FLAG_CPU         = (1 << 0),
>> +};
>> +
>>  #endif /* _UAPI_LINUX_MEMBARRIER_H */
>> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
>> index 168479a7d61b..e32e9476ccf3 100644
>> --- a/kernel/sched/membarrier.c
>> +++ b/kernel/sched/membarrier.c
>> @@ -18,6 +18,14 @@
>>  #define MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK 0
>>  #endif
>>
>> +#ifdef CONFIG_RSEQ
>> +#define MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ_BITMASK          \
>> +       (MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ                  \
>> +       | MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
>> +#else
>> +#define MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ_BITMASK  0
>> +#endif
>> +
>>  #define MEMBARRIER_CMD_BITMASK                                         \
>>         (MEMBARRIER_CMD_GLOBAL | MEMBARRIER_CMD_GLOBAL_EXPEDITED        \
>>         | MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED                      \
>> @@ -30,6 +38,13 @@ static void ipi_mb(void *info)
>>         smp_mb();       /* IPIs should be serializing but paranoid. */
>>  }
>>
>> +#ifdef CONFIG_RSEQ
>> +static void ipi_rseq(void *info)
>> +{
>> +       rseq_preempt(current);
>> +}
>> +#endif
>> +
>>  static void ipi_sync_rq_state(void *info)
>>  {
>>         struct mm_struct *mm = (struct mm_struct *) info;
>> @@ -129,19 +144,29 @@ static int membarrier_global_expedited(void)
>>         return 0;
>>  }
>>
>> -static int membarrier_private_expedited(int flags)
>> +static int membarrier_private_expedited(int flags, int cpu_id)
>>  {
>> -       int cpu;
>>         cpumask_var_t tmpmask;
>>         struct mm_struct *mm = current->mm;
>> +       smp_call_func_t ipi_func = ipi_mb;
>>
>> -       if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
>> +       if (flags == MEMBARRIER_FLAG_SYNC_CORE) {
>>                 if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
>>                         return -EINVAL;
>>                 if (!(atomic_read(&mm->membarrier_state) &
>>                       MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
>>                         return -EPERM;
>> +       } else if (flags == MEMBARRIER_FLAG_RSEQ) {
>> +#ifdef CONFIG_RSEQ
>> +               if (!(atomic_read(&mm->membarrier_state) &
>> +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY))
>> +                       return -EPERM;
>> +               ipi_func = ipi_rseq;
>> +#else
>> +               return -EINVAL;
>> +#endif

I'm allergic to mixing code logic and preprocessor logic. Anything against
the following changes ?

(above)

static void ipi_rseq(void *info)
{
    rseq_preempt(current);
}

^ without the #ifdef CONFIG_RSEQ (rseq_preempt is already defined as a no-op when
CONFIG_RSEQ=n)

and within membarrier_private_expedited:

if (!IS_ENABLED(CONFIG_RSEQ))
  return -EINVAL;
if (!(atomic_read(&mm->membarrier_state) &
    MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY))
  return -EPERM;
ipi_func = ipi_rseq;

[...]

>> @@ -310,8 +368,15 @@ static int membarrier_register_private_expedited(int flags)
>>
>>  /**
>>   * sys_membarrier - issue memory barriers on a set of threads
>> - * @cmd:   Takes command values defined in enum membarrier_cmd.
>> - * @flags: Currently needs to be 0. For future extensions.
>> + * @cmd:    Takes command values defined in enum membarrier_cmd.
>> + * @flags:  Currently needs to be 0 for all commands other than
>> + *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ: in the latter
>> + *          case it can be MEMBARRIER_CMD_FLAG_CPU, indicating that @cpu_id
>> + *          contains the CPU on which to interrupt (= restart)
>> + *          the RSEQ critical section.
>> + * @cpu_id: if @flags == MEMBARRIER_CMD_FLAG_CPU, indicates the cpu on which
>> + *          RSEQ CS should be interrupted (@cmd must be
>> + *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ).
>>   *
>>   * If this system call is not implemented, -ENOSYS is returned. If the
>>   * command specified does not exist, not available on the running
>> @@ -337,10 +402,21 @@ static int membarrier_register_private_expedited(int
>> flags)
>>   *        smp_mb()           X           O            O
>>   *        sys_membarrier()   O           O            O
>>   */
>> -SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
>> +SYSCALL_DEFINE3(membarrier, int, cmd, int, flags, int, cpu_id)

Now that we have the first use of "flags", it would be a good time to change
"int flags" to "unsigned int flags", which is a preferred way to express system
call flags parameters.

Thanks,

Mathieu

>>  {
>> -       if (unlikely(flags))
>> -               return -EINVAL;
>> +       switch (cmd) {
>> +       case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
>> +               if (unlikely(flags && flags != MEMBARRIER_CMD_FLAG_CPU))
>> +                       return -EINVAL;
>> +               break;
>> +       default:
>> +               if (unlikely(flags))
>> +                       return -EINVAL;
>> +       }
>> +
>> +       if (!(flags & MEMBARRIER_CMD_FLAG_CPU))
>> +               cpu_id = -1;
>> +
>>         switch (cmd) {
>>         case MEMBARRIER_CMD_QUERY:
>>         {
>> @@ -362,13 +438,17 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
>>         case MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED:
>>                 return membarrier_register_global_expedited();
>>         case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
>> -               return membarrier_private_expedited(0);
>> +               return membarrier_private_expedited(0, cpu_id);
>>         case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
>>                 return membarrier_register_private_expedited(0);
>>         case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
>> -               return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
>> +               return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE,
>> cpu_id);
>>         case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE:
>>                 return membarrier_register_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
>> +       case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
>> +               return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ,
>> cpu_id);
>> +       case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
>> +               return
>> membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
>>         default:
>>                 return -EINVAL;
>>         }
>> --
>> 2.28.0.402.g5ffc5be6b7-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
