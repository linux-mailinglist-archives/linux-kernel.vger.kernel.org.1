Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC71E7D83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgE2Mq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 08:46:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36010 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2Mq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:46:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeeP4-0002A8-13; Fri, 29 May 2020 06:46:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeeP3-0007XO-9w; Fri, 29 May 2020 06:46:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        axboe@kernel.dk, clemens@ladisch.de, arnd@arndb.de,
        gregkh@linuxfoundation.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, benh@kernel.crashing.org,
        rdna@fb.com, viro@zeniv.linux.org.uk, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, vbabka@suse.cz,
        sfr@canb.auug.org.au, jack@suse.cz, amir73il@gmail.com,
        rafael@kernel.org, tytso@mit.edu, julia.lawall@lip6.fr,
        akpm@linux-foundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20200529074108.16928-1-mcgrof@kernel.org>
        <20200529074108.16928-2-mcgrof@kernel.org>
        <87ftbiud6s.fsf@x220.int.ebiederm.org>
Date:   Fri, 29 May 2020 07:42:31 -0500
In-Reply-To: <87ftbiud6s.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 29 May 2020 07:40:27 -0500")
Message-ID: <878shaud3c.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeeP3-0007XO-9w;;;mid=<878shaud3c.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Q4ZChrgvw1NHSy03cGUWR9nu5bHWud8U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4452]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Luis Chamberlain <mcgrof@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 375 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.7%), b_tie_ro: 9 (2.4%), parse: 1.21 (0.3%),
         extract_message_metadata: 16 (4.3%), get_uri_detail_list: 1.59 (0.4%),
         tests_pri_-1000: 26 (7.1%), tests_pri_-950: 1.29 (0.3%),
        tests_pri_-900: 1.26 (0.3%), tests_pri_-90: 58 (15.5%), check_bayes:
        57 (15.1%), b_tokenize: 7 (1.9%), b_tok_get_all: 8 (2.1%),
        b_comp_prob: 2.5 (0.7%), b_tok_touch_all: 36 (9.5%), b_finish: 0.87
        (0.2%), tests_pri_0: 246 (65.4%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.58 (0.2%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 01/13] sysctl: add new register_sysctl_subdir() helper
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Luis Chamberlain <mcgrof@kernel.org> writes:
>
>> Often enough all we need to do is create a subdirectory so that
>> we can stuff sysctls underneath it. However, *if* that directory
>> was already created early on the boot sequence we really have no
>> need to use the full boiler plate code for it, we can just use
>> local variables to help us guide sysctl to place the new leaf files.
>>
>> So use a helper to do precisely this.
>
> Reset restart.  This is patch is total nonsense.
>
> - You are using register_sysctl_table which as I believe I have
>   mentioned is a deprecated compatibility wrapper.  The point of
>   spring house cleaning is to get off of the deprecated functions
>   isn't it?
>
> - You are using the old nasty form for creating directories instead
>   of just passing in a path.
>
> - None of this is even remotely necessary.  The directories
>   are created automatically if you just register their entries.

Oh.  *blink*  The poor naming threw me off.

This is a clumsy and poorly named version of register_sysctl();

Yes. This change is totally unnecessary.

Eric

