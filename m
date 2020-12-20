Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578DA2DF56C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 13:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgLTMzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 07:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgLTMzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 07:55:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543FCC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 04:54:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 91so7949743wrj.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 04:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CA/mWE8RmsRB6skbH6prneR2aKqG0lrfkDvQAtb3xzc=;
        b=Vp/j1Y+kFfMfTDLNqvUPcuXD17dIW1hJQ5ufnitPMCJUAJU1wZK/CgXedzl+bAJ6s5
         Yc3j87yAmD2EJ+Fdc7MnvEaQepSWSW0p7N9ojPCyX3qQxlteMZkwHDOYFudGn7p9/yeZ
         CozeDAYwvh0SytG+mnR6flhd9gj5Mib6iWB5lAfp+4KTVE8wOwKSXYr3aUthTGJ5Bbu6
         rEYGHQuaGanDGyO6/fk9MZ+Q5kXVVOyPaX0h97DwT+ZHBNXhRSM1bBeiQ8tdGVHHcAjA
         X/cQmdLxHYCArvlVlIOHY3k8qjjoTUv9Bh81poXGHOuOkE1fT3jnVsTApNq2Attp2flF
         8s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CA/mWE8RmsRB6skbH6prneR2aKqG0lrfkDvQAtb3xzc=;
        b=e4kKwWb1+qWxaCxt5nhshtIckNX0mMAQxo2CX+2gV+AbEpaGFSzxtayaadTj5hz+hF
         U8O0rMA0klnS79oz9GhpLtlKM2NhojsW7zP26j5DtFU9EmNxBIExPPy5fuActumPjjBU
         2apvwCTBUIUwYtzaLxIRZFWIoUf/JNHVmJJejKD9Ispg9LDRoHl+Fjv6NpGHV9BuSOEe
         0l9xRqaB8MltDdr5HsUJPfs/ivgo9GCN8BtdpTCpdH52mFx6Fd/9VcIfGMyV7LZ9dUbi
         INFpaC5ToasjkltGAh9Z/xl2MRbKxT6TImV8mmWkuwVgTRIHZvpWdLSLt9nq3+BOgEUK
         6NDg==
X-Gm-Message-State: AOAM530ZCet44+VJV1YpihrZ0mg/VcZqevUYFlOF0dgx9YuVfarMu/Q9
        6nxl7eRzGptGF4e2NyNUlM8=
X-Google-Smtp-Source: ABdhPJx3engM+4ZpjWXVuc1YQio2PEOW/V1HKOnt2Iw/cIKLwAgcXsZy7bvYpHRiDfSthZ0GVIVWyw==
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr13541689wrv.255.1608468860266;
        Sun, 20 Dec 2020 04:54:20 -0800 (PST)
Received: from [192.168.8.137] ([85.255.237.164])
        by smtp.gmail.com with ESMTPSA id m21sm18722262wml.13.2020.12.20.04.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Dec 2020 04:54:19 -0800 (PST)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Oleg Nesterov <oleg@redhat.com>
References: <abab9af4e0d26358538a45a2826650e9cefd2924.1606961931.git.asml.silence@gmail.com>
 <20201208013722.GG3579531@ZenIV.linux.org.uk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [RFC] exit: do exit_task_work() before shooting off mm
Message-ID: <ce5be208-99eb-f7bd-e602-9361008ff83c@gmail.com>
Date:   Sun, 20 Dec 2020 12:50:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201208013722.GG3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2020 01:37, Al Viro wrote:
> On Thu, Dec 03, 2020 at 02:30:46AM +0000, Pavel Begunkov wrote:
>> Handle task works and lock it earlier before it starts killing off
>> task's resources like mm. io_uring makes use of it a lot and it'd
>> nicer to have all added task_work finding tasks in a consistent state.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> Would it be correct? I clearly don't know all the exit invariants, but
>> can't find any users relying on task_works in-between.
> 
> You've just gotten rid of exit_task_work() anywhere after exit_files().
> And exit_mm() can trigger the final fput() just as easily as exit_files().
> 
> IOW, you have just made the effect of final close on exit() completely
> asynchronous.

One more moment, after we've set PF_EXITING any task_work_run() would be
equivalent to exit_task_work()

static inline void exit_task_work(struct task_struct *task)
{
       task_work_run();
}

It sounds from your words that this is not expected, is it? io_uring
may want (currently doesn't) to run works for cancellation purposes.
Shouldn't it be like below (not tested)? Also simplifies task_work_run().

CC Oleg

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 0d848a1e9e62..6aae0e6c3a04 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -24,10 +24,6 @@ int task_work_add(struct task_struct *task, struct callback_head *twork,
 
 struct callback_head *task_work_cancel(struct task_struct *, task_work_func_t);
 void task_work_run(void);
-
-static inline void exit_task_work(struct task_struct *task)
-{
-	task_work_run();
-}
+void exit_task_work(struct task_struct *task);
 
 #endif	/* _LINUX_TASK_WORK_H */
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 9cde961875c0..60715f3d91a0 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -107,26 +107,15 @@ task_work_cancel(struct task_struct *task, task_work_func_t func)
 void task_work_run(void)
 {
 	struct task_struct *task = current;
-	struct callback_head *work, *head, *next;
+	struct callback_head *work, *next;
 
 	for (;;) {
-		/*
-		 * work->func() can do task_work_add(), do not set
-		 * work_exited unless the list is empty.
-		 */
 		do {
-			head = NULL;
 			work = READ_ONCE(task->task_works);
-			if (!work) {
-				if (task->flags & PF_EXITING)
-					head = &work_exited;
-				else
-					break;
-			}
-		} while (cmpxchg(&task->task_works, work, head) != work);
+			if (!work)
+				return;
+		} while (cmpxchg(&task->task_works, work, NULL) != work);
 
-		if (!work)
-			break;
 		/*
 		 * Synchronize with task_work_cancel(). It can not remove
 		 * the first entry == work, cmpxchg(task_works) must fail.
@@ -143,3 +132,17 @@ void task_work_run(void)
 		} while (work);
 	}
 }
+
+void exit_task_work(struct task_struct *task)
+{
+	WARN_ON(task != current);
+	WARN_ON(!(task->flags & PF_EXITING));
+	WARN_ON(READ_ONCE(task->task_works) == &work_exited);
+
+	/*
+	 * work->func() can do task_work_add(), do not set
+	 * work_exited unless the list is empty.
+	 */
+	while (cmpxchg(&task->task_works, NULL, &work_exited) != NULL)
+		task_work_run();
+}

-- 
Pavel Begunkov
