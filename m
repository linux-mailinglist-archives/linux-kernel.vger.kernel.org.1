Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735C91B2A98
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgDUPCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 11:02:48 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54438 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDUPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:02:47 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQuQA-0003ce-To; Tue, 21 Apr 2020 09:02:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQuQ8-0006pm-IY; Tue, 21 Apr 2020 09:02:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christof Meerwald <cmeerw@cmeerw.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200419201336.GI22017@edge.cmeerw.net>
Date:   Tue, 21 Apr 2020 09:59:39 -0500
In-Reply-To: <20200419201336.GI22017@edge.cmeerw.net> (Christof Meerwald's
        message of "Sun, 19 Apr 2020 22:13:36 +0200")
Message-ID: <87v9ls51gk.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jQuQ8-0006pm-IY;;;mid=<87v9ls51gk.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19wSpoVnHs/NK3Cbc2PgMStLu6JhH5zp24=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1104]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christof Meerwald <cmeerw@cmeerw.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1919 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 13 (0.7%), b_tie_ro: 12 (0.6%), parse: 1.16
        (0.1%), extract_message_metadata: 92 (4.8%), get_uri_detail_list: 0.80
        (0.0%), tests_pri_-1000: 192 (10.0%), tests_pri_-950: 32 (1.7%),
        tests_pri_-900: 1.68 (0.1%), tests_pri_-90: 494 (25.7%), check_bayes:
        492 (25.6%), b_tokenize: 51 (2.6%), b_tok_get_all: 187 (9.8%),
        b_comp_prob: 2.2 (0.1%), b_tok_touch_all: 216 (11.2%), b_finish: 0.93
        (0.0%), tests_pri_0: 1057 (55.1%), check_dkim_signature: 0.79 (0.0%),
        check_dkim_adsp: 49 (2.5%), poll_dns_idle: 22 (1.2%), tests_pri_10:
        3.4 (0.2%), tests_pri_500: 27 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: SIGCHLD signal sometimes sent with si_pid==0 (Linux 5.6.5)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christof Meerwald <cmeerw@cmeerw.org> writes:

> Hi,
>
> this is probably related to commit
> 7a0cf094944e2540758b7f957eb6846d5126f535 (signal: Correct namespace
> fixups of si_pid and si_uid).
>
> With a 5.6.5 kernel I am seeing SIGCHLD signals that don't include a
> properly set si_pid field - this seems to happen for multi-threaded
> child processes.

Christof I want to say very good spotting and reporting of this issue.

Thank you.
Eric
