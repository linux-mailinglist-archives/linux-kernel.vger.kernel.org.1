Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD121BA7EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgD0PZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 11:25:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:34266 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgD0PZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:25:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT5d9-0005kl-2j; Mon, 27 Apr 2020 09:25:11 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT5d7-00063B-DM; Mon, 27 Apr 2020 09:25:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?Q?St=C3=A9phane?= Graber <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Serge Hallyn <serge@hallyn.com>,
        Aleksa Sarai <cyphar@cyphar.com>
References: <20200427143646.619227-1-christian.brauner@ubuntu.com>
Date:   Mon, 27 Apr 2020 10:21:55 -0500
In-Reply-To: <20200427143646.619227-1-christian.brauner@ubuntu.com> (Christian
        Brauner's message of "Mon, 27 Apr 2020 16:36:46 +0200")
Message-ID: <87sggpeyy4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jT5d7-00063B-DM;;;mid=<87sggpeyy4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/020IQ4+UDCdVTdPpbjDBiARVtrobelw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4893]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 249 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 14 (5.4%), b_tie_ro: 12 (4.9%), parse: 1.27
        (0.5%), extract_message_metadata: 3.0 (1.2%), get_uri_detail_list:
        0.41 (0.2%), tests_pri_-1000: 6 (2.3%), tests_pri_-950: 1.87 (0.7%),
        tests_pri_-900: 1.50 (0.6%), tests_pri_-90: 74 (29.8%), check_bayes:
        72 (28.9%), b_tokenize: 7 (2.9%), b_tok_get_all: 3.9 (1.6%),
        b_comp_prob: 2.2 (0.9%), b_tok_touch_all: 55 (22.1%), b_finish: 1.10
        (0.4%), tests_pri_0: 124 (49.6%), check_dkim_signature: 0.48 (0.2%),
        check_dkim_adsp: 2.4 (1.0%), poll_dns_idle: 0.53 (0.2%), tests_pri_10:
        3.3 (1.3%), tests_pri_500: 9 (3.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] nsproxy: attach to namespaces via pidfds
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I am still catching up on the what exists for pidfd.  Do you have a way
to safely go from a pidfd to the corresponding proc directory?

That would make this setns work just an optimization.  A nice one but
just an optimization.

Eric
