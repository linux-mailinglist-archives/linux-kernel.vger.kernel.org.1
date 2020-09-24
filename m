Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123032776AB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgIXQ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:26:10 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57004 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgIXQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:26:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kLU4L-00ENPr-R1; Thu, 24 Sep 2020 10:26:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:40828 helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kLU4K-0000tJ-La; Thu, 24 Sep 2020 10:26:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "bhe\@redhat.com" <bhe@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec\@lists.infradead.org" <kexec@lists.infradead.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
        <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
        <20200921201811.GB3437@char.us.oracle.com>
        <87v9g6fuub.fsf@x220.int.ebiederm.org>
        <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
        <20200923154825.GC7635@char.us.oracle.com>
        <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date:   Thu, 24 Sep 2020 11:25:31 -0500
In-Reply-To: <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
        (Michael Kelley's message of "Thu, 24 Sep 2020 16:15:03 +0000")
Message-ID: <874knndtvo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kLU4K-0000tJ-La;;;mid=<874knndtvo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18JVMPiun/wIfdY3BUVFG/zMkK+3mTcQDU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,LH_URI_DOM_IN_PATH,T_TM2_M_HEADER_IN_MSG,
        XMGappySubj_01,XMSubLong,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0948]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 LH_URI_DOM_IN_PATH URI: Long-host URI having a domain name in
        *      the path part
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Michael Kelley <mikelley@microsoft.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 608 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 9 (1.5%), parse: 0.91 (0.1%),
         extract_message_metadata: 5 (0.9%), get_uri_detail_list: 3.3 (0.5%),
        tests_pri_-1000: 3.9 (0.6%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 200 (32.9%), check_bayes:
        198 (32.5%), b_tokenize: 11 (1.9%), b_tok_get_all: 11 (1.8%),
        b_comp_prob: 3.9 (0.6%), b_tok_touch_all: 166 (27.3%), b_finish: 1.08
        (0.2%), tests_pri_0: 364 (59.8%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 3.4 (0.6%), poll_dns_idle: 1.01 (0.2%), tests_pri_10:
        2.5 (0.4%), tests_pri_500: 12 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> Sent: Wednesday, September 23, 2020 8:48 AM
>> 
>> On Wed, Sep 23, 2020 at 10:43:29AM +0800, Dave Young wrote:
>> > + more people who may care about this param
>> 
>> Paarty time!!
>> 
>> (See below, didn't snip any comments)
>> > On 09/21/20 at 08:45pm, Eric W. Biederman wrote:
>> > > Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> writes:
>> > >
>> > > > On Fri, Sep 18, 2020 at 05:47:43PM -0700, Andrew Morton wrote:
>> > > >> On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
>> > > >>
>> > > >> > crash_kexec_post_notifiers enables running various panic notifier
>> > > >> > before kdump kernel booting. This increases risks of kdump failure.
>> > > >> > It is well documented in kernel-parameters.txt. We do not suggest
>> > > >> > people to enable it together with kdump unless he/she is really sure.
>> > > >> > This is also not suggested to be enabled by default when users are
>> > > >> > not aware in distributions.
>> > > >> >
>> > > >> > But unfortunately it is enabled by default in systemd, see below
>> > > >> > discussions in a systemd report, we can not convince systemd to change
>> > > >> > it:
>> > > >> >
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fsyst
>> emd%2Fsystemd%2Fissues%2F16661&amp;data=02%7C01%7Cmikelley%40microsoft.com%
>> 7C3631bae06f7147c0f92908d85fd7f2b2%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%
>> 7C637364728378052956&amp;sdata=9CUpPUxcKLLggbJ1bjubBjbFUAhPVeZhIc4yss8wAiU%3
>> D&amp;reserved=0
>> > > >> >
>> > > >> > Actually we have got reports about kdump kernel hangs in both s390x
>> > > >> > and powerpcle cases caused by the systemd change,  also some x86 cases
>> > > >> > could also be caused by the same (although that is in Hyper-V code
>> > > >> > instead of systemd, that need to be addressed separately).
>> > > >
>> > > > Perhaps it may be better to fix the issus on s390x and PowerPC as well?
>> > > >
>> > > >> >
>> > > >> > Thus to avoid the auto enablement here just disable the param writable
>> > > >> > permission in sysfs.
>> > > >> >
>> > > >>
>> > > >> Well.  I don't think this is at all a desirable way of resolving a
>> > > >> disagreement with the systemd developers
>> > > >>
>> > > >> At the above github address I'm seeing "ryncsn added a commit to
>> > > >> ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
>> > > >> enable crash_kexec_post_notifiers by default".  So didn't that address
>> > > >> the issue?
>> > > >
>> > > > It does in systemd, but there is a strong interest in making this on
>> > > > by default.
>> > >
>> > > There is also a strong interest in removing this code entirely from the
>> > > kernel.
>> >
>> > Added Hyper-V people and people who created the param, it is below
>> > commit, I also want to remove it if possible, let's see how people
>> > think, but the least way should be to disable the auto setting in both systemd
>> > and kernel:
>
> Hyper-V uses a notifier to inform the host system that a Linux VM has
> panic'ed.  Informing the host is particularly important in a public cloud
> such as Azure so that the cloud software can alert the customer, and can
> track cloud-wide reliability statistics.   Whether a kdump is taken is controlled
> entirely by the customer and how he configures the VM, and we want
> the host to be informed either way.

Why?

Why does the host care?
Especially if the VM continues executing into a kdump kernel?

Further like I have mentioned everytime something like this has come up
a call on the kexec on panic code path should be a direct call (That can
be audited) not something hidden in a notifier call chain (which can not).

Eric
