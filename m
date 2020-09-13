Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B16F268150
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgIMVGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 17:06:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgIMVFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:05:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600031122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VEhiUXn6N6V9uHUKnQsZoN0xtPB1QwMr6LhI1ZlNVUA=;
        b=fjTGGPcfydyheITte0WUIT8uhQq9fthIsbSWUn2iy77NLQtkdgOpqhyaXcLMYR/iN8qEW5
        6U/kDI0tEG49kb3z4f+NUHRMUL1FmDuHIHIgPII4aSi1fODBaBiGPCxM9SlbqpVLesor7U
        78X931oH2idS92+LrxSc0iknvslbOIXf20X76Mr7FBUOHfWkeaxKtfTZjiYrh66YnmwiZJ
        3odLV1K+kLyKucfdWANVErDSADkql6gUJFa0My+nIgk+M0f+B0HnxarUEXHzjmdgOybi7N
        St0q3ROu1E5xJ/BAYXtspIECFAnT3C0gF1AMa+7gNMlnM1v8lafOr/8f+XWzXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600031122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VEhiUXn6N6V9uHUKnQsZoN0xtPB1QwMr6LhI1ZlNVUA=;
        b=dMeVQp3H3IWyYHfwUQwhIU9lV12XJNlN+2BR0cHP4jMURx9pymFnpXfGsaLDeE4b+cp6nB
        gJQ+LMU73lHcf+AA==
To:     syzbot <syzbot+bc9dbf05dcc151e9b972@syzkaller.appspotmail.com>,
        alexandre.chartre@oracle.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: WARNING: can't access registers at asm_sysvec_call_function_single
In-Reply-To: <0000000000002b02cf05aed302f3@google.com>
References: <0000000000002b02cf05aed302f3@google.com>
Date:   Sun, 13 Sep 2020 23:05:21 +0200
Message-ID: <87lfhdpeum.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08 2020 at 13:16, syzbot wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f4d51dff Linux 5.9-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1455d4f9900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=bc9dbf05dcc151e9b972
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bc9dbf05dcc151e9b972@syzkaller.appspotmail.com
>
> WARNING: can't access registers at asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:589

That's the ORC unwinder complaining, but I have no idea why...
