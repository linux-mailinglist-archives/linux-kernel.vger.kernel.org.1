Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866A32F24C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391649AbhALAZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:35884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404213AbhAKXw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:52:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61B22AB7F;
        Mon, 11 Jan 2021 23:52:17 +0000 (UTC)
To:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>, tdevries@suse.com,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <20210111200027.GH25645@zn.tnic>
 <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
 <CALCETrV=BpFwR-RU5ORioBCZj3RwK7nmD2Yz3VNd4gfFjukRAw@mail.gmail.com>
From:   Tom de Vries <tdevries@suse.de>
Subject: Re: gdbserver + fsgsbase kaputt
Message-ID: <0ad68c87-ac2e-478e-ed97-95256464a3ba@suse.de>
Date:   Tue, 12 Jan 2021 00:52:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CALCETrV=BpFwR-RU5ORioBCZj3RwK7nmD2Yz3VNd4gfFjukRAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 12:40 AM, Andy Lutomirski wrote:
> On Mon, Jan 11, 2021 at 1:06 PM Andy Lutomirski <luto@amacapital.net> wrote:
>>
>>
>>> On Jan 11, 2021, at 12:00 PM, Borislav Petkov <bp@alien8.de> wrote:
>>>
>>
>>
>>> Or do you mean I should add "unsafe_fsgsbase" to grub cmdline and bisect
>>> with fsgsbase enabled in all test kernels?
>>
>> Yes. But I can also look myself in a bit.
>>
> 
> Tom, if I reproduce it in an interactive gdb and play a bit, I get:
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0xf7df2cb6 in init_cacheinfo () from target:/lib/libc.so.6
> (gdb) p $gs = $gs
> $1 = 99
> (gdb) si
> 
> Program terminated with signal SIGSEGV, Segmentation fault.
> The program no longer exists.
> 
> That's gdb itself crashing.  Any idea what's wrong?
> 

The first "Program received signal SIGSEGV, Segmentation fault" means
that gdb intercepts the sigsegv, and allows you to inspect it f.i. by
printing $_siginfo.  The inferior is still live at this point.

Then when trying to continue using si,  the signal is passed on to the
inferior, which means it'll be terminated.

AFAIU, gdb has not crashed, and behaves as expected.  See below for a
similar scenario.

Thanks,
- Tom

...
$ cat test2.c
int
main (void)
{
  *((int *)0) = 0;
  return 0;
}
$ gcc test2.c
$ ./a.out
Segmentation fault (core dumped)
$ gdb -q ./a.out
Reading symbols from ./a.out...
(gdb) r
Starting program: /home/vries/a.out

Program received signal SIGSEGV, Segmentation fault.
0x00000000004004a0 in main ()
(gdb) si

Program terminated with signal SIGSEGV, Segmentation fault.
The program no longer exists.
(gdb)
...

