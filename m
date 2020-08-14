Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDB3244BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 17:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHNPUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 11:20:36 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51498 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNPUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:20:35 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k6bVR-00H01D-G4; Fri, 14 Aug 2020 09:20:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k6bVQ-0001vZ-PO; Fri, 14 Aug 2020 09:20:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Sang Yan <sangyan@huawei.com>
Cc:     <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <guohanjun@huawei.com>,
        <zhuling8@huawei.com>, <luanjianhai@huawei.com>,
        <luchunhua@huawei.com>
References: <20200814055239.47348-1-sangyan@huawei.com>
Date:   Fri, 14 Aug 2020 10:17:06 -0500
In-Reply-To: <20200814055239.47348-1-sangyan@huawei.com> (Sang Yan's message
        of "Fri, 14 Aug 2020 01:52:38 -0400")
Message-ID: <87tux5i7f1.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k6bVQ-0001vZ-PO;;;mid=<87tux5i7f1.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/U8iQDvUHSg0k7Zv0nFYBoIQGMmYLEEDU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4795]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Sang Yan <sangyan@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 362 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (3.1%), b_tie_ro: 10 (2.7%), parse: 0.89
        (0.2%), extract_message_metadata: 18 (5.0%), get_uri_detail_list: 1.18
        (0.3%), tests_pri_-1000: 19 (5.1%), tests_pri_-950: 1.65 (0.5%),
        tests_pri_-900: 1.45 (0.4%), tests_pri_-90: 102 (28.1%), check_bayes:
        100 (27.7%), b_tokenize: 4.6 (1.3%), b_tok_get_all: 4.7 (1.3%),
        b_comp_prob: 1.72 (0.5%), b_tok_touch_all: 85 (23.5%), b_finish: 1.12
        (0.3%), tests_pri_0: 194 (53.6%), check_dkim_signature: 0.63 (0.2%),
        check_dkim_adsp: 2.5 (0.7%), poll_dns_idle: 0.69 (0.2%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] kexec: Add quick kexec support for kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sang Yan <sangyan@huawei.com> writes:

> In normal kexec, relocating kernel may cost 5 ~ 10 seconds, to
> copy all segments from vmalloced memory to kernel boot memory,
> because of disabled mmu.

I haven't seen kexec that slow since I tested on my 16Mhz 386.

That machine has an excuse it really is slow.  Anything else
that takes seconds is almost certainly slow because someone
has misconfigured things to not cache the data copied by kexec.

I humbly suggest that you fix the arm64 code so that the data gets
cached.

Eric
