Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD8D1E3019
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 22:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403787AbgEZUgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 16:36:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59680 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390386AbgEZUgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:36:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdgIp-0004Ve-Su; Tue, 26 May 2020 14:35:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdgIp-0001UA-4D; Tue, 26 May 2020 14:35:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
References: <871rn6a6e5.fsf@x220.int.ebiederm.org>
        <CAHk-=wh5cddDjyS2Av57Oc=qaowkx0XrtuJN=sErcq08qpnb7w@mail.gmail.com>
Date:   Tue, 26 May 2020 15:32:10 -0500
In-Reply-To: <CAHk-=wh5cddDjyS2Av57Oc=qaowkx0XrtuJN=sErcq08qpnb7w@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 26 May 2020 12:09:16 -0700")
Message-ID: <87pnaq5tf9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jdgIp-0001UA-4D;;;mid=<87pnaq5tf9.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ejwF8OQ6gu/SpOahkBL41C3oTr2N+Lbk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_PhishingBody,T_TM2_M_HEADER_IN_MSG,
        XMSubMetaSxObfu_03,XMSubMetaSx_00,XM_B_Phish66 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4619]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 417 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.5%), b_tie_ro: 9 (2.2%), parse: 1.18 (0.3%),
         extract_message_metadata: 15 (3.6%), get_uri_detail_list: 1.92 (0.5%),
         tests_pri_-1000: 16 (3.7%), tests_pri_-950: 1.29 (0.3%),
        tests_pri_-900: 1.06 (0.3%), tests_pri_-90: 115 (27.5%), check_bayes:
        102 (24.5%), b_tokenize: 8 (1.8%), b_tok_get_all: 8 (2.0%),
        b_comp_prob: 3.1 (0.7%), b_tok_touch_all: 79 (19.0%), b_finish: 1.09
        (0.3%), tests_pri_0: 245 (58.8%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 0.51 (0.1%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] Please pull exec fix for v5.7
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, May 26, 2020 at 11:42 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> While working on my exec cleanups I found a bug in exec that winds
>> up miscomputing the ambient credentials during exec.  Andy appears
>> as to credentials are computed for both the script and the interpreter.
>

> Can you rephrase that?

yes.

The sentence should have read: 
"Andy appears to have to been confused as to why credentials are computed
for both the script and the interpreter."

If that is not enough ask and I will rewrite and resend the pull
request.

> I tried to figure out what you were trying to say, and I can't. I
> suspect a whole line or two is missing, or you were re-writing that
> thing and stopped in the middle or something.
>
> I'm also somewhat confused by your placement of that
>
>         new->cap_ambient = old->cap_ambient;


I am restoring the work usually done by prepare_exec_creds, that
happens to get messed up when cap_bprm_set_creds is called multiple
times.

Since that happens before cap_brpm_set_creds is ever called I figured
doing it at the top of the function in case there is something subtle
is the path to safety and reliability, especially if the code will
be backported.

I don't see us touching cap_ambient anywhere except the line that does:

	/* File caps or setid cancels ambient. */
	if (has_fcap || is_setid)
		cap_clear(new->cap_ambient);

But I am human and miss things occasionally.

> which doesn't seem to make a lot of sense. It's before the code even
> checks that the old ambient is valid, which I guess doesn't really
> matter (an error is an error, and the newly set state will not be used
> in that case), but aside from that it's just in an odd place.
>
> It's not near any other code that affects the new capabilities.
> Wouldn't it have made more sense to do this where we then clear
> cap_ambient if it's a setid binary?

That was my first thought but then I got defensive.

I think setting new->cap_ambient unconditionally at the top of the
function is the most robust way to code it. (see above).


The distance for other code clearing variables is also a mirage.  The
get_file_caps function 3 lines down in it's first line clears
new->cap_permitted.

> So this pull just confuses me for a couple of reasons - I'm not saying
> it's wrong, but at a minimum I'd like to get a merge message that
> makes more sense..

I am going to dash to get my allergy injection today, and then come
back and address whatever concerns you might have.

Eric
