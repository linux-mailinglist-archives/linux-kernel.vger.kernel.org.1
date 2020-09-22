Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64410273889
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 04:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgIVCcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 22:32:42 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:39096 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgIVCcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 22:32:42 -0400
X-Greylist: delayed 2828 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 22:32:42 EDT
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kKXN6-003r5K-5I; Mon, 21 Sep 2020 19:45:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55048 helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kKXN5-00046i-EE; Mon, 21 Sep 2020 19:45:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, bhe@redhat.com,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Eric DeVolder <eric.devolder@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
        <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
        <20200921201811.GB3437@char.us.oracle.com>
Date:   Mon, 21 Sep 2020 20:45:00 -0500
In-Reply-To: <20200921201811.GB3437@char.us.oracle.com> (Konrad Rzeszutek
        Wilk's message of "Mon, 21 Sep 2020 16:18:12 -0400")
Message-ID: <87v9g6fuub.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kKXN5-00046i-EE;;;mid=<87v9g6fuub.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/5xNF3EhmUwM3lMiZbswIDXGY5XwEjzco=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMGappySubj_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4953]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 333 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (3.5%), b_tie_ro: 10 (3.0%), parse: 1.10
        (0.3%), extract_message_metadata: 4.7 (1.4%), get_uri_detail_list: 2.4
        (0.7%), tests_pri_-1000: 3.7 (1.1%), tests_pri_-950: 1.26 (0.4%),
        tests_pri_-900: 1.03 (0.3%), tests_pri_-90: 61 (18.4%), check_bayes:
        60 (18.0%), b_tokenize: 7 (2.0%), b_tok_get_all: 8 (2.4%),
        b_comp_prob: 2.8 (0.9%), b_tok_touch_all: 39 (11.7%), b_finish: 0.90
        (0.3%), tests_pri_0: 229 (68.9%), check_dkim_signature: 0.50 (0.2%),
        check_dkim_adsp: 2.1 (0.6%), poll_dns_idle: 0.49 (0.1%), tests_pri_10:
        2.9 (0.9%), tests_pri_500: 7 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> writes:

> On Fri, Sep 18, 2020 at 05:47:43PM -0700, Andrew Morton wrote:
>> On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
>> 
>> > crash_kexec_post_notifiers enables running various panic notifier
>> > before kdump kernel booting. This increases risks of kdump failure.
>> > It is well documented in kernel-parameters.txt. We do not suggest
>> > people to enable it together with kdump unless he/she is really sure.
>> > This is also not suggested to be enabled by default when users are
>> > not aware in distributions.
>> > 
>> > But unfortunately it is enabled by default in systemd, see below
>> > discussions in a systemd report, we can not convince systemd to change
>> > it:
>> > https://github.com/systemd/systemd/issues/16661
>> > 
>> > Actually we have got reports about kdump kernel hangs in both s390x
>> > and powerpcle cases caused by the systemd change,  also some x86 cases
>> > could also be caused by the same (although that is in Hyper-V code
>> > instead of systemd, that need to be addressed separately).
>
> Perhaps it may be better to fix the issus on s390x and PowerPC as well?
>
>> > 
>> > Thus to avoid the auto enablement here just disable the param writable
>> > permission in sysfs.
>> > 
>> 
>> Well.  I don't think this is at all a desirable way of resolving a
>> disagreement with the systemd developers
>> 
>> At the above github address I'm seeing "ryncsn added a commit to
>> ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
>> enable crash_kexec_post_notifiers by default".  So didn't that address
>> the issue?
>
> It does in systemd, but there is a strong interest in making this on
> by default.

There is also a strong interest in removing this code entirely from the
kernel.

This failure is a case in point.

I think I am at my I told you so point.  This is what all of the testing
over all the years has said.  Leaving functionality to the peculiarities
of firmware when you don't have to, and can actually control what is
going on doesn't work.

Eric


