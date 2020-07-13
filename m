Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF321DF6D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 20:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgGMSOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 14:14:08 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49998 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgGMSOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:14:08 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jv2xn-0007Rg-FJ; Mon, 13 Jul 2020 12:14:03 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jv2xm-0007g5-AT; Mon, 13 Jul 2020 12:14:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     alex.gaynor@gmail.com, geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
Date:   Mon, 13 Jul 2020 13:11:13 -0500
In-Reply-To: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
        (Nick Desaulniers's message of "Thu, 9 Jul 2020 11:41:47 -0700")
Message-ID: <875zarb7zy.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jv2xm-0007g5-AT;;;mid=<875zarb7zy.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+fZqLDEdkWFk+UGPM1iZj0UVDopGAeX9M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Nick Desaulniers <ndesaulniers@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 770 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (1.4%), b_tie_ro: 9 (1.2%), parse: 0.92 (0.1%),
         extract_message_metadata: 12 (1.5%), get_uri_detail_list: 1.33 (0.2%),
         tests_pri_-1000: 5 (0.7%), tests_pri_-950: 1.49 (0.2%),
        tests_pri_-900: 1.22 (0.2%), tests_pri_-90: 295 (38.3%), check_bayes:
        286 (37.2%), b_tokenize: 7 (0.9%), b_tok_get_all: 158 (20.5%),
        b_comp_prob: 2.3 (0.3%), b_tok_touch_all: 116 (15.0%), b_finish: 0.80
        (0.1%), tests_pri_0: 431 (55.9%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.2 (0.3%), poll_dns_idle: 0.63 (0.1%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Linux kernel in-tree Rust support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:

> Hello folks,
> I'm working on putting together an LLVM "Micro Conference" for the
> upcoming Linux Plumbers Conf
> (https://www.linuxplumbersconf.org/event/7/page/47-attend).  It's not
> solidified yet, but I would really like to run a session on support
> for Rust "in tree."  I suspect we could cover technical aspects of
> what that might look like (I have a prototype of that, was trivial to
> wire up KBuild support), but also a larger question of "should we do
> this?" or "how might we place limits on where this can be used?"
>
> Question to folks explicitly in To:, are you planning on attending plumbers?
>
> If so, would this be an interesting topic that you'd participate in?

I have two big concerns about actually using rust.

1) How large is the rust language support, and will each rust module
   need to duplicate it.  I seem to remember someone mentioning it is
   noticable in size.

2) What is rust usable for?  The rust type system will not admit
   doubly linked lists (or anything where two pointers point at the
   same memory) unless you are using an unsafe block.

   Now maybe all of that can be wrapped up in libraries written in
   C that Rust can just call, so rust might be useful for building
   drivers.

   What I am certain of is that in the core kernel where I tend to spend
   my time not being able to use doubly linked lists looks like a
   non-starter.

Eric


