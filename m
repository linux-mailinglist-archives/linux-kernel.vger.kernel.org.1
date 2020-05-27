Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254EE1E39B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgE0GyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 02:54:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728111AbgE0GyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:54:21 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2983E3FD399042156E76;
        Wed, 27 May 2020 14:54:19 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 27 May 2020
 14:54:14 +0800
To:     <aarcange@redhat.com>, <akpm@linux-foundation.org>,
        <cracauer@cons.org>, <dplotnikov@virtuozzo.com>,
        <gokhale2@llnl.gov>, <hannes@cmpxchg.org>, <hughd@google.com>,
        <jglisse@redhat.com>, <kirill@shutemov.name>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <maxime.coquelin@redhat.com>, <mcfadden8@llnl.gov>,
        <mcgrof@kernel.org>, <mgorman@suse.de>, <mike.kravetz@oracle.com>,
        <pbonzini@redhat.com>, <peterx@redhat.com>,
        <rppt@linux.vnet.ibm.com>, <xemul@virtuozzo.com>,
        <keescook@chromium.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Subject: Re: [PATCH v2 1/1] userfaultfd/sysctl: add
 vm.unprivileged_userfaultfd
Message-ID: <3b64de85-beb4-5a07-0093-cad6e8f2a8d8@huawei.com>
Date:   Wed, 27 May 2020 14:54:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Mar 19, 2019 at 11:07:22AM +0800, Peter Xu wrote:
 > Add a global sysctl knob "vm.unprivileged_userfaultfd" to control
 > whether userfaultfd is allowed by unprivileged users.  When this is
 > set to zero, only privileged users (root user, or users with the
 > CAP_SYS_PTRACE capability) will be able to use the userfaultfd
 > syscalls.

Hello
I am a bit confused about this patch, can you help to answer it.

Why the sysctl interface of fs/userfaultfd.c belongs to vm_table instead 
of fs_table ?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cefdca0a86be517bc390fc4541e3674b8e7803b0

Thanks
Xiaoming Ni



